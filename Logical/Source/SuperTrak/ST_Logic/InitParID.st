(*********************************************************************************
 * Copyright: Bernecker+Rainer
 * Author:    B&R
 * Created:   June 12, 2018/13:10 AM 
 *********************************************************************************
 *********************************************************************************
 * Version History:
 * -------------------------------------------------------------------------------
 * V 1.00.0   June 12, 2018/13:10 AM  First Version
 *********************************************************************************
 * Description:
 * *Contains function block init parameters
 *********************************************************************************)

ACTION InitParID: 

	HmiControl_0.HMILink			:= ADR(HmiLink);
	HmiControl_0.Enable				:= TRUE;
	
	HmiWriteParID_0.HMILink			:= ADR(HmiLink);
	HmiWriteParID_0.Parameters		:= ADR(HmiWritePar);
	
	HmiReadParID_0.HMILink			:= ADR(HmiLink);
	HmiReadParID_0.Parameters		:= ADR(HmiReadPar);	
	
	HmiWritePar.ParameterValueCount	:= 1;
	HmiReadPar.ParameterValueCount	:= 1;
	
END_ACTION
