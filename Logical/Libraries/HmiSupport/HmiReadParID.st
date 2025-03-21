(******************************************************************************************
 * Copyright: Bernecker + Rainer
 * Author:  B+R
 * Created:  July 2, 2018/09:40 AM 
 ******************************************************************************************
 ******************************************************************************************
 * Version History:
 * ----------------------------------------------------------------------------------------
 * V 1.00.0   July 2, 2018/09:40 AM  First Version
 ******************************************************************************************
 * Description:
 * ----------------------------------------------------------------------------------------
 * July 2, 2018/09:40 AM V1.00.0:
 * This FUNCTION block reads ParIDs from the SuperTrak.
 * The FUB can be connected directly to a HMI application.
 * The parameter structure and I/Os can be used inside the visu without extra implementation.
 ******************************************************************************************)

FUNCTION_BLOCK HMIReadParID
		// Check if function block is enabled
	IF Enable THEN
		//####################################################################################//
		// FUNCTION BLOCK IS ENABLED
		//####################################################################################//
		
		// Check if error occured to change state
		IF Error THEN
			// Go to state error, to wait for acknowledge
			Internal.Step																	:= HMI_RPAR_STATE_ERROR;
		END_IF;
		
		//************************************************************************************//
		// Operation
		//************************************************************************************//
		CASE Internal.Step OF
			//--------------------------------------------------------------------------------//
			// Initialize internal parameters
			//--------------------------------------------------------------------------------//
			HMI_RPAR_STATE_INIT:
			
				// Initialize function block to create a logbook entry
				Internal.ArEventLogWrite.AddData											:= ADR(Internal.AddErrorInfo);
				Internal.ArEventLogWrite.AddDataFormat										:= 1;	// zero-terminated string
				Internal.ArEventLogWrite.AddDataSize										:= SIZEOF(Internal.AddErrorInfo);
				Internal.ArEventLogWrite.ObjectID											:= 'HMIReadParID';
				Internal.AddErrorInfo														:= '';
				Internal.ArEventLogWrite.OriginRecordID										:= 0;	// don't use origin record
				Internal.ArEventLogWrite.TimeStamp											:= 0;	// use internal time stamp
			
				Internal.Step																:= HMI_RPAR_STATE_INIT_CHECK_CONFIG;
			
				//--------------------------------------------------------------------------------//
				// Register function block
				//--------------------------------------------------------------------------------//
			HMI_RPAR_STATE_INIT_CHECK_CONFIG:
			
				// Check configuration inputs if valid
				IF (ADR(Parameters) > 0) AND
					(ADR(HMILink) > 0) THEN
					// Config OK
					Internal.Status.InitConfigCheckDone										:= TRUE;
					Internal.Step															:= HMI_RPAR_STATE_INIT_REG_FB;
				ELSE
					Internal.Status.InitConfigCheckDone										:= FALSE;
					// Set error
					StatusID																:= HMI_ERR_WRONG_CONFIG;
					Error																	:= TRUE;
				END_IF;
			
				//--------------------------------------------------------------------------------//
				// Register function block
				//--------------------------------------------------------------------------------//
			HMI_RPAR_STATE_INIT_REG_FB:
			
				// Check if function block is not registered yet
				IF NOT Internal.Status.FuncitonBlockRegistered THEN
					// Check if StControl instance is present and valid
					IF (HMILink.LibraryStatus.FbID[0] <> 0) AND (HMILink.LibraryStatus.LogBookIdent <> 0) THEN
						// Save logbook ident
						Internal.ArEventLogWrite.Ident										:= HMILink.LibraryStatus.LogBookIdent;
						// Create function block ID
						Internal.Status.FuncitonBlockID										:= HMI_CONFIG_FB_ID_HMIREAD;
						Internal.Status.FunctionBlockIDIndex								:= 0;
						Internal.Status.FuncitonBlockRegistered								:= TRUE;
						// Create logbook entry
						Internal.AddErrorInfo												:= 'Function block registration successfull';
						Internal.ArEventLogWrite.EventID									:= HMI_SUCC_FB_REGISTRATION;
						// Write logbook entry
						WriteLogbookEntry;
					ELSIF (HMILink.LibraryStatus.LogBookIdent <> 0) THEN
						Internal.AddErrorInfo												:= 'No enabled instance of HMIControl could be found';
						Internal.ArEventLogWrite.EventID									:= HMI_ERR_NO_HMICONTROL_REG;
						// Write logbook entry
						WriteLogbookEntry;
						// Set error
						StatusID															:= HMI_ERR_NO_HMICONTROL_REG;
						Error																:= TRUE;
					ELSE
						// Set error
						StatusID															:= HMI_ERR_NO_HMICONTROL_REG;
						Error																:= TRUE;
					END_IF;	
				ELSE
					// Continue
					Internal.Step															:= HMI_RPAR_STATE_INIT_CHECK_PAR;
				END_IF;
			
				//--------------------------------------------------------------------------------//
				// Check parameters
				//--------------------------------------------------------------------------------//
			HMI_RPAR_STATE_INIT_CHECK_PAR:
			
				// Save parameters
				Internal.ParametersUsed														:= Parameters;
				Internal.Status.InitParCheckDone											:= TRUE;
				Internal.Step																:= HMI_RPAR_STATE_OPERATION;
			
				//--------------------------------------------------------------------------------//
				// Operation
				//--------------------------------------------------------------------------------//
			HMI_RPAR_STATE_OPERATION:
				
				// Set active output
				Active																		:= TRUE;
			
				// Check configuration inputs if valid
				IF (ADR(Parameters) > 0) AND
					(ADR(HMILink) > 0) THEN
					//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::://
					// Parameter update handling
					// Check if parameters should be updated
					IF Update AND NOT Internal.UpdateOld AND NOT UpdateDone THEN
				
						// Check if parameters are valid
						IF (Parameters.ParameterNumber <> 0) AND
							(Parameters.SectionID <= HMI_CONFIG_NR_OF_SECTIONS) THEN
							// PARAMTERS ARE VALID
							// copy paramters to internal stucture
							Internal.ParametersUsed												:= Parameters;
							// Set status output that update is done
							UpdateDone															:= TRUE;
						ELSE
							// PARAMTERS ARE INVALID
							IF (Parameters.ParameterNumber = 0) THEN
								Internal.AddErrorInfo											:= 'Parameter ID is invalid';
							ELSIF (Parameters.SectionID > HMI_CONFIG_NR_OF_SECTIONS) THEN
								Internal.AddErrorInfo											:= 'Number of section is invalid';	
							END_IF;
							Internal.ArEventLogWrite.EventID									:= HMI_ERR_WRONG_PARAMETER;
							// Write logbook entry
							WriteLogbookEntry;
							// Set error
							StatusID															:= HMI_ERR_WRONG_PARAMETER;
							Error																:= TRUE;				
						END_IF;	
					ELSIF NOT Update THEN
						UpdateDone																:= FALSE;
					END_IF;

					//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::://
					// Service Channel implementation
					// Check if paramter should be written
					IF ReadUDINT AND NOT(CommandDone) THEN
						// Check if parameters are valid
						IF (Parameters.ParameterNumber <> 0) AND
							(Parameters.SectionID <= HMI_CONFIG_NR_OF_SECTIONS) THEN
							// PARAMTERS ARE VALID
							// copy paramters to internal stucture
							Internal.ParametersUsed												:= Parameters;
							Internal.Status.ReadStatus := SuperTrakServChanRead(Parameters.SectionID,Parameters.ParameterNumber,Parameters.StartParameterIndex,Parameters.ParameterValueCount,ADR(Out_UDINT),SIZEOF(Out_UDINT));
							IF Internal.Status.ReadStatus <> 0 THEN
								Internal.AddErrorInfo											:= 'Command was not executed successfully: ';	
								Info.ErrorCode													:= Internal.Status.ReadStatus;
								GetErrorCode;
								Internal.ArEventLogWrite.EventID								:= HMI_ERR_CMD_NOT_EXECUTED;
								// Write logbook entry
								WriteLogbookEntry;
								// Set error
								StatusID														:= HMI_ERR_CMD_NOT_EXECUTED;
								Error															:= TRUE;
							ELSE
								CommandDone														:= TRUE;
							END_IF;
						ELSE
							// PARAMTERS ARE INVALID
							IF (Parameters.ParameterNumber = 0) THEN
								Internal.AddErrorInfo											:= 'Parameter ID is invalid';
							ELSIF (Parameters.SectionID > HMI_CONFIG_NR_OF_SECTIONS) THEN
								Internal.AddErrorInfo											:= 'Number of section is invalid';	
							END_IF;
							Internal.ArEventLogWrite.EventID									:= HMI_ERR_WRONG_PARAMETER;
							// Write logbook entry
							WriteLogbookEntry;
							// Set error
							StatusID															:= HMI_ERR_WRONG_PARAMETER;
							Error																:= TRUE;				
						END_IF;
						
					ELSIF ReadUINT AND NOT(CommandDone) THEN
						// Check if parameters are valid
						IF (Parameters.ParameterNumber <> 0) AND
							(Parameters.SectionID <= HMI_CONFIG_NR_OF_SECTIONS) THEN
							// PARAMTERS ARE VALID
							// copy paramters to internal stucture
							Internal.ParametersUsed												:= Parameters;
							Internal.Status.ReadStatus := SuperTrakServChanRead(Parameters.SectionID,Parameters.ParameterNumber,Parameters.StartParameterIndex,Parameters.ParameterValueCount,ADR(Out_UINT),SIZEOF(Out_UINT));
							IF Internal.Status.ReadStatus <> 0 THEN
								Internal.AddErrorInfo											:= 'Command was not executed successfully: ';	
								Info.ErrorCode													:= Internal.Status.ReadStatus;
								GetErrorCode;
								Internal.ArEventLogWrite.EventID								:= HMI_ERR_CMD_NOT_EXECUTED;
								// Write logbook entry
								WriteLogbookEntry;
								// Set error
								StatusID														:= HMI_ERR_CMD_NOT_EXECUTED;
								Error															:= TRUE;
							ELSE
								CommandDone														:= TRUE;
							END_IF;
						ELSE
							// PARAMTERS ARE INVALID
							IF (Parameters.ParameterNumber = 0) THEN
								Internal.AddErrorInfo											:= 'Parameter ID is invalid';
							ELSIF (Parameters.SectionID > HMI_CONFIG_NR_OF_SECTIONS) THEN
								Internal.AddErrorInfo											:= 'Number of section is invalid';	
							END_IF;
							Internal.ArEventLogWrite.EventID									:= HMI_ERR_WRONG_PARAMETER;
							// Write logbook entry
							WriteLogbookEntry;
							// Set error
							StatusID															:= HMI_ERR_WRONG_PARAMETER;
							Error																:= TRUE;				
						END_IF;
						
					ELSIF ReadUSINT AND NOT(CommandDone) THEN
						// Check if parameters are valid
						IF (Parameters.ParameterNumber <> 0) AND
							(Parameters.SectionID <= HMI_CONFIG_NR_OF_SECTIONS) THEN
							// PARAMTERS ARE VALID
							// copy paramters to internal stucture
							Internal.ParametersUsed												:= Parameters;
							Internal.Status.ReadStatus := SuperTrakServChanRead(Parameters.SectionID,Parameters.ParameterNumber,Parameters.StartParameterIndex,Parameters.ParameterValueCount,ADR(Out_USINT),SIZEOF(Out_USINT));
							IF Internal.Status.ReadStatus <> 0 THEN
								Internal.AddErrorInfo											:= 'Command was not executed successfully: ';	
								Info.ErrorCode													:= Internal.Status.ReadStatus;
								GetErrorCode;
								Internal.ArEventLogWrite.EventID								:= HMI_ERR_CMD_NOT_EXECUTED;
								// Write logbook entry
								WriteLogbookEntry;
								// Set error
								StatusID														:= HMI_ERR_CMD_NOT_EXECUTED;
								Error															:= TRUE;
							ELSE
								CommandDone														:= TRUE;
							END_IF;
						ELSE
							// PARAMTERS ARE INVALID
							IF (Parameters.ParameterNumber = 0) THEN
								Internal.AddErrorInfo											:= 'Parameter ID is invalid';
							ELSIF (Parameters.SectionID > HMI_CONFIG_NR_OF_SECTIONS) THEN
								Internal.AddErrorInfo											:= 'Number of section is invalid';	
							END_IF;
							Internal.ArEventLogWrite.EventID									:= HMI_ERR_WRONG_PARAMETER;
							// Write logbook entry
							WriteLogbookEntry;
							// Set error
							StatusID															:= HMI_ERR_WRONG_PARAMETER;
							Error																:= TRUE;				
						END_IF;
				
					ELSIF ReadDINT AND NOT(CommandDone) THEN
						// Check if parameters are valid
						IF (Parameters.ParameterNumber <> 0) AND
							(Parameters.SectionID <= HMI_CONFIG_NR_OF_SECTIONS) THEN
							// PARAMTERS ARE VALID
							// copy paramters to internal stucture
							Internal.ParametersUsed												:= Parameters;
							Internal.Status.ReadStatus := SuperTrakServChanRead(Parameters.SectionID,Parameters.ParameterNumber,Parameters.StartParameterIndex,Parameters.ParameterValueCount,ADR(Out_DINT),SIZEOF(Out_DINT));
							IF Internal.Status.ReadStatus <> 0 THEN
								Internal.AddErrorInfo											:= 'Command was not executed successfully: ';	
								Info.ErrorCode													:= Internal.Status.ReadStatus;
								GetErrorCode;
								Internal.ArEventLogWrite.EventID								:= HMI_ERR_CMD_NOT_EXECUTED;
								// Write logbook entry
								WriteLogbookEntry;
								// Set error
								StatusID														:= HMI_ERR_CMD_NOT_EXECUTED;
								Error															:= TRUE;
							ELSE
								CommandDone														:= TRUE;
							END_IF;
						ELSE
							// PARAMTERS ARE INVALID
							IF (Parameters.ParameterNumber = 0) THEN
								Internal.AddErrorInfo											:= 'Parameter ID is invalid';
							ELSIF (Parameters.SectionID > HMI_CONFIG_NR_OF_SECTIONS) THEN
								Internal.AddErrorInfo											:= 'Number of section is invalid';	
							END_IF;
							Internal.ArEventLogWrite.EventID									:= HMI_ERR_WRONG_PARAMETER;
							// Write logbook entry
							WriteLogbookEntry;
							// Set error
							StatusID															:= HMI_ERR_WRONG_PARAMETER;
							Error																:= TRUE;				
						END_IF;
					
					ELSIF ReadINT AND NOT(CommandDone) THEN
						// Check if parameters are valid
						IF (Parameters.ParameterNumber <> 0) AND
							(Parameters.SectionID <= HMI_CONFIG_NR_OF_SECTIONS) THEN
							// PARAMTERS ARE VALID
							// copy paramters to internal stucture
							Internal.ParametersUsed												:= Parameters;
							Internal.Status.ReadStatus := SuperTrakServChanRead(Parameters.SectionID,Parameters.ParameterNumber,Parameters.StartParameterIndex,Parameters.ParameterValueCount,ADR(Out_INT),SIZEOF(Out_INT));
							IF Internal.Status.ReadStatus <> 0 THEN
								Internal.AddErrorInfo											:= 'Command was not executed successfully: ';	
								Info.ErrorCode													:= Internal.Status.ReadStatus;
								GetErrorCode;
								Internal.ArEventLogWrite.EventID								:= HMI_ERR_CMD_NOT_EXECUTED;
								// Write logbook entry
								WriteLogbookEntry;
								// Set error
								StatusID														:= HMI_ERR_CMD_NOT_EXECUTED;
								Error															:= TRUE;
							ELSE
								CommandDone														:= TRUE;
							END_IF;
						ELSE
							// PARAMTERS ARE INVALID
							IF (Parameters.ParameterNumber = 0) THEN
								Internal.AddErrorInfo											:= 'Parameter ID is invalid';
							ELSIF (Parameters.SectionID > HMI_CONFIG_NR_OF_SECTIONS) THEN
								Internal.AddErrorInfo											:= 'Number of section is invalid';	
							END_IF;
							Internal.ArEventLogWrite.EventID									:= HMI_ERR_WRONG_PARAMETER;
							// Write logbook entry
							WriteLogbookEntry;
							// Set error
							StatusID															:= HMI_ERR_WRONG_PARAMETER;
							Error																:= TRUE;				
						END_IF;
					
					ELSIF ReadSINT AND NOT(CommandDone) THEN
						// Check if parameters are valid
						IF (Parameters.ParameterNumber <> 0) AND
							(Parameters.SectionID <= HMI_CONFIG_NR_OF_SECTIONS) THEN
							// PARAMTERS ARE VALID
							// copy paramters to internal stucture
							Internal.ParametersUsed												:= Parameters;
							Internal.Status.ReadStatus := SuperTrakServChanRead(Parameters.SectionID,Parameters.ParameterNumber,Parameters.StartParameterIndex,Parameters.ParameterValueCount,ADR(Out_SINT),SIZEOF(Out_SINT));
							IF Internal.Status.ReadStatus <> 0 THEN
								Internal.AddErrorInfo											:= 'Command was not executed successfully: ';	
								Info.ErrorCode													:= Internal.Status.ReadStatus;
								GetErrorCode;
								Internal.ArEventLogWrite.EventID								:= HMI_ERR_CMD_NOT_EXECUTED;
								// Write logbook entry
								WriteLogbookEntry;
								// Set error
								StatusID														:= HMI_ERR_CMD_NOT_EXECUTED;
								Error															:= TRUE;
							ELSE
								CommandDone														:= TRUE;
							END_IF;
						ELSE
							// PARAMTERS ARE INVALID
							IF (Parameters.ParameterNumber = 0) THEN
								Internal.AddErrorInfo											:= 'Parameter ID is invalid';
							ELSIF (Parameters.SectionID > HMI_CONFIG_NR_OF_SECTIONS) THEN
								Internal.AddErrorInfo											:= 'Number of section is invalid';	
							END_IF;
							Internal.ArEventLogWrite.EventID									:= HMI_ERR_WRONG_PARAMETER;
							// Write logbook entry
							WriteLogbookEntry;
							// Set error
							StatusID															:= HMI_ERR_WRONG_PARAMETER;
							Error																:= TRUE;				
						END_IF;
					
					ELSIF ReadREAL AND NOT(CommandDone) THEN
						// Check if parameters are valid
						IF (Parameters.ParameterNumber <> 0) AND
							(Parameters.SectionID <= HMI_CONFIG_NR_OF_SECTIONS) THEN
							// PARAMTERS ARE VALID
							// copy paramters to internal stucture
							Internal.ParametersUsed												:= Parameters;
							Internal.Status.ReadStatus := SuperTrakServChanRead(Parameters.SectionID,Parameters.ParameterNumber,Parameters.StartParameterIndex,Parameters.ParameterValueCount,ADR(Out_REAL),SIZEOF(Out_REAL));
							IF Internal.Status.ReadStatus <> 0 THEN
								Internal.AddErrorInfo											:= 'Command was not executed successfully: ';	
								Info.ErrorCode													:= Internal.Status.ReadStatus;
								GetErrorCode;
								Internal.ArEventLogWrite.EventID								:= HMI_ERR_CMD_NOT_EXECUTED;
								// Write logbook entry
								WriteLogbookEntry;
								// Set error
								StatusID														:= HMI_ERR_CMD_NOT_EXECUTED;
								Error															:= TRUE;
							ELSE
								CommandDone														:= TRUE;
							END_IF;
						ELSE
							// PARAMTERS ARE INVALID
							IF (Parameters.ParameterNumber = 0) THEN
								Internal.AddErrorInfo											:= 'Parameter ID is invalid';
							ELSIF (Parameters.SectionID > HMI_CONFIG_NR_OF_SECTIONS) THEN
								Internal.AddErrorInfo											:= 'Number of section is invalid';	
							END_IF;
							Internal.ArEventLogWrite.EventID									:= HMI_ERR_WRONG_PARAMETER;
							// Write logbook entry
							WriteLogbookEntry;
							// Set error
							StatusID															:= HMI_ERR_WRONG_PARAMETER;
							Error																:= TRUE;				
						END_IF;
					
					ELSIF ReadSTRING AND NOT(CommandDone) THEN
						// Check if parameters are valid
						IF (Parameters.ParameterNumber <> 0) AND
							(Parameters.SectionID <= HMI_CONFIG_NR_OF_SECTIONS) AND
							(Parameters.STRINGsize > 0) THEN
							// PARAMTERS ARE VALID
							// copy paramters to internal stucture
							Internal.ParametersUsed												:= Parameters;
							Internal.Status.ReadStatus := SuperTrakServChanRead(Parameters.SectionID,Parameters.ParameterNumber,Parameters.StartParameterIndex,Parameters.STRINGsize,ADR(Out_STRING),Parameters.STRINGsize);
							IF Internal.Status.ReadStatus <> 0 THEN
								Internal.AddErrorInfo											:= 'Command was not executed successfully: ';	
								Info.ErrorCode													:= Internal.Status.ReadStatus;
								GetErrorCode;
								Internal.ArEventLogWrite.EventID								:= HMI_ERR_CMD_NOT_EXECUTED;
								// Write logbook entry
								WriteLogbookEntry;
								// Set error
								StatusID														:= HMI_ERR_CMD_NOT_EXECUTED;
								Error															:= TRUE;
							ELSE
								CommandDone														:= TRUE;
							END_IF;
						ELSE
							// PARAMTERS ARE INVALID
							IF (Parameters.ParameterNumber = 0) THEN
								Internal.AddErrorInfo											:= 'Parameter ID is invalid';
							ELSIF (Parameters.SectionID > HMI_CONFIG_NR_OF_SECTIONS) THEN
								Internal.AddErrorInfo											:= 'Number of section is invalid';	
							END_IF;
							Internal.ArEventLogWrite.EventID									:= HMI_ERR_WRONG_PARAMETER;
							// Write logbook entry
							WriteLogbookEntry;
							// Set error
							StatusID															:= HMI_ERR_WRONG_PARAMETER;
							Error																:= TRUE;				
						END_IF;
					END_IF;
				
					IF NOT(ReadUDINT) AND NOT(ReadUINT) AND NOT(ReadUSINT) AND NOT(ReadDINT) AND NOT(ReadINT) AND NOT(ReadSINT) AND NOT(ReadREAL) AND NOT(ReadSTRING) THEN
						CommandDone	:= FALSE;
					END_IF;
		
					//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::://
					// Error detection
					// Check if communication is not established
					IF NOT HMILink.SuperTrakStatus.StatusValid THEN
						IF (HMILink.LibraryStatus.FbID[0] = 0) AND (HMILink.LibraryStatus.LogBookIdent <> 0) THEN
							Internal.AddErrorInfo												:= 'No enabled instance of HMIControl could be found';
							Internal.ArEventLogWrite.EventID									:= HMI_ERR_NO_HMICONTROL_REG;
							// Write logbook entry
							WriteLogbookEntry;
							// Set error
							StatusID															:= HMI_ERR_NO_HMICONTROL_REG;
							Error																:= TRUE;
						ELSE
							// Set error
							Internal.AddErrorInfo												:= 'No communication to SuperTrak';
							Internal.ArEventLogWrite.EventID									:= HMI_ERR_COMMUNICAITON_TIME_OUT;
							// Write logbook entry
							WriteLogbookEntry;
							StatusID															:= HMI_ERR_COMMUNICAITON_TIME_OUT;
							Error																:= TRUE;
						END_IF;
					END_IF;
				ELSE
					Internal.Status.InitConfigCheckDone											:= FALSE;
					// Set error
					StatusID																	:= HMI_ERR_WRONG_CONFIG;
					Error																		:= TRUE;
				END_IF;
				
				//--------------------------------------------------------------------------------//
				// Error handling
				//--------------------------------------------------------------------------------//
			HMI_RPAR_STATE_ERROR:
			
				// Reset active output
				Active																		:= FALSE;
				
				UpdateDone																	:= FALSE;
				CommandDone																	:= FALSE;

				IF NOT Error THEN
					// Check in which state to jump
					IF NOT Internal.Status.FuncitonBlockRegistered THEN
						Internal.Step														:= HMI_RPAR_STATE_INIT;
					ELSIF NOT Internal.Status.InitConfigCheckDone THEN
						Internal.Step														:= HMI_RPAR_STATE_INIT;
					ELSIF NOT Internal.Status.InitParCheckDone THEN
						Internal.Step														:= HMI_RPAR_STATE_INIT_CHECK_PAR;
					ELSE
						Internal.Step														:= HMI_RPAR_STATE_OPERATION;
					END_IF;
				END_IF;

		END_CASE;
		
		//************************************************************************************//
		// Error and Warning acknowledgement
		//************************************************************************************//
		
		// Check if error or warning is acknowledged by user
		IF ErrorReset AND Error AND NOT Internal.ErrorResetOld THEN
			// Reset error
			StatusID																		:= HMI_NO_ERROR;
			Error																			:= FALSE;
			Internal.Status.ReadStatus														:= 0;
			Info.ErrorCode																	:= 0;
		ELSIF ErrorReset AND StatusID <> HMI_NO_ERROR AND NOT Internal.ErrorResetOld THEN
			// Reset warning
			StatusID																		:= HMI_NO_ERROR;
			Internal.Status.ReadStatus														:= 0;
			Info.ErrorCode																	:= 0;
		END_IF;
		
		// Copy command for edge detection
		Internal.ErrorResetOld																:= ErrorReset;
		Internal.UpdateOld																	:= Update;
				
	ELSE
		//####################################################################################//
		// FUNCTION BLOCK IS DISABLED
		//####################################################################################//
		// Reset all outputs
		Active																				:= FALSE;
		Error																				:= FALSE;
		StatusID																			:= 0;
		UpdateDone																			:= FALSE;

		CommandDone																			:= FALSE;
		
		Internal.Status.FuncitonBlockRegistered												:= FALSE;
		Internal.Status.InitParCheckDone													:= FALSE;
		Internal.Status.InitConfigCheckDone													:= FALSE;
		Internal.Step																		:= HMI_RPAR_STATE_INIT;
		
		Internal.Status.ReadStatus															:= 0;
		Info.ErrorCode																		:= 0;
	END_IF;
END_FUNCTION_BLOCK
