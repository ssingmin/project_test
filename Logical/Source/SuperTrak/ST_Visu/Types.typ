
TYPE
	RoboVisuPallet_t : 	STRUCT 
		Visible : BOOL; (*byte 0*)
		reserved_1 : USINT; (*byte 1*)
		Text : STRING[5]; (*Text / bytes 2-7*) (*STRING[n] = char[n + 1] = n characters plus terminator*)
		X : REAL; (*Position.X / bytes 8-11*)
		Y : REAL; (*Position.Y / bytes 12-15*)
		RZ : REAL; (*Orientation.RotZ / bytes 16-19*)
	END_STRUCT;
	RoboVisuData_t : 	STRUCT 
		StraightSectionVisible : ARRAY[0..63]OF BOOL; (*bytes 0-63*)
		N180SectionVisible : ARRAY[0..1]OF BOOL; (*bytes 64-65*)
		W180SectionVisible : ARRAY[0..1]OF BOOL; (*bytes 66-67*)
		StraightSectionPositionY : REAL; (*bytes 68-71*)
		CurvePositionX : REAL; (*bytes 72-75*)
		reserved_76 : REAL; (*bytes 76-79*)
		reserved_80 : ARRAY[0..47]OF USINT; (*bytes 80-127*)
		reserved_128 : ARRAY[0..383]OF USINT; (*bytes 128-511*)
		Pallet : ARRAY[0..127]OF RoboVisuPallet_t; (*bytes 512-3071*)
	END_STRUCT;
	SectionInfo_t : 	STRUCT 
		userAddress : UINT;
		sectionType : UINT;
		side : INT;
		modelIndex : INT;
		positionX : REAL;
	END_STRUCT;
END_TYPE
