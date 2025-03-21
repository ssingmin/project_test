(*********************************************************************************
 * Copyright: Bernecker + Rainer
 * Author:  B+R
 * Created:  June 30, 2017/08:15 AM 
 *********************************************************************************
 *********************************************************************************
 * Version History:
 * -------------------------------------------------------------------------------
 * V 1.00.0   June 30, 2017/08:15 AM  First Version
 *********************************************************************************
 * Description:
 * -------------------------------------------------------------------------------
 * June 30, 2017/08:15 AM AM V1.00.0:
 * This task is used for Error handling
 * Error number are read from the FUB and converted to messages
 * This messages are used for the visualization
 *********************************************************************************)

ACTION ReadErrorMessages: 
	
	brsmemset(ADR(ErrorInfo),0,SIZEOF(ErrorInfo));
	
	IF EDGENEG(AcknowledgeAll) THEN
		StControl_0.ErrorReset										:= FALSE;
		FOR Index := 0 TO (SIZEOF(StSection_) / SIZEOF(StSection_[0])) - 1 DO
			StSection_[Index].ErrorReset							:= FALSE;
		END_FOR;
		FOR Index := 0 TO (SIZEOF(StTargetExt_) / SIZEOF(StTargetExt_[0])) - 1 DO
			StTargetExt_[Index].ErrorReset							:= FALSE;
		END_FOR;
		StWritePnu_Region.ErrorReset								:= FALSE;
		StReadPnu_Region.ErrorReset									:= FALSE;
	END_IF;
	
	FOR Index := 0 TO (SIZEOF(StSection_) / SIZEOF(StSection_[0])) - 1 DO
		////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////
		//Check if fault is active to output the correct error msg
		Counter		:= 0;
		FOR FaultBitCounter := 0 TO 31 DO
			IF BIT_TST(StSection_[Index].Info.SuperTrak.SectionFaultBits,FaultBitCounter) THEN							
				// Set error
				FaultBit											:= FaultBitCounter;
				ErrorInfo.StSection[Index].ErrorText[Counter]		:= ErrorTexts[FaultBit];
				ErrorInfo.StSection[Index].Error[Counter]			:= FaultBit;
				Counter			:= Counter + 1;
			END_IF;
		END_FOR;
		
		IF StSection_[Index].StatusID <> stCOM_NO_ERROR THEN
			ErrorInfo.StSection[Index].StatusID				:= StSection_[Index].StatusID;
			
			// Get the needed text
			CASE ErrorInfo.StSection[Index].StatusID OF
				stCOM_ERR_FB_INSTANCE_REG:	
					ErrorInfo.StSection[Index].ErrorText[Counter]:= 'Instance of this function block already registered';
				
				stCOM_ERR_WRONG_PARAMETER:
					ErrorInfo.StSection[Index].ErrorText[Counter]:= 'Wrong parameter';
				
				stCOM_ERR_COMMUNICAITON_TIME_OUT:
					ErrorInfo.StSection[Index].ErrorText[Counter]:= 'Timeout for communication to SuperTrak';
				
				stCOM_ERR_NO_STCONTROL_REG:
					ErrorInfo.StSection[Index].ErrorText[Counter]:= 'There is no instance of StControl registered';
				
				stCOM_ERR_WRONG_CONFIG:
					ErrorInfo.StSection[Index].ErrorText[Counter]:= 'Address not valid, or Target/Section/PalletID not vaild';
				
				stCOM_ERR_CMD_NOT_EXECUTED:
					ErrorInfo.StSection[Index].ErrorText[Counter]:= 'Command could not be executed successfully';
				
				stCOM_ERR_SERVICE_CHANNEL_FAULT:
					ErrorInfo.StSection[Index].ErrorText[Counter]:= 'SuperTrak responded with an error to a service channel request';
				
				stCOM_ERR_CMD_HANDSHAKE:
					ErrorInfo.StSection[Index].ErrorText[Counter]:= 'CommandComplete flag is true before command execution';
			
			END_CASE;
		END_IF;
		
		////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////
		//Check if warning is active to output the correct error msg
		Counter		:= 0;
		FOR FaultBitCounter := 0 TO 31 DO
			IF BIT_TST(StSection_[Index].Info.SuperTrak.SectionWarningBits,FaultBitCounter) THEN
				// Set warning
				WarningBit											:= FaultBitCounter;
				ErrorInfo.StSection[Index].WarningText[Counter]		:= WarningTexts[WarningBit];
				ErrorInfo.StSection[Index].Warning[Counter]			:= WarningBit;
				Counter	:= Counter + 1;
			END_IF;
		END_FOR;
		
		IF StSection_[Index].StatusID <> stCOM_NO_ERROR THEN			
			// Get the needed text
			CASE ErrorInfo.StSection[Index].StatusID OF
				stCOM_WRN_ENABLE_SIGNAL_SOURCE:
					ErrorInfo.StSection[Index].WarningText[Counter]:= 'Enable signal source configuration does not allow this command';
							
				stCOM_INFO_COMM_STRUCT_TOO_BIG:
					ErrorInfo.StSection[Index].WarningText[Counter]:= 'The communication structure is too big';
			
			END_CASE;
		END_IF;
	END_FOR;
	
	///////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////
	// Use the actual selected Section to display
	// Count up the section on the Temperatures Visu page
	IF EDGEPOS(CountUpAlarm) THEN
		VisuAlarmSection		:= VisuAlarmSection + 1;
		// Check for last section
		IF VisuAlarmSection = (MAX_SECTIONS+1) THEN
			VisuAlarmSection	:= 1;
		END_IF;
		CountUpAlarm			:= FALSE;
		// Count down the section on the Temperatures Visu page
	ELSIF EDGEPOS(CountDownAlarm) THEN
		VisuAlarmSection		:= VisuAlarmSection - 1;
		// Check for first section
		IF VisuAlarmSection = 0 THEN
			VisuAlarmSection	:= MAX_SECTIONS;
		END_IF;
		CountDownAlarm			:= FALSE;
	END_IF;
	
	VisuAlarmSectionText		:= ErrorInfo.StSection[VisuAlarmSection-1].ErrorText;
	VisuWarningSectionText		:= ErrorInfo.StSection[VisuAlarmSection-1].WarningText;
	
	IF AcknowledgeSelectedSection AND AcknowledgeAll = FALSE THEN
		StSection_[VisuAlarmSection-1].ErrorReset		:= TRUE;
	END_IF;
	
	///////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////
	// Check if fault is active to output the correct error msg
	Counter	:= 0;
	FOR Index := 0 TO (SIZEOF(StTargetExt_) / SIZEOF(StTargetExt_[0])) - 1 DO
		// Get the StatusID of the FUB
		IF StTargetExt_[Index].StatusID <> stCOM_NO_ERROR THEN
			ErrorInfo.StTargetExt.StatusID[Counter]			:= StTargetExt_[Index].StatusID;
			ErrorInfo.StTargetExt.TargetID[Counter]			:= Index + 1;
			
			// Get the needed text
			CASE ErrorInfo.StTargetExt.StatusID[Counter] OF
				stCOM_ERR_FB_INSTANCE_REG:	
					ErrorInfo.StTargetExt.ErrorText[Counter]:= 'Instance of this function block already registered';
				
				stCOM_ERR_WRONG_PARAMETER:
					ErrorInfo.StTargetExt.ErrorText[Counter]:= 'Wrong parameter';
				
				stCOM_ERR_COMMUNICAITON_TIME_OUT:
					ErrorInfo.StTargetExt.ErrorText[Counter]:= 'Timeout for communication to SuperTrak';
				
				stCOM_ERR_NO_STCONTROL_REG:
					ErrorInfo.StTargetExt.ErrorText[Counter]:= 'There is no instance of StControl registered';
				
				stCOM_ERR_WRONG_CONFIG:
					ErrorInfo.StTargetExt.ErrorText[Counter]:= 'Address not valid, or Target/Section/PalletID not vaild';
				
				stCOM_ERR_CMD_NOT_EXECUTED:
					ErrorInfo.StTargetExt.ErrorText[Counter]:= 'Command could not be executed successfully';
				
				stCOM_ERR_SERVICE_CHANNEL_FAULT:
					ErrorInfo.StTargetExt.ErrorText[Counter]:= 'SuperTrak responded with an error to a service channel request';
				
				stCOM_ERR_CMD_HANDSHAKE:
					ErrorInfo.StTargetExt.ErrorText[Counter]:= 'CommandComplete flag is true before command execution';
				
				stCOM_WRN_ENABLE_SIGNAL_SOURCE:
					ErrorInfo.StTargetExt.ErrorText[Counter]:= 'Enable signal source configuration does not allow this command';
							
				stCOM_INFO_COMM_STRUCT_TOO_BIG:
					ErrorInfo.StTargetExt.ErrorText[Counter]:= 'The communication structure is too big';
			
			END_CASE;
			Counter	:= Counter + 1;
		END_IF;
	END_FOR;
		
	IF AcknowledgeSelectedTarget AND AcknowledgeAll = FALSE THEN
		IF (ErrorInfo.StTargetExt.TargetID[SelectedTarget] -1) >= 0 AND (ErrorInfo.StTargetExt.TargetID[SelectedTarget] -1) < 255 THEN
			StTargetExt_[ErrorInfo.StTargetExt.TargetID[SelectedTarget] -1].ErrorReset		:= TRUE;
		END_IF;
	ELSIF AcknowledgeAll = FALSE THEN
		IF (ErrorInfo.StTargetExt.TargetID[SelectedTarget] -1) >= 0 AND (ErrorInfo.StTargetExt.TargetID[SelectedTarget] -1) < 255 THEN
			StTargetExt_[ErrorInfo.StTargetExt.TargetID[SelectedTarget] -1].ErrorReset		:= FALSE;
		END_IF;
	END_IF;
	
	///////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////
	// Check if fault is active to output the correct error msg
	Counter	:= 0;
	FOR Index := 0 TO (SIZEOF(StPallet_) / SIZEOF(StPallet_[0])) - 1 DO
		// Get the StatusID of the FUB
		IF StPallet_[Index].StatusID <> stCOM_NO_ERROR THEN
			ErrorInfo.StPallet.StatusID[Counter]			:= StPallet_[Index].StatusID;
			ErrorInfo.StPallet.ShuttleID[Counter]			:= Index + 1;
			
			// Get the needed text
			CASE ErrorInfo.StPallet.StatusID[Counter] OF
				stCOM_ERR_FB_INSTANCE_REG:	
					ErrorInfo.StPallet.ErrorText[Counter]:= 'Instance of this function block already registered';
				
				stCOM_ERR_WRONG_PARAMETER:
					ErrorInfo.StPallet.ErrorText[Counter]:= 'Wrong parameter';
				
				stCOM_ERR_COMMUNICAITON_TIME_OUT:
					ErrorInfo.StPallet.ErrorText[Counter]:= 'Timeout for communication to SuperTrak';
				
				stCOM_ERR_NO_STCONTROL_REG:
					ErrorInfo.StPallet.ErrorText[Counter]:= 'There is no instance of StControl registered';
				
				stCOM_ERR_WRONG_CONFIG:
					ErrorInfo.StPallet.ErrorText[Counter]:= 'Address not valid, or Target/Section/PalletID not vaild';
				
				stCOM_ERR_CMD_NOT_EXECUTED:
					ErrorInfo.StPallet.ErrorText[Counter]:= 'Command could not be executed successfully';
				
				stCOM_ERR_SERVICE_CHANNEL_FAULT:
					ErrorInfo.StPallet.ErrorText[Counter]:= 'SuperTrak responded with an error to a service channel request';
				
				stCOM_ERR_CMD_HANDSHAKE:
					ErrorInfo.StPallet.ErrorText[Counter]:= 'CommandComplete flag is true before command execution';
				
				stCOM_WRN_ENABLE_SIGNAL_SOURCE:
					ErrorInfo.StPallet.ErrorText[Counter]:= 'Enable signal source configuration does not allow this command';
							
				stCOM_INFO_COMM_STRUCT_TOO_BIG:
					ErrorInfo.StPallet.ErrorText[Counter]:= 'The communication structure is too big';
			
			END_CASE;
			Counter	:= Counter + 1;
		END_IF;
	END_FOR;
		
	IF AcknowledgeSelectedShuttle AND AcknowledgeAll = FALSE THEN
		IF (ErrorInfo.StPallet.ShuttleID[SelectedShuttle] -1) >= 0 AND (ErrorInfo.StPallet.ShuttleID[SelectedShuttle] -1) < 255 THEN
			StPallet_[ErrorInfo.StPallet.ShuttleID[SelectedShuttle] -1].ErrorReset		:= TRUE;
		END_IF;
	ELSIF AcknowledgeAll = FALSE THEN
		IF (ErrorInfo.StPallet.ShuttleID[SelectedShuttle] -1) >= 0 AND (ErrorInfo.StPallet.ShuttleID[SelectedShuttle] -1) < 255 THEN
			StPallet_[ErrorInfo.StPallet.ShuttleID[SelectedShuttle] -1].ErrorReset		:= FALSE;
		END_IF;
	END_IF;
	
	///////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////
	//Check if fault is active to output the correct error msg
	ErrorInfo.StReadPnu_Region.StatusID			:= StReadPnu_Region.StatusID;
	// Get the needed text
	CASE ErrorInfo.StReadPnu_Region.StatusID OF
		stCOM_ERR_FB_INSTANCE_REG:	
			ErrorInfo.StReadPnu_Region.ErrorText:= 'Instance of this function block already registered';
			
		stCOM_ERR_WRONG_PARAMETER:
			ErrorInfo.StReadPnu_Region.ErrorText:= 'Wrong parameter';
			
		stCOM_ERR_COMMUNICAITON_TIME_OUT:
			ErrorInfo.StReadPnu_Region.ErrorText:= 'Timeout for communication to SuperTrak';
			
		stCOM_ERR_NO_STCONTROL_REG:
			ErrorInfo.StReadPnu_Region.ErrorText:= 'There is no instance of StControl registered';
			
		stCOM_ERR_WRONG_CONFIG:
			ErrorInfo.StReadPnu_Region.ErrorText:= 'Address not valid, or Target/Section/PalletID not vaild';
			
		stCOM_ERR_CMD_NOT_EXECUTED:
			ErrorInfo.StReadPnu_Region.ErrorText:= 'Command could not be executed successfully';
			
		stCOM_ERR_SERVICE_CHANNEL_FAULT:
			ErrorInfo.StReadPnu_Region.ErrorText:= 'SuperTrak responded with an error to a service channel request';
			
		stCOM_ERR_CMD_HANDSHAKE:
			ErrorInfo.StReadPnu_Region.ErrorText:= 'CommandComplete flag is true before command execution';
			
		stCOM_WRN_ENABLE_SIGNAL_SOURCE:
			ErrorInfo.StReadPnu_Region.ErrorText:= 'Enable signal source configuration does not allow this command';
						
		stCOM_INFO_COMM_STRUCT_TOO_BIG:
			ErrorInfo.StReadPnu_Region.ErrorText:= 'The communication structure is too big';
			
	END_CASE;
	
	///////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////
	//Check if fault is active to output the correct error msg
	ErrorInfo.StWritePnu_Region.StatusID		:= StWritePnu_Region.StatusID;
	// Get the needed text
	CASE ErrorInfo.StWritePnu_Region.StatusID OF
		stCOM_ERR_FB_INSTANCE_REG:	
			ErrorInfo.StWritePnu_Region.ErrorText:= 'Instance of this function block already registered';
			
		stCOM_ERR_WRONG_PARAMETER:
			ErrorInfo.StWritePnu_Region.ErrorText:= 'Wrong parameter';
			
		stCOM_ERR_COMMUNICAITON_TIME_OUT:
			ErrorInfo.StWritePnu_Region.ErrorText:= 'Timeout for communication to SuperTrak';
			
		stCOM_ERR_NO_STCONTROL_REG:
			ErrorInfo.StWritePnu_Region.ErrorText:= 'There is no instance of StControl registered';
			
		stCOM_ERR_WRONG_CONFIG:
			ErrorInfo.StWritePnu_Region.ErrorText:= 'Address not valid, or Target/Section/PalletID not vaild';
			
		stCOM_ERR_CMD_NOT_EXECUTED:
			ErrorInfo.StWritePnu_Region.ErrorText:= 'Command could not be executed successfully';
			
		stCOM_ERR_SERVICE_CHANNEL_FAULT:
			ErrorInfo.StWritePnu_Region.ErrorText:= 'SuperTrak responded with an error to a service channel request';
			
		stCOM_ERR_CMD_HANDSHAKE:
			ErrorInfo.StWritePnu_Region.ErrorText:= 'CommandComplete flag is true before command execution';
			
		stCOM_WRN_ENABLE_SIGNAL_SOURCE:
			ErrorInfo.StWritePnu_Region.ErrorText:= 'Enable signal source configuration does not allow this command';
						
		stCOM_INFO_COMM_STRUCT_TOO_BIG:
			ErrorInfo.StWritePnu_Region.ErrorText:= 'The communication structure is too big';
			
	END_CASE;
	
	///////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////
	//Check if fault is active to output the correct error msg
	Counter		:= 0;
	FOR FaultBitCounter := 0 TO 31 DO
		IF BIT_TST(StControl_0.Info.SuperTrak.SystemFaultBits,FaultBitCounter) THEN							
			// Set error
			FaultBit									:= FaultBitCounter;
			ErrorInfo.StControl.Error[Counter]			:= FaultBit;
			ErrorInfo.StControl.ErrorText[Counter]		:= ErrorTexts[FaultBit];
			Counter			:= Counter + 1;
		END_IF;
	END_FOR;
	
	IF StControl_0.StatusID <> stCOM_NO_ERROR THEN
		ErrorInfo.StControl.StatusID					:= StControl_0.StatusID;
			
		// Get the needed text
		CASE ErrorInfo.StControl.StatusID OF
			stCOM_ERR_FB_INSTANCE_REG:	
				ErrorInfo.StControl.ErrorText[Counter]:= 'Instance of this function block already registered';
				
			stCOM_ERR_WRONG_PARAMETER:
				ErrorInfo.StControl.ErrorText[Counter]:= 'Wrong parameter';
				
			stCOM_ERR_COMMUNICAITON_TIME_OUT:
				ErrorInfo.StControl.ErrorText[Counter]:= 'Timeout for communication to SuperTrak';
				
			stCOM_ERR_NO_STCONTROL_REG:
				ErrorInfo.StControl.ErrorText[Counter]:= 'There is no instance of StControl registered';
				
			stCOM_ERR_WRONG_CONFIG:
				ErrorInfo.StControl.ErrorText[Counter]:= 'Address not valid, or Target/Section/PalletID not vaild';
				
			stCOM_ERR_CMD_NOT_EXECUTED:
				ErrorInfo.StControl.ErrorText[Counter]:= 'Command could not be executed successfully';
				
			stCOM_ERR_SERVICE_CHANNEL_FAULT:
				ErrorInfo.StControl.ErrorText[Counter]:= 'SuperTrak responded with an error to a service channel request';
				
			stCOM_ERR_CMD_HANDSHAKE:
				ErrorInfo.StControl.ErrorText[Counter]:= 'CommandComplete flag is true before command execution';
			
		END_CASE;
	END_IF;
	
	////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////
	//Check if warning is active to output the correct error msg
	Counter		:= 0;
	FOR FaultBitCounter := 0 TO 31 DO
		IF BIT_TST(StControl_0.Info.SuperTrak.SystemWarningBits,FaultBitCounter) THEN						
			// Set Warning
			WarningBit								:= FaultBitCounter;
			ErrorInfo.StControl.Warning[Counter]	:= WarningBit;
			ErrorInfo.StControl.WarningText[Counter]:= WarningTexts[WarningBit];
			Counter	:= Counter + 1;
		END_IF;
	END_FOR;
	
	IF StControl_0.StatusID <> stCOM_NO_ERROR THEN
		// Get the needed text
		CASE ErrorInfo.StControl.StatusID OF
			stCOM_WRN_ENABLE_SIGNAL_SOURCE:
				ErrorInfo.StControl.WarningText[Counter]:= 'Enable signal source configuration does not allow this command';
							
			stCOM_INFO_COMM_STRUCT_TOO_BIG:
				ErrorInfo.StControl.WarningText[Counter]:= 'The communication structure is too big';
			
		END_CASE;
	END_IF;
	
	ErrorCode	:= 0;	
	////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////
	//Check for error in FUB
	ErrorInfo.HmiWriteParID.StatusID			:= HmiWriteParID_0.StatusID;
	// Get the needed text
	CASE ErrorInfo.HmiWriteParID.StatusID OF
		HMI_ERR_FB_INSTANCE_REG:	
			ErrorInfo.HmiWriteParID.ErrorText	:= 'Instance of this function block already registered';
			
		HMI_ERR_WRONG_PARAMETER:
			ErrorInfo.HmiWriteParID.ErrorText	:= 'Wrong parameter';
			
		HMI_ERR_COMMUNICAITON_TIME_OUT:
			ErrorInfo.HmiWriteParID.ErrorText	:= 'Timeout for communication to SuperTrak';
			
		HMI_ERR_NO_HMICONTROL_REG:
			ErrorInfo.HmiWriteParID.ErrorText	:= 'There is no instance of HmiControl registered';
			
		HMI_ERR_WRONG_CONFIG:
			ErrorInfo.HmiWriteParID.ErrorText	:= 'Address not valid, or Target/Section/PalletID not vaild';
			
		HMI_ERR_CMD_NOT_EXECUTED:
			ErrorInfo.HmiWriteParID.ErrorText:= 'Command could not be executed successfully';
			IF HmiWriteParID_0.Info.ErrorCode <> 0 THEN
				ErrorCode						:= HmiWriteParID_0.Info.ErrorCode;
				brsstrcpy(ADR(ErrorInfo.HmiWriteParID.ErrorText),ADR(HmiErrorTexts[ErrorCode]));
			END_IF;
			
		HMI_ERR_SERVICE_CHANNEL_FAULT:
			ErrorInfo.HmiWriteParID.ErrorText	:= 'SuperTrak responded with an error to a service channel request';
			
		HMI_ERR_CMD_HANDSHAKE:
			ErrorInfo.HmiWriteParID.ErrorText	:= 'CommandComplete flag is true before command execution';
			
		HMI_WRN_ENABLE_SIGNAL_SOURCE:
			ErrorInfo.HmiWriteParID.ErrorText	:= 'Enable signal source configuration does not allow this command';
						
		HMI_INFO_COMM_STRUCT_TOO_BIG:
			ErrorInfo.HmiWriteParID.ErrorText	:= 'The communication structure is too big';
		
	END_CASE;
	
	ErrorCode	:= 0;
	////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////
	//Check for error in FUB
	ErrorInfo.HmiReadParID.StatusID				:= HmiReadParID_0.StatusID;
	// Get the needed text
	CASE ErrorInfo.HmiReadParID.StatusID OF
		HMI_ERR_FB_INSTANCE_REG:	
			ErrorInfo.HmiReadParID.ErrorText	:= 'Instance of this function block already registered';
			
		HMI_ERR_WRONG_PARAMETER:
			ErrorInfo.HmiReadParID.ErrorText	:= 'Wrong parameter';
			
		HMI_ERR_COMMUNICAITON_TIME_OUT:
			ErrorInfo.HmiReadParID.ErrorText	:= 'Timeout for communication to SuperTrak';
			
		HMI_ERR_NO_HMICONTROL_REG:
			ErrorInfo.HmiReadParID.ErrorText	:= 'There is no instance of HmiControl registered';
			
		HMI_ERR_WRONG_CONFIG:
			ErrorInfo.HmiReadParID.ErrorText	:= 'Address not valid, or Target/Section/PalletID not vaild';
			
		HMI_ERR_CMD_NOT_EXECUTED:
			ErrorInfo.HmiReadParID.ErrorText	:= 'Command could not be executed successfully';
			IF HmiReadParID_0.Info.ErrorCode <> 0 THEN
				ErrorCode						:= HmiReadParID_0.Info.ErrorCode;
				brsstrcpy(ADR(ErrorInfo.HmiReadParID.ErrorText),ADR(HmiErrorTexts[ErrorCode]));
			END_IF;
			
		HMI_ERR_SERVICE_CHANNEL_FAULT:
			ErrorInfo.HmiReadParID.ErrorText	:= 'SuperTrak responded with an error to a service channel request';
			
		HMI_ERR_CMD_HANDSHAKE:
			ErrorInfo.HmiReadParID.ErrorText	:= 'CommandComplete flag is true before command execution';
			
		HMI_WRN_ENABLE_SIGNAL_SOURCE:
			ErrorInfo.HmiReadParID.ErrorText	:= 'Enable signal source configuration does not allow this command';
						
		HMI_INFO_COMM_STRUCT_TOO_BIG:
			ErrorInfo.HmiReadParID.ErrorText	:= 'The communication structure is too big';
		
	END_CASE;
	
END_ACTION
