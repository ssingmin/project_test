(******************************************************************************************************************************************************************************************************)
(******************************************************************************************************************************************************************************************************)
(*Shared structures and enumerators*)

TYPE
	StLinkType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak link*)
		SuperTrakCommand : {REDUND_UNREPLICABLE} StLinkCommandType; (*Commands for SuperTrak*)
		SuperTrakStatus : {REDUND_UNREPLICABLE} StLinkStatusType; (*Status of SuperTrak*)
		LibraryStatus : {REDUND_UNREPLICABLE} StLinkLibStatusType; (*Internal library status*)
	END_STRUCT;
	StLinkCommandType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak link commands*)
		Pallet : {REDUND_UNREPLICABLE} ARRAY[0..stCOM_CONFIG_PALLETS_MINUS_ONE]OF StLinkCmdPalletType; (*Shuttle commands*)
		Target : {REDUND_UNREPLICABLE} ARRAY[0..stCOM_CONFIG_TARGETS_MINUS_ONE]OF StLinkCmdTargetType; (*Target commands*)
		Section : {REDUND_UNREPLICABLE} ARRAY[0..stCOM_CONFIG_SECTIONS_MINUS_ONE]OF StLinkCmdSectionType; (*Seciton commands*)
		ServiceChannel : {REDUND_UNREPLICABLE} StLinkCmdServChType; (*Commands for service channel (requests)*)
		Custom : {REDUND_UNREPLICABLE} ARRAY[0..stCOM_CONFIG_COMMANDS_MINUS_ONE]OF StLinkCmdCustomType; (*Custom commands*)
	END_STRUCT;
	StLinkCmdPalletType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak link shuttle commands*)
		Advanced : {REDUND_UNREPLICABLE} ARRAY[0..7]OF USINT; (*Advanced commands*)
	END_STRUCT;
	StLinkCmdTargetType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak link target commands*)
		Simple : {REDUND_UNREPLICABLE} USINT; (*Simple target commands*)
		Advanced : {REDUND_UNREPLICABLE} ARRAY[0..7]OF USINT; (*Advanced target commands*)
	END_STRUCT;
	StLinkCmdSectionType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak link section commands*)
		Enable : {REDUND_UNREPLICABLE} BOOL; (*Command to enable seciton*)
		Acknowledge : {REDUND_UNREPLICABLE} BOOL; (*Command to acknowledge section errors and warnings*)
	END_STRUCT;
	StLinkCmdServChType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak link service channel request*)
		RequestOccupied : {REDUND_UNREPLICABLE} BOOL; (*Indicates that the request stucture can not be overwritten, since a request is currently executed*)
		RequestAccepted : {REDUND_UNREPLICABLE} BOOL; (*Indicates that StControl is executing the request*)
		NewRequest : {REDUND_UNREPLICABLE} BOOL; (*Indicates that a new request was entered, which should be sent to SuperTrak*)
		Request : {REDUND_UNREPLICABLE} StLinkServChMessageType; (*Servie Channel Request*)
	END_STRUCT;
	StLinkCmdCustomType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak link shuttle commands*)
		Advanced : {REDUND_UNREPLICABLE} ARRAY[0..7]OF USINT; (*Advanced commands*)
	END_STRUCT;
	StLinkStatusType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak link status*)
		StatusValid : {REDUND_UNREPLICABLE} BOOL; (*Indicates if the status information is valid*)
		System : {REDUND_UNREPLICABLE} StLinkStatusSystemType; (*Status information of System*)
		Target : {REDUND_UNREPLICABLE} ARRAY[0..stCOM_CONFIG_TARGETS_MINUS_ONE]OF StLinkStatusTargetType; (*Status information of targets*)
		Pallet : {REDUND_UNREPLICABLE} ARRAY[0..stCOM_CONFIG_PALLETS_MINUS_ONE]OF StLinkStatusPalletType; (*Status information of shuttles*)
		Section : {REDUND_UNREPLICABLE} ARRAY[0..stCOM_CONFIG_SECTIONS_MINUS_ONE]OF StLinkStatusSectionType; (*Status information of secitons*)
		ServiceChannel : {REDUND_UNREPLICABLE} StLinkStatusServChType; (*Commands for service channel (requests)*)
		Custom : {REDUND_UNREPLICABLE} ARRAY[0..stCOM_CONFIG_COMMANDS_MINUS_ONE]OF StLinkStatusCustomType;
	END_STRUCT;
	StLinkStatusSystemType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak link system status*)
		Warning : {REDUND_UNREPLICABLE} BOOL; (*System warning present*)
		Fault : {REDUND_UNREPLICABLE} BOOL; (*System fault present*)
		HeartbeatOutput : {REDUND_UNREPLICABLE} BOOL; (*Heartbeat signal to check communication*)
		TotalPallets : {REDUND_UNREPLICABLE} UINT; (*Number of shuttles on the system*)
		EnableSignalSource : {REDUND_UNREPLICABLE} StControlInfoStEnableSourceEnum; (*Source of enable signal for sections (this information is  only read when function block gets enabled, not cyclically)*)
	END_STRUCT;
	StLinkStatusTargetType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak link target status*)
		PalletPresent : {REDUND_UNREPLICABLE} BOOL; (*Shuttle present at target*)
		PalletInPosition : {REDUND_UNREPLICABLE} BOOL; (*Shuttle in "in-position-window"*)
		PalletPreArrival : {REDUND_UNREPLICABLE} BOOL; (*Shuttle arriving at the target*)
		PalletOverTarget : {REDUND_UNREPLICABLE} BOOL; (*Shuttle shelf is over the target*)
		ReleaseCommandError : {REDUND_UNREPLICABLE} BOOL; (*Error executing a release command*)
		PalletID : {REDUND_UNREPLICABLE} USINT; (*Shuttle ID at target*)
		ActOffsetTableIndex : {REDUND_UNREPLICABLE} USINT; (*Offset index of shuttle at the target*)
		CmdCommunicationActive : {REDUND_UNREPLICABLE} BOOL; (*Command is currently executed*)
		CmdBufferIdx : {REDUND_UNREPLICABLE} USINT; (*Index of command buffer entry*)
		CommandComplete : {REDUND_UNREPLICABLE} BOOL; (*Command is complete*)
		CommandSuccess : {REDUND_UNREPLICABLE} BOOL; (*Command was executed successfully*)
	END_STRUCT;
	StLinkStatusPalletType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak link shuttle status*)
		CmdCommunicationActive : {REDUND_UNREPLICABLE} BOOL; (*Command is currently executed*)
		CmdBufferIdx : {REDUND_UNREPLICABLE} USINT; (*Index of command buffer entry*)
		CommandComplete : {REDUND_UNREPLICABLE} BOOL; (*Command is complete*)
		CommandSuccess : {REDUND_UNREPLICABLE} BOOL; (*Command was executed successfully*)
	END_STRUCT;
	StLinkStatusSectionType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak link section status*)
		Enabled : {REDUND_UNREPLICABLE} BOOL := FALSE; (*Section is enabled*)
		UnrecognizedPallets : {REDUND_UNREPLICABLE} BOOL := FALSE; (*Unrecognized shuttles on the section*)
		MotorPowerOn : {REDUND_UNREPLICABLE} BOOL := FALSE; (*Motor power of section is on*)
		PalletsRecovering : {REDUND_UNREPLICABLE} BOOL := FALSE; (*Shuttles are recovering on the section*)
		LocatingPallets : {REDUND_UNREPLICABLE} BOOL := FALSE; (*Shuttles are being automatically "jogged" so that their location can be determined*)
		DisabledExternally : {REDUND_UNREPLICABLE} BOOL := FALSE; (*The section is disabled due to an external condition. The standard controller application project maps Digital Input 1, on the X20DM9324 module, to this function, for all sections*)
		Warning : {REDUND_UNREPLICABLE} BOOL := FALSE; (*Section warning present*)
		Fault : {REDUND_UNREPLICABLE} BOOL := FALSE; (*Seciton fault present*)
	END_STRUCT;
	StLinkStatusServChType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak link service channel response*)
		MaxRequestDataSize : {REDUND_UNREPLICABLE} UDINT; (*Maximum size of data that can be written in a request*)
		MaxResponseDataSize : {REDUND_UNREPLICABLE} UDINT; (*Maximum size of data that can be read from a response*)
		ResponseAvailable : {REDUND_UNREPLICABLE} BOOL; (*Indicates that a new response is available from SuperTrak and was not yet read by a FB*)
		Response : {REDUND_UNREPLICABLE} StLinkServChMessageType; (*Servie Channel Response from SuperTrak*)
	END_STRUCT;
	StLinkServChMessageType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak link service channel message*)
		DataLength : {REDUND_UNREPLICABLE} UINT; (*Length of valid data (exclusive header)*)
		Task : {REDUND_UNREPLICABLE} USINT; (*Task ID (command or error code)*)
		ParameterID : {REDUND_UNREPLICABLE} UINT; (*Parameter ID*)
		SectionID : {REDUND_UNREPLICABLE} USINT; (*Section ID*)
		StartIndex : {REDUND_UNREPLICABLE} UDINT; (*Start Index for arrays*)
		Count : {REDUND_UNREPLICABLE} UINT; (*Paramter count for arrays*)
		Data : {REDUND_UNREPLICABLE} ARRAY[0..stCOM_CONFIG_SERV_CH_MAX_DATA_M1]OF UDINT; (*Parameter value(s)*)
	END_STRUCT;
	StLinkStatusCustomType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak link shuttle status*)
		CmdCommunicationActive : {REDUND_UNREPLICABLE} BOOL; (*Command is currently executed*)
		CmdBufferIdx : {REDUND_UNREPLICABLE} USINT; (*Index of command buffer entry*)
		CommandComplete : {REDUND_UNREPLICABLE} BOOL; (*Command is complete*)
		CommandSuccess : {REDUND_UNREPLICABLE} BOOL; (*Command was executed successfully*)
	END_STRUCT;
	StLinkLibStatusType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak link library status*)
		LogBookIdent : {REDUND_UNREPLICABLE} ArEventLogIdentType; (*Ident of log book*)
		FbID : {REDUND_UNREPLICABLE} ARRAY[0..stCOM_CONFIG_FBS_MINUS_ONE]OF UINT; (*Funtion block IDs*)
		Simulation : {REDUND_UNREPLICABLE} StLinkLibStatSimType; (*Shared variables used for simulation*)
	END_STRUCT;
	StLinkLibStatSimType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak link simulation*)
		PalletsCreated : {REDUND_UNREPLICABLE} BOOL; (*Indicates that simulated shuttles have been created (SimPalletRef is valid)*)
		SimPalletReference : {REDUND_UNREPLICABLE} ARRAY[0..stCOM_CONFIG_PALLETS_MINUS_ONE]OF UINT; (*Array of simulated pallet references (used to delete sim pallets)*)
	END_STRUCT;
END_TYPE

(*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*)

TYPE
	StParamAdvReleaseConfigType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak advance release parameters*)
		Direction : {REDUND_UNREPLICABLE} StParamAdvReleaseConfigDirEnum; (*Direction of the movment*)
		DestinationTarget : {REDUND_UNREPLICABLE} USINT := 1; (*Next target to move to (0...255)*)
		MoveConfigIdx : {REDUND_UNREPLICABLE} USINT := 0; (*Movement configuration to use (0...243)*)
		TargetOffsetIdx : {REDUND_UNREPLICABLE} USINT := 0; (*Index of offset from table to use (0...255)*)
		TargetOffset : {REDUND_UNREPLICABLE} REAL := 0; (*Offset to destination target [mm] (-500...500)*)
		IncrementalOffset : {REDUND_UNREPLICABLE} REAL := 0; (*Incremental offset [mm] (-500...500)*)
	END_STRUCT;
	StParamPalletMotionConfigType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak motion parameters*)
		Velocity : {REDUND_UNREPLICABLE} UINT := 0; (*Shuttle velocity [mm/s] (10...4000)*)
		Acceleration : {REDUND_UNREPLICABLE} UINT := 0; (*Shuttle acceleration and deceleration [mm/s^2] (1000...60000)*)
	END_STRUCT;
	StParamPalletShelfConfigType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak shelf parameters*)
		ShelfWidth : {REDUND_UNREPLICABLE} REAL := 152; (*Pallet shelf width [mm] (152...500)*)
		OffsetFromCenter : {REDUND_UNREPLICABLE} REAL := 0; (*Offset from center [mm] (-500...500)*)
	END_STRUCT;
	StParamPalletCtrlConfigType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak controller parameters*)
		ControlGainSetIdx : {REDUND_UNREPLICABLE} USINT := 0; (*Index of pallet controller gain set to be used (configured via TrakMaster)*)
		FilterWeightMoving : {REDUND_UNREPLICABLE} REAL := 0; (*Pallet controller filter weight: moving (0...1)*)
		FilterWeightStationary : {REDUND_UNREPLICABLE} REAL := 0; (*Pallet controller filter weight: stationary (0...1)*)
	END_STRUCT;
	StParamAdvReleaseConfigDirEnum : 
		( (*Direction of movement*)
		stCOM_DIR_LEFT := 0,
		stCOM_DIR_RIGHT := 1
		);
	StParamReleaseConfigEnum : 
		( (*Release configuration*)
		stCOM_RELEASE_CONFIG_1 := 0, (*Using local move configuration 1 for release*)
		stCOM_RELEASE_CONFIG_2 := 1, (*Using local move configuration 2 for release*)
		stCOM_RELEASE_CONFIG_3 := 2 (*Using local move configuration 3 for release*)
		);
END_TYPE

(**)
(******************************************************************************************************************************************************************************************************)
(******************************************************************************************************************************************************************************************************)
(*StControl*)

TYPE
	StControlStepEnum : 
		( (*Steps for state-machine*)
		ST_CTRL_STATE_INIT := 0,
		ST_CTRL_STATE_INIT_CHECK_CONFIG := 1,
		ST_CTRL_STATE_CREATE_LOGBOOK := 2,
		ST_CTRL_STATE_REGISTER_FB := 3,
		ST_CTRL_STATE_INIT_CHECK_PAR := 4,
		ST_CTRL_STATE_READ_NR_SECTIONS := 5,
		ST_CTRL_STATE_READ_SYS_NAME := 6,
		ST_CTRL_STATE_READ_ENABLE_CTRL := 7,
		ST_CTRL_STATE_ENABLE_CTRL_IF := 8,
		ST_CTRL_STATE_UPDATE_COM_STRUCT := 9,
		ST_CTRL_STATE_OPERATION := 10,
		ST_CTRL_STATE_ERROR := 255
		);
	StControlUpdateComStructEnum : 
		( (*Steps for updating command strucutre layout on SuperTrak*)
		ST_CTRL_STATE_WRITE_NR_SECTIONS := 0,
		ST_CTRL_STATE_WRITE_NR_TARGETS := 1,
		ST_CTRL_STATE_WRITE_NR_COMMANDS := 2,
		ST_CTRL_STATE_WRITE_NR_IOS := 3,
		ST_CTRL_STATE_SAVE_ST_PARAMETERS := 4,
		ST_CTRL_STATE_WRITE_DONE := 5
		);
	StCtrlServChannelStepEnum : 
		( (*Steps for service channel*)
		ST_CTRL_SERV_CH_STATE_WAIT_CMD := 0,
		ST_CTRL_SERV_CH_STATE_REQ := 1,
		ST_CTRL_SERV_CH_STATE_WAIT_RES := 2,
		ST_CTRL_SERV_CH_STATE_CPY_RES := 3
		);
	StControlParType : {REDUND_UNREPLICABLE} 	STRUCT  (*Function block parameters*)
		NrOfSections : {REDUND_UNREPLICABLE} USINT := 8; (*Number of sections on the system (1...50)*)
		NrOfTargets : {REDUND_UNREPLICABLE} USINT := 128; (*Number of targets on the system (4...252)*)
		NrOfPallets : {REDUND_UNREPLICABLE} USINT := 32; (*Max number of shuttles on the system (1...255)*)
		NrOfCommands : {REDUND_UNREPLICABLE} USINT := 48; (*Number of commands, which should be exectued simultaniously (8...64)*)
	END_STRUCT;
	StControlInfoType : {REDUND_UNREPLICABLE} 	STRUCT  (*Function block info*)
		SuperTrak : {REDUND_UNREPLICABLE} StControlInfoSuperTrakType; (*Information about the SuperTrak system*)
		Library : {REDUND_UNREPLICABLE} StControlInfoLibraryType; (*Information about the StCom library*)
	END_STRUCT;
	StControlInfoSuperTrakType : {REDUND_UNREPLICABLE} 	STRUCT  (*Information about the SuperTrak system*)
		SystemName : {REDUND_UNREPLICABLE} STRING[32]; (*Name of the SuperTrak system (this information is  only read when function block gets enabled, not cyclically)*)
		NrOfPallets : {REDUND_UNREPLICABLE} UINT; (*Number of shuttles currently on the system (this information is read cyclically)*)
		NrOfSections : {REDUND_UNREPLICABLE} UINT; (*Number of configured SuperTrak sections (this information is  only read when function block gets enabled, not cyclically)*)
		EnableSignalSource : {REDUND_UNREPLICABLE} StControlInfoStEnableSourceEnum; (*Source of enable signal for sections (this information is  only read when function block gets enabled, not cyclically)*)
		SystemFaultActive : {REDUND_UNREPLICABLE} BOOL; (*Indicates an active system fault (this information is read cyclically)*)
		SystemFaultBits : {REDUND_UNREPLICABLE} UDINT; (*Bit coded fault messages (see TrakMaster for description)*)
		SystemWarningActive : {REDUND_UNREPLICABLE} BOOL; (*Indicates an active system warning (this information is read cyclically)*)
		SystemWarningBits : {REDUND_UNREPLICABLE} UDINT; (*Bit coded warning messages (see TrakMaster for description)*)
	END_STRUCT;
	StControlInfoLibraryType : {REDUND_UNREPLICABLE} 	STRUCT  (*Information about the StCom library*)
		Version : {REDUND_UNREPLICABLE} STRING[8]; (*Version of the library*)
		StCtrlDataSize : {REDUND_UNREPLICABLE} UDINT; (*Required size of control data structure (in bytes)*)
		StStatDataSize : {REDUND_UNREPLICABLE} UDINT; (*Required size of status data structure (in bytes)*)
		RegisteredTargetFbs : {REDUND_UNREPLICABLE} USINT; (*Number of target (and targetExt) function block enabled and registered*)
		RegisteredPalletFbs : {REDUND_UNREPLICABLE} USINT; (*Number of shuttle function block enabled and registered*)
		RegisteredSectionFbs : {REDUND_UNREPLICABLE} USINT; (*Number of Section function block enabled and registered*)
	END_STRUCT;
	StControlInfoStEnableSourceEnum : 
		( (*Configuration of enable signal control*)
		stCOM_SECTION_CONTROL := 0, (*Each section's enable state is commanded individually, via the PLC interfaces*)
		stCOM_SYSTEM_CONTROL := 1, (*The entire conveyor's enable state is commanded by a single bit in the PLC interface*)
		stCOM_SERVICE_CHANNEL_CONTROL := 2, (*Each section's enable state is commanded individually, by the configuration software*)
		stCOM_INFORMATION_NOT_VALID := 255 (*Information about the enable signal control is not valid*)
		);
	StControlInternalType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal variables*)
		Step : {REDUND_UNREPLICABLE} StControlStepEnum; (*Step of state-machine*)
		UpdateComStructStep : {REDUND_UNREPLICABLE} StControlUpdateComStructEnum; (*Step of state-machine*)
		ParametersUsed : {REDUND_UNREPLICABLE} StControlParType; (*Internally used parameters*)
		ParameterCheck : {REDUND_UNREPLICABLE} StControlInternalParCheckType; (*Calculations for parameter check*)
		UpdateComStruct : {REDUND_UNREPLICABLE} BOOL; (*Internal command to update command structure layout on SuperTrak*)
		Index : {REDUND_UNREPLICABLE} UDINT; (*Index variable*)
		Index2 : {REDUND_UNREPLICABLE} UDINT; (*Index variable*)
		Status : {REDUND_UNREPLICABLE} StControlInternalStatusType; (*Internal status*)
		AddErrorInfo : {REDUND_UNREPLICABLE} STRING[stCOM_CONFIG_SIZE_OF_LOG_DATA]; (*Additional error information*)
		LastLogEntryID : {REDUND_UNREPLICABLE} ArEventLogRecordIDType; (*ID of last logger entry*)
		ArEventLogCreate : {REDUND_UNREPLICABLE} ArEventLogCreate; (*Function block to create log book*)
		ArEventLogGetIdent : {REDUND_UNREPLICABLE} ArEventLogGetIdent; (*Function block to get log book ident*)
		ArEventLogWrite : {REDUND_UNREPLICABLE} ArEventLogWrite; (*Function block to write log book entry*)
		CommunicationWatchdog : {REDUND_UNREPLICABLE} TON; (*Timer for communication check*)
		SuperTrakControl : {REDUND_UNREPLICABLE} StControlInternalStCtrlType; (*SuperTrak control data*)
		SuperTrakStatus : {REDUND_UNREPLICABLE} StControlInternalStStatType; (*SuperTrak status data*)
		ServiceChannel : {REDUND_UNREPLICABLE} StControlInternalServChType; (*Service Channel data*)
		ErrorResetOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		UpdateOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		EnableAllSectionsOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		ErrorTimer : {REDUND_UNREPLICABLE} TON; (*Reset error information*)
		ErrorRead : {REDUND_UNREPLICABLE} ARRAY[0..31]OF BOOL; (*Marker that log for this event has been created*)
		WarningRead : {REDUND_UNREPLICABLE} ARRAY[0..31]OF BOOL; (*Marker that log for this event has been created*)
	END_STRUCT;
	StControlInternalParCheckType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal parameter check*)
		ControlOffset : {REDUND_UNREPLICABLE} StCtrlIntStCtrlOffsetType; (*Offsets for control stucture*)
		StatusOffset : {REDUND_UNREPLICABLE} StCtrlIntStStatOffsetType; (*Offsets for status structure*)
	END_STRUCT;
	StControlInternalStatusType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal status*)
		InitConfigCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of function block configuration done*)
		LogBookCreated : {REDUND_UNREPLICABLE} BOOL; (*Lob book created*)
		FuncitonBlockRegistered : {REDUND_UNREPLICABLE} BOOL; (*Function block registered*)
		FuncitonBlockID : {REDUND_UNREPLICABLE} UINT; (*Function block ID*)
		InitParCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of parameters done*)
		ComStructUpdated : {REDUND_UNREPLICABLE} BOOL; (*Indicates that command structure layout was updated on SuperTrak*)
		WarningActive : {REDUND_UNREPLICABLE} BOOL; (*Warning is active*)
		ErrorActive : {REDUND_UNREPLICABLE} BOOL; (*Error is active *)
		FaultMsgRead : {REDUND_UNREPLICABLE} BOOL; (*Indicates that the fault message was read*)
		WarningMsgRead : {REDUND_UNREPLICABLE} BOOL; (*Indicates that the warning message was read*)
	END_STRUCT;
	StControlInternalStCtrlType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak commands*)
		SystemControl : {REDUND_UNREPLICABLE} UINT; (*System control bits*)
		SectionControl : {REDUND_UNREPLICABLE} ARRAY[0..stCOM_CONFIG_SECTIONS_MINUS_ONE]OF USINT; (*Section control bits (32 sections)*)
		TargetRelease : {REDUND_UNREPLICABLE} ARRAY[0..64]OF USINT; (*Target release command bits (128 targets; 2 bits per target)*)
		CommandTrigger : {REDUND_UNREPLICABLE} ARRAY[0..31]OF USINT; (*Target advanced release command bits (128 command slots; 1 bit per command slot)*)
		Command : {REDUND_UNREPLICABLE} ARRAY[0..stCOM_CONFIG_COMMANDS_MINUS_ONE]OF StControlInternalStCtrlSubType; (*Shuttle advanced commands (128 command slots)*)
		VirtualInput : {REDUND_UNREPLICABLE} ARRAY[0..15]OF USINT; (*Virtual inputs (128 inputs; 1 bit each)*)
		Offset : {REDUND_UNREPLICABLE} StCtrlIntStCtrlOffsetType; (*Offsets for control structure*)
	END_STRUCT;
	StCtrlIntStCtrlOffsetType : {REDUND_UNREPLICABLE} 	STRUCT  (*Command interface offsets*)
		SystemControl : {REDUND_UNREPLICABLE} UDINT; (*Offset for system control (starts with 0 bytes)*)
		SectionControl : {REDUND_UNREPLICABLE} UDINT; (*Offset for section control*)
		TargetRelease : {REDUND_UNREPLICABLE} UDINT; (*Offset for target release*)
		CommandTrigger : {REDUND_UNREPLICABLE} UDINT; (*Offset for command trigger*)
		Command : {REDUND_UNREPLICABLE} UDINT; (*Offset for commands*)
		VirtualInput : {REDUND_UNREPLICABLE} UDINT; (*Offset for virtual inputs*)
		End : {REDUND_UNREPLICABLE} UDINT; (*Offset at the end of the structure (=size of structure)*)
	END_STRUCT;
	StControlInternalStStatType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak status*)
		SystemStatus : {REDUND_UNREPLICABLE} UINT; (*System status bits*)
		TotalPallets : {REDUND_UNREPLICABLE} UINT; (*Number of shuttles on the system*)
		SectionStatus : {REDUND_UNREPLICABLE} ARRAY[0..stCOM_CONFIG_SECTIONS_MINUS_ONE]OF USINT; (*Section status bits (32 sections)*)
		TargetStatus : {REDUND_UNREPLICABLE} ARRAY[0..255]OF StControlInternalStStatSubType; (*Target status bits (128 targets)*)
		CommandComplete : {REDUND_UNREPLICABLE} ARRAY[0..31]OF USINT; (*Command complete status bits (128 command slots; 1 bit per command slot)*)
		CommandSuccess : {REDUND_UNREPLICABLE} ARRAY[0..31]OF USINT; (*Command success status bits (128 command slots; 1 bit per command slot)*)
		VirtualOutput : {REDUND_UNREPLICABLE} ARRAY[0..15]OF USINT; (*Virtual outputs (128 outputs; 1 bit each)*)
		Offset : {REDUND_UNREPLICABLE} StCtrlIntStStatOffsetType; (*Offsets for status structure*)
		NrOfSections : {REDUND_UNREPLICABLE} UINT; (*Number of SuperTrak sections on the system*)
		EnableSignalSource : {REDUND_UNREPLICABLE} USINT; (*Source of enable signal*)
		SystemFaults : {REDUND_UNREPLICABLE} UDINT; (*Bit coded system fault messages*)
		SystemWarnings : {REDUND_UNREPLICABLE} UDINT; (*Bit coded system warning messages*)
		SystemName : {REDUND_UNREPLICABLE} STRING[32]; (*Name of the SuperTrak system (this information is  only read when function block gets enabled, not cyclically)*)
	END_STRUCT;
	StCtrlIntStStatOffsetType : {REDUND_UNREPLICABLE} 	STRUCT  (*Status interface offsets*)
		SystemStatus : {REDUND_UNREPLICABLE} UDINT; (*Offset for system status*)
		TotalPallets : {REDUND_UNREPLICABLE} UDINT; (*Offset for total shuttles*)
		SectionStatus : {REDUND_UNREPLICABLE} UDINT; (*Offset for section status*)
		TargetStatus : {REDUND_UNREPLICABLE} UDINT; (*Offset for target status*)
		CommandComplete : {REDUND_UNREPLICABLE} UDINT; (*Offset for command complete*)
		CommandSuccess : {REDUND_UNREPLICABLE} UDINT; (*Offset for command success*)
		VirtualOutput : {REDUND_UNREPLICABLE} UDINT; (*Offset for virtual outputs*)
		End : {REDUND_UNREPLICABLE} UDINT; (*Offset at the end of the structure (=size of structure)*)
	END_STRUCT;
	StControlInternalStCtrlSubType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak sub commands*)
		u1 : {REDUND_UNREPLICABLE} ARRAY[0..7]OF USINT; (*Command bits for shuttle release*)
	END_STRUCT;
	StControlInternalStStatSubType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak sub status*)
		Status : {REDUND_UNREPLICABLE} USINT; (*Status bits for target*)
		PalletID : {REDUND_UNREPLICABLE} USINT; (*Shuttle ID at target*)
		OffsetIndex : {REDUND_UNREPLICABLE} USINT; (*Offset index of shuttle at the target*)
	END_STRUCT;
	StControlInternalServChType : {REDUND_UNREPLICABLE} 	STRUCT  (*Service channel handling*)
		Step : {REDUND_UNREPLICABLE} StCtrlServChannelStepEnum; (*Step for state-machine*)
		RequestData : {REDUND_UNREPLICABLE} StCtrlInternalServChMsgType; (*Request data sent to SuperTrak*)
		ResponseData : {REDUND_UNREPLICABLE} StCtrlInternalServChMsgType; (*Response data from SuperTrak*)
		ReadParameters : {REDUND_UNREPLICABLE} StReadPnuParType; (*Parameters for internal read command*)
		WriteParameters : {REDUND_UNREPLICABLE} StWritePnuParType; (*Parameters for internal write command*)
		CmdReadParameter : {REDUND_UNREPLICABLE} BOOL; (*Internal command to read parameters*)
		CmdWriteParameter : {REDUND_UNREPLICABLE} BOOL; (*Internal command to write parameters*)
		CmdSaveParameter : {REDUND_UNREPLICABLE} BOOL; (*Internal command to save parameters*)
		CommActive : {REDUND_UNREPLICABLE} BOOL; (*Indicates that service channel is occupied by this FB instance*)
		ParameterRead : {REDUND_UNREPLICABLE} BOOL; (*Internal status info that parameter was read*)
		ParameterWritten : {REDUND_UNREPLICABLE} BOOL; (*Internal status info that parameter was written*)
		ParameterSaved : {REDUND_UNREPLICABLE} BOOL; (*Internal status info that parameter was saved*)
		ReadData : {REDUND_UNREPLICABLE} ARRAY[0..stCOM_CONFIG_SERV_CH_MAX_DATA_M1]OF UDINT; (*Internal service channel data*)
		WriteData : {REDUND_UNREPLICABLE} ARRAY[0..stCOM_CONFIG_SERV_CH_MAX_DATA_M1]OF UDINT; (*Internal service channel data*)
		ValidReadDataSize : {REDUND_UNREPLICABLE} UDINT; (*Internal service channel data size*)
	END_STRUCT;
	StCtrlInternalServChMsgType : {REDUND_UNREPLICABLE} 	STRUCT  (*Service channel message strucutre*)
		Length : {REDUND_UNREPLICABLE} UINT; (*Length of message*)
		Sequence : {REDUND_UNREPLICABLE} USINT; (*Sequence (used to indicate a new request)*)
		Task : {REDUND_UNREPLICABLE} USINT; (*Task ID (read or write)*)
		ParameterID : {REDUND_UNREPLICABLE} UINT; (*Parameter ID*)
		SectionID : {REDUND_UNREPLICABLE} USINT; (*Section ID*)
		Reserved0 : {REDUND_UNREPLICABLE} USINT; (*Reserved for future implementation*)
		StartIndex : {REDUND_UNREPLICABLE} UDINT; (*Start index for arrays*)
		Reserved1 : {REDUND_UNREPLICABLE} UINT; (*Reserved for future implementation*)
		Count : {REDUND_UNREPLICABLE} UINT; (*Parameter count for arrays*)
		Data : {REDUND_UNREPLICABLE} ARRAY[0..stCOM_CONFIG_SERV_CH_MAX_DATA_M1]OF UDINT; (*Parameter value(s)*)
	END_STRUCT;
END_TYPE

(**)
(******************************************************************************************************************************************************************************************************)
(******************************************************************************************************************************************************************************************************)
(*StTarget*)

TYPE
	StTargetStepEnum : 
		( (*Steps for state-machine*)
		ST_TARG_STATE_INIT := 0,
		ST_TARG_STATE_INIT_CHECK_CONFIG := 1,
		ST_TARG_STATE_INIT_REG_FB := 2,
		ST_TARG_STATE_INIT_CHECK_PAR := 3,
		ST_TARG_STATE_OPERATION := 4,
		ST_TARG_STATE_ERROR := 255
		);
	StTargetParType : {REDUND_UNREPLICABLE} 	STRUCT  (*Function block parameters*)
		ReleaseConfig : {REDUND_UNREPLICABLE} StParamReleaseConfigEnum; (*Configuration for release command*)
	END_STRUCT;
	StTargetInternalType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal variables*)
		Step : {REDUND_UNREPLICABLE} StTargetStepEnum; (*Step of state-machine*)
		ParametersUsed : {REDUND_UNREPLICABLE} StTargetParType; (*Internally used parameters*)
		Index : {REDUND_UNREPLICABLE} UDINT; (*Index variable*)
		Status : {REDUND_UNREPLICABLE} StTargetInternalStatusType; (*Internal status*)
		AddErrorInfo : {REDUND_UNREPLICABLE} STRING[stCOM_CONFIG_SIZE_OF_LOG_DATA]; (*Additional error information*)
		ArEventLogWrite : {REDUND_UNREPLICABLE} ArEventLogWrite; (*Function block to write log book entry*)
		ErrorResetOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		UpdateOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		ReleasePalletOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		TargetOld : {REDUND_UNREPLICABLE} USINT; (*Marker for edge detection*)
		IgnoreResetParameter : {REDUND_UNREPLICABLE} BOOL; (*Disable setting old values for edge detection*)
		CheckNewParID : {REDUND_UNREPLICABLE} BOOL; (*Check if ID is already in use*)
	END_STRUCT;
	StTargetInternalStatusType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal status*)
		InitConfigCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of function block configuration done*)
		FuncitonBlockRegistered : {REDUND_UNREPLICABLE} BOOL; (*Function block registered*)
		FuncitonBlockID : {REDUND_UNREPLICABLE} UINT; (*Function block ID*)
		FunctionBlockIDIndex : {REDUND_UNREPLICABLE} UINT; (*Index of function block id entry*)
		InitParCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of parameters done*)
	END_STRUCT;
END_TYPE

(**)
(******************************************************************************************************************************************************************************************************)
(******************************************************************************************************************************************************************************************************)
(*StTargetExt*)

TYPE
	StTargetExtStepEnum : 
		( (*Steps for state-machine*)
		ST_TRGX_STATE_INIT := 0,
		ST_TRGX_STATE_INIT_CHECK_CONFIG := 1,
		ST_TRGX_STATE_INIT_REG_FB := 3,
		ST_TRGX_STATE_INIT_CHECK_PAR := 4,
		ST_TRGX_STATE_OPERATION := 5,
		ST_TRGX_STATE_ERROR := 255
		);
	StTargetExtSubStepEnum : 
		( (*Steps for sub-state-machine*)
		ST_TRGX_SUB_WAIT_CMD := 0,
		ST_TRGX_SUB_RELEASE_PALLET := 1,
		ST_TRGX_SUB_RELEASE_TO_TARGET := 2,
		ST_TRGX_SUB_RELEASE_TO_OFFSET := 3,
		ST_TRGX_SUB_INCREMENT_OFFSET := 4,
		ST_TRGX_SUB_SET_PALLET_ID := 5,
		ST_TRGX_SUB_SET_PALLET_MOTION := 6,
		ST_TRGX_SUB_SET_PALLET_SHELF := 7,
		ST_TRGX_SUB_SET_PALLET_GAIN := 8
		);
	StTargetExtParType : {REDUND_UNREPLICABLE} 	STRUCT  (*Function block parameters*)
		AdvancedReleaseConfig : {REDUND_UNREPLICABLE} StParamAdvReleaseConfigType; (*Configuration for release commands*)
		SimpleReleaseConfig : {REDUND_UNREPLICABLE} StParamReleaseConfigEnum; (*Configuration for release commands*)
		PalletConfig : {REDUND_UNREPLICABLE} StTargetExtParPalletConfigType; (*Configuration of shuttle*)
	END_STRUCT;
	StTargetExtParPalletConfigType : {REDUND_UNREPLICABLE} 	STRUCT  (*Shuttle configuration*)
		ID : {REDUND_UNREPLICABLE} USINT := 1; (*Shuttle ID to set*)
		Motion : {REDUND_UNREPLICABLE} StParamPalletMotionConfigType; (*Shuttle motion parameters to set*)
		Shelf : {REDUND_UNREPLICABLE} StParamPalletShelfConfigType; (*Shuttle shelf parameters to set*)
		Controller : {REDUND_UNREPLICABLE} StParamPalletCtrlConfigType; (*Shuttle controller parameters to set*)
	END_STRUCT;
	StTargetExtInternalType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal variables*)
		Step : {REDUND_UNREPLICABLE} StTargetExtStepEnum; (*Step of state-machine*)
		SubStep : {REDUND_UNREPLICABLE} StTargetExtSubStepEnum; (*Step of sub-state-machine*)
		ParametersUsed : {REDUND_UNREPLICABLE} StTargetExtParType; (*Internally used parameters*)
		ParametersUsedCalc : {REDUND_UNREPLICABLE} StTargetExtInternalParamCalcType; (*Internally used parameters calculated*)
		Index : {REDUND_UNREPLICABLE} UDINT; (*Index variable*)
		Status : {REDUND_UNREPLICABLE} StTargetExtInternalStatusType; (*Internal status*)
		AddErrorInfo : {REDUND_UNREPLICABLE} STRING[stCOM_CONFIG_SIZE_OF_LOG_DATA]; (*Additional error information*)
		ArEventLogWrite : {REDUND_UNREPLICABLE} ArEventLogWrite; (*Function block to write log book entry*)
		ErrorResetOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		UpdateOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		ReleasePalletOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		ReleaseToTargetOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		ReleaseToOffsetOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		IncrementOffsetOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		SetPalletIdOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		SetPalletMotionParOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		SetPalletShelfOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		SetPalletGainOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		TargetOld : {REDUND_UNREPLICABLE} USINT; (*Marker for edge detection*)
		IgnoreResetParameter : {REDUND_UNREPLICABLE} BOOL; (*Disable setting old values for edge detection*)
		CheckNewParID : {REDUND_UNREPLICABLE} BOOL; (*Check if ID is already in use*)
	END_STRUCT;
	StTargetExtInternalParamCalcType : {REDUND_UNREPLICABLE} 	STRUCT  (*Calculated parameters*)
		IncrementalOffsetLarge : {REDUND_UNREPLICABLE} DINT; (*Incremental offest in um*)
		IncrementalOffsetSmall : {REDUND_UNREPLICABLE} INT; (*Incremental offset in um*)
		TargetOffsetLarge : {REDUND_UNREPLICABLE} DINT; (*Offset in um*)
		Velocity : {REDUND_UNREPLICABLE} UINT; (*Velocity in um/s*)
		Acceleration : {REDUND_UNREPLICABLE} UINT; (*Acceleration in um/s*)
		ShelfWidth : {REDUND_UNREPLICABLE} UINT; (*Width of pallet in um*)
		OffsetFromCenter : {REDUND_UNREPLICABLE} INT; (*Offset from center in um*)
		ControlGain : {REDUND_UNREPLICABLE} USINT; (*Controller gain*)
		ControlFilterMoving : {REDUND_UNREPLICABLE} USINT; (*Controller filter moving*)
		ControlFilterStationary : {REDUND_UNREPLICABLE} USINT; (*Controller filter stationary*)
	END_STRUCT;
	StTargetExtInternalStatusType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal status*)
		InitConfigCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of function block configuration done*)
		FuncitonBlockRegistered : {REDUND_UNREPLICABLE} BOOL; (*Function block registered*)
		FuncitonBlockID : {REDUND_UNREPLICABLE} UINT; (*Function block ID*)
		FunctionBlockIDIndex : {REDUND_UNREPLICABLE} UINT; (*Index of function block id entry*)
		InitParCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of parameters done*)
	END_STRUCT;
END_TYPE

(**)
(******************************************************************************************************************************************************************************************************)
(******************************************************************************************************************************************************************************************************)
(*StPallet*)

TYPE
	StPalletStepEnum : 
		( (*Steps for state-machine*)
		ST_PALL_STATE_INIT := 0,
		ST_PALL_STATE_INIT_CHECK_CONFIG := 1,
		ST_PALL_STATE_INIT_REG_FB := 3,
		ST_PALL_STATE_INIT_CHECK_PAR := 4,
		ST_PALL_STATE_OPERATION := 5,
		ST_PALL_STATE_ERROR := 255
		);
	StPalletSubStepEnum : 
		( (*Steps for sub-state-machine*)
		ST_PALL_SUB_WAIT_CMD := 0,
		ST_PALL_SUB_RELEASE_TO_TARGET := 2,
		ST_PALL_SUB_RELEASE_TO_OFFSET := 3,
		ST_PALL_SUB_INCREMENT_OFFSET := 4,
		ST_PALL_SUB_SET_PALLET_MOTION := 6,
		ST_PALL_SUB_SET_PALLET_SHELF := 7,
		ST_PALL_SUB_SET_PALLET_GAIN := 8
		);
	StPalletParType : {REDUND_UNREPLICABLE} 	STRUCT  (*Function block parameters*)
		AdvancedReleaseConfig : {REDUND_UNREPLICABLE} StParamAdvReleaseConfigType; (*Configuration for release commands*)
		PalletConfig : {REDUND_UNREPLICABLE} StPalletParPalletConfigType; (*Configuration of shuttle*)
	END_STRUCT;
	StPalletParPalletConfigType : {REDUND_UNREPLICABLE} 	STRUCT  (*Shuttle configuration*)
		Motion : {REDUND_UNREPLICABLE} StParamPalletMotionConfigType; (*Shuttle motion parameters to set*)
		Shelf : {REDUND_UNREPLICABLE} StParamPalletShelfConfigType; (*Shuttle shelf parameters to set*)
		Controller : {REDUND_UNREPLICABLE} StParamPalletCtrlConfigType; (*Shuttle controller parameters to set*)
	END_STRUCT;
	StPalletInternalType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal variables*)
		Step : {REDUND_UNREPLICABLE} StPalletStepEnum; (*Step of state-machine*)
		SubStep : {REDUND_UNREPLICABLE} StPalletSubStepEnum; (*Step of sub-state-machine*)
		ParametersUsed : {REDUND_UNREPLICABLE} StPalletParType; (*Internally used parameters*)
		ParametersUsedCalc : {REDUND_UNREPLICABLE} StPalletInternalParamCalcType; (*Internally used parameters calculated*)
		Index : {REDUND_UNREPLICABLE} UDINT; (*Index variable*)
		Status : {REDUND_UNREPLICABLE} StPalletInternalStatusType; (*Internal status*)
		AddErrorInfo : {REDUND_UNREPLICABLE} STRING[stCOM_CONFIG_SIZE_OF_LOG_DATA]; (*Additional error information*)
		ArEventLogWrite : {REDUND_UNREPLICABLE} ArEventLogWrite; (*Function block to write log book entry*)
		ErrorResetOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		UpdateOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		ReleasePalletOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		ReleaseToTargetOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		ReleaseToOffsetOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		IncrementOffsetOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		SetPalletMotionParOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		SetPalletShelfOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		SetPalletGainOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		PalletIdOld : {REDUND_UNREPLICABLE} USINT; (*Marker for edge detection*)
		IgnoreResetParameter : {REDUND_UNREPLICABLE} BOOL; (*Disable setting old values for edge detection*)
		CheckNewParID : {REDUND_UNREPLICABLE} BOOL; (*Check if ID is already in use*)
	END_STRUCT;
	StPalletInternalParamCalcType : {REDUND_UNREPLICABLE} 	STRUCT  (*Calculated parameters*)
		IncrementalOffsetLarge : {REDUND_UNREPLICABLE} DINT; (*Incremental offest in um*)
		IncrementalOffsetSmall : {REDUND_UNREPLICABLE} INT; (*Incremental offset in um*)
		TargetOffsetLarge : {REDUND_UNREPLICABLE} DINT; (*Offset in um*)
		Velocity : {REDUND_UNREPLICABLE} UINT; (*Velocity in um/s*)
		Acceleration : {REDUND_UNREPLICABLE} UINT; (*Acceleration in um/s*)
		ShelfWidth : {REDUND_UNREPLICABLE} UINT; (*Width of pallet in um*)
		OffsetFromCenter : {REDUND_UNREPLICABLE} INT; (*Offset from center in um*)
		ControlGain : {REDUND_UNREPLICABLE} USINT; (*Controller gain*)
		ControlFilterMoving : {REDUND_UNREPLICABLE} USINT; (*Controller filter moving*)
		ControlFilterStationary : {REDUND_UNREPLICABLE} USINT; (*Controller filter stationary*)
	END_STRUCT;
	StPalletInternalStatusType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal status*)
		InitConfigCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of function block configuration done*)
		FuncitonBlockRegistered : {REDUND_UNREPLICABLE} BOOL; (*Function block registered*)
		FuncitonBlockID : {REDUND_UNREPLICABLE} UINT; (*Function block ID*)
		FunctionBlockIDIndex : {REDUND_UNREPLICABLE} UINT; (*Index of function block id entry*)
		InitParCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of parameters done*)
	END_STRUCT;
END_TYPE

(**)
(******************************************************************************************************************************************************************************************************)
(******************************************************************************************************************************************************************************************************)
(*StSection*)

TYPE
	StSectionStepEnum : 
		( (*Steps for state-machine*)
		ST_SECT_STATE_INIT := 0,
		ST_SECT_STATE_INIT_CHECK_CONFIG := 1,
		ST_SECT_STATE_INIT_REG_FB := 2,
		ST_SECT_STATE_INIT_CHECK_PAR := 3,
		ST_SECT_STATE_OPERATION := 4,
		ST_SECT_STATE_ERROR := 255
		);
	StSectionParType : {REDUND_UNREPLICABLE} 	STRUCT  (*Function block parameters*)
		Reserved : {REDUND_UNREPLICABLE} BOOL; (*Reserved for future implementation*)
	END_STRUCT;
	StSectionInfoType : {REDUND_UNREPLICABLE} 	STRUCT  (*Function block info*)
		SuperTrak : {REDUND_UNREPLICABLE} StSectionInfoSuperTrakType; (*Information about the SuperTrak system*)
	END_STRUCT;
	StSectionInfoSuperTrakType : {REDUND_UNREPLICABLE} 	STRUCT  (*Information about the SuperTrak system*)
		SectionFaultActive : {REDUND_UNREPLICABLE} BOOL; (*Indicates an active system fault (this information is read cyclically)*)
		SectionFaultBits : {REDUND_UNREPLICABLE} UDINT; (*Bit coded fault messages (see TrakMaster for description)*)
		SectionWarningActive : {REDUND_UNREPLICABLE} BOOL; (*Indicates an active system warning (this information is read cyclically)*)
		SectionWarningBits : {REDUND_UNREPLICABLE} UDINT; (*Bit coded warning messages (see TrakMaster for description)*)
	END_STRUCT;
	StSectionInternalType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal variables*)
		Step : {REDUND_UNREPLICABLE} StSectionStepEnum; (*Step of state-machine*)
		ParametersUsed : {REDUND_UNREPLICABLE} StSectionParType; (*Internally used parameters*)
		Index : {REDUND_UNREPLICABLE} UDINT; (*Index variable*)
		Status : {REDUND_UNREPLICABLE} StSectionInternalStatusType; (*Internal status*)
		AddErrorInfo : {REDUND_UNREPLICABLE} STRING[stCOM_CONFIG_SIZE_OF_LOG_DATA]; (*Additional error information*)
		ArEventLogWrite : {REDUND_UNREPLICABLE} ArEventLogWrite; (*Function block to write log book entry*)
		ServiceChannel : {REDUND_UNREPLICABLE} StSectionInternalServChType; (*Service Channel data*)
		SuperTrakStatus : {REDUND_UNREPLICABLE} StSectionInternalStStatType; (*SuperTrak status data*)
		ErrorResetOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		UpdateOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		EnableSectionOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		SectionOld : {REDUND_UNREPLICABLE} USINT; (*Marker for edge detection*)
		IgnoreResetParameter : {REDUND_UNREPLICABLE} BOOL; (*Disable setting old values for edge detection*)
		ErrorTimer : {REDUND_UNREPLICABLE} TON; (*Reset the error read bit to read every 10ms the error information*)
		ErrorRead : {REDUND_UNREPLICABLE} ARRAY[0..31]OF BOOL; (*Marker that log for this event has been created*)
		WarningRead : {REDUND_UNREPLICABLE} ARRAY[0..31]OF BOOL; (*Marker that log for this event has been created*)
		AcknowledgeScope : {REDUND_UNREPLICABLE} UINT;
	END_STRUCT;
	StSectionInternalStatusType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal status*)
		InitConfigCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of function block configuration done*)
		FuncitonBlockRegistered : {REDUND_UNREPLICABLE} BOOL; (*Function block registered*)
		FuncitonBlockID : {REDUND_UNREPLICABLE} UINT; (*Function block ID*)
		FunctionBlockIDIndex : {REDUND_UNREPLICABLE} UINT; (*Index of function block id entry*)
		InitParCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of parameters done*)
		WarningActive : {REDUND_UNREPLICABLE} BOOL; (*Section warning active*)
		ErrorActive : {REDUND_UNREPLICABLE} BOOL; (*Section fault active*)
		FaultMsgRead : {REDUND_UNREPLICABLE} BOOL; (*Indicates that the fault message was read*)
		WarningMsgRead : {REDUND_UNREPLICABLE} BOOL; (*Indicates that the warning message was read*)
	END_STRUCT;
	StSectionInternalServChType : {REDUND_UNREPLICABLE} 	STRUCT  (*Service channel handling*)
		RequestData : {REDUND_UNREPLICABLE} StCtrlInternalServChMsgType; (*Request data sent to SuperTrak*)
		ResponseData : {REDUND_UNREPLICABLE} StCtrlInternalServChMsgType; (*Response data from SuperTrak*)
		ReadParameters : {REDUND_UNREPLICABLE} StReadPnuParType; (*Parameters for internal read command*)
		WriteParameters : {REDUND_UNREPLICABLE} StWritePnuParType; (*Parameters for internal write command*)
		CmdReadParameter : {REDUND_UNREPLICABLE} BOOL; (*Internal command to read parameters*)
		CmdWriteParameter : {REDUND_UNREPLICABLE} BOOL; (*Internal command to write parameters*)
		CmdSaveParameter : {REDUND_UNREPLICABLE} BOOL; (*Internal command to save parameters*)
		CommActive : {REDUND_UNREPLICABLE} BOOL; (*Indicates that service channel is occupied by this FB instance*)
		ParameterRead : {REDUND_UNREPLICABLE} BOOL; (*Internal status info that parameter was read*)
		ParameterWritten : {REDUND_UNREPLICABLE} BOOL; (*Internal status info that parameter was written*)
		ParameterSaved : {REDUND_UNREPLICABLE} BOOL; (*Internal status info that parameter was saved*)
		ReadData : {REDUND_UNREPLICABLE} ARRAY[0..stCOM_CONFIG_SERV_CH_MAX_DATA_M1]OF UDINT; (*Internal service channel data*)
		WriteData : {REDUND_UNREPLICABLE} ARRAY[0..stCOM_CONFIG_SERV_CH_MAX_DATA_M1]OF UDINT; (*Internal service channel data*)
		ValidReadDataSize : {REDUND_UNREPLICABLE} UDINT; (*Internal service channel data size*)
	END_STRUCT;
	StSectionInternalStStatType : {REDUND_UNREPLICABLE} 	STRUCT  (*SuperTrak status*)
		SectionFaults : {REDUND_UNREPLICABLE} UDINT; (*Bit coded system fault messages*)
		SectionWarnings : {REDUND_UNREPLICABLE} UDINT; (*Bit coded system warning messages*)
	END_STRUCT;
END_TYPE

(**)
(******************************************************************************************************************************************************************************************************)
(******************************************************************************************************************************************************************************************************)
(*StReadPar*)

TYPE
	StReadPnuStepEnum : 
		( (*Steps for state-machine*)
		ST_RPAR_STATE_INIT := 0,
		ST_RPAR_STATE_INIT_CHECK_CONFIG := 1,
		ST_RPAR_STATE_INIT_REG_FB := 2,
		ST_RPAR_STATE_INIT_CHECK_PAR := 3,
		ST_RPAR_STATE_OPERATION := 4,
		ST_RPAR_STATE_ERROR := 255
		);
	StReadPnuParType : {REDUND_UNREPLICABLE} 	STRUCT  (*Function block parameters*)
		ParameterNumber : {REDUND_UNREPLICABLE} UINT; (*Parameter number (parameter ID) to be read*)
		SectionID : {REDUND_UNREPLICABLE} USINT; (*OPTIONAL Section ID for paramters which are section specific*)
		StartParameterIndex : {REDUND_UNREPLICABLE} UDINT; (*OPTIONAL Start Index of array to be read from (only for arrays)*)
		ParameterValueCount : {REDUND_UNREPLICABLE} UINT; (*OPTIONAL Number of values (array entries) to be read after the start index (only for arrays)*)
	END_STRUCT;
	StReadPnuInternalType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal variables*)
		Step : {REDUND_UNREPLICABLE} StReadPnuStepEnum; (*Step of state-machine*)
		ParametersUsed : {REDUND_UNREPLICABLE} StReadPnuParType; (*Internally used parameters*)
		Index : {REDUND_UNREPLICABLE} UDINT; (*Index variable*)
		Status : {REDUND_UNREPLICABLE} StReadPnuInternalStatusType; (*Internal status*)
		AddErrorInfo : {REDUND_UNREPLICABLE} STRING[stCOM_CONFIG_SIZE_OF_LOG_DATA]; (*Additional error information*)
		ArEventLogWrite : {REDUND_UNREPLICABLE} ArEventLogWrite; (*Function block to write log book entry*)
		UpdateOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		ErrorResetOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		ReadCmdOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		ExecuteReading : {REDUND_UNREPLICABLE} BOOL; (*Internal command to execute parameter reading*)
	END_STRUCT;
	StReadPnuInternalStatusType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal status*)
		InitConfigCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of function block configuration done*)
		FuncitonBlockRegistered : {REDUND_UNREPLICABLE} BOOL; (*Function block registered*)
		FuncitonBlockID : {REDUND_UNREPLICABLE} UINT; (*Function block ID*)
		FunctionBlockIDIndex : {REDUND_UNREPLICABLE} UINT; (*Index of function block id entry*)
		InitParCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of parameters done*)
		CommActive : {REDUND_UNREPLICABLE} BOOL; (*Indicates that service channel is occupied by this FB instance*)
	END_STRUCT;
	StReadInfoType : {REDUND_UNREPLICABLE} 	STRUCT  (*Additional function block information*)
		MaxValidDataSize : {REDUND_UNREPLICABLE} UDINT; (*Maximum size of data to be read [bytes]*)
	END_STRUCT;
END_TYPE

(**)
(******************************************************************************************************************************************************************************************************)
(******************************************************************************************************************************************************************************************************)
(*StWritePar*)

TYPE
	StWritePnuStepEnum : 
		( (*Steps for state-machine*)
		ST_WPAR_STATE_INIT := 0,
		ST_WPAR_STATE_INIT_CHECK_CONFIG := 1,
		ST_WPAR_STATE_INIT_REG_FB := 2,
		ST_WPAR_STATE_INIT_CHECK_PAR := 3,
		ST_WPAR_STATE_OPERATION := 4,
		ST_WPAR_STATE_ERROR := 255
		);
	StWritePnuParType : {REDUND_UNREPLICABLE} 	STRUCT  (*Function block parameters*)
		ValidDataSize : {REDUND_UNREPLICABLE} UDINT; (*Size of valid data to be written [bytes]*)
		ParameterNumber : {REDUND_UNREPLICABLE} UINT; (*Parameter number (parameter ID) to be written*)
		SectionID : {REDUND_UNREPLICABLE} USINT; (*OPTIONAL Section ID for paramters which are section specific*)
		StartParameterIndex : {REDUND_UNREPLICABLE} UDINT; (*OPTIONAL Start Index of array to be written to (only for arrays)*)
		ParameterValueCount : {REDUND_UNREPLICABLE} UINT; (*OPTIONAL Number of values (array entries) to be written after the start index (only for arrays)*)
	END_STRUCT;
	StWritePnuInternalType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal variables*)
		Step : {REDUND_UNREPLICABLE} StWritePnuStepEnum; (*Step of state-machine*)
		ParametersUsed : {REDUND_UNREPLICABLE} StWritePnuParType; (*Internally used parameters*)
		Index : {REDUND_UNREPLICABLE} UDINT; (*Index variable*)
		Status : {REDUND_UNREPLICABLE} StWritePnuInternalStatusType; (*Internal status*)
		AddErrorInfo : {REDUND_UNREPLICABLE} STRING[stCOM_CONFIG_SIZE_OF_LOG_DATA]; (*Additional error information*)
		ArEventLogWrite : {REDUND_UNREPLICABLE} ArEventLogWrite; (*Function block to write log book entry*)
		ErrorResetOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		UpdateOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		WriteCmdOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		SaveParCmdOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		ExecuteWriting : {REDUND_UNREPLICABLE} BOOL; (*Internal command to execute parameter writing*)
		ExecuteSaving : {REDUND_UNREPLICABLE} BOOL; (*Internal command to execute parameter saving*)
		SaveParData : {REDUND_UNREPLICABLE} DINT; (*Internal data for paramter save command*)
	END_STRUCT;
	StWritePnuInternalStatusType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal status*)
		InitConfigCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of function block configuration done*)
		FuncitonBlockRegistered : {REDUND_UNREPLICABLE} BOOL; (*Function block registered*)
		FuncitonBlockID : {REDUND_UNREPLICABLE} UINT; (*Function block ID*)
		FunctionBlockIDIndex : {REDUND_UNREPLICABLE} UINT; (*Index of function block id entry*)
		InitParCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of parameters done*)
		CommActive : {REDUND_UNREPLICABLE} BOOL; (*Indicates that service channel is occupied by this FB instance*)
	END_STRUCT;
	StWriteInfoType : {REDUND_UNREPLICABLE} 	STRUCT  (*Additional function block information*)
		MaxValidDataSize : {REDUND_UNREPLICABLE} UDINT; (*Maximum size of data to be written [bytes]*)
	END_STRUCT;
END_TYPE

(**)
(******************************************************************************************************************************************************************************************************)
(******************************************************************************************************************************************************************************************************)
(*StAdvCmd*)

TYPE
	StAdvCmdStepEnum : 
		( (*Steps for state-machine*)
		ST_ACMD_STATE_INIT := 0,
		ST_ACMD_STATE_INIT_CHECK_CONFIG := 1,
		ST_ACMD_STATE_INIT_REG_FB := 2,
		ST_ACMD_STATE_INIT_CHECK_PAR := 3,
		ST_ACMD_STATE_OPERATION := 4,
		ST_ACMD_STATE_ERROR := 255
		);
	StAdvCmdSubStepEnum : 
		( (*Steps for sub-state-machine*)
		ST_ACMD_SUB_WAIT_CMD := 0,
		ST_ACMD_SUB_EXECUTE_CMD := 1
		);
	StAdvCmdParType : {REDUND_UNREPLICABLE} 	STRUCT  (*Function block parameters*)
		CommandID : {REDUND_UNREPLICABLE} USINT := 16; (*Command ID to  be executed*)
		Context : {REDUND_UNREPLICABLE} USINT := 1; (*Context of command (target ID or pallet ID)*)
		Parameters : {REDUND_UNREPLICABLE} ARRAY[0..5]OF USINT := [6(0)]; (*Parameters to be sent with the command (e.g. move configuration index etc.)*)
	END_STRUCT;
	StAdvCmdInternalType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal variables*)
		Step : {REDUND_UNREPLICABLE} StAdvCmdStepEnum; (*Step of state-machine*)
		SubStep : {REDUND_UNREPLICABLE} StAdvCmdSubStepEnum; (*Step of sub-state-machine*)
		ParametersUsed : {REDUND_UNREPLICABLE} StAdvCmdParType; (*Internally used parameters*)
		Index : {REDUND_UNREPLICABLE} UDINT; (*Index variable*)
		Status : {REDUND_UNREPLICABLE} StAdvCmdInternalStatusType; (*Internal status*)
		AddErrorInfo : {REDUND_UNREPLICABLE} STRING[stCOM_CONFIG_SIZE_OF_LOG_DATA]; (*Additional error information*)
		ArEventLogWrite : {REDUND_UNREPLICABLE} ArEventLogWrite; (*Function block to write log book entry*)
		ErrorResetOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		UpdateOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
		SendCmdOld : {REDUND_UNREPLICABLE} BOOL; (*Marker for edge detection*)
	END_STRUCT;
	StAdvCmdInternalStatusType : {REDUND_UNREPLICABLE} 	STRUCT  (*Internal status*)
		InitConfigCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of function block configuration done*)
		FuncitonBlockRegistered : {REDUND_UNREPLICABLE} BOOL; (*Function block registered*)
		FuncitonBlockID : {REDUND_UNREPLICABLE} UINT; (*Function block ID*)
		FunctionBlockIDIndex : {REDUND_UNREPLICABLE} UINT; (*Index of function block id entry*)
		FunctionBlockInstance : {REDUND_UNREPLICABLE} USINT; (*Instance of function block*)
		InitParCheckDone : {REDUND_UNREPLICABLE} BOOL; (*Check of parameters done*)
	END_STRUCT;
END_TYPE
