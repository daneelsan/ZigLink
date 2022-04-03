BeginTestSection["demo_numericarray"]

(* ::Text:: *)
(*The demo_error example has examples of calling functions that trigger errors.*)

VerificationTest[(* 1 *)
	FileExistsQ[FindLibrary["demo_numericarray"]]
	,
	True	
	,
	TestID->"f5e8fe26-9b75-4c86-8791-c53886331a7a"
]

BeginTestSection["numericArrayReverse"]

VerificationTest[(* 2 *)
	numericArrayReverse=LibraryFunctionLoad["demo_numericarray", "numericArrayReverse", {{NumericArray, "Constant"}}, {NumericArray}]
	,
	HoldPattern[LibraryFunction[_, "numericArrayReverse", {{NumericArray, "Constant"}}, NumericArray]]	
	,
	SameTest->MatchQ
]

(* ::Text:: *)
(*numericArrayReverse[na] reverses the contents of a rank-1 NumericArray na (for all types):*)

VerificationTest[(* 3 *)
	Normal[numericArrayReverse[NumericArray[Range[5]]]]
	,
	{5, 4, 3, 2, 1}	
	,
	TestID->"bf42ff93-4caa-4513-be78-6f176f58d8c5"
]

VerificationTest[(* 4 *)
	Normal[numericArrayReverse[NumericArray[{1.5, 4.5, 6.7}]]]
	,
	{6.7, 4.5, 1.5}	
	,
	TestID->"e04d344b-b489-4595-b486-1f652bf3ec45"
]

VerificationTest[(* 5 *)
	Normal[numericArrayReverse[ByteArray[{127, 128, 129, 130}]]]
	,
	{130, 129, 128, 127}	
	,
	TestID->"c8543ce3-8d32-4d66-80e1-ca43d349f6f8"
]

VerificationTest[(* 6 *)
	Normal[numericArrayReverse[NumericArray[{1 + I, 3.5 - 2*I}]]]
	,
	{3.5 - 2.*I, 1. + 1.*I}	
	,
	TestID->"a79067ad-5dd0-40f8-bde2-779b00343b6f"
]

(* ::Text:: *)
(*NumericArrays of rank greater than 1 are not supported:*)

VerificationTest[(* 7 *)
	numericArrayReverse[NumericArray[{{1, 2}, {3, 4}}]]
	,
	LibraryFunctionError["LIBRARY_RANK_ERROR", 2]
	,
	{LibraryFunction::rnkerr}
	,
	TestID->"73c9b755-6c23-4464-8c9b-c8fbce346e89"
]

EndTestSection[]

BeginTestSection["numericArrayComplexConjugate"]

VerificationTest[(* 8 *)
	numericArrayComplexConjugate=LibraryFunctionLoad["demo_numericarray", "numericArrayComplexConjugate", {{NumericArray, "Constant"}}, {NumericArray}]
	,
	HoldPattern[LibraryFunction[_, "numericArrayComplexConjugate", {{NumericArray, "Constant"}}, NumericArray]]	
	,
	SameTest->MatchQ
]

(* ::Text:: *)
(*numericArrayComplexConjugate[na] computes the complex conjugate of each element in a NumericArray na:*)

VerificationTest[(* 9 *)
	Normal[numericArrayComplexConjugate[NumericArray[{1 + I, 3.5 - 2*I}]]]
	,
	{1. - 1.*I, 3.5 + 2.*I}	
	,
	TestID->"65da9cb1-ac95-4b51-95ee-a49e34c829fb"
]

VerificationTest[(* 10 *)
	numericArrayComplexConjugate[NumericArray[{{1 + I, 6.5 - 3*I}, {3.5 - 2*I, 4*I}}, "ComplexReal32"]]
	,
	RawArray["Complex64", {{1. - 1.*I, 6.5 + 3.*I}, {3.5 + 2.*I, 0. - 4.*I}}]	
	,
	TestID->"e262a8ca-2d35-413b-8903-56ffc1a8ebd1"
]

(* ::Text:: *)
(*NumericArrays of non-complex types are converted to MNumericArray_Type_Complex_Real64:*)

VerificationTest[(* 11 *)
	Normal[numericArrayComplexConjugate[NumericArray[Range[5]]]]
	,
	{1. + 0.*I, 2. + 0.*I, 3. + 0.*I, 4. + 0.*I, 5. + 0.*I}	
	,
	TestID->"fff692e7-bdf2-48ba-ae58-43f78a401567"
]

VerificationTest[(* 12 *)
	numericArrayComplexConjugate[NumericArray[{1, 2, 3}, "Integer16"]]
	,
	RawArray["Complex128", {1. + 0.*I, 2. + 0.*I, 3. + 0.*I}]	
	,
	TestID->"9550e759-7463-45d2-a6cb-72ad7fbf8d4a"
]

VerificationTest[(* 13 *)
	numericArrayComplexConjugate[ByteArray[{127, 128, 129, 130}]]
	,
	RawArray["Complex128", {127. + 0.*I, 128. + 0.*I, 129. + 0.*I, 130. + 0.*I}]	
	,
	TestID->"a2f305f0-2802-41ec-a189-9c8457b01e36"
]

EndTestSection[]

BeginTestSection["readBytesFromFile"]

VerificationTest[(* 14 *)
	readBytesFromFile=LibraryFunctionLoad["demo_numericarray", "readBytesFromFile", {"UTF8String"}, {ByteArray}]
	,
	HoldPattern[LibraryFunction[_, "readBytesFromFile", {"UTF8String"}, ByteArray]]	
	,
	SameTest->MatchQ
]

(* ::Text:: *)
(*readBytesFromFile[filename] reads all bytes from the specified file and returns them as ByteArray:*)

VerificationTest[(* 15 *)
	ba=readBytesFromFile[FindFile["ExampleData/rose.gif"]]
	,
	ByteArray["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"]	
	,
	TestID->"385d2a1a-02d3-4a55-9fb9-b0e4822eb4ea"
]

EndTestSection[]

EndTestSection[]
