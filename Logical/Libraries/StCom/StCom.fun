
{REDUND_UNREPLICABLE} FUNCTION_BLOCK StAdvCmd (*This function block can be used to send a advanced command to SuperTrak*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		StLink : REFERENCE TO StLinkType; (*Connection to other SuperTrak function blocks*) (* *) (*#PAR*)
		Enable : {REDUND_UNREPLICABLE} BOOL; (*Enables the function block*) (* *) (*#PAR*)
		ErrorReset : {REDUND_UNREPLICABLE} BOOL; (*Resets function block errors*) (* *) (*#PAR*)
		Parameters : REFERENCE TO StAdvCmdParType; (*Function block parameters*) (* *) (*#PAR*)
		Update : {REDUND_UNREPLICABLE} BOOL; (*Updates the parameters*) (* *) (*#PAR*)
		SendCommand : {REDUND_UNREPLICABLE} BOOL; (*Sends the command specified in the parameters to SuperTrak*) (* *) (*#CMD*)
	END_VAR
	VAR_OUTPUT
		Active : {REDUND_UNREPLICABLE} BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR*)
		Error : {REDUND_UNREPLICABLE} BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR*)
		StatusID : {REDUND_UNREPLICABLE} DINT; (*Status information about the function block*) (* *) (*#PAR*)
		UpdateDone : {REDUND_UNREPLICABLE} BOOL; (*Parameter update completed*) (* *) (*#PAR*)
		CommandBusy : {REDUND_UNREPLICABLE} BOOL; (*The function block is currently executing a command*) (* *) (*#CMD*)
		CommandDone : {REDUND_UNREPLICABLE} BOOL; (*Command successfully executed by function block*) (* *) (*#CMD*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} StAdvCmdInternalType; (*Internal variables*) (* *) (*#OMIT*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_UNREPLICABLE} FUNCTION_BLOCK StControl (*This function block is used as connection to the SuperTrak communication interface (SuperTrakCommand and SuperTrakStatus) and all other function blocks. It’s responsible for command queuing and provides information about the actual status of SuperTrak. Also a command to enable all SuperTrak sections is provided*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		StLink : REFERENCE TO StLinkType; (*Connection to other SuperTrak function blocks*) (* *) (*#PAR*)
		Enable : {REDUND_UNREPLICABLE} BOOL; (*Enables the function block*) (* *) (*#PAR*)
		ErrorReset : {REDUND_UNREPLICABLE} BOOL; (*Resets function block errors*) (* *) (*#PAR*)
		Parameters : REFERENCE TO StControlParType; (*Function block parameters*) (* *) (*#PAR*)
		Update : {REDUND_UNREPLICABLE} BOOL; (*Updates the parameters*) (* *) (*#PAR*)
		StCtrlData : {REDUND_UNREPLICABLE} UDINT; (*Address of array of USINT (the required size of the array is shown in the Info-structure of the function block, once it is enabled)*) (* *) (*#PAR*)
		StCtrlDataSize : {REDUND_UNREPLICABLE} UDINT; (*Size of array given to StCtrlData (in bytes)*) (* *) (*#PAR*)
		StStatData : {REDUND_UNREPLICABLE} UDINT; (*Address of array of USINT (the required size of the array is shown in the Info-structure of the function block, once it is enabled)*) (* *) (*#PAR*)
		StStatDataSize : {REDUND_UNREPLICABLE} UDINT; (*Size of array given to StStatData (in bytes)*) (* *) (*#PAR*)
		StServChRequestData : {REDUND_UNREPLICABLE} UDINT; (*Address of array of USINT for service channel request data (at least 128 bytes; e.g.: USINT[0..127])*) (* *) (*#PAR*)
		StServChRequestDataSize : {REDUND_UNREPLICABLE} UDINT; (*Size of array given to StServChRequestData (in bytes)*) (* *) (*#PAR*)
		StServChResponseData : {REDUND_UNREPLICABLE} UDINT; (*Address of array of USINT for service channel response data (at least 128 bytes; e.g.: USINT[0..127])*) (* *) (*#PAR*)
		StServChResponseDataSize : {REDUND_UNREPLICABLE} UDINT; (*Size of array given to StServChResponseData (in bytes)*) (* *) (*#PAR*)
		EnableAllSections : {REDUND_UNREPLICABLE} BOOL; (*Enables all sections of SuperTrak (to use this functionality, SuperTrak has to be configured accordingly via TrakMaster)*) (* *) (*#CMD#OPT*)
	END_VAR
	VAR_OUTPUT
		Active : {REDUND_UNREPLICABLE} BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR*)
		Error : {REDUND_UNREPLICABLE} BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR*)
		StatusID : {REDUND_UNREPLICABLE} DINT; (*Status information about the function block*) (* *) (*#PAR*)
		UpdateDone : {REDUND_UNREPLICABLE} BOOL; (*Parameter update completed*) (* *) (*#PAR*)
		SectionsEnabled : {REDUND_UNREPLICABLE} BOOL; (*Indicates whether all sections of SuperTrak are enabled*) (* *) (*#CMD#OPT*)
		Info : {REDUND_UNREPLICABLE} StControlInfoType; (*Additional information about the SuperTrak system and library*) (* *) (*#CMD*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} StControlInternalType; (*Internal variables*) (* *) (*#OMIT*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_UNREPLICABLE} FUNCTION_BLOCK StPallet (*This function block can be used to execute advanced release commands and to set shuttle parameters on a specified pallet*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		StLink : REFERENCE TO StLinkType; (*Connection to other SuperTrak function blocks*) (* *) (*#PAR*)
		Enable : {REDUND_UNREPLICABLE} BOOL; (*Enables the function block*) (* *) (*#PAR*)
		ErrorReset : {REDUND_UNREPLICABLE} BOOL; (*Resets function block errors*) (* *) (*#PAR*)
		Parameters : REFERENCE TO StPalletParType; (*Function block parameters*) (* *) (*#PAR*)
		Update : {REDUND_UNREPLICABLE} BOOL; (*Updates the parameters*) (* *) (*#PAR*)
		PalletID : {REDUND_UNREPLICABLE} USINT; (*ID of shuttle to be controlled*) (* *) (*#PAR*)
		ReleaseToTarget : {REDUND_UNREPLICABLE} BOOL; (*Command to release the shuttle to a specified destination target*) (* *) (*#CMD*)
		ReleaseToOffset : {REDUND_UNREPLICABLE} BOOL; (*Command to release the shuttle to a specified offset*) (* *) (*#CMD*)
		IncrementOffset : {REDUND_UNREPLICABLE} BOOL; (*Command to add an specified offset to the shuttle (e.g. for calibration)*) (* *) (*#CMD*)
		SetPalletMotionPar : {REDUND_UNREPLICABLE} BOOL; (*Command to set acceleration and velocity for the shuttle*) (* *) (*#CMD*)
		SetPalletShelf : {REDUND_UNREPLICABLE} BOOL; (*Command to set shelf width and offset for the shuttle*) (* *) (*#CMD*)
		SetPalletGain : {REDUND_UNREPLICABLE} BOOL; (*Command to set controller parameters for the shuttle*) (* *) (*#CMD*)
	END_VAR
	VAR_OUTPUT
		Active : {REDUND_UNREPLICABLE} BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR*)
		Error : {REDUND_UNREPLICABLE} BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR*)
		StatusID : {REDUND_UNREPLICABLE} DINT; (*Status information about the function block*) (* *) (*#PAR*)
		UpdateDone : {REDUND_UNREPLICABLE} BOOL; (*Parameter update completed*) (* *) (*#PAR*)
		CommandBusy : {REDUND_UNREPLICABLE} BOOL; (*The function block is currently executing a command*) (* *) (*#CMD*)
		CommandDone : {REDUND_UNREPLICABLE} BOOL; (*Command successfully executed by function block*) (* *) (*#CMD*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} StPalletInternalType; (*Internal variables*) (* *) (*#OMIT*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_UNREPLICABLE} FUNCTION_BLOCK StReadPnu (*This function block can be used to read parameters from SuperTrak*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		StLink : REFERENCE TO StLinkType; (*Connection to other SuperTrak function blocks*) (* *) (*#PAR*)
		Enable : {REDUND_UNREPLICABLE} BOOL; (*Enables the function block*) (* *) (*#PAR*)
		ErrorReset : {REDUND_UNREPLICABLE} BOOL; (*Resets function block errors*) (* *) (*#PAR*)
		Parameters : REFERENCE TO StReadPnuParType; (*Function block parameters*) (* *) (*#PAR*)
		Update : {REDUND_UNREPLICABLE} BOOL; (*Updates the parameters*) (* *) (*#PAR*)
		DataAddress : {REDUND_UNREPLICABLE} UDINT; (*Address of the user variable where the parameter value(s) should be copied to*) (* *) (*#PAR*)
		DataSize : {REDUND_UNREPLICABLE} UDINT; (*Memory size of variable at DataAddress [bytes]*) (* *) (*#PAR*)
		Read : {REDUND_UNREPLICABLE} BOOL; (*Command to read the specified parameter from SuperTrak*) (* *) (*#CMD*)
	END_VAR
	VAR_OUTPUT
		Active : {REDUND_UNREPLICABLE} BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR*)
		Error : {REDUND_UNREPLICABLE} BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR*)
		StatusID : {REDUND_UNREPLICABLE} DINT; (*Status information about the function block*) (* *) (*#PAR*)
		UpdateDone : {REDUND_UNREPLICABLE} BOOL; (*Parameter update completed*) (* *) (*#PAR*)
		CommandBusy : {REDUND_UNREPLICABLE} BOOL; (*The function block is currently executing a command*) (* *) (*#CMD*)
		CommandDone : {REDUND_UNREPLICABLE} BOOL; (*Command successfully executed by function block*) (* *) (*#CMD*)
		ValidDataSize : {REDUND_UNREPLICABLE} UDINT; (*Size of valid data in the memory at DataAddress [bytes]*) (* *) (*#CMD*)
		Info : {REDUND_UNREPLICABLE} StReadInfoType; (*Additional function block information*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} StReadPnuInternalType; (*Internal variables*) (* *) (*#OMIT*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_UNREPLICABLE} FUNCTION_BLOCK StSection (*This function block can be used to enable a specific section and to monitor the actual section status*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		StLink : REFERENCE TO StLinkType; (*Connection to other SuperTrak function blocks*) (* *) (*#PAR*)
		Enable : {REDUND_UNREPLICABLE} BOOL; (*Enables the function block*) (* *) (*#PAR*)
		ErrorReset : {REDUND_UNREPLICABLE} BOOL; (*Resets function block errors*) (* *) (*#PAR*)
		Parameters : REFERENCE TO StSectionParType; (*Function block parameters*) (* *) (*#PAR*)
		Update : {REDUND_UNREPLICABLE} BOOL; (*Updates the parameters*) (* *) (*#PAR*)
		Section : {REDUND_UNREPLICABLE} USINT; (*ID of section to be controlled*) (* *) (*#PAR*)
		EnableSection : {REDUND_UNREPLICABLE} BOOL; (*Enables the configured section (to use this functionality, SuperTrak has to be configured accordingly via TrakMaster)*) (* *) (*#CMD#OPT*)
	END_VAR
	VAR_OUTPUT
		Active : {REDUND_UNREPLICABLE} BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR*)
		Error : {REDUND_UNREPLICABLE} BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR*)
		StatusID : {REDUND_UNREPLICABLE} DINT; (*Status information about the function block*) (* *) (*#PAR*)
		UpdateDone : {REDUND_UNREPLICABLE} BOOL; (*Parameter update completed*) (* *) (*#PAR*)
		SectionEnabled : {REDUND_UNREPLICABLE} BOOL; (*Status information about the function block*) (* *) (*#CMD*)
		UnrecognizedPallets : {REDUND_UNREPLICABLE} BOOL; (*Indicates whether shuttles on the section are not recognized*) (* *) (*#CYC*)
		MotorPowerOn : {REDUND_UNREPLICABLE} BOOL; (*Indicates whether the motor power is on*) (* *) (*#CYC*)
		PalletsRecovering : {REDUND_UNREPLICABLE} BOOL; (*Indicates whether shuttles are currently recovering*) (* *) (*#CYC*)
		LocatingPallets : {REDUND_UNREPLICABLE} BOOL; (*Indicates whether shuttles are being automatically "jogged" so that their location can be determined*) (* *) (*#CYC*)
		DisabledExternally : {REDUND_UNREPLICABLE} BOOL; (*Indicates if the section is disabled due to an external condition*) (* *) (*#CYC*)
		Info : {REDUND_UNREPLICABLE} StSectionInfoType; (*Additional information about the SuperTrak section*) (* *) (*#CMD*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} StSectionInternalType; (*Internal variables*) (* *) (*#OMIT*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_UNREPLICABLE} FUNCTION_BLOCK StTarget (*This function block can be used to execute simple shuttle-release commands using the parameters configured by TrakMaster (see also “Simple Pallet Control” in SuperTrak interface description) and monitor the actual target status*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		StLink : REFERENCE TO StLinkType; (*Connection to other SuperTrak function blocks*) (* *) (*#PAR*)
		Enable : {REDUND_UNREPLICABLE} BOOL; (*Enables the function block*) (* *) (*#PAR*)
		ErrorReset : {REDUND_UNREPLICABLE} BOOL; (*Resets function block errors*) (* *) (*#PAR*)
		Parameters : REFERENCE TO StTargetParType; (*Function block parameters*) (* *) (*#PAR*)
		Update : {REDUND_UNREPLICABLE} BOOL; (*Updates the parameters*) (* *) (*#PAR*)
		Target : {REDUND_UNREPLICABLE} USINT; (*ID of Target to be controlled*) (* *) (*#PAR*)
		ReleasePallet : {REDUND_UNREPLICABLE} BOOL; (*Command to release the shuttle at the target with the parameterized move configuration*) (* *) (*#CMD*)
	END_VAR
	VAR_OUTPUT
		Active : {REDUND_UNREPLICABLE} BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR*)
		Error : {REDUND_UNREPLICABLE} BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR*)
		StatusID : {REDUND_UNREPLICABLE} DINT; (*Status information about the function block*) (* *) (*#PAR*)
		UpdateDone : {REDUND_UNREPLICABLE} BOOL; (*Parameter update completed*) (* *) (*#PAR*)
		PalletID : {REDUND_UNREPLICABLE} USINT; (*ID of shuttle at the target*) (* *) (*#CYC*)
		PalletOffsetIdx : {REDUND_UNREPLICABLE} USINT; (*Offset-table index applied to the shuttle at the target*) (* *) (*#CYC*)
		PalletPresent : {REDUND_UNREPLICABLE} BOOL; (*Indicates if shuttle is at the target*) (* *) (*#CYC*)
		PalletInPosition : {REDUND_UNREPLICABLE} BOOL; (*Indicates if shuttle at the target is in the "in-position-window"*) (* *) (*#CYC*)
		PalletPreArrival : {REDUND_UNREPLICABLE} BOOL; (*Indicates if a shuttle will arrive at the target*) (* *) (*#CYC*)
		PalletOverTarget : {REDUND_UNREPLICABLE} BOOL; (*Indicates if a shuttle shelf is over the target (targets only report this information, if configured to do so)*) (* *) (*#CYC#OPT*)
		CommandBusy : {REDUND_UNREPLICABLE} BOOL; (*The function block is currently executing a command*) (* *) (*#CMD*)
		CommandDone : {REDUND_UNREPLICABLE} BOOL; (*Command successfully executed by function block*) (* *) (*#CMD*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} StTargetInternalType; (*Internal variables*) (* *) (*#OMIT*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_UNREPLICABLE} FUNCTION_BLOCK StTargetExt (*This function block can be used to execute advanced shuttle-release commands on the shuttle at the target, set shuttle parameters on the shuttle at the target and monitor the actual target status*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		StLink : REFERENCE TO StLinkType; (*Connection to other SuperTrak function blocks*) (* *) (*#PAR*)
		Enable : {REDUND_UNREPLICABLE} BOOL; (*Enables the function block*) (* *) (*#PAR*)
		ErrorReset : {REDUND_UNREPLICABLE} BOOL; (*Resets function block errors*) (* *) (*#PAR*)
		Parameters : REFERENCE TO StTargetExtParType; (*Function block parameters*) (* *) (*#PAR*)
		Update : {REDUND_UNREPLICABLE} BOOL; (*Updates the parameters*) (* *) (*#PAR*)
		Target : {REDUND_UNREPLICABLE} USINT; (*ID of Target to be controlled*) (* *) (*#PAR*)
		ReleasePallet : {REDUND_UNREPLICABLE} BOOL; (*Command to release the shuttle at the target with the parameterized move configuration*) (* *) (*#CMD*)
		ReleaseToTarget : {REDUND_UNREPLICABLE} BOOL; (*Command to release the shuttle at the target to a specified destination target*) (* *) (*#CMD*)
		ReleaseToOffset : {REDUND_UNREPLICABLE} BOOL; (*Command to add an specified offset to the shuttle at the target (e.g. for calibration)*) (* *) (*#CMD*)
		IncrementOffset : {REDUND_UNREPLICABLE} BOOL; (*Command to add an specified offset to the shuttle at the target (e.g. for calibration)*) (* *) (*#CMD*)
		SetPalletID : {REDUND_UNREPLICABLE} BOOL; (*Command to set an ID for the shuttle at the target*) (* *) (*#CMD*)
		SetPalletMotionPar : {REDUND_UNREPLICABLE} BOOL; (*Command to set acceleration and velocity for the shuttle at the target*) (* *) (*#CMD*)
		SetPalletShelf : {REDUND_UNREPLICABLE} BOOL; (*Command to set shelf width and offset for the shuttle at the target*) (* *) (*#CMD*)
		SetPalletGain : {REDUND_UNREPLICABLE} BOOL; (*Command to set controller parameters for the shuttle at the target*) (* *) (*#CMD*)
	END_VAR
	VAR_OUTPUT
		Active : {REDUND_UNREPLICABLE} BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR*)
		Error : {REDUND_UNREPLICABLE} BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR*)
		StatusID : {REDUND_UNREPLICABLE} DINT; (*Status information about the function block*) (* *) (*#PAR*)
		UpdateDone : {REDUND_UNREPLICABLE} BOOL; (*Parameter update completed*) (* *) (*#PAR*)
		PalletID : {REDUND_UNREPLICABLE} USINT; (*ID of shuttle at the target*) (* *) (*#CYC*)
		PalletOffsetIdx : {REDUND_UNREPLICABLE} USINT; (*Offset-table index applied to the shuttle at the target*) (* *) (*#CYC*)
		PalletPresent : {REDUND_UNREPLICABLE} BOOL; (*Indicates if shuttle is at the target*) (* *) (*#CYC*)
		PalletInPosition : {REDUND_UNREPLICABLE} BOOL; (*Indicates if shuttle at the target is in the "in-position-window"*) (* *) (*#CYC*)
		PalletPreArrival : {REDUND_UNREPLICABLE} BOOL; (*Indicates if a shuttle will arrive at the target*) (* *) (*#CYC*)
		PalletOverTarget : {REDUND_UNREPLICABLE} BOOL; (*Indicates if a shuttle shelf is over the target (targets only report this information, if configured to do so)*) (* *) (*#CYC#OPT*)
		CommandBusy : {REDUND_UNREPLICABLE} BOOL; (*The function block is currently executing a command*) (* *) (*#CMD*)
		CommandDone : {REDUND_UNREPLICABLE} BOOL; (*Command successfully executed by function block*) (* *) (*#CMD*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} StTargetExtInternalType; (*Internal variables*) (* *) (*#OMIT*)
	END_VAR
END_FUNCTION_BLOCK

{REDUND_UNREPLICABLE} FUNCTION_BLOCK StWritePnu (*This function block can be used to write and save parameters to SuperTrak*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		StLink : REFERENCE TO StLinkType; (*Connection to other SuperTrak function blocks*) (* *) (*#PAR*)
		Enable : {REDUND_UNREPLICABLE} BOOL; (*Enables the function block*) (* *) (*#PAR*)
		ErrorReset : {REDUND_UNREPLICABLE} BOOL; (*Resets function block errors*) (* *) (*#PAR*)
		Parameters : REFERENCE TO StWritePnuParType; (*Function block parameters*) (* *) (*#PAR*)
		Update : {REDUND_UNREPLICABLE} BOOL; (*Updates the parameters*) (* *) (*#PAR*)
		DataAddress : {REDUND_UNREPLICABLE} UDINT; (*Address of the user variable where the parameter value(s) should be copied from*) (* *) (*#PAR*)
		DataSize : {REDUND_UNREPLICABLE} UDINT; (*Memory size of variable at DataAddress [bytes]*) (* *) (*#PAR*)
		Write : {REDUND_UNREPLICABLE} BOOL; (*Command to write the specified parameter to SuperTrak*) (* *) (*#CMD*)
		SaveParamters : {REDUND_UNREPLICABLE} BOOL; (*Command to save parameters to SuperTrak configuration files*) (* *) (*#CMD*)
	END_VAR
	VAR_OUTPUT
		Active : {REDUND_UNREPLICABLE} BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR*)
		Error : {REDUND_UNREPLICABLE} BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR*)
		StatusID : {REDUND_UNREPLICABLE} DINT; (*Status information about the function block*) (* *) (*#PAR*)
		UpdateDone : {REDUND_UNREPLICABLE} BOOL; (*Parameter update completed*) (* *) (*#PAR*)
		CommandBusy : {REDUND_UNREPLICABLE} BOOL; (*The function block is currently executing a command*) (* *) (*#CMD*)
		CommandDone : {REDUND_UNREPLICABLE} BOOL; (*Command successfully executed by function block*) (* *) (*#CMD*)
		Info : {REDUND_UNREPLICABLE} StWriteInfoType; (*Additional function block information*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} StWritePnuInternalType; (*Internal variables*) (* *) (*#OMIT*)
	END_VAR
END_FUNCTION_BLOCK
