(*********************************************************************************
 * Copyright: Bernecker + Rainer
 * Author:  B+R
 * Created:  November 20, 2017/08:15 AM 
 *********************************************************************************
 *********************************************************************************
 * Version History:
 * -------------------------------------------------------------------------------
 * V 1.00.0   November 20, 2017/08:15 AM  First Version
 *********************************************************************************
 * Description:
 * -------------------------------------------------------------------------------
 * This task is used for setting Shuttle(Pallet) IDs
 *********************************************************************************)

ACTION SetPalletIDs:
	
	// Check if actual shuttles has an ID
	IF StTargetExt_[StartTarget-1].PalletPresent AND StTargetExt_[StartTarget-1].PalletID = 0 THEN
		StTargetExt_[StartTarget-1].SetPalletID	:= TRUE;
	// Release the shuttle to a Wait target
	ELSIF StTargetExt_[StartTarget-1].CommandDone AND StTargetExt_[StartTarget-1].SetPalletID THEN
		StTargetExt_[StartTarget-1].SetPalletID	:= FALSE;
		PalletControlParameters[TargetControlParameters[StartTarget-1].PalletConfig.ID-1].AdvancedReleaseConfig.Direction			:= stCOM_DIR_RIGHT;
		PalletControlParameters[TargetControlParameters[StartTarget-1].PalletConfig.ID-1].AdvancedReleaseConfig.DestinationTarget	:= WaitTarget;
		StPallet_[TargetControlParameters[StartTarget-1].PalletConfig.ID-1].ReleaseToTarget											:= TRUE;
		TargetControlParameters[StartTarget-1].PalletConfig.ID	:= TargetControlParameters[StartTarget-1].PalletConfig.ID + 1;
	END_IF;
	
	// Count the shuttles on the Wait target (Target 2)
	FOR IndexSetIDs := 0 TO (SIZEOF(StPallet_) / SIZEOF(StPallet_[0])) - 1 DO
		IF StPallet_[IndexSetIDs].CommandDone THEN
			StPallet_[IndexSetIDs].ReleaseToTarget	:= FALSE;
		END_IF;
	END_FOR;
	
	// Release shuttles from Wait target
	IF StTargetExt_[WaitTarget-1].PalletPresent AND NOT(StTargetExt_[WaitTarget-1].ReleaseToTarget) THEN
		TargetControlParameters[WaitTarget-1].AdvancedReleaseConfig.DestinationTarget	:= StartTarget;
		TargetControlParameters[WaitTarget-1].AdvancedReleaseConfig.Direction			:= stCOM_DIR_RIGHT;
		StTargetExt_[WaitTarget-1].ReleaseToTarget	:= TRUE;
		ReleasedShuttles							:= ReleasedShuttles + 1;
	ELSIF StTargetExt_[WaitTarget-1].CommandDone THEN
		StTargetExt_[WaitTarget-1].ReleaseToTarget	:= FALSE;
	END_IF;
	
	// Check if all shuttles have IDs and are released from Wait target
	IF StTargetExt_[StartTarget-1].PalletPresent AND StTargetExt_[StartTarget-1].PalletID >= 1 AND TargetControlParameters[StartTarget-1].PalletConfig.ID > NumberOfShuttles AND
		ReleasedShuttles = NumberOfShuttles THEN
		IDSet	:= TRUE;
	// Check if all shuttles have an ID. Release shuttles if not all have an ID and wait for the problematic shuttle
	ELSIF StTargetExt_[StartTarget-1].PalletPresent AND StTargetExt_[StartTarget-1].PalletID <> 0 AND TargetControlParameters[StartTarget-1].PalletConfig.ID <= NumberOfShuttles THEN
		StPallet_[StTargetExt_[StartTarget-1].PalletID-1].ReleaseToTarget	:= TRUE;
	END_IF;
	
END_ACTION
