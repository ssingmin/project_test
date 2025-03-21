(*********************************************************************************
 * Copyright: Bernecker + Rainer
 * Author:  B+R
 * Created:  November 23, 2017/2:00 PM 
 *********************************************************************************
 *********************************************************************************
 * Version History:
 * -------------------------------------------------------------------------------
 * V 1.00.0   November 23, 2017/2:00 PM  First Version
 *********************************************************************************
 * Description:
 * -------------------------------------------------------------------------------
 * November 23, 2017/2:00 PM V1.00.0:
 * This task is used FOR disable the safety region
 *********************************************************************************)

ACTION DisableRegion: 
	StWritePnu_Region.Enable			:= TRUE;
	StWritePnu_Region.DataAddress		:= ADR(Region);
	StWritePnu_Region.DataSize			:= SIZEOF(Region);
	StWritePnuPar_Region.ParameterNumber:= 1600;
	StWritePnuPar_Region.ValidDataSize	:= SIZEOF(Region);
	
	StWritePnu_Region.Write				:= TRUE;
	
	StReadPnu_Region.Enable				:= TRUE;
			
	IF StReadPnu_Region.Read = FALSE AND StReadPnu_Region.CommandDone = FALSE AND StReadPnu_Region.Active THEN
		StReadPnu_Region.Read			:= TRUE;
	ELSE
		StReadPnu_Region.Read			:= FALSE;
	END_IF;
			
	IF StWritePnu_Region.CommandDone AND RegionStatus = 0 THEN		
		//Save region configuration
		IF SuperTrakServChanWrite(0,Save_Parameter,0,1,ADR(SaveValue),SIZEOF(SaveValue)) = 0 AND StControl_0.Info.SuperTrak.SystemWarningActive = FALSE THEN
			StWritePnu_Region.Write		:= FALSE;
			RegionDisabled				:= TRUE;
			RegionEnabled				:= FALSE;
			StReadPnu_Region.Enable		:= FALSE;
			StWritePnu_Region.Enable	:= FALSE;
		END_IF;
	END_IF;	
END_ACTION
