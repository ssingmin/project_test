(************************************************************************************************************************************)
(************************************************************************************************************************************)
(*Structures for SuperTrak control*)

TYPE
	SuperTrakCtrlType : 	STRUCT  (*Control structure for SuperTrak*)
		Command : SuperTrakCtrlCmdType; (*SuperTrak commands*)
		Parameter : SuperTrakCtrlParType; (*SuperTrak parameters*)
		Status : SuperTrakCtrlStatType; (*SuperTrak status*)
	END_STRUCT;
	SuperTrakCtrlCmdType : 	STRUCT  (*Command strucutre for SuperTrak*)
		EnableAllSections : BOOL; (*Command to enable all sections on the system*)
	END_STRUCT;
	SuperTrakCtrlParType : 	STRUCT  (*Parameter structure for SuperTrak*)
		Reserved : BOOL; (*Reserved for future development*)
	END_STRUCT;
	SuperTrakCtrlStatType : 	STRUCT  (*Status strucutre for SuperTrak*)
		AllSectionsEnabled : BOOL; (*Indicating if all sections on the system are enabled*)
		CommandBusy : BOOL; (*SuperTrak busy*)
		AntiSloshingEnabled : BOOL; (*AntiSloshing function active*)
		TrackingEnabled : BOOL; (*Tracking fuction active*)
		PalletControl : BOOL; (*Shuttle control active*)
	END_STRUCT;
END_TYPE

(*Error handling*)

TYPE
	InfoType : 	STRUCT  (*Error information structure*)
		StControl : StControlErrorInfoType; (*Error information structure StControl*)
		StSection : ARRAY[0..CONFIG_ST_MAX_SECTIONS_MINUS_ONE]OF StSectionErrorInfoType; (*Error information structure StSection*)
		StTargetExt : StTargetExtErrorInfoType; (*Error information structure StTargetExt*)
		StPallet : StPalletErrorInfoType; (*Error information structure StPallet*)
		StReadPnu_Region : StReadPnuErrorInfoType; (*Error information structure StReadPnu*)
		StWritePnu_Region : StWritePnuErrorInfoType; (*Error information structure StWritePnu*)
		HmiWriteParID : HmiWriteParIDErrorInfoType; (*Error information structure HmiWriteParID*)
		HmiReadParID : HmiReadParIDErrorInfoType; (*Error information structure HmiReadParID*)
	END_STRUCT;
	StControlErrorInfoType : 	STRUCT  (*Error information structure StControl*)
		StatusID : DINT; (*Status ID of the FUB*)
		Error : ARRAY[0..23]OF DINT; (*Error number*)
		Warning : ARRAY[0..23]OF DINT; (*Warning number*)
		ErrorText : ARRAY[0..23]OF STRING[80]; (*Error text*)
		WarningText : ARRAY[0..23]OF STRING[80]; (*Warning text*)
	END_STRUCT;
	StSectionErrorInfoType : 	STRUCT  (*Error information structure StSection*)
		StatusID : DINT; (*Status ID of the FUB*)
		Error : ARRAY[0..23]OF DINT; (*Error number*)
		Warning : ARRAY[0..23]OF DINT; (*Warning number*)
		ErrorText : ARRAY[0..23]OF STRING[80]; (*Error text*)
		WarningText : ARRAY[0..23]OF STRING[80]; (*Warning text*)
	END_STRUCT;
	StTargetExtErrorInfoType : 	STRUCT  (*Error information structure StTargetExt*)
		StatusID : ARRAY[0..CONFIG_USED_TARGETS_MINUS_ONE]OF DINT; (*StatusID of the FUB*)
		ErrorText : ARRAY[0..CONFIG_USED_TARGETS_MINUS_ONE]OF STRING[80]; (*Error text*)
		WarningText : ARRAY[0..CONFIG_USED_TARGETS_MINUS_ONE]OF STRING[80]; (*Warning text*)
		TargetID : ARRAY[0..CONFIG_USED_TARGETS_MINUS_ONE]OF USINT; (*Target ID*)
	END_STRUCT;
	StPalletErrorInfoType : 	STRUCT  (*Error information structure StTargetExt*)
		StatusID : ARRAY[0..CONFIG_USED_SHUTTLES_MINUS_ONE]OF DINT; (*StatusID of the FUB*)
		ErrorText : ARRAY[0..CONFIG_USED_SHUTTLES_MINUS_ONE]OF STRING[80]; (*Error text*)
		WarningText : ARRAY[0..CONFIG_USED_SHUTTLES_MINUS_ONE]OF STRING[80]; (*Warning text*)
		ShuttleID : ARRAY[0..CONFIG_USED_SHUTTLES_MINUS_ONE]OF USINT; (*Shuttle ID*)
	END_STRUCT;
	StReadPnuErrorInfoType : 	STRUCT  (*Error information structure StReadPnu*)
		StatusID : DINT; (*StatusID of the FUB*)
		ErrorText : STRING[80]; (*Error text*)
	END_STRUCT;
	StWritePnuErrorInfoType : 	STRUCT  (*Error information structure StWritePnu*)
		StatusID : DINT; (*StatusID of the FUB*)
		ErrorText : STRING[80]; (*Error text*)
	END_STRUCT;
	HmiWriteParIDErrorInfoType : 	STRUCT  (*Error information structure HmiWriteParID*)
		StatusID : DINT; (*StatusID of the FUB*)
		ErrorText : STRING[80]; (*Error text*)
	END_STRUCT;
	HmiReadParIDErrorInfoType : 	STRUCT  (*Error information structure HmiReadParID*)
		StatusID : DINT; (*StatusID of the FUB*)
		ErrorText : STRING[80]; (*Error text*)
	END_STRUCT;
END_TYPE

(*Read temperatures*)

TYPE
	TemperaturesType : 	STRUCT  (*Temperatures structure type*)
		Section : ARRAY[1..CONFIG_ST_MAX_SECTIONS]OF SectionType; (*Section information type*)
	END_STRUCT;
	RealSectionType : 	STRUCT  (*Section information type with real values*)
		Value : ARRAY[0..15]OF REAL; (*Value of the sensor*)
		Warning : ARRAY[0..15]OF BOOL; (*Temperature warning*)
		Error : ARRAY[0..15]OF BOOL; (*Temperature error*)
	END_STRUCT;
	SectionType : 	STRUCT  (*Section information type with uint values*)
		Value : ARRAY[0..15]OF UINT; (*Value of the sensor*)
		Warning : ARRAY[0..15]OF BOOL; (*Temperature warning*)
		Error : ARRAY[0..15]OF BOOL; (*Temperature error*)
		UserDisableMask : UINT; (*UserDisable mask for temperature sensors*)
		UserEnableMask : UINT; (*UserEnable mask for temperature sensors*)
		DefaultMask : UINT; (*Default mask for temperature sensors*)
		EffectiveMask : UINT; (*Effective mask for temperature sensors*)
		SensorActivated : ARRAY[0..15]OF BOOL; (*Indicates which sensors are active*)
	END_STRUCT;
END_TYPE

(*Shuttle position*)

TYPE
	ShuttlePosition : 	STRUCT  (*Actual position of the shuttle on the SuperTrak*)
		Position : DINT; (*Actual position*)
		Section : USINT; (*Actual section*)
		PositionOld : DINT; (*Position one cycle ago*)
	END_STRUCT;
	ErrorBitSectionType : 	STRUCT  (*Check if the error has been already read*)
		ErrorBitSet : ARRAY[0..31]OF BOOL; (*Check if the error has been already read*)
	END_STRUCT;
END_TYPE
