
(*****************************************************************************
 * Copyright: COPYRIGHT (C) BERNECKER + RAINER, AUSTRIA
 *****************************************************************************
 * Author:  B+R  Created:  June 21, 2017/10:34 AM
 *****************************************************************************
 * Description: Implementation of a Pallet-Control
 ******************************************************************************)
ACTION PalletControl: 

	IF cmd_StartPalletControl THEN
		// Definition of the Destination-Target and the Direction of the movement
		TargetControlParameters[0].AdvancedReleaseConfig.DestinationTarget := 2;
		TargetControlParameters[0].AdvancedReleaseConfig.Direction			:= stCOM_DIR_RIGHT;
		TargetControlParameters[1].AdvancedReleaseConfig.DestinationTarget := 3;
		TargetControlParameters[1].AdvancedReleaseConfig.Direction	       := stCOM_DIR_RIGHT; 
		TargetControlParameters[2].AdvancedReleaseConfig.DestinationTarget := 1;
		TargetControlParameters[2].AdvancedReleaseConfig.Direction	        := stCOM_DIR_RIGHT;
			
		// Change Motion-Parameters at target
		IF EDGEPOS(StTargetExt_[1].PalletPresent) THEN
			TargetControlParameters[1].PalletConfig.Motion.Acceleration := 10000;
			TargetControlParameters[1].PalletConfig.Motion.Velocity		:= 1000;
			StTargetExt_[1].SetPalletMotionPar							:= TRUE;
		END_IF
		// Reset Input after command is done
		IF EDGEPOS(StTargetExt_[1].CommandDone) AND StTargetExt_[1].SetPalletMotionPar THEN
			StTargetExt_[1].SetPalletMotionPar							:= FALSE;
		END_IF
		// Release shuttle
		IF EDGENEG(StTargetExt_[1].CommandDone) AND StTargetExt_[1].PalletPresent THEN
			StTargetExt_[1].ReleaseToTarget := TRUE;
		END_IF
		// Reset the Relase to target command
		IF NOT(StTargetExt_[1].PalletPresent) THEN
			StTargetExt_[1].ReleaseToTarget := FALSE;
		END_IF
		// Change Motion-Parameters at target
		IF EDGEPOS(StTargetExt_[2].PalletPresent) THEN
			TargetControlParameters[2].PalletConfig.Motion.Acceleration := 15000;
			TargetControlParameters[2].PalletConfig.Motion.Velocity		:= 2500;
			StTargetExt_[2].SetPalletMotionPar							:= TRUE;
		END_IF
		// Reset Input after command is done
		IF EDGEPOS(StTargetExt_[2].CommandDone) AND StTargetExt_[2].SetPalletMotionPar THEN
			StTargetExt_[2].SetPalletMotionPar							:= FALSE;
		END_IF
		IF EDGENEG(StTargetExt_[2].CommandDone) THEN
			StTargetExt_[2].ReleaseToTarget := TRUE;
		END_IF
		// Reset the Relase to target command
		IF NOT(StTargetExt_[2].PalletPresent) THEN
			StTargetExt_[2].ReleaseToTarget := FALSE;
		END_IF
			
		// Simple release options of the pallet for target 1
		StTargetExt_[0].ReleaseToTarget 	:= StTargetExt_[0].PalletPresent;
		
		// Set Status
		SuperTrakControl.Status.PalletControl	:= TRUE;
	END_IF	
	
	// Stop pallet-control after user event
	IF cmd_StopPalletControl THEN
		cmd_StartPalletControl 	:= FALSE;
		cmd_StopPalletControl	:= FALSE;
		SuperTrakControl.Status.PalletControl	:= FALSE;
	END_IF	
	
END_ACTION
