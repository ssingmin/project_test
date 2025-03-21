(*********************************************************************************
 * Copyright: Bernecker + Rainer
 * Author:  B+R
 * Created:  July 27, 2016/10:44 AM 
 *********************************************************************************
 *********************************************************************************
 * Version History:
 * -------------------------------------------------------------------------------
 * V 1.00.0   July 27, 2016/10:44 AM  First Version
 *********************************************************************************
 * Description:
 * -------------------------------------------------------------------------------
 * July 27, 2016/10:44 AM V1.00.0:
 * This task is an example OF simple SuperTrak control
 *********************************************************************************)

PROGRAM _INIT
 
 	(*************************************************************************************************)
 	(*************************************************************************************************)
 	(* FUNCTION BLOCK CONFIGURATION *)
 
 	// Configure the internal communication structure to/from SuperTrak
	SuperTrakControlParameters.NrOfCommands 	:= CONFIG_ST_MAX_COMMANDS;
	SuperTrakControlParameters.NrOfPallets  	:= CONFIG_ST_MAX_PALLETS;
	SuperTrakControlParameters.NrOfSections 	:= CONFIG_ST_MAX_SECTIONS;
	SuperTrakControlParameters.NrOfTargets  	:= CONFIG_ST_MAX_TARGETS;
 
	(*************************************************************************************************)
	(*************************************************************************************************)
	(* FUNCTION BLOCK INITIALIZATION *)

	// Initialize the function block, handling the communication to/from SuperTrak
	StControl_0.StLink      	 				:= ADR(gStLink);
	StControl_0.Enable       					:= TRUE;
	StControl_0.Parameters      				:= ADR(SuperTrakControlParameters);
	StControl_0.StCtrlData      				:= ADR(gStCyclicControlData);
	StControl_0.StCtrlDataSize     				:= SIZEOF(gStCyclicControlData);
	StControl_0.StStatData      				:= ADR(gStCyclicStatusData);
	StControl_0.StStatDataSize     				:= SIZEOF(gStCyclicStatusData);
	StControl_0.StServChRequestData   			:= ADR(gStServiceChannelReqData);
	StControl_0.StServChRequestDataSize  		:= SIZEOF(gStServiceChannelReqData);
	StControl_0.StServChResponseData  			:= ADR(gStServiceChannelResData);
	StControl_0.StServChResponseDataSize 		:= SIZEOF(gStServiceChannelResData);
 
	// Initialize the fucntion blocks, controlling a single section
	FOR Index := 0 TO (SIZEOF(StSection_) / SIZEOF(StSection_[0])) - 1 DO
		StSection_[Index].StLink    			:= ADR(gStLink);
		StSection_[Index].Parameters   			:= ADR(SuperTrakSectionParameters);
		StSection_[Index].Section    			:= Index + 1;
	END_FOR;

	// Initialize the fucntion blocks, controlling a single section
	FOR Index := 0 TO (SIZEOF(StTargetExt_) / SIZEOF(StTargetExt_[0])) - 1 DO
		StTargetExt_[Index].StLink    			:= ADR(gStLink);
		StTargetExt_[Index].Parameters  		:= ADR(TargetControlParameters[Index]);
		StTargetExt_[Index].Target    			:= Index + 1;
	END_FOR;
	
// Initialize the fucntion blocks, controlling a single section
	FOR Index := 0 TO (SIZEOF(StPallet_) / SIZEOF(StPallet_[0])) - 1 DO
		StPallet_[Index].StLink 				:= ADR(gStLink);
		StPallet_[Index].Parameters 			:= ADR(PalletControlParameters[Index]);
		StPallet_[Index].PalletID 				:= Index + 1;
		
		PalletControlParameters[Index].PalletConfig.Shelf.ShelfWidth					:= 152;
		PalletControlParameters[Index].PalletConfig.Shelf.OffsetFromCenter				:= 0;
		PalletControlParameters[Index].PalletConfig.Controller.ControlGainSetIdx		:= 0;
		PalletControlParameters[Index].PalletConfig.Controller.FilterWeightMoving		:= 0.5;
		PalletControlParameters[Index].PalletConfig.Controller.FilterWeightStationary	:= 0.5;
	END_FOR;
	
	
	// Initialize the function block for AntiSloshing 
	StAdvCmd_0.StLink 							:= ADR(gStLink);
	StAdvCmd_0.Parameters 						:= ADR(StAdvCmdParameters);
	
	// Set Parameters for AntiSloshing
	StAdvCmdParameters.CommandID   	 			:= 82;				// Specify the Control-Parent; 80 -> Target; 82 -> PalletID
	StAdvCmdParameters.Context		 			:= 1;				// Used PalletID -> 1; ID will be checked at the start of the Anti-Sloshing mode
	StAdvCmdParameters.Parameters[0] 			:= 1;				// Used Container-Shape; 0 -> None; 1 -> Rectangle; 2 -> Cylinder
	StAdvCmdParameters.Parameters[1] 			:= 2;				// Used Oscillation-Mode
	StAdvCmdParameters.Parameters[2] 			:= 189;				// Length of the Container [mm], "Liquid-Length"
	StAdvCmdParameters.Parameters[3]			:= 0;
	StAdvCmdParameters.Parameters[4] 			:= 58;				// Fill-Height of the liquid
	StAdvCmdParameters.Parameters[5] 			:= 0;
	
	ContainerShape								:= 1;				// Used Container-Shape; 0 -> None; 1 -> Rectangle; 2 -> Cylinder
	ContainerLength								:= 189;				// Length of the Container [mm], "Liquid-Length"
	ContainerHeight								:= 58;				// Fill-Height of the liquid

	
	// Set start parameters to read temperatures
	SectionID									:= 1;
	
	// Set start section to be displayed at the Temperatures, Alarm and Shuttle page
	VisuSection									:= 1;
	VisuAlarmSection							:= 1;
	VisuShuttle									:= 1;
	
	// Target where shuttles get IDs
	StartTarget									:= 1;
	WaitTarget									:= 2;
	
	// Start of the Expert mode
	StateCnc									:= EXPERT_MODE_START;
	CncStartTarget								:= 1;
	
	// Set the WritePnu parameter
	StWritePnu_Region.StLink					:= ADR(gStLink);
	StWritePnu_Region.Parameters				:= ADR(StWritePnuPar_Region);
	
	// Set the ReadPnu parameter
	StReadPnu_Region.StLink						:= ADR(gStLink);
	StReadPnu_Region.Parameters					:= ADR(StReadPnuPar_Region);
	
	RegionStatus								:= 7;			// 7 --> Bit 0,1,2 --> Enable Region, Limit v, Limit a
	TimerRegionEnable.PT						:= T#1s;
	
	// Get the used cycle time
	RTInfo_0.enable								:= TRUE;
	RTInfo_0();
	CycleTime									:= UDINT_TO_REAL(RTInfo_0.cycle_time)/1000;
	
	// Init mappAlarmX parameters
	AlarmXInit;
	
	//ParID Hmi Init
	InitParID;
	
	// Init shuttle config page
	Config_ShelfWidth				:= 152;
	Config_OffsetFromCenter			:= 0;
	Config_ControlGainSetIndex		:= 0;
	Config_FilterWeightMoving		:= 0.5;
	Config_FilterWeightStationary	:= 0.5;
	
END_PROGRAM

PROGRAM _CYCLIC
	
 	(*************************************************************************************************)
 	(*************************************************************************************************)
 	(* FUNCTION BLOCK ENABLE *)
 
 	// Wait for StControl to be active, before enalbing all other function blocks
	IF StControl_0.Active THEN
		// Loop thru all StSection function blocks
		FOR Index := 0 TO (SIZEOF(StSection_) / SIZEOF(StSection_[0])) - 1 DO
			// Enable StSection
			StSection_[Index].Enable     		:= TRUE; 
			IF StSection_[Index].Error = FALSE AND StSection_[Index].Info.SuperTrak.SectionFaultActive = FALSE AND StSection_[Index].ErrorReset THEN
				StSection_[Index].ErrorReset	:= FALSE;
			END_IF;
		END_FOR;
		
		// Loop thru all StTargetExt function blocks
		FOR Index := 0 TO (SIZEOF(StTargetExt_) / SIZEOF(StTargetExt_[0])) - 1 DO
			// Enable StTargetExt
			StTargetExt_[Index].Enable     		:= TRUE; 
			IF StTargetExt_[Index].Error = FALSE AND StTargetExt_[Index].ErrorReset THEN
				StTargetExt_[Index].ErrorReset	:= FALSE;
			END_IF;
		END_FOR;
		
		// Loop thru all StPallet function blocks
		FOR Index := 0 TO (SIZEOF(StPallet_) / SIZEOF(StPallet_[0])) - 1 DO
			// Enable StPallet
			StPallet_[Index].Enable 			:= TRUE;
			IF StPallet_[Index].Error = FALSE AND StPallet_[Index].ErrorReset THEN
				StPallet_[Index].ErrorReset		:= FALSE;
			END_IF;
		END_FOR;
		
		// Enable AntiSloshing function block
		StAdvCmd_0.Enable 						:= TRUE;
		
		// Reset ErrorReset
		IF StReadPnu_Region.Error = FALSE AND StReadPnu_Region.ErrorReset THEN
			StReadPnu_Region.ErrorReset			:= FALSE;
		END_IF;
		
		// Reset ErrorReset
		IF StWritePnu_Region.Error = FALSE AND StWritePnu_Region.ErrorReset THEN
			StWritePnu_Region.ErrorReset		:= FALSE;
		END_IF;
		
		// Enable the start-up region
		IF NOT(IDSet) AND RegionEnabled = FALSE THEN
			EnableRegion;
		END_IF;
	END_IF;
	
	// Wait for HmiControl to be active, before enalbing all other function blocks
	IF HmiControl_0.Active THEN
		HmiWriteParID_0.Enable					:= TRUE;
		HmiReadParID_0.Enable					:= TRUE;
		
		IF HmiWriteParID_0.SaveParameters AND HmiWriteParID_0.CommandDone THEN
			SaveSuccessful						:= TRUE;
			SaveFailed							:= FALSE;
		ELSIF HmiWriteParID_0.SaveParameters AND HmiWriteParID_0.Error THEN
			SaveSuccessful						:= FALSE;
			SaveFailed							:= TRUE;
		END_IF;
		
		IF NOT(HmiWriteParID_0.SaveParameters) AND EDGEPOS(HmiWriteParID_0.CommandDone) THEN
			SaveSuccessful						:= FALSE;
			SaveFailed							:= FALSE;
		END_IF;
		
		IF HmiWriteParID_0.Error THEN
			HmiWriteParID_0.WriteUDINT			:= FALSE;
			HmiWriteParID_0.WriteUINT			:= FALSE;
			HmiWriteParID_0.WriteUSINT			:= FALSE;
			HmiWriteParID_0.WriteDINT			:= FALSE;
			HmiWriteParID_0.WriteINT			:= FALSE;
			HmiWriteParID_0.WriteSINT			:= FALSE;
			HmiWriteParID_0.WriteREAL			:= FALSE;
			HmiWriteParID_0.WriteSTRING			:= FALSE;
			HmiWriteParID_0.SaveParameters		:= FALSE;
		END_IF;
		
		IF HmiReadParID_0.Error THEN
			HmiReadParID_0.ReadUDINT			:= FALSE;
			HmiReadParID_0.ReadUINT				:= FALSE;
			HmiReadParID_0.ReadUSINT			:= FALSE;
			HmiReadParID_0.ReadDINT				:= FALSE;
			HmiReadParID_0.ReadINT				:= FALSE;
			HmiReadParID_0.ReadSINT				:= FALSE;
			HmiReadParID_0.ReadREAL				:= FALSE;
			HmiReadParID_0.ReadSTRING			:= FALSE;
		END_IF;
		
		IF HmiReadParID_0.Error = FALSE AND HmiReadParID_0.ErrorReset THEN
			HmiReadParID_0.ErrorReset			:= FALSE;
		END_IF;
		
		IF HmiWriteParID_0.Error = FALSE AND HmiWriteParID_0.ErrorReset THEN
			HmiWriteParID_0.ErrorReset			:= FALSE;
		END_IF;
	END_IF;
	
	// Read temperatures
	ReadTemp;
	
	(*************************************************************************************************)
	(*************************************************************************************************)
	(* ENABLE / DISABLE SUPERTRAK SECTIONS *)
 
	// Wait for command, to enable all sections
	IF SuperTrakControl.Command.EnableAllSections THEN
		// Loop thru all StSection function blocks
		FOR Index := 0 TO (SIZEOF(StSection_) / SIZEOF(StSection_[0])) - 1 DO
			// Check if section is ready to be enalbed
			IF StSection_[Index].MotorPowerOn AND NOT StSection_[Index].Error THEN
				// Enable section
				StSection_[Index].EnableSection := TRUE; 
			END_IF; 
		END_FOR;
  
		// If command is reset, disable all sections
	ELSE
		// Loop thru all StSection function blocks
		FOR Index := 0 TO (SIZEOF(StSection_) / SIZEOF(StSection_[0])) - 1 DO
			// Disable section
			StSection_[Index].EnableSection    	:= FALSE; 
		END_FOR;
	END_IF;	
	
	// Sections enabled and SuperTrak ready to perform a movement
	IF SuperTrakControl.Status.AllSectionsEnabled THEN	
		// Set global status to true if all sections are enabled
		gAllSectionsEnabled 					:= TRUE;
		
		// Get the number of shuttles on the SuperTrak
		NumberOfShuttles						:= UINT_TO_USINT(StControl_0.Info.SuperTrak.NrOfPallets);
	
		// Check if the shuttles are in standstill
		SuperTrakGetPalletInfo(ADR(ShuttleInfo),NumberOfShuttles,FALSE);
		CheckStandstill;
		
		// Assign Pallet ID to the existing Shuttles
		IF NOT(IDSet) AND RegionEnabled THEN
			SetPalletIDs;
		END_IF;
		
		// Disable the start-up region
		IF IDSet AND NOT(RegionDisabled) AND ShuttlesStandstill THEN
			DisableRegion;
		END_IF;
		
		IF IDSet AND RegionDisabled THEN
			(* Call Actions *)
			IF NOT(SuperTrakControl.Status.TrackingEnabled) AND NOT(SuperTrakControl.Status.PalletControl) THEN
				// Action for AntiSloshing
				AntiSloshing;
			ELSE
				cmd_StartAntiSloshing	:= FALSE;
				cmd_StopAntiSloshing	:= FALSE;
			END_IF;
			
			IF NOT(SuperTrakControl.Status.TrackingEnabled) AND NOT(SuperTrakControl.Status.AntiSloshingEnabled) THEN
				// Action for Shuttle-Control
				PalletControl;
			ELSE
				cmd_StartPalletControl	:= FALSE;
				cmd_StopPalletControl	:= FALSE;
			END_IF;
			
			IF NOT(SuperTrakControl.Status.PalletControl) AND NOT(SuperTrakControl.Status.AntiSloshingEnabled) THEN
				// Action for Tracking a shuttle
				ExpertMode;
			ELSE
				cmd_StartTracking		:= FALSE;
				cmd_StopTracking		:= FALSE;
			END_IF;
		
			// Move all shuttles to target 1 when no mode is selected
			IF NOT(SuperTrakControl.Status.PalletControl) AND NOT(SuperTrakControl.Status.TrackingEnabled) AND NOT(SuperTrakControl.Status.AntiSloshingEnabled) THEN
				
				FOR Index := 1 TO (SIZEOF(TargetControlParameters) / SIZEOF(TargetControlParameters[0])) - 1 DO
					TargetControlParameters[Index].AdvancedReleaseConfig.DestinationTarget := 1;
					TargetControlParameters[Index].AdvancedReleaseConfig.Direction	       := stCOM_DIR_RIGHT; 
					IF StTargetExt_[Index].PalletPresent THEN
						StTargetExt_[Index].ReleaseToTarget	:= TRUE;
					ELSE 
						StTargetExt_[Index].ReleaseToTarget := FALSE;
					END_IF;
				END_FOR;
				
			END_IF;
		END_IF;
	ELSIF IDSet THEN
		// Reset the global status if the sections are not enabled
		gAllSectionsEnabled 	:= FALSE;
		
		cmd_StartAntiSloshing	:= FALSE;
		cmd_StopAntiSloshing	:= TRUE;
		cmd_StartPalletControl	:= FALSE;
		cmd_StopPalletControl	:= TRUE;
		cmd_StartTracking		:= FALSE;
		cmd_StopTracking		:= TRUE;
	END_IF

	(*************************************************************************************************)
	(*************************************************************************************************)
	(* CALL THE ERROR HANDLING *)
	ReadErrorMessages;
	
	// Reset all active errors and warnings
	IF AcknowledgeAll THEN
		StControl_0.ErrorReset					:= StControl_0.Error OR StControl_0.StatusID <> 0;
		StReadPnu_Region.ErrorReset				:= StReadPnu_Region.Error OR StReadPnu_Region.StatusID <> 0;
		StWritePnu_Region.ErrorReset			:= StWritePnu_Region.Error OR StWritePnu_Region.StatusID <> 0;
		FOR Index := 0 TO (SIZEOF(StTargetExt_) / SIZEOF(StTargetExt_[0])) - 1 DO
			StTargetExt_[Index].ErrorReset   	:= StTargetExt_[Index].Error OR StTargetExt_[Index].StatusID <> 0;
		END_FOR;
		FOR Index := 0 TO (SIZEOF(StSection_) / SIZEOF(StSection_[0])) - 1 DO
			StSection_[Index].ErrorReset  		:= StSection_[Index].Error OR StSection_[Index].StatusID <> 0; 
		END_FOR;
		FOR Index := 0 TO (SIZEOF(StPallet_) / SIZEOF(StPallet_[0])) - 1 DO
			StPallet_[Index].ErrorReset			:= StPallet_[Index].Error OR StPallet_[Index].StatusID <> 0;
		END_FOR;
		HmiReadParID_0.ErrorReset				:= HmiReadParID_0.Error OR HmiReadParID_0.StatusID <> 0;
		HmiWriteParID_0.ErrorReset				:= HmiWriteParID_0.Error OR HmiWriteParID_0.StatusID <> 0;
		AcknowledgeAll							:= FALSE;
	END_IF;
	
	(*************************************************************************************************)
	(*************************************************************************************************)
	(* Reset Read and Write commands *)	
	// Reset all write commands
	IF HmiWriteParID_0.CommandDone THEN
		HmiWriteParID_0.WriteUDINT				:= FALSE;
		HmiWriteParID_0.WriteUINT				:= FALSE;
		HmiWriteParID_0.WriteUSINT				:= FALSE;
		HmiWriteParID_0.WriteDINT				:= FALSE;
		HmiWriteParID_0.WriteINT				:= FALSE;
		HmiWriteParID_0.WriteSINT				:= FALSE;
		HmiWriteParID_0.WriteREAL				:= FALSE;
		HmiWriteParID_0.WriteSTRING				:= FALSE;
	END_IF;
	
	// Reset all read commands
	IF HmiReadParID_0.CommandDone THEN
		HmiReadParID_0.ReadUDINT				:= FALSE;
		HmiReadParID_0.ReadUINT					:= FALSE;
		HmiReadParID_0.ReadUSINT				:= FALSE;
		HmiReadParID_0.ReadDINT					:= FALSE;
		HmiReadParID_0.ReadINT					:= FALSE;
		HmiReadParID_0.ReadSINT					:= FALSE;
		HmiReadParID_0.ReadREAL					:= FALSE;
		HmiReadParID_0.ReadSTRING				:= FALSE;
	END_IF;
	
	(*************************************************************************************************)
	(*************************************************************************************************)
	(* CALL THE mapp ALARMX ERROR HANDLING *)
	
	AlarmX;
	
	(*************************************************************************************************)
	(*************************************************************************************************)
	(* CALL THE shuttle configuration task *)
	
	ShuttleConfig;
	
	(*************************************************************************************************)
	(*************************************************************************************************)
	(* FUNCTION BLOCK CALLS *)
 
	// Call StControl
	StControl_0();
 
	// Loop thru all StSection function blocks
	FOR Index := 0 TO (SIZEOF(StSection_) / SIZEOF(StSection_[0])) - 1 DO
		// Call StSection
		StSection_[Index]();
	END_FOR;
 
	// Loop thru all StTargetExt function blocks
	FOR Index := 0 TO (SIZEOF(StTargetExt_) / SIZEOF(StTargetExt_[0])) - 1 DO
		// Call StTargetExt
		StTargetExt_[Index]();
	END_FOR;
	
	// Loop thru all StPallet function blocks
	FOR Index := 0 TO (SIZEOF(StPallet_) / SIZEOF(StPallet_[0])) - 1 DO
		// Call StPallet
		StPallet_[Index]();
	END_FOR;
	
	// Call StAdvCmd
	StAdvCmd_0();
	
	// Call StWritePnu
	StWritePnu_Region();
	
	// Call StReadPnu
	StReadPnu_Region();
	
	// Call the Timer
	TimerRegionEnable();
	
	// Call HmiControl
	HmiControl_0();
	
	// Call HmiWriteParID
	HmiWriteParID_0();
	
	// Call HmiReadParID
	HmiReadParID_0();
 
	(*************************************************************************************************)
	(*************************************************************************************************)
	(* MAPPING OF STATUS VARIABLES *)
 
	// Set information on wether all sections are enabled or not, to command structure
	SuperTrakControl.Status.AllSectionsEnabled   := StControl_0.SectionsEnabled;
	
END_PROGRAM

PROGRAM _EXIT
	
	// Disable the FUB
	StControl_0.Enable	:= FALSE;
	// Call the StControl
	StControl_0();
	
	// Loop thru all StSection function blocks
	FOR Index := 0 TO (SIZEOF(StSection_) / SIZEOF(StSection_[0])) - 1 DO
		// Disable the FUB
		StSection_[Index].Enable	:= FALSE;
		// Call StSection
		StSection_[Index]();
	END_FOR;
 
	// Loop thru all StTargetExt function blocks
	FOR Index := 0 TO (SIZEOF(StTargetExt_) / SIZEOF(StTargetExt_[0])) - 1 DO
		// Disable the FUB
		StTargetExt_[Index].Enable	:= FALSE;
		// Call StTargetExt
		StTargetExt_[Index]();
	END_FOR;
	
	// Loop thru all StPallet function blocks
	FOR Index := 0 TO (SIZEOF(StPallet_) / SIZEOF(StPallet_[0])) - 1 DO
		// Disable the FUB
		StPallet_[Index].Enable		:= FALSE;
		// Call StPallet
		StPallet_[Index]();
	END_FOR;
	
	// Disable the FUB
	StAdvCmd_0.Enable				:= FALSE;
	// Call StAdvCmd
	StAdvCmd_0();
	
	// Disable the FUB
	StWritePnu_Region.Enable		:= FALSE;
	// Call StWritePnu
	StWritePnu_Region();
	
	// Disable the FUB
	StReadPnu_Region.Enable			:= FALSE;
	// Call StReadPnu
	StReadPnu_Region();
	
	// Disable the FUB
	HmiControl_0.Enable				:= FALSE;
	// Call StHmiControl
	HmiControl_0();
	
	// Disable the FUB
	HmiWriteParID_0.Enable			:= FALSE;
	// Call StHmiWriteParID
	HmiWriteParID_0();
	
	// Disable the FUB
	HmiReadParID_0.Enable			:= FALSE;
	// Call StHmiReadParID
	HmiReadParID_0();
	
END_PROGRAM
