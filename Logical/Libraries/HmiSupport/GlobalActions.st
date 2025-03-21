(******************************************************************************************
 * Copyright: Bernecker + Rainer
 * Author:  B+R
 * Created:  July 2, 2018/10:07 AM 
 ******************************************************************************************
 ******************************************************************************************
 * Version History:
 * ----------------------------------------------------------------------------------------
 * V 1.00.0   July 2, 2018/10:07 AM  First Version
 ******************************************************************************************
 * Description:
 * ----------------------------------------------------------------------------------------
 * July 2, 2018/10:07 AM V1.00.0:
 * The actions defined here are used in the FUNCTION block implementations.
 * All FUNCTION blocks, where these actions should be used, must have the
 * variables used here as part OF the internal structure
 ******************************************************************************************)

ACTION WriteLogbookEntry:
	
	// Set command to write logbook entry
	Internal.ArEventLogWrite.Execute						:= TRUE;
	// Function block call
	Internal.ArEventLogWrite();
	// Check if writing of logbook entry is finished, to reset command
	IF Internal.ArEventLogWrite.Done THEN
		// Reset additional error info
		brsmemset(ADR(Internal.AddErrorInfo), 0, SIZEOF(Internal.AddErrorInfo));
		// Reset command to create logbook entry
		Internal.ArEventLogWrite.Execute					:= FALSE;
		// Function block call
		Internal.ArEventLogWrite();
	ELSIF Internal.ArEventLogWrite.Error THEN
		// Set command to write logbook entry
		Internal.ArEventLogWrite.Execute					:= FALSE;
		// Function block call
		Internal.ArEventLogWrite();
		StatusID											:= Internal.ArEventLogWrite.StatusID;
		Error												:= TRUE;
	END_IF;
	
END_ACTION

ACTION GetErrorCode:
	
	CASE Info.ErrorCode OF
		1:
			brsstrcat(ADR(Internal.AddErrorInfo),ADR('An invalid section number was specified.'));
			
		2:
			brsstrcat(ADR(Internal.AddErrorInfo),ADR('The specified parameter number was not recognized.'));
		
		3:
			brsstrcat(ADR(Internal.AddErrorInfo),ADR('The specified task code was not recognized.'));
		
		4:
			brsstrcat(ADR(Internal.AddErrorInfo),ADR('The requested operation is currently unavailable.'));
		
		6:
			brsstrcat(ADR(Internal.AddErrorInfo),ADR('The specified starting index is invalid.'));
		
		7:
			brsstrcat(ADR(Internal.AddErrorInfo),ADR('The value to be written was outside of the valid range.'));
		
		8:
			brsstrcat(ADR(Internal.AddErrorInfo),ADR('The requested number of elements is invalid.'));
		
		10:
			brsstrcat(ADR(Internal.AddErrorInfo),ADR('The command did not complete in a timely manner.'));
		
		11:
			brsstrcat(ADR(Internal.AddErrorInfo),ADR('The request was denied due to a lack of permissions.'));
		
		14:
			brsstrcat(ADR(Internal.AddErrorInfo),ADR('The packet is malformed, or its length is incorrect.'));
		
		15:
			brsstrcat(ADR(Internal.AddErrorInfo),ADR('An internal error occurred while processing the request.'));
			
	END_CASE;
	
END_ACTION