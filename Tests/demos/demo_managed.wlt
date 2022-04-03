BeginTestSection["demo_managed"]

(* ::Text:: *)
(*The demo_error example has examples of calling functions that trigger errors.*)

VerificationTest[(* 1 *)
	FileExistsQ[FindLibrary["demo_managed"]]
	,
	True	
	,
	TestID->"bda7d1fa-6fa2-4676-a3d6-d7bcb0ce1728"
]

(* ::Text:: *)
(*The following loads the library (the registration of the manager with name \[OpenCurlyDoubleQuote]LCG\[CloseCurlyDoubleQuote] is done when the library is first loaded) and defines several LibraryFunctions that manipulate instances:*)

VerificationTest[(* 2 *)
	setInstanceState=LibraryFunctionLoad["demo_managed", "setInstanceState", {Integer, {Integer, 1}}, "Void"]
	,
	HoldPattern[LibraryFunction[_, "setInstanceState", {Integer, {Integer, 1}}, {}]]	
	,
	SameTest->MatchQ, TestID->"977ee09c-e62a-478f-b0da-82973aa77c06"
]

VerificationTest[(* 3 *)
	getInstanceState=LibraryFunctionLoad["demo_managed", "getInstanceState", {{Integer}}, {Integer, 1}]
	,
	HoldPattern[LibraryFunction[_, "getInstanceState", {Integer}, {Integer, 1}]]	
	,
	SameTest->MatchQ, TestID->"9b03425d-85e9-425c-9e7e-7af82dcff7c7"
]

VerificationTest[(* 4 *)
	releaseInstance=LibraryFunctionLoad["demo_managed", "releaseInstance", {{Integer}}, "Void"]
	,
	HoldPattern[LibraryFunction[_, "releaseInstance", {Integer}, {}]]	
	,
	SameTest->MatchQ, TestID->"fb0f6932-1c6b-44c6-bea8-779c7dc6c46a"
]

VerificationTest[(* 5 *)
	generateFromInstance=LibraryFunctionLoad["demo_managed", "generateFromInstance", {Integer, {Integer, _}}, {Real, _}]
	,
	HoldPattern[LibraryFunction[_, "generateFromInstance", {Integer, {Integer, _}}, {Real, _}]]	
	,
	SameTest->MatchQ, TestID->"3e50de85-b794-43b3-81cb-553528b6f393"
]

VerificationTest[(* 6 *)
	getAllInstanceIDs=LibraryFunctionLoad["demo_managed", "getAllInstanceIDs", {}, {Integer, 1}]
	,
	HoldPattern[LibraryFunction[_, "getAllInstanceIDs", {}, {Integer, 1}]]	
	,
	SameTest->MatchQ, TestID->"b95e2bc6-2704-48f2-8f0e-f792f87eb9d8"
]

(* ::Text:: *)
(*The following makes several definitions to set up an expression type with head LCG that will be used as a handle to an instance:*)

VerificationTest[(* 7 *)
	LCGQ[e_]:=ManagedLibraryExpressionQ[e, "LCG"];instanceID[inst_]:=ManagedLibraryExpressionID[inst, "LCG"];CreateLCG[a_Integer, c_Integer, m_Integer, x_Integer]:=
Module[{res}, 
res=CreateManagedLibraryExpression["LCG", LCG];
setInstanceState[instanceID[res], {a, c, m, x}];
res
];ListLCGs[]:=Map[LCG[#]->getInstanceState[#]&, getAllInstanceIDs[]];
	,
	Null	
	,
	TestID->"783624ad-899f-4cc7-8147-a6d67902a104"
]

(* ::Text:: *)
(*Finally, this defines the \[OpenCurlyDoubleQuote]random\[CloseCurlyDoubleQuote] number generator:*)

VerificationTest[(* 8 *)
	LCGRandom[inst_?LCGQ]:=LCGRandom[inst, {}];LCGRandom[inst_?LCGQ, len_Integer]:=LCGRandom[inst, {len}];LCGRandom[inst_?LCGQ, dims:{(_Integer?Positive)...}]:=
Module[{id=instanceID[inst]}, 
generateFromInstance[id, dims]
];
	,
	Null	
	,
	TestID->"f2431a9b-8a11-4315-8eda-d8d1a1ec8fbb"
]

(* ::Text:: *)
(*This sets up an instance (the parameters come from Numerical Recipes (1992)), tests it, and generates a number from it:*)

VerificationTest[(* 9 *)
	g=CreateLCG[1664525, 1013904223, 2^32, 0]
	,
	LCG[1]	
	,
	TestID->"aa16798d-0b3c-4752-b35e-b0b02fd7ab6b"
]

VerificationTest[(* 10 *)
	LCGQ[g]
	,
	True	
	,
	TestID->"7414bd17-6bbb-44ea-a4f6-b0e7c1ce02b4"
]

VerificationTest[(* 11 *)
	LCGRandom[g]
	,
	0.23606797284446657	
	,
	TestID->"42d1c248-b66d-4415-8589-3a5ea58d0bc5"
]

(* ::Text:: *)
(*This sets up another instance and generates two numbers from it. Note that the ID is unique:*)

VerificationTest[(* 12 *)
	g1=CreateLCG[1664525, 1013904223, 2^32, 0]
	,
	LCG[2]	
	,
	TestID->"4f9860b8-e2b9-43d1-b83f-a72399f97a01"
]

VerificationTest[(* 13 *)
	LCGRandom[g1, 2]
	,
	{0.23606797284446657, 0.278566908556968}	
	,
	TestID->"c18a469b-cba7-41f3-9f61-1f4653b6baaf"
]

(* ::Text:: *)
(*This shows all the instances with their states:*)

VerificationTest[(* 14 *)
	ListLCGs[]
	,
	{LCG[1]->{1664525, 1013904223, 4294967296, 1013904223}, LCG[2]->{1664525, 1013904223, 4294967296, 1196435762}}	
	,
	TestID->"c554088f-39b9-423f-8541-cdfef766b362"
]

(* ::Text:: *)
(*The following sets up a third instance, but being careful to be sure that the assignment is the only reference to the instance expression and use it to generate a matrix:*)

VerificationTest[(* 15 *)
	g2=CreateLCG[1664525, 1013904223, 2^32, 0]
	,
	LCG[3]	
	,
	TestID->"68ffb9b6-631a-4dca-b9cf-8c6f0cdad4eb"
]

VerificationTest[(* 16 *)
	LCGRandom[g2, {2, 2}]
	,
	{{0.23606797284446657, 0.278566908556968}, {0.8195337599609047, 0.6678668977692723}}	
	,
	TestID->"f74dbc54-9b0a-45ab-9d50-56958199dd9d"
]

(* ::Text:: *)
(*The following releases the second instance:*)

VerificationTest[(* 17 *)
	releaseInstance[2]
	,
	Null	
	,
	TestID->"44812779-b424-468a-a84d-7ab6984a8baa"
]

VerificationTest[(* 18 *)
	ListLCGs[]
	,
	{LCG[1]->{1664525, 1013904223, 4294967296, 1013904223}, LCG[3]->{1664525, 1013904223, 4294967296, 2868466484}}	
	,
	TestID->"aff2e5ed-0d3f-4694-abe8-86991ce509a5"
]

(* ::Text:: *)
(*Unsetting the value of g2 takes away all references to the third instance, and the manage_instance function is automatically called, removing the instance from the hashmap:*)

VerificationTest[(* 19 *)
	g2=.;
	,
	Null	
	,
	TestID->"64927a6a-b8ba-448b-a862-76064b8faa68"
]

VerificationTest[(* 20 *)
	ListLCGs[]
	,
	{LCG[1]->{1664525, 1013904223, 4294967296, 1013904223}}	
	,
	TestID->"df6af996-f6e7-41f9-b852-705262f74251"
]

(* ::Text:: *)
(*When the library is unloaded, the remaining instances will be removed so g is no longer a managed library expression:*)

VerificationTest[(* 21 *)
	LCGQ[g]
	,
	True	
	,
	TestID->"67366e6c-ce44-4a0e-9033-6bf79485c494"
]

VerificationTest[(* 22 *)
	LibraryUnload["demo_managed"];LCGQ[g]
	,
	False	
	,
	TestID->"ecbe9156-2904-421f-8fab-ec0440ccde13"
]

EndTestSection[]
