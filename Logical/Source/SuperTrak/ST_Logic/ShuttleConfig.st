
ACTION ShuttleConfig: 

	///////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////
	// Use the actual selected shuttle to display
	// Count up the shuttle on the Temperatures Visu page
	IF EDGEPOS(CountUpShuttle) THEN
		VisuShuttle				:= VisuShuttle + 1;
		// Check for last section
		IF VisuShuttle = (StControl_0.Info.SuperTrak.NrOfPallets+1) THEN
			VisuShuttle			:= 1;
		END_IF;
		CountUpShuttle			:= FALSE;
		
		Config_ShelfWidth				:= PalletControlParameters[VisuShuttle-1].PalletConfig.Shelf.ShelfWidth;
		Config_OffsetFromCenter			:= PalletControlParameters[VisuShuttle-1].PalletConfig.Shelf.OffsetFromCenter;
		Config_ControlGainSetIndex		:= PalletControlParameters[VisuShuttle-1].PalletConfig.Controller.ControlGainSetIdx;
		Config_FilterWeightMoving		:= PalletControlParameters[VisuShuttle-1].PalletConfig.Controller.FilterWeightMoving;
		Config_FilterWeightStationary	:= PalletControlParameters[VisuShuttle-1].PalletConfig.Controller.FilterWeightStationary;
		
		// Count down the section on the Temperatures Visu page
	ELSIF EDGEPOS(CountDownShuttle) THEN
		VisuShuttle				:= VisuShuttle - 1;
		// Check for first section
		IF VisuShuttle = 0 THEN
			VisuShuttle			:= StControl_0.Info.SuperTrak.NrOfPallets;
		END_IF;
		CountDownShuttle		:= FALSE;
		
		Config_ShelfWidth				:= PalletControlParameters[VisuShuttle-1].PalletConfig.Shelf.ShelfWidth;
		Config_OffsetFromCenter			:= PalletControlParameters[VisuShuttle-1].PalletConfig.Shelf.OffsetFromCenter;
		Config_ControlGainSetIndex		:= PalletControlParameters[VisuShuttle-1].PalletConfig.Controller.ControlGainSetIdx;
		Config_FilterWeightMoving		:= PalletControlParameters[VisuShuttle-1].PalletConfig.Controller.FilterWeightMoving;
		Config_FilterWeightStationary	:= PalletControlParameters[VisuShuttle-1].PalletConfig.Controller.FilterWeightStationary;
	END_IF;
	
	PalletControlParameters[VisuShuttle-1].PalletConfig.Shelf.ShelfWidth					:= Config_ShelfWidth;
	PalletControlParameters[VisuShuttle-1].PalletConfig.Shelf.OffsetFromCenter				:= Config_OffsetFromCenter;
	PalletControlParameters[VisuShuttle-1].PalletConfig.Controller.ControlGainSetIdx		:= Config_ControlGainSetIndex;
	PalletControlParameters[VisuShuttle-1].PalletConfig.Controller.FilterWeightMoving		:= Config_FilterWeightMoving;
	PalletControlParameters[VisuShuttle-1].PalletConfig.Controller.FilterWeightStationary	:= Config_FilterWeightStationary;
	
	StPallet_[VisuShuttle-1].SetPalletShelf				:= Config_SetPalletShelf AND NOT(StPallet_[VisuShuttle-1].SetPalletGain);
	StPallet_[VisuShuttle-1].SetPalletGain				:= Config_SetGain AND NOT(StPallet_[VisuShuttle-1].SetPalletShelf);
	
	IF StPallet_[VisuShuttle-1].CommandDone THEN
		StPallet_[VisuShuttle-1].SetPalletShelf			:= FALSE;
		StPallet_[VisuShuttle-1].SetPalletGain			:= FALSE;
		Config_SetPalletShelf							:= FALSE;
		Config_SetGain									:= FALSE;
	END_IF;
	
END_ACTION
