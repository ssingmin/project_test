
(*********************************************************************************
 * Copyright: COPYRIGHT (C) BERNECKER + RAINER, AUSTRIA
 *********************************************************************************
 * Author:  B+R  Created:  November 23, 2017/08:15 PM
 *********************************************************************************
 * Description: Implementation of the AntiSloshing functionality for every shuttle
 *********************************************************************************)
ACTION AntiSloshing: 	
	// Execute AntiSloshing
	IF cmd_StartAntiSloshing THEN
		// Wait for shuttle
		StAdvCmdParameters.Context 				:= StTargetExt_[0].PalletID;
		StAdvCmdParameters.Parameters[0] 		:= ContainerShape;
		brsmemcpy(ADR(StAdvCmdParameters.Parameters[2]),ADR(ContainerLength),SIZEOF(ContainerLength));
		brsmemcpy(ADR(StAdvCmdParameters.Parameters[4]),ADR(ContainerHeight),SIZEOF(ContainerHeight));
			
		// Set proper Motion-Parameters for used container
		TargetControlParameters[0].PalletConfig.Motion.Velocity 	:= 2000;	//  [mm/s]
		TargetControlParameters[0].PalletConfig.Motion.Acceleration := 3500;	//	[mm/s²]	
		// 
		StTargetExt_[0].SetPalletMotionPar 		:= TRUE;
		IF	StTargetExt_[0].CommandDone THEN
			StTargetExt_[0].SetPalletMotionPar 	:= FALSE;
			// Execute the AntiSloshing
			StAdvCmd_0.SendCommand 				:= TRUE;
			cmd_StartAntiSloshing 				:= FALSE;
		END_IF;
	END_IF	
	// Reset the Input of the Antisloshing function block
	IF ((EDGEPOS(StAdvCmd_0.CommandDone) AND StAdvCmd_0.SendCommand) OR StTargetExt_[0].Update OR StTargetExt_[4].Update OR StTargetExt_[5].Update) AND NOT(cmd_StopAntiSloshing)THEN
		StAdvCmd_0.SendCommand 						:= FALSE;
		
		// Set the Destination-Targets for each Target
		TargetControlParameters[0].AdvancedReleaseConfig.DestinationTarget := 5;
		TargetControlParameters[0].AdvancedReleaseConfig.Direction := stCOM_DIR_RIGHT;
		TargetControlParameters[4].AdvancedReleaseConfig.DestinationTarget := 6;
		TargetControlParameters[4].AdvancedReleaseConfig.Direction := stCOM_DIR_RIGHT;
		TargetControlParameters[5].AdvancedReleaseConfig.DestinationTarget := 5;
		TargetControlParameters[5].AdvancedReleaseConfig.Direction := stCOM_DIR_LEFT;
		
		// Update the targets
		StTargetExt_[0].Update						:= TRUE;
		StTargetExt_[4].Update						:= TRUE;
		StTargetExt_[5].Update						:= TRUE;
		IF StTargetExt_[0].UpdateDone AND StTargetExt_[4].UpdateDone AND StTargetExt_[5].UpdateDone THEN
			StTargetExt_[0].Update					:= FALSE;
			StTargetExt_[4].Update					:= FALSE;
			StTargetExt_[5].Update					:= FALSE;
			SuperTrakControl.Status.AntiSloshingEnabled := TRUE;
			StTargetExt_[0].ReleaseToTarget				:= TRUE;
		END_IF;
	END_IF
	IF StTargetExt_[0].PalletPresent = FALSE THEN
		StTargetExt_[0].ReleaseToTarget				:= FALSE;
	END_IF;
	// Timer for Stopping on the Target
	Target_TON[0].PT := StopTime;
	Target_TON[0].IN := StTargetExt_[4].PalletPresent OR StTargetExt_[5].PalletPresent;
	Target_TON[0]();
	
	// Sending the Pallet constantly from Target 2 to Target 3 and back
	IF SuperTrakControl.Status.AntiSloshingEnabled THEN
		StTargetExt_[4].ReleaseToTarget := StTargetExt_[4].PalletPresent AND Target_TON[0].Q;
		StTargetExt_[5].ReleaseToTarget := StTargetExt_[5].PalletPresent AND Target_TON[0].Q AND NOT(cmd_StopAntiSloshing);
	END_IF
	// Stop Executing AntiSloshing
	IF cmd_StopAntiSloshing AND (StTargetExt_[4].PalletPresent OR StTargetExt_[5].PalletPresent OR SuperTrakControl.Status.AntiSloshingEnabled = FALSE) THEN
		cmd_StartAntiSloshing 	:= FALSE;
		StAdvCmdParameters.Parameters[0] := 0;
		StAdvCmd_0.SendCommand 	:= TRUE;	
		IF EDGEPOS(StAdvCmd_0.CommandDone) AND StAdvCmd_0.SendCommand THEN
			SuperTrakControl.Status.AntiSloshingEnabled := FALSE;
		END_IF	
		IF SuperTrakControl.Status.AntiSloshingEnabled = FALSE THEN
			// Send back to Init Position (Target 1)
			PalletControlParameters[StAdvCmdParameters.Context-1].AdvancedReleaseConfig.DestinationTarget 	:= 1;
			PalletControlParameters[StAdvCmdParameters.Context-1].AdvancedReleaseConfig.Direction 			:= stCOM_DIR_RIGHT;
			StPallet_[StAdvCmdParameters.Context-1].ReleaseToTarget := TRUE;
			// Reset Inputs after the Pallet is in Position
			IF StPallet_[StAdvCmdParameters.Context-1].CommandDone THEN
				StPallet_[StAdvCmdParameters.Context-1].ReleaseToTarget 	:= FALSE;
				cmd_StopAntiSloshing			:= FALSE;
				StAdvCmd_0.SendCommand 			:= FALSE;
			END_IF
		END_IF	
	END_IF
			
END_ACTION
