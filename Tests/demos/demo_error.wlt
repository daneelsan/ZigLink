BeginTestSection["demo_error"]

(* ::Text:: *)
(*The demo_error example has examples of calling functions that trigger errors.*)

VerificationTest[(* 1 *)
	FileExistsQ[FindLibrary["demo_error"]]
	,
	True	
	,
	TestID -> "ff07203c-0c0e-4463-b58b-8f171289c64a"
]

BeginTestSection["errordemo1"]

VerificationTest[(* 2 *)
	errordemo1 = LibraryFunctionLoad["demo_error",  "errordemo1", {{Integer,  _},  Integer}, 
   Real]
	,
	HoldPattern[LibraryFunction[_,  "errordemo1", {{Integer,  _},  Integer}, Real]]	
	,
	SameTest -> MatchQ
]

(* ::Text:: *)
(*The example takes an integer MTensor. The function calls MTensor_getReal which results in an error and returns a LibraryFunctionError expression:*)

VerificationTest[(* 3 *)
	errordemo1[{2,  1},  1]
	,
	LibraryFunctionError["LIBRARY_TYPE_ERROR",  1]
	,
	{LibraryFunction::typerr}
	,
	TestID -> "6131a71d-9537-4441-bacc-c87e572473e1"
]

EndTestSection[]

BeginTestSection["errordemo4"]

(* ::Text:: *)
(*This example takes a real MTensor and a part, and does various error checking before returning the specified part.*)

VerificationTest[(* 4 *)
	errordemo4 = LibraryFunctionLoad["demo_error",  "errordemo4", {{Real,  _},  Integer}, Real]
	,
	HoldPattern[LibraryFunction[_,  "errordemo4", {{Real,  _},  Integer}, Real]]	
	,
	SameTest -> MatchQ
]

(* ::Text:: *)
(*If the tensor is not a rank-1 tensor, the function issues a custom message (\[OpenCurlyDoubleQuote]rankerror\[CloseCurlyDoubleQuote]) and returns an error:*)

VerificationTest[(* 5 *)
	errordemo4[{{1.,  2.},  {3.,  4.}},  1]
	,
	LibraryFunctionError["LIBRARY_RANK_ERROR",  2]
	,
	{LibraryFunction::rankerror, LibraryFunction::rnkerr}
	,
	TestID -> "72185c8c-fe07-458a-9eec-7b5e934cf219"
]

(* ::Text:: *)
(*If the part specification is not between 1 and the length of the tensor, another custom message is issued (\[OpenCurlyDoubleQuote]outofrange\[CloseCurlyDoubleQuote]) and an error is returned:*)

VerificationTest[(* 6 *)
	errordemo4[{1.,  2., 3., 4.},  5]
	,
	LibraryFunctionError["LIBRARY_DIMENSION_ERROR",  3]
	,
	{LibraryFunction::outofrange, LibraryFunction::dimerr}
	,
	TestID -> "0c1b1959-129b-48b8-84c1-67381a34d584"
]

(* ::Text:: *)
(*If no errors are encountered, then the result is the specified tensor part:*)

VerificationTest[(* 7 *)
	errordemo4[{1.,  2., 3., 4.},  3]
	,
	3.`	
	,
	TestID -> "c9d98dc2-8e1f-42f9-92e7-49768f8ca80d"
]

EndTestSection[]

EndTestSection[]
