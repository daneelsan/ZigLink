BeginTestSection["demo_string"]

(* ::Text:: *)
(*The demo_error example has examples of calling functions that trigger errors.*)

VerificationTest[(* 1 *)
	FileExistsQ[FindLibrary["demo_string"]]
	,
	True	
	,
	TestID->"482c0bcf-dd78-4f60-b621-edf65633eb69"
]

BeginTestSection["countSubstring"]

VerificationTest[(* 2 *)
	countSubstring=LibraryFunctionLoad["demo_string", "countSubstring", {"UTF8String", "UTF8String"}, Integer]
	,
	HoldPattern[LibraryFunction[_, "countSubstring", {"UTF8String", "UTF8String"}, Integer]]	
	,
	SameTest->MatchQ
]

(* ::Text:: *)
(*countSubstring[str, sub] counts the number of times a substring sub appears in a string str:*)

VerificationTest[(* 3 *)
	countSubstring["abababa", "ba"]
	,
	3	
	,
	TestID->"87583c1a-713b-4717-8d67-14921f10f361"
]

VerificationTest[(* 4 *)
	countSubstring["abababa", "bac"]
	,
	0	
	,
	TestID->"99914a42-4e71-4fab-87c2-73e40b1b6aca"
]

VerificationTest[(* 5 *)
	countSubstring["This function counts substrings", "un"]
	,
	2	
	,
	TestID->"bf105a07-f1f1-4825-9dc6-3879cb9f50f8"
]

EndTestSection[]

BeginTestSection["encodeString"]

(* ::Text:: *)
(*https://reference.wolfram.com/language/LibraryLink/tutorial/Examples.html (demo_string)*)

VerificationTest[(* 6 *)
	encodeString=LibraryFunctionLoad["demo_string", "encodeString", {"UTF8String", Integer}, "UTF8String"]
	,
	HoldPattern[LibraryFunction[_, "encodeString", {"UTF8String", Integer}, "UTF8String"]]	
	,
	SameTest->MatchQ
]

(* ::Text:: *)
(*encodeString[str, shift] does a simple shift cipher for an ASCII string str:*)

VerificationTest[(* 7 *)
	encodeString["demo_string", 1]
	,
	"efnp`tusjoh"	
	,
	TestID->"7e11619d-debf-465f-858e-6ce0af7fddd2"
]

VerificationTest[(* 8 *)
	encodeString["demo_string", -10]
	,
	"Z[ceUijh_d]"	
	,
	TestID->"2300ef00-1279-4970-bccb-d04cbbcd4b77"
]

(* ::Text:: *)
(*Non-ASCII strings are not supported:*)

VerificationTest[(* 9 *)
	encodeString["Pel\[EAcute]", 2]
	,
	LibraryFunctionError["LIBRARY_FUNCTION_ERROR", 6]	
	,
	TestID->"5e71ae60-4e9d-4a66-9e3f-772c6a946a20"
]

EndTestSection[]

BeginTestSection["reverseString"]

(* ::Text:: *)
(*https://reference.wolfram.com/language/LibraryLink/tutorial/Examples.html (demo_string)*)

VerificationTest[(* 10 *)
	reverseString=LibraryFunctionLoad["demo_string", "reverseString", {"UTF8String"}, "UTF8String"]
	,
	HoldPattern[LibraryFunction[_, "reverseString", {"UTF8String"}, "UTF8String"]]	
	,
	SameTest->MatchQ
]

(* ::Text:: *)
(*reverseString[\[OpenCurlyDoubleQuote]string\[CloseCurlyDoubleQuote]] reverses the order of the characters in the \[OpenCurlyDoubleQuote]string\[CloseCurlyDoubleQuote]:*)

VerificationTest[(* 11 *)
	reverseString["abcdef"]
	,
	"fedcba"	
	,
	TestID->"2049545c-fd41-484c-bbaf-4a3227cd9aa1"
]

(* ::Text:: *)
(*Non-ASCII strings are not supported:*)

VerificationTest[(* 12 *)
	reverseString["\[FilledDiamond]\[Alpha]\[Beta]\[Gamma]\[LongLeftRightArrow]\[ScriptCapitalA]\[ScriptCapitalB]\[ScriptCapitalC]\[ReturnIndicator]"]
	,
	LibraryFunctionError["LIBRARY_FUNCTION_ERROR", 6]	
	,
	TestID->"fc8a2424-cfb5-4712-9a66-12c65e642758"
]

(* ::Text:: *)
(*Newline (\n) counts as a single character:*)

VerificationTest[(* 13 *)
	reverseString["abc\ndef"]
	,
	"fed\ncba"	
	,
	TestID->"cf255034-d1ea-4d62-9ed5-f2d8dc4fe2c9"
]

(* ::Text:: *)
(*reverseString is its own reverse:*)

VerificationTest[(* 14 *)
	reverseString[reverseString["abcdef"]]
	,
	"abcdef"	
	,
	TestID->"e5cfd628-8440-497a-b50d-f3936521b77d"
]

EndTestSection[]

EndTestSection[]
