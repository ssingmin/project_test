(*********************************************************************************************************************************************************)
(*********************************************************************************************************************************************************)

TYPE
	HMILinkType : {REDUND_UNREPLICABLE} 	STRUCT  (*Hmi link*)
		SuperTrakStatus : {REDUND_UNREPLICABLE} HMILinkSuperTrakStatusType; (*Hmi link status*)
		LibraryStatus : {REDUND_UNREPLICABLE} HMILinkLibStatusType; (*Hmi link library status*)
	END_STRUCT;
	HMILinkSuperTrakStatusType : {REDUND_UNREPLICABLE} 	STRUCT  (*Hmi link status*)
		StatusValid : {REDUND_UNREPLICABLE} BOOL; (*Indicates if the status information is valid*)
	END_STRUCT;
	HMILinkLibStatusType : {REDUND_UNREPLICABLE} 	STRUCT  (*Hmi link library status*)
		LogBookIdent : {REDUND_UNREPLICABLE} ArEventLogIdentType; (*Ident of log book*)
		FbID : {REDUND_UNREPLICABLE} ARRAY[0..HMI_CONFIG_FBS_MINUS_ONE]OF UINT; (*Funtion block IDs*)
	END_STRUCT;
END_TYPE

(*********************************************************************************************************************************************************)
(*********************************************************************************************************************************************************)

TYPE
	HMIControlInfoType : {REDUND_UNREPLICABLE} 	STRUCT  (*Function block info*)
		Library : {REDUND_UNREPLICABLE} HMIControlLibraryType; (*Library information*)
	END_STRUCT;
	HMIControlLibraryType : {REDUND_UNREPLICABLE} 	STRUCT  (*Library information*)
		Version : {REDUND_UNREPLICABLE} STRING[8] := 'V1.0.0'; (*Actual library version*)
	END_STRUCT;
	HMIControlInternalType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal variables*)
		Step : {REDUND_UNREPLICABLE} HMIControlStepEnum; (*Step of state-machine*)
		Index : {REDUND_UNREPLICABLE} UDINT; (*Index variable*)
		Index2 : {REDUND_UNREPLICABLE} UDINT; (*Index variable*)
		Status : {REDUND_UNREPLICABLE} HMIControlInternalStatusType; (*Internal status*)
		AddErrorInfo : {REDUND_UNREPLICABLE} STRING[HMI_CONFIG_SIZE_OF_LOG_DATA]; (*Additional error information*)
		LastLogEntryID : {REDUND_UNREPLICABLE} ArEventLogRecordIDType; (*ID of last logger entry*)
		ArEventLogCreate : {REDUND_UNREPLICABLE} ArEventLogCreate; (*Function block to create log book*)
		ArEventLogGetIdent : {REDUND_UNREPLICABLE} ArEventLogGetIdent; (*Function block to get log book ident*)
		ArEventLogWrite : {REDUND_UNREPLICABLE} ArEventLogWrite; (*Function block to write log book entry*)
		CommunicationWatchdog : {REDUND_UNREPLICABLE} TON; (*Timer for communication check*)
		ErrorResetOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		UpdateOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
	END_STRUCT;
	HMIControlInternalStatusType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal status*)
		InitConfigCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of function block configuration done*)
		LogBookCreated : {REDUND_UNREPLICABLE} BOOL; (*Lob book created*)
		FuncitonBlockRegistered : {REDUND_UNREPLICABLE} BOOL; (*Function block registered*)
		FuncitonBlockID : {REDUND_UNREPLICABLE} UINT; (*Function block ID*)
	END_STRUCT;
END_TYPE

(*********************************************************************************************************************************************************)
(*********************************************************************************************************************************************************)

TYPE
	HMIReadParType : {REDUND_UNREPLICABLE} 	STRUCT  (*Function block parameter*)
		ParameterNumber : {REDUND_UNREPLICABLE} UINT; (*Parameter number (parameter ID) to be read*)
		SectionID : {REDUND_UNREPLICABLE} USINT; (*Section ID for paramters which are section specific*)
		StartParameterIndex : {REDUND_UNREPLICABLE} UDINT; (*Start Index of array to be read from (only for arrays)*)
		ParameterValueCount : {REDUND_UNREPLICABLE} UINT; (*Number of values (array entries) to be read after the start index (only for arrays)*)
		STRINGsize : {REDUND_UNREPLICABLE} UINT; (*Size of the string that should be read*)
	END_STRUCT;
	HMIReadInfoType : {REDUND_UNREPLICABLE} 	STRUCT  (*Function block info*)
		ErrorCode : {REDUND_UNREPLICABLE} UINT; (*Code to get the correct message*)
	END_STRUCT;
	HMIReadInternalType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal variables*)
		Step : {REDUND_UNREPLICABLE} HMIReadStepEnum; (*Step of state-machine*)
		ParametersUsed : {REDUND_UNREPLICABLE} HMIReadParType; (*Internally used parameters*)
		Index : {REDUND_UNREPLICABLE} UDINT; (*Index variable*)
		Status : {REDUND_UNREPLICABLE} HMIReadInternalStatusType; (*Internal status*)
		AddErrorInfo : {REDUND_UNREPLICABLE} STRING[HMI_CONFIG_SIZE_OF_LOG_DATA]; (*Additional error information*)
		ArEventLogWrite : {REDUND_UNREPLICABLE} ArEventLogWrite; (*Function block to write log book entry*)
		ErrorResetOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		UpdateOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
	END_STRUCT;
	HMIReadInternalStatusType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal status*)
		InitConfigCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of function block configuration done*)
		FuncitonBlockRegistered : {REDUND_UNREPLICABLE} BOOL; (*Function block registered*)
		FuncitonBlockID : {REDUND_UNREPLICABLE} UINT; (*Function block ID*)
		FunctionBlockIDIndex : {REDUND_UNREPLICABLE} UINT; (*Index of function block id entry*)
		InitParCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of parameters done*)
		CommActive : {REDUND_UNREPLICABLE} BOOL; (*Indicates that service channel is occupied by this FB instance*)
		ReadStatus : {REDUND_UNREPLICABLE} UINT; (*Status of the read command*)
	END_STRUCT;
END_TYPE

(*********************************************************************************************************************************************************)
(*********************************************************************************************************************************************************)

TYPE
	HMIWriteParType : {REDUND_UNREPLICABLE} 	STRUCT  (*Function block parameter*)
		ParameterNumber : {REDUND_UNREPLICABLE} UINT; (*Parameter number (parameter ID) to be written*)
		SectionID : {REDUND_UNREPLICABLE} USINT; (*Section ID for paramters which are section specific*)
		StartParameterIndex : {REDUND_UNREPLICABLE} UDINT; (*Start Index of array to be written to (only for arrays)*)
		ParameterValueCount : {REDUND_UNREPLICABLE} UINT; (*Number of values (array entries) to be written after the start index (only for arrays)*)
		UDINTvalue : {REDUND_UNREPLICABLE} UDINT; (*UDINT variable*)
		UINTvalue : {REDUND_UNREPLICABLE} UINT; (*UINT variable*)
		USINTvalue : {REDUND_UNREPLICABLE} USINT; (*USINT variable*)
		DINTvalue : {REDUND_UNREPLICABLE} DINT; (*DINT variable*)
		INTvalue : {REDUND_UNREPLICABLE} INT; (*INT variable*)
		SINTvalue : {REDUND_UNREPLICABLE} SINT; (*SINT variable*)
		REALvalue : {REDUND_UNREPLICABLE} REAL; (*REAL variable*)
		STRINGvalue : {REDUND_UNREPLICABLE} STRING[80]; (*STRING variable*)
		STRINGsize : {REDUND_UNREPLICABLE} UINT; (*STRING size*)
		Save : {REDUND_UNREPLICABLE} HMIWriteSaveType; (*Save variable*)
	END_STRUCT;
	HMIWriteSaveType : {REDUND_UNREPLICABLE} 	STRUCT  (*Parameter save*)
		SystemLayout : {REDUND_UNREPLICABLE} BOOL; (*Save system layout*)
		Targets : {REDUND_UNREPLICABLE} BOOL; (*Save targets*)
		Regions : {REDUND_UNREPLICABLE} BOOL; (*Save regions*)
		MoveConfig : {REDUND_UNREPLICABLE} BOOL; (*Save move configuration*)
		GlobalPar : {REDUND_UNREPLICABLE} BOOL; (*Save global parameters*)
		Offsets : {REDUND_UNREPLICABLE} BOOL; (*Save offsets*)
		SectionPar : {REDUND_UNREPLICABLE} BOOL; (*Save section parameters*)
		ControlGains : {REDUND_UNREPLICABLE} BOOL; (*Save control gains*)
		EncoderConfig : {REDUND_UNREPLICABLE} BOOL; (*Save encoder calibration and configuration*)
		IRTagConfig : {REDUND_UNREPLICABLE} BOOL; (*Save IR tag configuration*)
		VirtualIO : {REDUND_UNREPLICABLE} BOOL; (*Save virtual IOs*)
		PosTrig : {REDUND_UNREPLICABLE} BOOL; (*Save position triggers*)
	END_STRUCT;
	HMIWriteInfoType : {REDUND_UNREPLICABLE} 	STRUCT  (*Function block info*)
		ErrorCode : {REDUND_UNREPLICABLE} UINT; (*Code to get the correct message*)
	END_STRUCT;
	HMIWriteInternalType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal variables*)
		Step : {REDUND_UNREPLICABLE} HMIWriteStepEnum; (*Step of state-machine*)
		ParametersUsed : {REDUND_UNREPLICABLE} HMIWriteParType; (*Internally used parameters*)
		Index : {REDUND_UNREPLICABLE} UDINT; (*Index variable*)
		Status : {REDUND_UNREPLICABLE} HMIWriteInternalStatusType; (*Internal status*)
		AddErrorInfo : {REDUND_UNREPLICABLE} STRING[HMI_CONFIG_SIZE_OF_LOG_DATA]; (*Additional error information*)
		ArEventLogWrite : {REDUND_UNREPLICABLE} ArEventLogWrite; (*Function block to write log book entry*)
		ErrorResetOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		UpdateOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		SaveValue : {REDUND_UNREPLICABLE} UDINT; (*Parameter that should be saved*)
	END_STRUCT;
	HMIWriteInternalStatusType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal status*)
		InitConfigCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of function block configuration done*)
		FuncitonBlockRegistered : {REDUND_UNREPLICABLE} BOOL; (*Function block registered*)
		FuncitonBlockID : {REDUND_UNREPLICABLE} UINT; (*Function block ID*)
		FunctionBlockIDIndex : {REDUND_UNREPLICABLE} UINT; (*Index of function block id entry*)
		InitParCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of parameters done*)
		CommActive : {REDUND_UNREPLICABLE} BOOL; (*Indicates that service channel is occupied by this FB instance*)
		WriteStatus : {REDUND_UNREPLICABLE} UINT; (*Internal status of the write command*)
	END_STRUCT;
END_TYPE

(*********************************************************************************************************************************************************)
(*********************************************************************************************************************************************************)

TYPE
	HMIControlStepEnum : 
		( (*Steps for state-machine*)
		HMI_CTRL_STATE_INIT := 0, (*Init state*)
		HMI_CTRL_STATE_INIT_CHECK_CONFIG := 1, (*Check configuration*)
		HMI_CTRL_STATE_CREATE_LOGBOOK := 2, (*Create Logbook*)
		HMI_CTRL_STATE_REGISTER_FB := 3, (*Register FUB*)
		HMI_CTRL_STATE_OPERATION := 10, (*Operation*)
		HMI_CTRL_STATE_ERROR := 255 (*Error*)
		);
	HMIWriteStepEnum : 
		( (*Steps for state-machine*)
		HMI_WPAR_STATE_INIT := 0, (*Init state*)
		HMI_WPAR_STATE_INIT_CHECK_CONFIG := 1, (*Check configuration*)
		HMI_WPAR_STATE_INIT_REG_FB := 2, (*Register FUB*)
		HMI_WPAR_STATE_INIT_CHECK_PAR := 3, (*Check parameter*)
		HMI_WPAR_STATE_OPERATION := 10, (*Operation*)
		HMI_WPAR_STATE_ERROR := 255 (*Error*)
		);
	HMIReadStepEnum : 
		( (*Steps for state-machine*)
		HMI_RPAR_STATE_INIT := 0, (*Init state*)
		HMI_RPAR_STATE_INIT_CHECK_CONFIG := 1, (*Check configuration*)
		HMI_RPAR_STATE_INIT_REG_FB := 2, (*Register FUB*)
		HMI_RPAR_STATE_INIT_CHECK_PAR := 3, (*Check parameter*)
		HMI_RPAR_STATE_OPERATION := 10, (*Operation*)
		HMI_RPAR_STATE_ERROR := 255 (*Error*)
		);
END_TYPE
