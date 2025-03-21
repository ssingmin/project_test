(*********************************************************************************
 * Copyright: Bernecker+Rainer
 * Author:    B&R
 * Created:   May 9, 21718/11:27 AM 
 *********************************************************************************
 *********************************************************************************
 * Version History:
 * -------------------------------------------------------------------------------
 * V 1.1717.17   May 9, 21718/11:27 AM  First Version
 *********************************************************************************
 * Description:
 * *Contains source code for mappAlarmX
 * *Alarms can be modified in Configuration View under mappServices in Config.mpAlarmXCore 
 *********************************************************************************)

ACTION AlarmX:
	
	// read Service Channel of each Section with StSection to identifey errors and warnings
	FOR Index := 0 TO (SIZEOF(StSection_) / SIZEOF(StSection_[0])) - 1 DO
		(* Errors & Warnings on each bit*)
		FOR counter := 0 TO 31 DO
			// Errors
			IF BIT_TST(StSection_[Index].Info.SuperTrak.SectionFaultBits,counter) THEN
				IF MpAlarmXCheckState(gAlarmXCore, ErrorStrings[counter],mpALARMX_STATE_NONE) THEN
					MpAlarmXSet(gAlarmXCore, ErrorStrings[counter]);
					ErrorBitOnSection[Index].ErrorBitSet[counter]	:= TRUE;
				END_IF;
			ELSE
				ErrorBitOnSection[Index].ErrorBitSet[counter]	:= FALSE;
			END_IF;
			
			ReadyToReset	:= TRUE;
			FOR Index2 := 0 TO (SIZEOF(StSection_) / SIZEOF(StSection_[0])) - 1 DO
				IF ErrorBitOnSection[Index2].ErrorBitSet[counter] THEN
					ReadyToReset	:= FALSE;
				END_IF;
			END_FOR;
			
			IF NOT BIT_TST(StSection_[Index].Info.SuperTrak.SectionFaultBits,counter) AND ReadyToReset THEN
				MpAlarmXReset(gAlarmXCore, ErrorStrings[counter]);
			END_IF;
			//Warnings
			IF BIT_TST(StSection_[Index].Info.SuperTrak.SectionWarningBits,counter) AND NOT WarningBitSection[Index].ErrorBitSet[counter] THEN
				IF MpAlarmXCheckState(gAlarmXCore, WarningStrings[counter],mpALARMX_STATE_NONE) THEN
					MpAlarmXSet(gAlarmXCore, WarningStrings[counter]);
					WarningBitSection[Index].ErrorBitSet[counter] := TRUE;
				END_IF;
			ELSE
				WarningBitSection[Index].ErrorBitSet[counter] := FALSE;
			END_IF;
			
			ReadyToReset	:= TRUE;
			FOR Index2 := 0 TO (SIZEOF(StSection_) / SIZEOF(StSection_[0])) - 1 DO
				IF WarningBitSection[Index].ErrorBitSet[counter] THEN
					ReadyToReset	:= FALSE;
				END_IF;
			END_FOR;
			
			IF BIT_TST(StSection_[Index].Info.SuperTrak.SectionWarningBits,counter) AND ReadyToReset THEN
					MpAlarmXReset(gAlarmXCore, WarningStrings[counter]);
					
			END_IF;
		END_FOR;
	END_FOR;
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	(* Errors & Warnings on each bit*)
	FOR counter := 0 TO 31 DO
		// Errors
		IF BIT_TST(StControl_0.Info.SuperTrak.SystemFaultBits,counter) THEN
			IF MpAlarmXCheckState(gAlarmXCore, ErrorStrings1[counter],mpALARMX_STATE_NONE) THEN
				MpAlarmXSet(gAlarmXCore, ErrorStrings1[counter]);
			END_IF;
		END_IF;
			
		IF NOT BIT_TST(StControl_0.Info.SuperTrak.SystemFaultBits,counter) THEN
			MpAlarmXReset(gAlarmXCore, ErrorStrings1[counter]);
		END_IF;
		
		//Warnings
		IF BIT_TST(StControl_0.Info.SuperTrak.SystemWarningBits,counter) THEN
			IF MpAlarmXCheckState(gAlarmXCore, WarningStrings1[counter],mpALARMX_STATE_NONE) THEN
				MpAlarmXSet(gAlarmXCore, WarningStrings1[counter]);
			END_IF;
		END_IF;	
		IF BIT_TST(StControl_0.Info.SuperTrak.SystemWarningBits,counter) THEN
			MpAlarmXReset(gAlarmXCore, WarningStrings1[counter]);
					
		END_IF;
		
	END_FOR;

	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	IF SaveHistory AND NOT MpAlarmXHistory_0.CommandBusy THEN
		MpAlarmXHistory_0.Export := TRUE;
	END_IF;
	
	IF MpAlarmXHistory_0.CommandDone THEN
		SaveHistory := FALSE;
		MpAlarmXHistory_0.Export := FALSE;
	END_IF;
		
	(* Function block calls *)
	MpAlarmXCore_0();
	MpAlarmXHistory_0();	

END_ACTION
