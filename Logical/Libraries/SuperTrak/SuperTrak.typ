(*
Copyright ATS Automation Tooling Systems, Inc. 2015-2020
All rights reserved.
*)
(*Control interface structures*)

TYPE
	SuperTrakSystemControl_t : 	STRUCT  (*System Control portion of a control interface*)
		control : WORD; (*System control bits*)
		reserved : UINT; (*Not used; should always be zero*)
	END_STRUCT;
	SuperTrakSystemStatus_t : 	STRUCT  (*System Status portion of a control interface*)
		status : WORD; (*System status bits*)
		totalPallets : UINT; (*Not used; should always be zero*)
	END_STRUCT;
	SuperTrakSectionControl_t : 	STRUCT  (*Section Control portion of a control interface*)
		control : BYTE; (*Section control bits*)
	END_STRUCT;
	SuperTrakSectionStatus_t : 	STRUCT  (*Section Status portion of a control interface*)
		status : BYTE; (*Section status bits*)
	END_STRUCT;
	SuperTrakSectionStatusR3_t : 	STRUCT  (*Section Status portion of a control interface*)
		status : WORD; (*Section status bits*)
	END_STRUCT;
	SuperTrakTargetStatus_t : 	STRUCT  (*Target Status portion of a control interface*)
		status : BYTE; (*Target status bits (see StTargetStatusBits)*)
		palletID : USINT; (*Pallet ID for the pallet at the target*)
		offsetIndex : USINT; (*Current offset map index for the pallet at the target*)
	END_STRUCT;
	SuperTrakCommand_t : 	STRUCT  (*Command Buffer portion of a control interface*)
		u1 : ARRAY[0..7]OF USINT; (*Command data*)
	END_STRUCT;
	ServiceChannelHeader_t : 	STRUCT  (*Header structure for service channel requests and responses*)
		length : UINT; (*Total length of the request or response, including this header.*)
		sequence : USINT; (*The requestor normally increments this number, for each request. The value is echoed in the reply.*)
		task : USINT; (*In requests, one of the scTASK constants. In responses, one of the scERR constants.*)
		param : UINT; (*Specifies which parameter is being addressed.*)
		section : USINT; (*Specifies which section is being addressed, or zero to address the system.*)
		reserved0 : USINT; (*Not used; should always be zero*)
		startIndex : UDINT; (*Specifies the starting index for the parameter that is being addressed.*)
		reserved1 : UINT; (*Not used; should always be zero*)
		count : UINT; (*Specifies the number of data elements to be transferred.*)
	END_STRUCT;
	SyncZoneControl_t : 	STRUCT  (*SyncZone Control portion of a control interface*)
		control : BYTE; (*SyncZone control bis*)
	END_STRUCT;
	SyncZoneStatus_t : 	STRUCT  (*SyncZone Status portion of a control interface*)
		status : BYTE; (*SyncZone status bits*)
		firstPalletID : USINT; (*ID of the first pallet pertaining to SyncZone*)
		lastPalletID : USINT; (*ID of the last pallet pertaining to SyncZone*)
	END_STRUCT;
	SyncZoneStatusR3_t : 	STRUCT  (*SyncZone Status portion of a control interface*)
		status : WORD; (*SyncZone status bits*)
		firstPalletID : USINT; (*ID of the first pallet pertaining to SyncZone*)
		lastPalletID : USINT; (*ID of the last pallet pertaining to SyncZone*)
	END_STRUCT;
	SyncMasterControl_t : 	STRUCT  (*Sync Master Control portion of a control interface*)
		masterVelocitySetpoint : REAL; (*Sync Master velocity setpoint*)
		masterCycleStopPosition : REAL; (*Sync Master cycle stop position*)
		masterControlBits : WORD; (*Sync Master control bits 0 - 15*)
		spareWord1 : UINT; (*Not used: should always be zero*)
	END_STRUCT;
	SyncMasterStatus_t : 	STRUCT  (*Sync Master Status portion of a control interface*)
		masterActVelocity : REAL; (*Sync Master current velocity*)
		masterActPosition : REAL; (*Sync Master current position*)
		masterErrorCode : UDINT; (*Sync Master error code*)
		masterStatusBits : WORD; (*Sync Master status bits 0 - 15*)
		spareWord1 : UINT; (*Not used: should always be zero*)
	END_STRUCT;
	SyncFollowerManualControl_t : 	STRUCT  (*Sync Follower (selected) Manual Control*)
		followerIndex : USINT; (*Index of follower in use*)
		followerControlBits : BYTE; (*Sync Follower control bits*)
		followerSpare1 : USINT; (*Not used: should always be zero*)
		followerSpare2 : USINT; (*Not used: should always be zero*)
		followerCmdPosition : REAL; (*Sync Follower commanded position*)
		followerVelocity : REAL; (*Sync Follower commanded velocity*)
	END_STRUCT;
	SyncFollowerManualStatus_t : 	STRUCT  (*Sync Follower (selected) Manual Status*)
		followerIndex : USINT; (*Index of follower in use*)
		followerStatusBits : BYTE; (*Sync Follower status bits*)
		followerSpare1 : USINT; (*Not used: should always be zero*)
		followerSpare2 : USINT; (*Not used: should always be zero*)
		followerActVelocity : REAL; (*Sync Follower current velocity*)
		followerActPosition : REAL; (*Sync Follower current position*)
		followerCmdPosition : REAL; (*Sync Follower setpoint position*)
		followerErrorCode : DINT; (*Sync Follower error code*)
	END_STRUCT;
	SyncSingleFollowerControl_t : 	STRUCT  (*Sync Follower (specific) Control*)
		controlBits : BYTE; (*Sync Follower control bits*)
		selectedRecipe : USINT; (*Sync Follower selected recipe*)
	END_STRUCT;
	SyncSingleFollowerStatus_t : 	STRUCT  (*Sync Follower (specific) Status*)
		statusBits : BYTE; (*Sync Follower status bits*)
		activeRecipe : USINT; (*Sync Follower active recipe*)
	END_STRUCT;
	SyncSingleFollowerFeedback_t : 	STRUCT  (*Sync Follower (specific) extra status feedback*)
		position : REAL; (*Sync Follower current position *)
	END_STRUCT;
	SyncExtMasterCommonIn_t : 	STRUCT  (*Sync External Master Common input*)
		timeStampReturn : DINT; (*Echoed Time stamp*)
		commonControlBits : BYTE; (*External Master common control bits*)
		reserved : ARRAY[0..2]OF USINT;
	END_STRUCT;
	SyncExtMasterCommonOut_t : 	STRUCT  (*Sync External Master Common output*)
		timeStamp : DINT; (*Time Stamp*)
		timeDiff : DINT; (*Time Stamp difference*)
	END_STRUCT;
	SyncExtMasterControl_t : 	STRUCT  (*Sync External Master Control*)
		setpointPosition : DINT; (*Setpoint position for External Master Control (udeg)*)
		setpointVel : DINT; (*Setpoint velocity for External Master Control (mdeg / sec)*)
		setPointAccel : DINT; (*Setpoint acceleretion for External Master Control (mdeg / sec^2)*)
		setPointJerk : DINT; (*Setpoint jerk for External Master Control (mdeg / sec^3)*)
		commandedVel : DINT; (*Commanded velocity for External Master Control (mdeg / sec)*)
		commandedAccel : DINT; (*Commanded acceleration for External Master Control (mdeg / sec^2)*)
	END_STRUCT;
	SyncExtMasterStatus_t : 	STRUCT  (*Sync External Master status*)
		extMasterStatusBits : BYTE; (*External Master status bits*)
	END_STRUCT;
END_TYPE

(*Command structures*)

TYPE
	StCmdReleasePallet_t : 	STRUCT  (*Data for commands 16 to 19*)
		command : USINT; (*values 16 through 19*)
		context : USINT; (*current target for commands 16/17; pallet ID for commands 18/19*)
		destTarget : USINT; (*0 = none*)
		moveConfig : USINT; (*0 = none; 1 - 240 global; 241 - 243 local*)
		targetOffset : USINT; (*index in offset table; 0 = none*)
		reserved5 : USINT; (*specify 0*)
		incrementalOffset : UINT; (*in microns*)
	END_STRUCT;
	StCmdReleaseTargetOffset_t : 	STRUCT  (*Data for commands 24 to 27*)
		command : USINT; (*values 24 through 27*)
		context : USINT; (*current target for commands 24/25; pallet ID for commands 26/27*)
		destTarget : USINT; (*0 = none*)
		moveConfig : USINT; (*0 = none; 1 - 240 global; 241 - 243 local*)
		offset : DINT; (*offset relative to target, in microns*)
	END_STRUCT;
	StCmdReleaseIncrementalOffset_t : 	STRUCT  (*Data for commands 28 to 31*)
		command : USINT; (*values 28 through 31*)
		context : USINT; (*current target for commands 28/29; pallet ID for commands 30/31*)
		destTarget : USINT; (*0 = none*)
		moveConfig : USINT; (*0 = none; 1 - 240 global; 241 - 243 local*)
		offset : DINT; (*incremental offset, in microns*)
	END_STRUCT;
	StCmdContinueMove_t : 	STRUCT  (*Data for commands 60 and 62*)
		command : USINT; (*values 60 and 62*)
		context : USINT; (*current target for command 60; pallet ID for command 62*)
		reserved2to3 : UINT; (*specify 0*)
		reserved4to7 : UDINT; (*specify 0*)
	END_STRUCT;
	StCmdSetPalletID_t : 	STRUCT  (*Data for command 64*)
		command : USINT; (*value 64*)
		target : USINT; (*current target*)
		palletID : USINT; (*pallet ID to assign*)
		reserved3 : USINT; (*specify 0*)
		reserved4to7 : UDINT; (*specify 0*)
	END_STRUCT;
	StCmdSetVelocityAccel_t : 	STRUCT  (*Data for commands 68 and 70*)
		command : USINT; (*values 68 and 70*)
		context : USINT; (*current target for command 68; pallet ID for command 70*)
		velocity : UINT; (*commanded velocity, in mm/s; 0 = no change*)
		acceleration : UINT; (*commanded acceleration, in m/s^2; 0 = no change*)
		reserved6to7 : UINT; (*specify 0*)
	END_STRUCT;
	StCmdSetPalletWidth_t : 	STRUCT  (*Data for commands 72 and 74*)
		command : USINT; (*values 72 and 74*)
		context : USINT; (*current target for command 72; pallet ID for command 74*)
		shelfWidth : UINT; (*in units of 0.1mm*)
		shelfOffset : UINT; (*in units of 0.1mm*)
		reserved6to7 : UINT; (*specify 0*)
	END_STRUCT;
	StCmdSetPalletControlParams_t : 	STRUCT  (*Data for commands 76 and 78*)
		command : USINT; (*values 76 and 78*)
		context : USINT; (*current target for command 76; pallet ID for command 78*)
		controlGainSet : USINT; (*0 to 15*)
		movingFilterPercent : USINT;
		stationaryFilterPercent : USINT;
		reserved5 : USINT; (*specify 0*)
		reserved6to7 : UINT; (*specify 0*)
	END_STRUCT;
	StCmdAntiSlosh_t : 	STRUCT  (*Data for commands 80 and 82*)
		command : USINT; (*values 80 and 82*)
		context : USINT; (*current target for command 80; pallet ID for command 82*)
		containerShape : USINT; (*0 = disable, 1 = rectangle, 2 = cylinder*)
		oscillationModes : USINT; (*0 = first, 1 = 1st and 2nd, 2 = 1st, 2nd, and 3rd*)
		containerLength : UINT; (*millimetres*)
		fillLevel : UINT; (*millimetres*)
	END_STRUCT;
	StCmdAttachEncoderOutput_t : 	STRUCT  (*Data for commands 84 and 86*)
		command : USINT; (*values 84 and 86*)
		context : USINT; (*current target for command 84; pallet ID for command 86*)
		encoderOutputIndex : USINT; (*Index of the encoder output to attach*)
	END_STRUCT;
	StCmdDetachEncoderOutput_t : 	STRUCT  (*Data for commands 85 and 87*)
		command : USINT; (*values 85 and 87*)
		context : USINT; (*current target for command 85; pallet ID for command 87*)
	END_STRUCT;
END_TYPE

(*Miscellaneous structures*)

TYPE
	SuperTrakControlInterface_t : 	STRUCT  (*Data for the SuperTrakProcessControl function*)
		pControl : UDINT; (*Pointer to control data buffer (typically a structure or byte array)*)
		pStatus : UDINT; (*Pointer to status data buffer (typically a structure or byte array)*)
		controlSize : UINT; (*Size of control data, in bytes*)
		statusSize : UINT; (*Size of status data buffer, in bytes*)
		connectionType : USINT; (*Connection type; use stCONNECTION constants*)
	END_STRUCT;
	ServiceChannel_t : 	STRUCT  (*Data for the SuperTrakServiceChannel function*)
		channelId : USINT; (*Uniquely identifies this service channel instance (use values 1 through 15)*)
		state : USINT; (*Indicates the current state of this service channel*)
		requestSequence : USINT; (*Tracks the most recent request sequence number*)
		reserved0 : USINT; (*Not used; should always be zero*)
		timeLimit : UINT; (*Maximum time allowed for request completion, in milliseconds*)
		timer : UINT; (*Used to implement a timeout mechanism for requests that must be processed asynchronously*)
		pRequestHeader : REFERENCE TO ServiceChannelHeader_t; (*Pointer to the request header*)
		pResponseHeader : REFERENCE TO ServiceChannelHeader_t; (*Pointer to the response header*)
		requestBufferSize : UINT; (*Size of the pRequestValues buffer, in bytes*)
		responseBufferSize : UINT; (*Size of the pResponseValues buffer, in bytes*)
		pRequestValues : UDINT; (*Pointer to the request values, or zero if not applicable*)
		pResponseValues : UDINT; (*Pointer to the response values, or zero if not applicable*)
	END_STRUCT;
	SuperTrakControlIfConfig_t : 	STRUCT  (*Control interface configuration information*)
		options : WORD; (*Control interface options (for bit assignments, see StControlIfOptions)*)
		revision : UINT;
		systemControlOffset : UINT;
		systemStatusOffset : UINT;
		controlSize : UINT; (*Total size of control data*)
		statusSize : UINT; (*Total size of status data*)
		sectionStartIndex : UINT; (*Zero-based index relative to Logical Head Section*)
		sectionCount : UINT;
		sectionControlOffset : UINT;
		sectionStatusOffset : UINT;
		targetStartIndex : UINT;
		targetCount : UINT;
		targetControlOffset : UINT;
		targetStatusOffset : UINT;
		commandCount : UINT;
		commandTriggerOffset : UINT; (*Used only when revision < 2*)
		commandDataOffset : UINT;
		commandStatusOffset : UINT; (*Used only when revision >= 2*)
		commandCompleteOffset : UINT; (*Used only when revision < 2*)
		commandSuccessOffset : UINT; (*Used only when revision < 2*)
		networkIoStartIndex : UINT;
		networkIoCount : UINT;
		networkInputOffset : UINT; (*Inputs to the conveyor (control)*)
		networkOutputOffset : UINT; (*Outputs from the conveyor (status)*)
		syncZoneStartIndex : UINT;
		syncZoneCount : UINT;
		syncZoneControlOffset : UINT;
		syncZoneStatusOffset : UINT;
		serviceChannelSize : UINT;
		serviceChannelRequestOffset : UINT; (*Request data (control)*)
		serviceChannelResponseOffset : UINT; (*Response data (status)*)
		masterCount : UINT;
		masterControlOffset : UINT;
		masterStatusOffset : UINT;
		followerManualCount : UINT;
		followerManualControlOffset : UINT;
		followerManualStatusOffset : UINT;
		followerCount : UINT;
		followerControlOffset : UINT;
		followerStatusOffset : UINT;
		followerPositionOffset : UINT;
		extMasterStatusOffset : UINT;
		extMasterControlOffset : UINT;
	END_STRUCT;
	SuperTrakPalletInfo_t : 	STRUCT  (*Data for the SuperTrakGetPalletInfo function*)
		palletID : USINT; (*Pallet ID number assigned to the pallet*)
		status : BYTE; (*Pallet status bits (see StPalletStatusBits)*)
		controlMode : USINT; (*Pallet control mode*)
		section : USINT; (*Section number where the pallet is currently located*)
		position : DINT; (*Current pallet position, in microns*)
	END_STRUCT;
	FieldbusHardwareOption_t : 	STRUCT  (*Specifies a fieldbus hardware selection option*)
		ID : UDINT;
		Title : STRING[39];
		Data : STRING[19];
	END_STRUCT;
END_TYPE

(*Enumerations*)

TYPE
	StControlIfOptionBits_e : 
		( (*Control Interface Options bit definitions*)
		stCONTROL_IF_ENABLED := 0, (*Control interface is enabled*)
		stCONTROL_IF_SYSTEM_ENABLED := 1, (*System Status/Control enabled*)
		stCONTROL_IF_STATUS_ONLY := 2, (*If true, then some control features are disabled*)
		stCONTROL_IF_SERV_CHAN_ENABLED := 3, (*Service Channel enabled*)
		stCONTROL_IF_EXT_MASTER := 4 (*External Master Control enabled*)
		);
	StPalletStatusBits_e : 
		( (*Pallet Status bit definitions*)
		stPALLET_PRESENT := 0,
		stPALLET_RECOVERING := 1,
		stPALLET_AT_TARGET := 2,
		stPALLET_IN_POSITION := 3,
		stPALLET_SERVO_ENABLED := 4,
		stPALLET_INITIALIZING := 5,
		stPALLET_LOST := 6
		);
	StTargetStatusBits_e : 
		( (*Target Status bit definitions*)
		stTARGET_PALLET_PRESENT := 0,
		stTARGET_PALLET_IN_POSITION := 1,
		stTARGET_PALLET_PRE_ARRIVAL := 2,
		stTARGET_PALLET_OVER := 3,
		stTARGET_PALLET_POS_UNCERTAIN := 6,
		stTARGET_RELEASE_ERROR := 7
		);
	StSectionStatusBits_e : 
		( (*Section Status bit definitions*)
		stSECTION_ENABLED := 0,
		stSECTION_UNRECOGNIZED_PALLET := 1,
		stSECTION_MOTOR_POWER_ON := 2,
		stSECTION_PALLETS_RECOVERING := 3,
		stSECTION_LOCATING_PALLETS := 4,
		stSECTION_DISABLED_EXTERNALLY := 5,
		stSECTION_WARNING := 6,
		stSECTION_FAULT := 7
		);
	StSectionControlBits_e : 
		( (*Section Control bit definitions*)
		stSECTION_ENABLE := 0,
		stSECTION_ACKNOWLEDGE_FAULTS := 7
		);
	StSystemControlBits_e : 
		( (*System Control bit definitions*)
		stSYSTEM_ENABLE_ALL_SECTIONS := 0,
		stSYSTEM_ACKNOWLEDGE_FAULTS := 7,
		stSYSTEM_CONTROL_HEARTBEAT := 15
		);
	StSystemStatusBits_e : 
		( (*System Status bit definitions*)
		stSYSTEM_PALLETS_STOPPED := 4,
		stSYSTEM_WARNING := 6,
		stSYSTEM_FAULT := 7,
		stSYSTEM_STATUS_HEARTBEAT := 15
		);
END_TYPE

(*Structures for Position Triggering*)

TYPE
	PosTrigEdgeGen_t : 	STRUCT  (*I/O mapping for one edge-generator of an X20DS4389*)
		InputError : BOOL; (*Status bit indicating an error*)
		InputWarning : BOOL; (*Status bit indicating a warning*)
		OutputEnable : BOOL; (*Enable command for HW module*)
		OutputQuitError : BOOL; (*Command to acknowledge errors*)
		OutputQuitWarning : BOOL; (*Command to acknowledge warnings*)
		OutputSequence : SINT; (*Sequence number*)
		OutputTimestamp : DINT; (*Time stamp, when output should be active*)
	END_STRUCT;
	QuadPosTrigHardware_t : 	STRUCT  (*I/O mapping for X20DS4389 for 4 position trigger outputs*)
		ModuleOk : BOOL; (*Module present status*)
		DeviceAddress : STRING[39]; (*PLC Address in Physical View*)
		EdgeGen : ARRAY[0..3]OF PosTrigEdgeGen_t;
	END_STRUCT;
	StPositionTriggerInternal_t : 	STRUCT  (* *) (* *) (*#OMIT*)
		busy : BOOL;
		prevPulseRelativeTime : DINT;
		prevPulseTime : DINT;
		prevPulseEndTime : DINT;
		writtenPulseDuration : UDINT;
		AsyncIOWrite : AsIOAccWrite;
	END_STRUCT;
END_TYPE

(*Structures for Encoder Outputs*)

TYPE
	EncoderOutputHardware_t : 	STRUCT  (*I/O mapping for X20DS1119 for an encoder output*)
		ModuleOk : BOOL; (*Module present status*) (* *) (*#CYC*)
		InMovFifoEmpty : BOOL; (*Status bit indicating an error*) (* *) (*#CYC*)
		InMovFifoFull : BOOL; (*Status bit indicating an error*) (* *) (*#CYC*)
		InMovTargetTimeViolation : BOOL; (*Status bit indicating an error*) (* *) (*#CYC*)
		InMovMaxFrequencyViolation : BOOL; (*Status bit indicating an error*) (* *) (*#CYC*)
		OutMovQuitFifoEmpty : BOOL; (*Status bit indicating an error acknowledgement*) (* *) (*#CYC*)
		OutMovQuitFifoFull : BOOL; (*Status bit indicating an error acknowledgement*) (* *) (*#CYC*)
		OutMovQuitTargetTimeViolation : BOOL; (*Status bit indicating an error acknowledgement*) (* *) (*#CYC*)
		OutMovQuitMaxFreqViolation : BOOL; (*Status bit indicating an error acknowledgement*) (* *) (*#CYC*)
		OutMovEnable : BOOL; (*Enable command for HW module*) (* *) (*#CYC*)
		OutMovTargetTime : DINT; (*Timestamp at which to reach the target position*) (* *) (*#CYC*)
		OutMovTargetPosition : DINT; (*Position to be reached by the target timestamp*) (* *) (*#CYC*)
		OutMovReferenceStopMargin : DINT; (*End position to stop the reference pulse (relative to home position)*) (* *) (*#CYC*)
	END_STRUCT;
END_TYPE
