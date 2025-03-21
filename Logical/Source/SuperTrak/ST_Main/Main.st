(*********************************************************************************
 * Copyright: ATS Automation Tooling Systems, Inc. 2015
 *     All rights reserved.
 *********************************************************************************
 *********************************************************************************
 * Description:
 * -------------------------------------------------------------------------------
 * This task configures the internal communication structure AND controlls
 * the SuperTrak system.
 *********************************************************************************)

PROGRAM _INIT
// SuperTrak initialization	
	IF DiagCpuIsARsim() THEN
		(* This path can be customized as needed *)
		StoragePath := '/DEVICE=C:\Temp\SuperTrakUser';
	ELSE
		(* CFast card USER partition *)
		StoragePath := '/DEVICE=F:\';
	END_IF;	
	
	// SuperTrak Init function call
	SuperTrakInit(StoragePath, ARSimIPAddress, EthernetInterfaces);
	
	
	// Service Channel initialization
	ServiceChannelData.channelId    		:= 1;
	ServiceChannelData.pRequestHeader		:= ADR(gStServiceChannelReqData);
	ServiceChannelData.pResponseHeader		:= ADR(gStServiceChannelResData);
	ServiceChannelData.pRequestValues     	:= ADR(gStServiceChannelReqData) + SIZEOF(ServiceChannelHeader_t);
	ServiceChannelData.pResponseValues    	:= ADR(gStServiceChannelResData) + SIZEOF(ServiceChannelHeader_t);
	ServiceChannelData.requestBufferSize  	:= SIZEOF(gStServiceChannelReqData);
	ServiceChannelData.responseBufferSize  	:= SIZEOF(gStServiceChannelResData);
	ServiceChannelData.state     			:= scSTATE_RECV;
 
	pResView ACCESS ADR(gStServiceChannelResData); 
	pReqView ACCESS ADR(gStServiceChannelReqData);
 
	// Command interface mapping
	SuperTrakControlInterface[0].pControl  	:= ADR(gStCyclicControlData);
	SuperTrakControlInterface[0].pStatus   	:= ADR(gStCyclicStatusData);
	SuperTrakControlInterface[0].controlSize:= SIZEOF(gStCyclicControlData);
	SuperTrakControlInterface[0].statusSize := SIZEOF(gStCyclicStatusData);
		
	(* De-configure any "Allow Section Enable" inputs *)
	(* Parameter 1092: Parameter Array Length (UDINT) *)
	(* Parameter 1200: Digital Input Function (UINT) *)
	status := SuperTrakServChanRead(0, 1092, 1200 - 1024, 1, ADR(udintValue), SIZEOF(udintValue));
			
	IF (status = scERR_SUCCESS) THEN
		count := MIN(UDINT_TO_UINT(udintValue),
		SIZEOF(digitalInputFunction) / SIZEOF(digitalInputFunction[0]));
				
		status := SuperTrakServChanRead(0, 1200, 0, count, ADR(digitalInputFunction), SIZEOF(digitalInputFunction));
				
		IF (status = scERR_SUCCESS) THEN
			FOR i := 0 TO count - 1 DO
				(* Input Function 25: Allow Section Enable *)
				IF (digitalInputFunction[i] = 25) THEN
					(* Input Function 0: Not Configured *)
					digitalInputFunction[i] := 0;
					status := SuperTrakServChanWrite(0, 1200, i, 1, ADR(digitalInputFunction[i]), SIZEOF(digitalInputFunction[i]));
				END_IF;
			END_FOR;
		END_IF;
	END_IF;
	
	(* Ensure that control interface revision 0 is selected *)
	(* Parameter 1444: Control Interface Revision (UINT) *)
	status := SuperTrakServChanRead(0, 1444, 0, 1, ADR(uintValue), SIZEOF(uintValue));
		
	IF (status = scERR_SUCCESS) THEN
		IF (uintValue <> 0) THEN
			uintValue := 0;
			status := SuperTrakServChanWrite(0, 1444, 0, 1, ADR(uintValue), SIZEOF(uintValue));
		END_IF;
	END_IF;
	
END_PROGRAM

PROGRAM _CYCLIC

	// Map internal communication structure
	FOR i := 0 TO stMAX_CONTROL_IF_INDEX DO
		SuperTrakProcessControl(i, SuperTrakControlInterface[i]);
	END_FOR;
	
	// Cylcic SuperTrak control
	SuperTrakCyclic1();
	
	(* PLC interfaces status *)
	FOR i := 0 TO stMAX_CONTROL_IF_INDEX DO
		SuperTrakProcessStatus(i, SuperTrakControlInterface[i]);
	END_FOR;
	
	// Service channel handling
	IF ServiceChannelData.state = scSTATE_RECV AND
		pReqView.sequence <> pResView.sequence THEN
		ServiceChannelData.requestSequence  := pReqView.sequence;
		ServiceChannelData.state    		:= scSTATE_EXEC;
	ELSIF ServiceChannelData.state = scSTATE_EXEC OR ServiceChannelData.state = scSTATE_WAIT THEN
		SuperTrakServiceChannel(ServiceChannelData);
	ELSIF ServiceChannelData.state = scSTATE_SEND THEN
		ServiceChannelData.state    		:= scSTATE_RECV;
	END_IF;
 
END_PROGRAM

PROGRAM _EXIT

 // Clear internal memory
	SuperTrakExit();

END_PROGRAM


