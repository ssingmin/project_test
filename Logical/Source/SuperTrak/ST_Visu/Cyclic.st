(*********************************************************************************
 * Copyright Bernecker + Rainer 2015
 * Copyright ATS Automation Tooling Systems, Inc. 2017-2018
 * All rights reserved.
 * -------------------------------------------------------------------------------
 * This task calculates the actual pallet positions in the room based on the
 * section number and the position of the pallet in the section.
 * It is also hiding unused sections and/or pallets.
 * This data is then provided to B&R Scene Viewer.
 *********************************************************************************)

PROGRAM _INIT

	visuStep := 0;
	
END_PROGRAM

PROGRAM _CYCLIC
	
	CASE visuStep OF
		visuSTEP_INITIALIZE:
			visuStep := visuSTEP_GET_SECTION_COUNT;
		
		visuSTEP_GET_SECTION_COUNT:
			// read parameter 1080: section count
			result := SuperTrakServChanRead(0, 1080, 0, 1, ADR(sectionCount), SIZEOF(sectionCount));
			
			IF (result = scERR_SUCCESS) AND (sectionCount > 0) THEN
				visuStep := visuSTEP_GET_SECTION_ADDRS;
			ELSE
				visuStep := visuSTEP_ERROR;
			END_IF;
		
		visuSTEP_GET_SECTION_ADDRS:
			// read parameter 1081: section user address
			result := SuperTrakServChanRead(0, 1081, 0, sectionCount, ADR(servChanResponseUINT), SIZEOF(servChanResponseUINT));
			
			IF (result = scERR_SUCCESS) THEN
				FOR i := 0 TO sectionCount - 1 DO
					Section[i].userAddress := servChanResponseUINT[i];
					
					IF (Section[i].userAddress > 0) AND (Section[i].userAddress < 99) THEN
						sectionLookup[ Section[i].userAddress ] := i;
					END_IF;
				END_FOR;
				
				visuStep := visuSTEP_GET_SECTION_TYPES;
				i := 0;
			ELSE
				visuStep := visuSTEP_ERROR;
			END_IF;
		
		visuSTEP_GET_SECTION_TYPES:
			// read parameter 1082: section type
			result := SuperTrakServChanRead(UINT_TO_USINT(Section[i].userAddress), 1082, 0, 1, ADR(Section[i].sectionType), SIZEOF(UINT));
			
			IF (result = scERR_SUCCESS) THEN
				i := i + 1;
				
				IF (i >= sectionCount) THEN					
					visuStep := visuSTEP_SETUP_SECTIONS;
				END_IF;
			ELSE
				visuStep := visuSTEP_ERROR;
			END_IF;

		visuSTEP_SETUP_SECTIONS:
			// Assign visualization models to sections.
			// Mostly assume that the layout is sensible.
			side := 0;
			sideLength[0] := 0;
			sideLength[1] := 0;
			position := 0;
			modelIndex := 0;
			
			FOR i := 0 TO sectionCount - 1 DO
				Section[i].side := -1;
				Section[i].modelIndex := -1;
				
				IF (Section[i].sectionType = SECTION_TYPE_1M) OR (Section[i].sectionType = SECTION_TYPE_1M_LP) THEN
					// Straight section models are indexed 0-31 (front) and 32-63 (back).
					IF (side < 2)
						AND (modelIndex >= (side * 32))
						AND (modelIndex < ((side + 1) * 32)) THEN
						
						Section[i].side := side;
						sideLength[side] := sideLength[side] + 1;

						Data.StraightSectionVisible[modelIndex] := TRUE;
						Section[i].modelIndex := modelIndex;
						modelIndex := modelIndex + 1;
						
						Section[i].positionX := position;

						IF (side = 0) THEN
							position := position + 1000;
						ELSE
							position := position - 1000;
						END_IF;
					END_IF;

				ELSIF (Section[i].sectionType = SECTION_TYPE_N180) OR (Section[i].sectionType = SECTION_TYPE_W180L) THEN
					// Advance to next side when a curve follows straights,
					// or when a curve already exists on the current side.
					IF (side < 2) AND ((sideLength[side] > 0) OR (curveHSection[side] >= 0)) THEN
						side := side + 1;

						IF (side = 1) THEN
							modelIndex := 64 - sideLength[0];
							Data.CurvePositionX := position;
						END_IF;
					END_IF;
					
					IF (side = 1) THEN
						curveSide := 1;
					ELSE
						curveSide := 0;
					END_IF;

					IF (curveHSection[curveSide] < 0) THEN
						Section[i].side := curveSide;
						curveHSection[curveSide] := i;
						
						IF (Section[i].sectionType = SECTION_TYPE_N180) THEN
							Data.N180SectionVisible[curveSide] := TRUE;
						ELSE
							Data.W180SectionVisible[curveSide] := TRUE;
						END_IF;
					
						curveType := Section[i].sectionType;
					END_IF;
						
				ELSIF (Section[i].sectionType = SECTION_TYPE_W180R) THEN
					IF (side = 1) THEN
						curveSide := 1;
					ELSE
						curveSide := 0;
					END_IF;
					
					Section[i].side := curveSide;

				ELSE
					// unhandled section type
					
				END_IF;
			END_FOR;

			IF (curveType = SECTION_TYPE_N180) THEN
				Data.StraightSectionPositionY := 0;
				straightPalletPositionY[0] := -236;
				straightPalletPositionY[1] := 236;
			ELSE	// W180
				Data.StraightSectionPositionY := 365.5;
				straightPalletPositionY[0] := -236;
				straightPalletPositionY[1] := 600.5;
			END_IF;
			
			visuStep := visuSTEP_RUN;
			
		visuSTEP_RUN:
			// get actual pallet positions
			SuperTrakGetPalletInfo(ADR(Pallet), 128, FALSE);
			
			FOR i := 0 TO 127 DO
				IF (Pallet[i].section >= 1) AND (Pallet[i].section <= 99) THEN
					h := sectionLookup[ Pallet[i].section ];
				ELSE
					h := -1;
				END_IF;
				
				IF (h >= 0) THEN
					// display this pallet
					Data.Pallet[i].Visible := TRUE;
					position := DINT_TO_REAL(Pallet[i].position) / 1000;
					
					IF (Section[h].sectionType = SECTION_TYPE_1M) OR (Section[h].sectionType = SECTION_TYPE_1M_LP) THEN
						IF (Section[h].side = 0) THEN
							Data.Pallet[i].X := Section[h].positionX + position;
							Data.Pallet[i].Y := straightPalletPositionY[0];
							Data.Pallet[i].RZ := 0;
						ELSE
							Data.Pallet[i].X := Section[h].positionX - position;
							Data.Pallet[i].Y := straightPalletPositionY[1];
							Data.Pallet[i].RZ := 180;
						END_IF;

					ELSIF (Section[h].sectionType = SECTION_TYPE_N180) THEN
						// approximate the shape of the curve
						IF (position <= 15) THEN
							Data.Pallet[i].X := position;
							Data.Pallet[i].Y := -236;
							Data.Pallet[i].RZ := 0;
						ELSIF (position < 1015) THEN
							angle := brmPI * (position - 15) / 1000;
							Data.Pallet[i].X := 15 + (355 * SIN(angle)) - (15 * SIN(angle * 3));
							Data.Pallet[i].Y := (-257 * COS(angle)) + (21 * COS(angle * 3));
							Data.Pallet[i].RZ := 90 - 90 * COS(angle);
						ELSE
							Data.Pallet[i].X := 1030 - position;
							Data.Pallet[i].Y := 236;
							Data.Pallet[i].RZ := 180;
						END_IF;
						
						IF (Section[h].side = 0) THEN		
							Data.Pallet[i].X := -Data.Pallet[i].X;
							Data.Pallet[i].Y := -Data.Pallet[i].Y;
							Data.Pallet[i].RZ := Data.Pallet[i].RZ - 180;
						ELSE
							Data.Pallet[i].X := Data.Pallet[i].X + Data.CurvePositionX;
						END_IF;

					ELSIF (Section[h].sectionType = SECTION_TYPE_W180L) THEN
						IF (position > 100) THEN
							angle := (position - 100) / W180_RADIUS * 180 / brmPI;
							position := 100;
						ELSE
							angle := 0;
						END_IF;
						
						IF (Section[h].side = 0) THEN
							Data.Pallet[i].X := -position - W180_RADIUS * SIN(angle * brmPI / 180);
							Data.Pallet[i].Y := 181.75 + W180_RADIUS * COS(angle * brmPI / 180);
							angle := angle + 180;
						ELSE
							Data.Pallet[i].X := position + Data.CurvePositionX + W180_RADIUS * SIN(angle * brmPI / 180);
							Data.Pallet[i].Y := 181.75 - W180_RADIUS * COS(angle * brmPI / 180);
						END_IF;

						Data.Pallet[i].RZ := angle;
					
					ELSIF (Section[h].sectionType = SECTION_TYPE_W180R) THEN
						IF (position > 650) THEN
							angle := 180;
							position := 759.347 - position;
						ELSE
							angle := (position / W180_RADIUS * 180 / brmPI) + 90;
							position := 100;
						END_IF;
						
						IF (Section[h].side = 0) THEN
							angle := angle + 180;
							Data.Pallet[i].X := -position - W180_RADIUS * ABS(SIN(angle * brmPI / 180));
							Data.Pallet[i].Y := 181.75 - W180_RADIUS * ABS(COS(angle * brmPI / 180));
						ELSE
							Data.Pallet[i].X := position + Data.CurvePositionX + W180_RADIUS * ABS(SIN(angle * brmPI / 180));
							Data.Pallet[i].Y := 181.75 + W180_RADIUS * ABS(COS(angle * brmPI / 180));
						END_IF;
						
						Data.Pallet[i].RZ := angle;
										
					END_IF;
					
				ELSE
					// hide this pallet
					Data.Pallet[i].Visible := FALSE;
					Data.Pallet[i].X := 0;
					Data.Pallet[i].Y := 0;
					Data.Pallet[i].RZ := 0;
					
				END_IF;
			END_FOR;
			
		ELSE
			// error or unhandled state; do nothing
			
	END_CASE;

END_PROGRAM
