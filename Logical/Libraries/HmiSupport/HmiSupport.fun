
FUNCTION_BLOCK HMIControl (*This function block is used as connection between the Hmi function blocks. This funciton block also creates the logbook for this library*) (*$Group=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		HMILink : REFERENCE TO HMILinkType; (*Connection to other Hmi function blocks*) (* *) (*#PAR*)
		Enable : BOOL; (*Enables the function block*) (* *) (*#PAR*)
		ErrorReset : BOOL; (*Resets the function block errors*) (* *) (*#PAR*)
		Update : BOOL; (*Updates the parameters*) (* *) (*#PAR*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR*)
		Error : BOOL; (*Indicates that the funciton block is in an error state or a command was not executed correctly*) (* *) (*#PAR*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR*)
		UpdateDone : BOOL; (*Parameter update completed*) (* *) (*#PAR*)
		Info : HMIControlInfoType; (*Additional information about the library*) (* *) (*#PAR*)
	END_VAR
	VAR
		Internal : HMIControlInternalType; (*Internal variables*) (* *) (*#OMIT*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK HMIReadParID (*This function block can be used to read ParIDs from SuperTrak with a HMI.*) (*$Group=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		HMILink : REFERENCE TO HMILinkType; (*Connection to other Hmi function blocks*) (* *) (*#PAR*)
		Enable : BOOL; (*Enables the function block*) (* *) (*#PAR*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR*)
		Parameters : REFERENCE TO HMIReadParType; (*Function block parameters*) (* *) (*#PAR*)
		Update : BOOL; (*Updates the parameters*) (* *) (*#PAR*)
		ReadUDINT : BOOL; (*Read UDINT ParID*) (* *) (*#CMD*)
		ReadUINT : BOOL; (*Read UINT ParID*) (* *) (*#CMD*)
		ReadUSINT : BOOL; (*Read USINT ParID*) (* *) (*#CMD*)
		ReadDINT : BOOL; (*Read DINT ParID*) (* *) (*#CMD*)
		ReadINT : BOOL; (*Read INT ParID*) (* *) (*#CMD*)
		ReadSINT : BOOL; (*Read SINT ParID*) (* *) (*#CMD*)
		ReadREAL : BOOL; (*Read REAL ParID*) (* *) (*#CMD*)
		ReadSTRING : BOOL; (*Read STRING ParID*) (* *) (*#CMD*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR*)
		UpdateDone : BOOL; (*Parameter update completed*) (* *) (*#PAR*)
		Out_UDINT : UDINT; (*UDINT output*) (* *) (*#CMD*)
		Out_UINT : UINT; (*UINT output*) (* *) (*#CMD*)
		Out_USINT : USINT; (*USINT output*) (* *) (*#CMD*)
		Out_DINT : DINT; (*DINT output*) (* *) (*#CMD*)
		Out_INT : INT; (*INT output*) (* *) (*#CMD*)
		Out_SINT : SINT; (*SINT output*) (* *) (*#CMD*)
		Out_REAL : REAL; (*REAL output*) (* *) (*#CMD*)
		Out_STRING : STRING[80]; (*STRING output*) (* *) (*#CMD*)
		CommandDone : BOOL; (*Command successfully executed by the function block*) (* *) (*#CMD*)
		Info : HMIReadInfoType; (*Function block informations*) (* *) (*#PAR*)
	END_VAR
	VAR
		Internal : HMIReadInternalType; (*Internal variables*) (* *) (*#OMIT*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK HMIWriteParID (*This function block can be used to write ParIDs from SuperTrak with a HMI.*) (*$Group=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		HMILink : REFERENCE TO HMILinkType; (*Connection to other Hmi function blocks*) (* *) (*#PAR*)
		Enable : BOOL; (*Enables the function block*) (* *) (*#PAR*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR*)
		Parameters : REFERENCE TO HMIWriteParType; (*Function block parameters*) (* *) (*#PAR*)
		Update : BOOL; (*Updates the parameters*) (* *) (*#PAR*)
		WriteUDINT : BOOL; (*Write UDINT ParID*) (* *) (*#CMD*)
		WriteUINT : BOOL; (*Write UINT ParID*) (* *) (*#CMD*)
		WriteUSINT : BOOL; (*Write USINT ParID*) (* *) (*#CMD*)
		WriteDINT : BOOL; (*Write DINT ParID*) (* *) (*#CMD*)
		WriteINT : BOOL; (*Write INT ParID*) (* *) (*#CMD*)
		WriteSINT : BOOL; (*Write SINT ParID*) (* *) (*#CMD*)
		WriteREAL : BOOL; (*Write REAL ParID*) (* *) (*#CMD*)
		WriteSTRING : BOOL; (*Write STRING ParID*) (* *) (*#CMD*)
		SaveParameters : BOOL; (*Save parameters*) (* *) (*#CMD*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR*)
		UpdateDone : BOOL; (*Parameter update completed*) (* *) (*#PAR*)
		CommandDone : BOOL; (*Command successfully executed by the function block*) (* *) (*#CMD*)
		Info : HMIWriteInfoType; (*Function block informations*) (* *) (*#PAR*)
	END_VAR
	VAR
		Internal : HMIWriteInternalType; (*Internal variables*) (* *) (*#OMIT*)
	END_VAR
END_FUNCTION_BLOCK
