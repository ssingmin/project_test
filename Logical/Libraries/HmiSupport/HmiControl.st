(******************************************************************************************
 * Copyright: Bernecker + Rainer
 * Author:  B+R
 * Created:  July 2, 2018/08:25 AM 
 ******************************************************************************************
 ******************************************************************************************
 * Version History:
 * ----------------------------------------------------------------------------------------
 * V 1.00.0   July 2, 2018/08:25 AM  First Version
 ******************************************************************************************
 * Description:
 * ----------------------------------------------------------------------------------------
 * July 2, 2018/08:25 AM V1.00.0:
 * This function block writes error data into the logger from other FUBs of this library.
 ******************************************************************************************)

FUNCTION_BLOCK HMIControl
	
	// Check if function block is enabled
	IF Enable THEN
		//####################################################################################//
		// FUNCTION BLOCK IS ENABLED
		//####################################################################################//
		
		// Set Library version information
		Info.Library.Version															:= HMI_CONFIG_VERSION;
	
		// Check if error occured to change state
		IF Error THEN
			// Go to state error, to wait for acknowledge
			Internal.Step																:= HMI_CTRL_STATE_ERROR;
		END_IF;
		
		//************************************************************************************//
		// Operation
		//************************************************************************************//
		CASE Internal.Step OF
			//--------------------------------------------------------------------------------//
			// Initialize internal parameters
			//--------------------------------------------------------------------------------//
			HMI_CTRL_STATE_INIT:
				
				// Initialize function block to create a logbook
				Internal.ArEventLogCreate.Info											:= 0;	// Reserved (see AS help)
				Internal.ArEventLogCreate.Name											:= 'HMILib';
				Internal.ArEventLogCreate.Persistence									:= arEVENTLOG_PERSISTENCE_PERSIST;
				Internal.ArEventLogCreate.Size											:= 65536;
				
				Internal.ArEventLogGetIdent.Name										:= Internal.ArEventLogCreate.Name;
				
				// Initialize function block creating a logbook entry
				Internal.ArEventLogWrite.AddData										:= ADR(Internal.AddErrorInfo);
				Internal.ArEventLogWrite.AddDataFormat									:= 1;	// zero-terminated string
				Internal.ArEventLogWrite.AddDataSize									:= SIZEOF(Internal.AddErrorInfo);
				Internal.ArEventLogWrite.ObjectID										:= 'HmiControl';
				
				Internal.ArEventLogWrite.OriginRecordID									:= 0;	// don't use origin record
				Internal.ArEventLogWrite.TimeStamp										:= 0;	// use internal time stamp
				
				// Initialize communication watchdog
				Internal.CommunicationWatchdog.PT										:= HMI_CONFIG_COMM_TIME_OUT;
			
				Internal.Step															:= HMI_CTRL_STATE_INIT_CHECK_CONFIG;
			
				//--------------------------------------------------------------------------------//
				// First check of function block configuration
				//--------------------------------------------------------------------------------//
			HMI_CTRL_STATE_INIT_CHECK_CONFIG:

				// Check if given addresses are valid
				IF (ADR(HMILink) > 0) THEN

					Internal.Status.InitConfigCheckDone									:= TRUE;
					Internal.Step														:= HMI_CTRL_STATE_CREATE_LOGBOOK;
				ELSE
					Internal.Status.InitConfigCheckDone									:= FALSE;
					// Address not valid, set error
					StatusID															:= HMI_ERR_WRONG_CONFIG;
					Error																:= TRUE;
				END_IF;	
			
				//--------------------------------------------------------------------------------//
				// Create logbook for all function blocks
				//--------------------------------------------------------------------------------//
			HMI_CTRL_STATE_CREATE_LOGBOOK:
				
				// Set command to create logbook
				Internal.ArEventLogCreate.Execute										:= TRUE;
				Internal.ArEventLogCreate();
				
				// Check if logbook is created successfully, to continue
				IF Internal.ArEventLogCreate.Done THEN
					// Reset command
					Internal.ArEventLogCreate.Execute									:= FALSE;
					Internal.Status.LogBookCreated										:= TRUE;
					// Save Ident of logbook
					Internal.ArEventLogWrite.Ident										:= Internal.ArEventLogCreate.Ident;
					HMILink.LibraryStatus.LogBookIdent									:= Internal.ArEventLogCreate.Ident;
					Internal.ArEventLogCreate();
					
					// Create logbook entry
					Internal.AddErrorInfo												:= 'HMI Version ';
					brsstrcat(ADR(Internal.AddErrorInfo), ADR(HMI_CONFIG_VERSION));
				
					Internal.ArEventLogWrite.EventID									:= HMI_SUCC_FB_REGISTRATION;
					// Write logbook entry
					WriteLogbookEntry;
					
					Internal.Step														:= HMI_CTRL_STATE_REGISTER_FB;

					// Check if logbook already exists, to continue
				ELSIF (Internal.ArEventLogCreate.StatusID = arEVENTLOG_ERR_LOGBOOK_EXISTS) THEN
					// Get logbook ident
					Internal.ArEventLogGetIdent.Execute									:= TRUE;
					Internal.ArEventLogGetIdent();
					
					// Wait until FB is done getting the ident
					IF Internal.ArEventLogGetIdent.Done THEN
						// Copy ident
						Internal.ArEventLogWrite.Ident									:= Internal.ArEventLogGetIdent.Ident;
						HMILink.LibraryStatus.LogBookIdent								:= Internal.ArEventLogGetIdent.Ident;
						// Reset command
						Internal.ArEventLogCreate.Execute								:= FALSE;
						Internal.ArEventLogGetIdent.Execute								:= FALSE;
						Internal.Status.LogBookCreated									:= TRUE;
						Internal.ArEventLogCreate();
						Internal.ArEventLogGetIdent();
						
						// Create logbook entry
						Internal.AddErrorInfo											:= 'HMI Version ';
						brsstrcat(ADR(Internal.AddErrorInfo), ADR(HMI_CONFIG_VERSION));
						
						Internal.ArEventLogWrite.EventID								:= HMI_SUCC_FB_REGISTRATION;
						// Write logbook entry
						WriteLogbookEntry;
						
						Internal.Step													:= HMI_CTRL_STATE_REGISTER_FB;
					END_IF;

					// If creation of logbook was not successfull, set error
				ELSIF Internal.ArEventLogCreate.Error THEN	
					// Copy status id of failed funciton block
					StatusID															:= Internal.ArEventLogCreate.StatusID;
					Internal.Status.LogBookCreated										:= FALSE;
					Internal.ArEventLogCreate.Execute									:= FALSE;
					Internal.ArEventLogCreate();
					Error																:= TRUE;
				END_IF;
			
				//--------------------------------------------------------------------------------//
				// Register function block in HMILink structure
				//--------------------------------------------------------------------------------//
			HMI_CTRL_STATE_REGISTER_FB:
				
				// Build function block ID
				Internal.Status.FuncitonBlockID											:= HMI_CONFIG_FB_ID_HMICONTROL;
			
				// Check if FB is already registered
				IF Internal.Status.FuncitonBlockRegistered THEN
					Internal.Step														:= HMI_CTRL_STATE_OPERATION;
					
					// If this function block ID is not yet used and the FB is not registered, register FB, otherwise set error,
					// because there can only be one instance OF this FB
				ELSIF (HMILink.LibraryStatus.FbID[0] <> Internal.Status.FuncitonBlockID) THEN
					// For StControl, use always index 0
					HMILink.LibraryStatus.FbID[0]										:= Internal.Status.FuncitonBlockID;
					Internal.Status.FuncitonBlockRegistered								:= TRUE;
					
					// Create logbook entry
					Internal.AddErrorInfo												:= 'Function block registration successfull';
					Internal.ArEventLogWrite.EventID									:= HMI_SUCC_FB_REGISTRATION;
					// Write logbook entry
					WriteLogbookEntry;
					Internal.Step														:= HMI_CTRL_STATE_OPERATION;
					
				ELSE
					// Create logbook entry
					Internal.AddErrorInfo												:= 'Another instance of this function block is already registered';
					Internal.ArEventLogWrite.EventID									:= HMI_ERR_FB_INSTANCE_REG;
					// Write logbook entry
					WriteLogbookEntry;
					// StControl instance is already in use, set error
					StatusID															:= HMI_ERR_FB_INSTANCE_REG;
					Error																:= TRUE;
				END_IF;
				
				//--------------------------------------------------------------------------------//
				// Operation
				//--------------------------------------------------------------------------------//
			HMI_CTRL_STATE_OPERATION:
				
				// Set active output
				Active																		:= TRUE;
			
				IF (ADR(HMILink) > 0) THEN
					//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::://
					// Parameter update handling
					// Check if parameters should be updated
					IF Update AND NOT Internal.UpdateOld AND NOT UpdateDone THEN
						UpdateDone															:= TRUE;
					ELSIF NOT Update THEN
						UpdateDone															:= FALSE;
					END_IF;
					
					// Set valid
					HMILink.SuperTrakStatus.StatusValid									:= TRUE;
				END_IF;
				

			//--------------------------------------------------------------------------------//
			// Error handling
			//--------------------------------------------------------------------------------//
			HMI_CTRL_STATE_ERROR:

				// Reset outputs
				Active																	:= FALSE;
				UpdateDone																:= FALSE;
				
				// Return to previous state, if error is cleared
				IF NOT Error THEN
					// Check in which state to jump
					IF NOT Internal.Status.InitConfigCheckDone THEN
						Internal.Step													:= HMI_CTRL_STATE_INIT_CHECK_CONFIG;
					ELSIF NOT Internal.Status.LogBookCreated THEN
						Internal.Step													:= HMI_CTRL_STATE_CREATE_LOGBOOK;
					ELSIF NOT Internal.Status.FuncitonBlockRegistered THEN
						Internal.Step													:= HMI_CTRL_STATE_REGISTER_FB;
					ELSE
						Internal.Step													:= HMI_CTRL_STATE_OPERATION;
					END_IF;
				END_IF;
		END_CASE;
		
		//************************************************************************************//
		// Error and Warning acknowledgement
		//************************************************************************************//
		
		// Check if error or warning is acknowledged by user
		IF ErrorReset AND Error AND NOT Internal.ErrorResetOld THEN
			// Reset error
			StatusID																	:= HMI_NO_ERROR;
			Error																		:= FALSE;
		ELSIF ErrorReset AND StatusID <> HMI_NO_ERROR AND NOT Internal.ErrorResetOld THEN
			// Reset warning
			StatusID																	:= HMI_NO_ERROR;
		END_IF;
		
		Internal.ErrorResetOld															:= ErrorReset;
		Internal.UpdateOld																:= Update;
		
		//************************************************************************************//
		// Function block calls
		//************************************************************************************//
		Internal.CommunicationWatchdog();
		
	ELSE
		//####################################################################################//
		// FUNCTION BLOCK IS DISABLED
		//####################################################################################//
		// Reset all outputs
		Active																			:= FALSE;
		Error																			:= FALSE;
		StatusID																		:= HMI_NO_ERROR;
		UpdateDone																		:= FALSE;
				
		// Reset state machine
		Internal.Step																	:= HMI_CTRL_STATE_INIT;
		// Check if address is valid, to avoid system crash
		IF (ADR(HMILink) > 0) THEN
			// Unregister function block (if registered)
			IF Internal.Status.FuncitonBlockRegistered THEN
				HMILink.LibraryStatus.FbID[0]											:= 0;
				Internal.Status.FuncitonBlockRegistered									:= FALSE;
			END_IF;	
		END_IF;
						
		Internal.Status.LogBookCreated													:= FALSE;
		Internal.CommunicationWatchdog.IN												:= FALSE;
		
	END_IF;
	
END_FUNCTION_BLOCK
