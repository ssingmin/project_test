
(*****************************************************************************
 * Copyright: COPYRIGHT (C) BERNECKER + RAINER, AUSTRIA
 *****************************************************************************
 * Author:  B+R  Created:  November 23, 2017/09:45 AM
 *****************************************************************************
 * Description: Implementation OF the Tracking functionality
 ****************************************************************************)

(*****************************************************************************)
(*****************************************************************************)
(*************************NO COLLISION AVOIDANCE******************************)
(*****************************************************************************)
(*****************************************************************************)

ACTION ExpertMode: 
	(* IF all Sections are enabled the program can be executed *)
	IF SuperTrakControl.Status.AllSectionsEnabled THEN
		(* State of the Tracking *)
		CASE StateCnc OF
			(* Enter the expert mode when axis is on position = 0 to start the tracking *)
			(* The used shuttle should be on Section=1 Position=0 to start the tracking, otherwise jumps can happen *)
			(* Section=1 Position=0 --> Axis.Position = 0 *)
			EXPERT_MODE_START:
				IF gMpAxisBasic_0.Position = 0 THEN
					(* Axis ready *)
					gMpAxisBasic_0.MoveAbsolute		:= FALSE;
					gMpAxisBasic_0.Update			:= FALSE;
					(* Move all shuttles until shuttle 1 is on target 1 *)
					IF cmd_StartTracking AND StTargetExt_[CncStartTarget-1].PalletPresent THEN
						(* Enter the expert mode *)
						ControlledShuttle			:= StTargetExt_[CncStartTarget-1].PalletID;
						SuperTrakBeginExtCtrlStatus	:= SuperTrakBeginExternalControl(ControlledShuttle);
						IF SuperTrakBeginExtCtrlStatus THEN
							StateCnc				:= EXPERT_MODE_EXECUTE;
							SuperTrakControl.Status.TrackingEnabled	:= TRUE;
						END_IF
					END_IF;
					(* Move the axis to 0 *)
				ELSIF gMpAxisBasic_0.Position <> 0 THEN
					gMpAxisBasicParam.Position		:= 0;
					gMpAxisBasic_0.Update			:= TRUE;
					IF gMpAxisBasic_0.UpdateDone THEN
						gMpAxisBasic_0.MoveAbsolute	:= TRUE;
					END_IF;
				END_IF
			
			(* Tracking of the shuttle *)
			EXPERT_MODE_EXECUTE:
				(* Get the actual position of the axis *)
				Position							:= LREAL_TO_DINT(gMpAxisBasic_0.Position*1000);
				(* Calculate the section and position where the shutlle should be located *)
				FOR Index:=1 TO CONFIG_ST_MAX_SECTIONS DO
					IF Position - SectionLength[Index] < 0 THEN
						CncUpdateSection			:= Index;
						CncUpdatePosition			:= Position;
						EXIT;
					ELSE
						Position					:= Position - SectionLength[Index];
					END_IF
				END_FOR
			
				(* Calculate velocity and acceleration of the axis *)
				(* Velocity = mm/s and cycle time = ms *)
				(* mm/s / ms =  m/s²*)
				CncUpdateAccel						:= (gMpAxisBasic_0.Velocity-OldVelocity)/CycleTime;	//0.8 --> cycle time
				CncUpdateVelocity					:= REAL_TO_INT(gMpAxisBasic_0.Velocity);
				OldVelocity							:= gMpAxisBasic_0.Velocity;
			
				(* Call the Tracking function *)
				IF NOT(cmd_StopTracking) THEN
					SuperTrakPalletControlStatus	:= SuperTrakPalletControl(ControlledShuttle,CncUpdateSection,CncUpdatePosition,REAL_TO_INT(CncUpdateVelocity),CncUpdateAccel);	
				END_IF;
				
				(* To exit this mode the StPallet FUB must be used to send the shuttle to a target *)
				(* After exit the expert mode, the SuperTrakBeginExternalControl must be called again *)
				IF cmd_StopTracking THEN
					(* Set parameters for controlled shuttle *)
					IF PalletControlParameters[ControlledShuttle-1].AdvancedReleaseConfig.DestinationTarget <> CncStartTarget OR PalletControlParameters[ControlledShuttle-1].AdvancedReleaseConfig.Direction <> stCOM_DIR_RIGHT THEN
						PalletControlParameters[ControlledShuttle-1].AdvancedReleaseConfig.DestinationTarget	:= CncStartTarget;
						PalletControlParameters[ControlledShuttle-1].AdvancedReleaseConfig.Direction			:= stCOM_DIR_RIGHT;
						PalletControlParameters[ControlledShuttle-1].PalletConfig.Motion.Acceleration 			:= 20000;
						PalletControlParameters[ControlledShuttle-1].PalletConfig.Motion.Velocity 				:= 2000;
						StPallet_[ControlledShuttle-1].Update			:= TRUE;
					ELSE
						StPallet_[ControlledShuttle-1].ReleaseToTarget	:= TRUE;
					END_IF;
					(* Release the shuttle *)
					IF StPallet_[ControlledShuttle-1].UpdateDone THEN
						StPallet_[ControlledShuttle-1].ReleaseToTarget	:= TRUE;
						StPallet_[ControlledShuttle-1].Update			:= FALSE;
					END_IF;
					(* Reset the parameter *)	
					IF StPallet_[ControlledShuttle-1].CommandDone AND StPallet_[ControlledShuttle-1].ReleaseToTarget THEN
						StPallet_[ControlledShuttle-1].ReleaseToTarget	:= FALSE;
						StateCnc					:= EXPERT_MODE_START;
						cmd_StartTracking			:= FALSE;
						cmd_StopTracking			:= FALSE;
						gMpAxisBasic_0.MoveAbsolute	:= FALSE;
						gMpAxisBasic_0.MoveAdditive	:= FALSE;
						gMpAxisBasic_0.MoveVelocity	:= FALSE;
						gMpAxisBasic_0.JogNegative	:= FALSE;
						gMpAxisBasic_0.JogPositive	:= FALSE;
						SuperTrakControl.Status.TrackingEnabled			:= FALSE;
					END_IF;	
				END_IF;

		END_CASE
	END_IF
END_ACTION
