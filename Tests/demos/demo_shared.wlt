BeginTestSection["demo_shared"]

VerificationTest[(* 1 *)
	FileExistsQ[FindLibrary["demo_shared"]]
	,
	True	
	,
	TestID -> "8b5e8542-fded-4e86-98f8-6e45d51733c9"
]

VerificationTest[(* 2 *)
	loadArray = LibraryFunctionLoad["demo_shared",  "loadArray", {{Real,  _, "Shared"}}, 
   Integer]
	,
	HoldPattern[LibraryFunction[_,  "loadArray", {{Real,  _, "Shared"}}, Integer]]	
	,
	SameTest -> MatchQ,  TestID -> "4dbd9b87-12c9-451c-bdf6-1e8fa8a2a891"
]

VerificationTest[(* 3 *)
	unloadArray = LibraryFunctionLoad["demo_shared",  "unloadArray", {}, Integer]
	,
	HoldPattern[LibraryFunction[_,  "unloadArray", {}, Integer]]	
	,
	SameTest -> MatchQ,  TestID -> "aae11e5d-5b0f-4e20-b82e-1ec3da8389c3"
]

VerificationTest[(* 4 *)
	getArray = LibraryFunctionLoad["demo_shared",  "getArray", {}, {Real,  _, "Shared"}]
	,
	HoldPattern[LibraryFunction[_,  "getArray", {}, {Real,  _, "Shared"}]]	
	,
	SameTest -> MatchQ,  TestID -> "be0c4a41-a33e-4401-9351-0df5b2cc817d"
]

VerificationTest[(* 5 *)
	getElementVector = LibraryFunctionLoad["demo_shared",  "getElementVector", {Integer}, 
   Real]
	,
	HoldPattern[LibraryFunction[_,  "getElementVector", {Integer}, Real]]	
	,
	SameTest -> MatchQ,  TestID -> "02772ed3-f845-4b70-bd52-209137fb07df"
]

VerificationTest[(* 6 *)
	setElementVector = LibraryFunctionLoad["demo_shared",  "setElementVector", 
   {Integer,  Real}, Integer]
	,
	HoldPattern[LibraryFunction[_,  "setElementVector", {Integer,  Real}, Integer]]	
	,
	SameTest -> MatchQ,  TestID -> "bb0c4814-7647-4ef3-a62a-7d27c680dea7"
]

VerificationTest[(* 7 *)
	getElement = LibraryFunctionLoad["demo_shared",  "getElement", {Integer,  Integer}, Real]
	,
	HoldPattern[LibraryFunction[_,  "getElement", {Integer,  Integer}, Real]]	
	,
	SameTest -> MatchQ,  TestID -> "2497c228-4be3-44f4-b6df-941bee16c0cf"
]

VerificationTest[(* 8 *)
	setElement = LibraryFunctionLoad["demo_shared",  "setElement", {Integer,  Integer, Real}, 
   Integer]
	,
	HoldPattern[LibraryFunction[_,  "setElement", {Integer,  Integer, Real}, Integer]]	
	,
	SameTest -> MatchQ,  TestID -> "fcde98c0-a28f-44e4-b65b-ce54ec9ea062"
]

(* ::Text:: *)
(*Create a packed array of reals:*)

(* ::Text:: *)
(*Load the array into the library:*)

VerificationTest[(* 9 *)
	array = Range[1., 20]; 
loadArray[array]
	,
	0	
	,
	TestID -> "dc3ba0c1-7e80-40e6-a3d2-0fabd4093fcb"
]

(* ::Text:: *)
(*Since shared memory passing was used, the array can be used in other function calls.*)

VerificationTest[(* 10 *)
	getElementVector[10]
	,
	10.`	
	,
	TestID -> "efc3c295-f9f4-4e18-927e-1b29df25c90f"
]

VerificationTest[(* 11 *)
	setElementVector[10,  20.]
	,
	0	
	,
	TestID -> "b3452bba-1752-487f-8a29-a37cc5ac1e30"
]

VerificationTest[(* 12 *)
	array[[10]]
	,
	20.`	
	,
	TestID -> "1f51b989-cbd6-4483-a5d7-0b783d2b7f11"
]

(* ::Text:: *)
(*This unloads the array; after this the array cannot be used any more:*)

VerificationTest[(* 13 *)
	unloadArray[]
	,
	0	
	,
	TestID -> "1e5e2b60-0a8b-4f68-b041-2f0b95ce5462"
]

(* ::Text:: *)
(*Create and load a 2d array into the library*)

VerificationTest[(* 14 *)
	array = ConstantArray[0., {5, 10}]; 
loadArray[array]
	,
	0	
	,
	TestID -> "0915780b-ee94-40e3-9054-29b671b4dbd0"
]

(* ::Text:: *)
(*Get the element at position {3, 3}:*)

VerificationTest[(* 15 *)
	array[[3, 3]] === getElement[3,  3]
	,
	True	
	,
	TestID -> "f99e80c0-edf1-40ac-8925-773eb146bec7"
]

(* ::Text:: *)
(*Set the element at position {3, 3} to -1.:*)

VerificationTest[(* 16 *)
	setElement[3,  3, -1.]
	,
	0	
	,
	TestID -> "eae403d1-6758-41e1-9b57-7c4ff6938a5f"
]

VerificationTest[(* 17 *)
	array[[3, 3]]
	,
	-1.	
	,
	TestID -> "e897ac3e-0b3a-4862-95cf-a548a990dc3c"
]

(* ::Text:: *)
(*Get the shared array from the library:*)

VerificationTest[(* 18 *)
	getArray[]
	,
	{{0.,  0., 0., 0., 0., 0., 0., 0., 0., 0.},  {0.,  0., 0., 0., 0., 0., 0., 0., 0., 0.}, 
  {0.,  0., -1., 0., 0., 0., 0., 0., 0., 0.}, {0.,  0., 0., 0., 0., 0., 0., 0., 0., 0.}, 
  {0.,  0., 0., 0., 0., 0., 0., 0., 0., 0.}}	
	,
	TestID -> "45dca82f-3166-4605-b47c-36043aec89e2"
]

EndTestSection[]
