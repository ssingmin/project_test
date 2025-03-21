(*********************************************************************************
 * Copyright: Bernecker + Rainer
 * Author:  B+R
 * Created:  November 23, 2017/1:30 PM 
 *********************************************************************************
 *********************************************************************************
 * Version History:
 * -------------------------------------------------------------------------------
 * V 1.00.0   November 23, 2017/1:30 PM  First Version
 *********************************************************************************
 * Description:
 * -------------------------------------------------------------------------------
 * November 23, 2017/1:30 PM V1.00.0:
 * This task is used FOR enable the safety region
 *********************************************************************************)

ACTION EnableRegion: 
	StWritePnu_Region.Enable				:= TRUE;
	StWritePnu_Region.DataAddress			:= ADR(RegionEnable);
	StWritePnu_Region.DataSize				:= SIZEOF(RegionEnable);
	StWritePnuPar_Region.ParameterNumber	:= 1600;
	StWritePnuPar_Region.ValidDataSize		:= SIZEOF(RegionEnable);
	
	StWritePnu_Region.Write					:= TRUE;
	
	IF StWritePnu_Region.Write THEN
		TimerRegionEnable.IN				:= TRUE;
	END_IF;
	
	IF TimerRegionEnable.Q THEN
		TimerRegionEnable.IN				:= FALSE;
		StWritePnu_Region.Write				:= FALSE;
	END_IF;
		
	StReadPnu_Region.Enable					:= TRUE;
	StReadPnu_Region.DataAddress			:= ADR(RegionStatus);
	StReadPnu_Region.DataSize				:= SIZEOF(RegionStatus);
	StReadPnuPar_Region.ParameterNumber		:= 1600;
	StReadPnuPar_Region.StartParameterIndex	:= 0;
			
	IF StReadPnu_Region.Read = FALSE AND StReadPnu_Region.CommandDone = FALSE THEN
		StReadPnu_Region.Read				:= TRUE;
	ELSE
		StReadPnu_Region.Read				:= FALSE;
	END_IF;
			
	IF StWritePnu_Region.CommandDone AND RegionStatus = 7 THEN
		//Save region configuration
		IF SuperTrakServChanWrite(0,Save_Parameter,0,1,ADR(SaveValue),SIZEOF(SaveValue)) = 0 AND StControl_0.Info.SuperTrak.SystemWarningActive = FALSE THEN
			StWritePnu_Region.Write			:= FALSE;
			RegionEnabled					:= TRUE;
			TimerRegionEnable.IN			:= FALSE;
			StReadPnu_Region.Enable			:= FALSE;
		END_IF;
	END_IF;	
END_ACTION
