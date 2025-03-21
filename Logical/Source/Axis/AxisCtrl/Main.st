
(*****************************************************************************
 * Copyright: COPYRIGHT (C) BERNECKER + RAINER, AUSTRIA
 *****************************************************************************
 * Author:  B+R  Created:  May 03, 2022/14:05 PM
 *****************************************************************************
 * Description: Implementation of the SDC-Axis
 ******************************************************************************)
PROGRAM _INIT	
	
	// Initialize the function block
	gMpAxisBasic_0.Enable 				:= TRUE;
	gMpAxisBasic_0.MpLink 				:= ADR(gAxis1);
	gMpAxisBasic_0.Parameters			:= ADR(gMpAxisBasicParam);
	
	gMpAxisBasicParam.Velocity			:= 4000;
	gMpAxisBasicParam.Acceleration		:= 10000;
	gMpAxisBasicParam.Deceleration		:= 10000;
	gMpAxisBasicParam.Jog.Velocity		:= 1000;
	gMpAxisBasicParam.Jog.Acceleration	:= 10000;
	gMpAxisBasicParam.Jog.Deceleration	:= 10000;
	
	gMpAxisBasicParam.Jog.LimitPosition.FirstPosition := 500;
	gMpAxisBasicParam.Jog.LimitPosition.LastPosition := 3200;
	
END_PROGRAM

PROGRAM _CYCLIC
	// Home the axis if the SuperTrak-Sections is enabled
	IF gAllSectionsEnabled THEN
		gMpAxisBasic_0.Power 			:= TRUE;
	END_IF
	// Home the axis if its power on
	IF gMpAxisBasic_0.PowerOn AND NOT(gMpAxisBasic_0.IsHomed) THEN
		gMpAxisBasic_0.Home 			:= TRUE;
	END_IF
	// Reset the Input if the homing is done
	IF EDGEPOS(gMpAxisBasic_0.IsHomed) THEN
		gMpAxisBasic_0.Home				:= FALSE;
	END_IF
	
	//Call of the function block
	gMpAxisBasic_0(); 
	
END_PROGRAM

PROGRAM _EXIT
	
	gMpAxisBasic_0.Enable				:= FALSE;
	gMpAxisBasic_0();
	 
END_PROGRAM

