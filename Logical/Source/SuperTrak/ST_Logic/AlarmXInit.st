(*********************************************************************************
 * Copyright: Bernecker+Rainer
 * Author:    B&R
 * Created:   May 9, 2018/11:27 AM 
 *********************************************************************************
 *********************************************************************************
 * Version History:
 * -------------------------------------------------------------------------------
 * V 1.00.0   May 9, 2018/11:27 AM  First Version
 *********************************************************************************
 * Description:
 * *Contains function block init parameters
 * *Alarms can be modified in Configuration View under mappServices in Config.mpAlarmXCore 
 *********************************************************************************)

ACTION AlarmXInit: 
		(* Setting up mpAlarmX Parameters *)
	MpAlarmXCore_0.MpLink := ADR(gAlarmXCore);
	MpAlarmXCore_0.Enable := TRUE;
	
	(* Setting parameter for mpAlarmXHistory *)
	MpAlarmXHistory_0.MpLink := ADR(gAlarmXHistory);
	MpAlarmXHistory_0.Enable := TRUE; 
	IF DiagCpuIsSimulated() THEN
		MpAlarmXHistory_0.DeviceName := ADR('Sim');
	ELSE
		MpAlarmXHistory_0.DeviceName := ADR('CFast');
	END_IF;
END_ACTION
