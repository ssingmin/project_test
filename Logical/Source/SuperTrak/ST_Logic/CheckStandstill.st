(*********************************************************************************
 * Copyright: Bernecker + Rainer
 * Author:  B+R
 * Created:  November 22, 2017/3:15 PM 
 *********************************************************************************
 *********************************************************************************
 * Version History:
 * -------------------------------------------------------------------------------
 * V 1.00.0   November 22, 2017/3:15 PM  First Version
 *********************************************************************************
 * Description:
 * -------------------------------------------------------------------------------
 * November 22, 2017/3:15 PM V1.00.0:
 * This task is used for checking if all shuttles are not moving
 *********************************************************************************)
ACTION CheckStandstill: 

	// Check if the shuttle is in standstill
	ShuttlesStandstill	:= TRUE;
	FOR Index := 0 TO (SIZEOF(StPallet_) / SIZEOF(StPallet_[0])) - 1 DO
		PositionDelta[Index].Position		:= ShuttleInfo[Index].position - PositionDelta[Index].PositionOld;
		PositionDelta[Index].PositionOld	:= ShuttleInfo[Index].position;
		
		IF ABS(PositionDelta[Index].Position) > PositionOffset OR StTargetExt_[WaitTarget-1].PalletPresent THEN
			ShuttlesStandstill	:= FALSE;
		END_IF;
		
	END_FOR;
	
END_ACTION
