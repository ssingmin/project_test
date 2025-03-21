(*********************************************************************************
 * Copyright: Bernecker + Rainer
 * Author:  B+R
 * Created:  June 28, 2017/08:43 AM 
 *********************************************************************************
 *********************************************************************************
 * Version History:
 * -------------------------------------------------------------------------------
 * V 1.00.0   June 28, 2017/08:43 AM  First Version
 *********************************************************************************
 * Description:
 * -------------------------------------------------------------------------------
 * June 28, 2017/08:43 AM V1.00.0:
 * This task is reading the temperatures OF a SuperTrak.
 * The variables for the visualization are set
 *********************************************************************************)

ACTION ReadTemp: 
	
	StartIndex	:= 0;
	SuperTrakServChanRead(SectionID,TemperatureID,StartIndex,SIZEOF(Temperatures.Section[SectionID].Value)/SIZEOF(Temperatures.Section[SectionID].Value[0]),ADR(Temperatures.Section[SectionID]),SIZEOF(Temperatures.Section[SectionID]));

	// Read all sensors which are enabled or disabled by the user
	SuperTrakServChanRead(SectionID,1170,StartIndex,1, ADR(Temperatures.Section[SectionID].DefaultMask), SIZEOF(Temperatures.Section[SectionID].DefaultMask));
	SuperTrakServChanRead(SectionID,1169,StartIndex,1, ADR(Temperatures.Section[SectionID].UserEnableMask), SIZEOF(Temperatures.Section[SectionID].UserEnableMask));
	SuperTrakServChanRead(SectionID,1168,StartIndex,1, ADR(Temperatures.Section[SectionID].UserDisableMask), SIZEOF(Temperatures.Section[SectionID].UserDisableMask));
	
	// Calculate effective mask for temperature sensors
	Temperatures.Section[SectionID].EffectiveMask := Temperatures.Section[SectionID].UserEnableMask OR(Temperatures.Section[SectionID].DefaultMask AND NOT(Temperatures.Section[SectionID].UserDisableMask));
	
	// Mapping of active temperature sensors
	Temperatures.Section[SectionID].SensorActivated[0] := Temperatures.Section[SectionID].EffectiveMask.0;
	Temperatures.Section[SectionID].SensorActivated[1] := Temperatures.Section[SectionID].EffectiveMask.1;
	Temperatures.Section[SectionID].SensorActivated[2] := Temperatures.Section[SectionID].EffectiveMask.2;
	Temperatures.Section[SectionID].SensorActivated[3] := Temperatures.Section[SectionID].EffectiveMask.3;
	Temperatures.Section[SectionID].SensorActivated[4] := Temperatures.Section[SectionID].EffectiveMask.4;
	Temperatures.Section[SectionID].SensorActivated[5] := Temperatures.Section[SectionID].EffectiveMask.5;
	Temperatures.Section[SectionID].SensorActivated[6] := Temperatures.Section[SectionID].EffectiveMask.6;
	
	Temperatures.Section[SectionID].SensorActivated[8] := Temperatures.Section[SectionID].EffectiveMask.8;
	Temperatures.Section[SectionID].SensorActivated[9] := Temperatures.Section[SectionID].EffectiveMask.9;
	Temperatures.Section[SectionID].SensorActivated[10] := Temperatures.Section[SectionID].EffectiveMask.10;
	Temperatures.Section[SectionID].SensorActivated[11] := Temperatures.Section[SectionID].EffectiveMask.11;
	Temperatures.Section[SectionID].SensorActivated[12] := Temperatures.Section[SectionID].EffectiveMask.12;
	Temperatures.Section[SectionID].SensorActivated[13] := Temperatures.Section[SectionID].EffectiveMask.13;
	Temperatures.Section[SectionID].SensorActivated[14] := Temperatures.Section[SectionID].EffectiveMask.14;

		
	// Search for error/warning
	// To get the temperature --> /100
	FOR StartIndex := 0 TO 15 DO
		IF Temperatures.Section[VisuSection].SensorActivated[StartIndex] THEN
				Temperatures.Section[VisuSection].Warning[StartIndex]	:= (UINT_TO_REAL(Temperatures.Section[VisuSection].Value[StartIndex])/100) > WarningTemperature;
				Temperatures.Section[VisuSection].Error[StartIndex]	:= (UINT_TO_REAL(Temperatures.Section[VisuSection].Value[StartIndex])/100) > ErrorTemperature;
		END_IF	
	END_FOR;

	IF SectionID = CONFIG_ST_MAX_SECTIONS THEN
		SectionID					:= 1;
	ELSE
		SectionID					:= SectionID+1;
	END_IF;
	
	// Count up the section on the Temperatures Visu page
	IF EDGEPOS(CountUp) THEN
		VisuSection		:= VisuSection + 1;
		// Check for last section
		IF VisuSection = (MAX_SECTIONS+1) THEN
			VisuSection	:= 1;
		END_IF;
		CountUp			:= FALSE;
		// Count down the section on the Temperatures Visu page
	ELSIF EDGEPOS(CountDown) THEN
		VisuSection		:= VisuSection - 1;
		// Check for first section
		IF VisuSection = 0 THEN
			VisuSection	:= MAX_SECTIONS;
		END_IF;
		CountDown		:= FALSE;
	END_IF;
	
	// Get the needed section data
	FOR i:= 0 TO 15 DO
		IF Temperatures.Section[VisuSection].SensorActivated[i] THEN
			VisuTemp.Value[i]				:= UINT_TO_REAL(Temperatures.Section[VisuSection].Value[i])/100;
		ELSE
			VisuTemp.Value[i] 				:= 0;
		END_IF	
	END_FOR;
	VisuTemp.Error		:= Temperatures.Section[VisuSection].Error;
	VisuTemp.Warning	:= Temperatures.Section[VisuSection].Warning;
END_ACTION
