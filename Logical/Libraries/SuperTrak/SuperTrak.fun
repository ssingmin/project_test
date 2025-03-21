(*
Copyright ATS Automation Tooling Systems, Inc. 2015-2022
All rights reserved.
*)
(*
=== begin SuperTrak standard items ===
*)
(*SuperTrak Conveyor Controller implementation*)

FUNCTION SuperTrakInit : BOOL (*Called during INIT of Cyclic #1*) (*Not used*)
	VAR_INPUT
		storagePath : STRING[127]; (*Specifies the filesystem location for conveyor configuration data*) (* *) (*#PAR*)
		simIPAddress : STRING[15]; (*Simulation IP address, as specified in CPU Configuration*) (* *) (*#PAR*)
		ethernetInterfaces : STRING[63]; (*Comma-delimited list of Ethernet interfaces. Example: 'IF3,IF4'*) (* *) (*#PAR*)
	END_VAR
END_FUNCTION

FUNCTION SuperTrakFieldbusHwConfig : BOOL (*Informs the SuperTrak library about hardware configurations that are supported by the application project.*)
	VAR_INPUT
		pOptions : UDINT; (*Pointer to array of FieldbusHardwareOption_t*) (* *) (*#PAR*)
		optionCount : UINT; (* *) (* *) (*#PAR*)
	END_VAR
END_FUNCTION

FUNCTION SuperTrakCyclic1 : BOOL (*Called during Cyclic #1*) (*Not used*)
END_FUNCTION

FUNCTION SuperTrakExit : BOOL (*Called during EXIT of Cyclic #1*) (*Not used*)
END_FUNCTION
(*Control interface functions*)

FUNCTION SuperTrakProcessControl : BOOL (*Process the control portion of a control interface*) (*True on success, False on failure*)
	VAR_INPUT
		index : UINT; (*Fieldbus interface index (0 - 3)*) (* *) (*#PAR*)
		data : SuperTrakControlInterface_t; (*Control interface data buffers*) (* *) (*#PAR*)
	END_VAR
END_FUNCTION

FUNCTION SuperTrakProcessStatus : BOOL (*Process the status and service channel portion of a control interface *) (*True on success, False on failure*)
	VAR_INPUT
		index : UINT; (*Fieldbus interface index (0 - 3)*) (* *) (*#PAR*)
		data : SuperTrakControlInterface_t; (*Control interface data buffers*) (* *) (*#PAR*)
	END_VAR
END_FUNCTION

FUNCTION SuperTrakServiceChannel : BOOL (*See also SuperTrakServChanRead/Write and StServiceChannel*) (*True on success, False on failure*)
	VAR_IN_OUT
		sc : ServiceChannel_t; (*Service channel structure*)
	END_VAR
END_FUNCTION

FUNCTION SuperTrakServChanRead : UINT (*Reads data from the conveyor*) (*One of the scERR constants*)
	VAR_INPUT
		section : USINT; (*User-assigned section address, or 0 to access system parameters*) (* *) (*#PAR*)
		parameter : UINT; (*Parameter to read*) (* *) (*#PAR*)
		startIndex : UDINT; (*Index of first value to read*) (* *) (*#PAR*)
		count : UINT; (*Count of values to read*) (* *) (*#PAR*)
		pBuffer : UDINT; (*Buffer to accept values*) (* *) (*#PAR*)
		bufferSize : UINT; (*Size of the buffer, in bytes*) (* *) (*#PAR*)
	END_VAR
END_FUNCTION

FUNCTION SuperTrakServChanWrite : UINT (*Writes data to the conveyor*) (*One of the scERR constants*)
	VAR_INPUT
		section : USINT; (*User-assigned section address, or 0 to access system parameters*) (* *) (*#PAR*)
		parameter : UINT; (*Parameter to write*) (* *) (*#PAR*)
		startIndex : UDINT; (*Index of first value to write*) (* *) (*#PAR*)
		count : UINT; (*Count of values to write*) (* *) (*#PAR*)
		pData : UDINT; (*Data values to write*) (* *) (*#PAR*)
		dataLength : UINT; (*Size of data to write, in bytes*) (* *) (*#PAR*)
	END_VAR
END_FUNCTION

FUNCTION_BLOCK StServiceChannel (*Exchange data with the conveyor*)
	VAR_INPUT
		Execute : BOOL; (* *) (* *) (*#PAR*)
		Task : USINT; (*Use scTASK_**) (* *) (*#PAR*)
		Section : USINT; (*Specify 0 for system parameters*) (* *) (*#PAR*)
		Parameter : UINT; (*Use stPAR_**) (* *) (*#PAR*)
		StartIndex : UDINT; (* *) (* *) (*#PAR*)
		Count : UINT; (*Number of elements to read or write*) (* *) (*#PAR*)
		reserved0 : UINT; (*Specify 0*) (* *) (*#OMIT*)
		RequestDataLength : UINT; (*Size of request data (in bytes)*) (* *) (*#PAR*)
		ResponseBufferSize : UINT; (*Size of response buffer (in bytes)*) (* *) (*#PAR*)
		pRequestData : UDINT; (*Address of data to be written (specify 0 when reading data)*) (* *) (*#PAR*)
		pResponseBuffer : UDINT; (*Address of buffer for read data (specify 0 when writing data)*) (* *) (*#PAR*)
	END_VAR
	VAR_OUTPUT
		Busy : BOOL; (* *) (* *) (*#PAR*)
		Done : BOOL; (* *) (* *) (*#PAR*)
		Error : BOOL; (* *) (* *) (*#PAR*)
		ErrorID : UINT; (*See scERR_**) (* *) (*#PAR*)
		ResponseDataLength : UINT; (*Actual length of data read*) (* *) (*#PAR*)
	END_VAR
	VAR
		Internal : UDINT; (* *) (* *) (*#OMIT*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION SuperTrakGetControlIfConfig : BOOL (*Retrieve cyclic control interface configuration and data layout information.*)
	VAR_INPUT
		index : UINT; (* *) (* *) (*#PAR*)
	END_VAR
	VAR_IN_OUT
		config : SuperTrakControlIfConfig_t; (* *) (* *) (*#PAR*)
	END_VAR
END_FUNCTION
(*CNC pallet control*)

FUNCTION SuperTrakCncBeginControl : BOOL (*Begin coordinated motion at a target*) (*True on success, False on failure*)
	VAR_INPUT
		instance : UINT; (*CNC instance index (0 - 3)*) (* *) (*#PAR*)
		target : UINT; (*Conveyor target where the pallet is stopped*) (* *) (*#PAR*)
	END_VAR
END_FUNCTION

FUNCTION SuperTrakCncUpdateControl : BOOL (*Update coordinated motion at a target*) (*True on success, False on failure*)
	VAR_INPUT
		instance : UINT; (*CNC instance index (0 - 3)*) (* *) (*#PAR*)
		position : DINT; (*Commanded position, in microns, relative to initial position; right is positive*) (* *) (*#PAR*)
		acceleration : REAL; (*Instantaneous commanded acceleration, in mm/s^2*) (* *) (*#PAR*)
	END_VAR
END_FUNCTION

FUNCTION SuperTrakCncEndControl : BOOL (*End coordinated motion at a target*) (*True on success, False on failure*)
	VAR_INPUT
		instance : UINT; (*CNC instance index (0 - 3)*) (* *) (*#PAR*)
	END_VAR
END_FUNCTION
(*Advanced pallet control*)

FUNCTION SuperTrakGetPalletInfo : BOOL (*Get pallet position information*) (*True on success, False on failure*)
	VAR_INPUT
		palletInfo : UDINT; (*Pointer to array of SuperTrakPalletInfo_t*) (* *) (*#PAR*)
		count : USINT; (*Size of pallet information array*) (* *) (*#PAR*)
		useSetpointPositions : BOOL; (*TRUE = return setpoint positions, FALSE = return actual positions*) (* *) (*#PAR*)
	END_VAR
END_FUNCTION

FUNCTION SuperTrakBeginExternalControl : BOOL (*Begin external control of a pallet*) (*True on success, False on failure*)
	VAR_INPUT
		palletID : UINT; (*Pallet ID of the affected pallet*) (* *) (*#PAR*)
	END_VAR
END_FUNCTION

FUNCTION SuperTrakPalletControl : BOOL (*Update external control of a pallet*) (*True on success, False on failure*)
	VAR_INPUT
		palletID : UINT; (*Pallet ID of the affected pallet*) (* *) (*#PAR*)
		setpointSection : UINT; (*User-assigned section where the pallet is commanded to be positioned*) (* *) (*#PAR*)
		setpointPosition : DINT; (*Commanded position on section, in microns*) (* *) (*#PAR*)
		setpointVelocity : REAL; (*Instantaneous commanded velocity, in mm/s = um/ms; positive = right*) (* *) (*#PAR*)
		setpointAccel : REAL; (*Instantaneous commanded acceleration, in m/s^2 = um/ms^2; positive = right accel / left decel*) (* *) (*#PAR*)
	END_VAR
END_FUNCTION
(*Miscellaneous*)

FUNCTION SuperTrakAttachParameter : BOOL (*Configures a service channel parameter that is stored in the application space*)
	VAR_INPUT
		paramNum : UINT; (*Service channel parameter number*) (* *) (*#PAR*)
		varAddress : UDINT; (*Address of the variable*) (* *) (*#PAR*)
		varType : UINT; (*Use scDATA_TYPE constants*) (* *) (*#PAR*)
		count : UDINT; (*Array Length*) (* *) (*#PAR*)
		indexOffset : UDINT; (*Size of array*) (* *) (*#PAR*)
	END_VAR
END_FUNCTION

FUNCTION SuperTrakGetDistance : DINT (*Returns the distance between two user-addressed sections and positions*)
	VAR_INPUT
		userStartSection : UINT; (*User-addressed start section*) (* *) (*#PAR*)
		startPosition : DINT; (*Start position*) (* *) (*#PAR*)
		userEndSection : UINT; (*User-addressed end section*) (* *) (*#PAR*)
		endPosition : DINT; (*End Position*) (* *) (*#PAR*)
		inForwardDirection : BOOL; (*If TRUE, distance will be found in the pallet flow direction, If FALSE, distance will be found in the reverse pallet flow direction*) (* *) (*#PAR*)
	END_VAR
END_FUNCTION

FUNCTION SuperTrakSimulateMoveTrajectory : UINT (*Simulates pallet movement. This can take a long time to execute!*)
	VAR_INPUT
		moveDistance : DINT; (*Pallet movement distance, in microns*) (* *) (*#PAR*)
		desiredVelocity : INT; (*Desired velocity, in mm/s*) (* *) (*#PAR*)
		desiredAccel : REAL; (*Desired acceleration, in m/s^2*) (* *) (*#PAR*)
		pPositionBuffer : UDINT; (*Address of an array of DINT where position values will be stored*) (* *) (*#PAR*)
		positionBufferCount : UINT; (*Number of elements in the position array*) (* *) (*#PAR*)
	END_VAR
END_FUNCTION

FUNCTION SuperTrakGetRelativePosition : BOOL (*Finds the section and position at a specified distance from a specified location.*)
	VAR_INPUT
		section : UINT; (*Section number at starting point*) (* *) (*#PAR*)
		position : DINT; (*Position at starting point*) (* *) (*#PAR*)
		distance : DINT; (*Distance from starting point (positive = right, negative = left)*) (* *) (*#PAR*)
	END_VAR
	VAR_IN_OUT
		resultSection : UINT; (*Section number at ending point*) (* *) (*#PAR*)
		resultPosition : DINT; (*Position at ending point*) (* *) (*#PAR*)
	END_VAR
END_FUNCTION
(*Simulation*)

FUNCTION SuperTrakSimCreatePallet : UINT (*Create a simulated pallet*) (*Handle value for the new simulated pallet*)
	VAR_INPUT
		tagID : USINT; (*IR tag serial number (may be zero if IR tags are not used)*) (* *) (*#PAR*)
		section : UINT; (*Section number where the pallet will be created*) (* *) (*#PAR*)
		position : REAL; (*Position on the section, in millimetres, where the pallet will be created*) (* *) (*#PAR*)
		shelfWidth : REAL; (*Shelf width, in millimetres*) (* *) (*#PAR*)
		shelfOffset : REAL; (*Shelf offset from center, in millimetres*) (* *) (*#PAR*)
		mass : REAL; (*Payload mass, in kilograms*) (* *) (*#PAR*)
	END_VAR
END_FUNCTION

FUNCTION SuperTrakSimDeletePallet : BOOL (*Remove a simulated pallet*) (*True on success, False on failure*)
	VAR_INPUT
		hSimPallet : UINT; (*Handle value for the simulated pallet to be removed*) (* *) (*#PAR*)
	END_VAR
END_FUNCTION
(*I/O hardware support*)

FUNCTION SuperTrakProcessInputs : BOOL (*Processes discrete digital inputs*)
	VAR_INPUT
		pInputs : UDINT; (*Pointer to array of BOOL*) (* *) (*#PAR*)
		inputCount : UINT; (* *) (* *) (*#PAR*)
	END_VAR
END_FUNCTION

FUNCTION SuperTrakProcessOutputs : BOOL (*Processes discrete digital outputs*)
	VAR_INPUT
		pOutputs : UDINT; (*Pointer to array of BOOL*) (* *) (*#PAR*)
		outputCount : UINT; (* *) (* *) (*#PAR*)
	END_VAR
END_FUNCTION

FUNCTION_BLOCK StPositionTrigger (*Function block to trigger an X20DS4389 digital output based on a pallet position*)
	VAR_INPUT
		Enable : BOOL; (*Enables the function block*) (* *) (*#CYC*)
		Hardware : REFERENCE TO QuadPosTrigHardware_t; (*Variables mapped to hardware*) (* *) (*#PAR*)
		EdgeGenIndex : UINT; (*0 to 3, corresponding to X20DS4389 EdgeGen01 through EdgeGen04*) (* *) (*#PAR*)
		PositionTriggerIndex : UINT; (*Index of position trigger in TrakMaster*) (* *) (*#PAR*)
		MinimumTimeOffset : DINT; (*Shortest time to generate an output: ProgramCycleTime + PowerLinkCycleTime + X2XCycleTime + 200us*) (* *) (*#PAR*)
		MaximumTimeOffset : DINT; (*Longest time to generate an output: MinimumTimeOffset + (ProgramCycleTime x 1.5)*) (* *) (*#PAR*)
	END_VAR
	VAR_OUTPUT
		OutputPulseCount : UDINT; (*Count of output pulses generated*) (* *) (*#CYC*)
		LatePulseCount : UDINT; (*Count of output pulses started late*) (* *) (*#CYC*)
		DroppedPulseCount : UDINT; (*Count of output pulses not generated because they would overlap*) (* *) (*#CYC*)
		HwWarningCount : UDINT; (*Count of hardware warnings acknowledged*) (* *) (*#CYC*)
		HwErrorCount : UDINT; (*Count of hardware errors acknowledged*) (* *) (*#CYC*)
		HardwareError : BOOL; (*If TRUE, check ModuleOK, DeviceName, I/O mappings, and timing parameters*) (* *) (*#PAR*)
		ParameterError : BOOL; (*Indicates that the function block was not configured correctly*) (* *) (*#PAR*)
	END_VAR
	VAR
		Internal : StPositionTriggerInternal_t; (* *) (* *) (*#OMIT*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK StEncoderOutput (*Function block to drive an encoder output based on a pallet position*)
	VAR_INPUT
		Enable : BOOL; (*Enables the function block*) (* *) (*#CYC*)
		Hardware : REFERENCE TO EncoderOutputHardware_t; (*Variables mapped to hardware*) (* *) (*#PAR*)
		EncoderOutputIndex : UINT; (*Index of encoder output in TrakMaster*) (* *) (*#PAR*)
		TimeDelay : DINT; (* *) (* *) (*#PAR*)
	END_VAR
	VAR_OUTPUT
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR*)
		MovFifoEmptyCount : DINT; (*Count of MovFifoEmpty errors*) (* *) (*#CYC*)
		MovFifoFullCount : DINT; (*Count of MovFifoFull errors*) (* *) (*#CYC*)
		MovTargetTimeViolationCount : DINT; (*Count of MovTargetTimeViolation errors*) (* *) (*#CYC*)
		MovMaxFrequencyViolationCount : DINT; (*Count of MovMaxFrequencyViolation errors*) (* *) (*#CYC*)
	END_VAR
END_FUNCTION_BLOCK
(*ArEventLog helpers*)

FUNCTION SuperTrakLogWrite : ArEventLogRecordIDType (*Writes a message to the SuperTrak logbook*)
	VAR_INPUT
		objectID : STRING[36]; (* *) (* *) (*#PAR*)
		originRecordID : ArEventLogRecordIDType; (* *) (* *) (*#PAR*)
		severity : USINT; (*use arEVENTLOG_SEVERITY_**) (* *) (*#PAR*)
		message : STRING[127]; (* *) (* *) (*#PAR*)
	END_VAR
END_FUNCTION
(*AsArLog helpers (please use ArEventLog instead where possible)*)

FUNCTION SuperTrakLegacyLogWrite : BOOL (*Writes a message to the SuperTrak logbook using legacy B&R error codes*)
	VAR_INPUT
		logLevel : UDINT; (*use arlogLEVEL_* constants*) (* *) (*#PAR*)
		errornr : UDINT; (*status from B&R legacy function block*) (* *) (*#PAR*)
		message : STRING[127]; (* *) (* *) (*#PAR*)
	END_VAR
END_FUNCTION
(*
=== end SuperTrak standard items ===
*)
