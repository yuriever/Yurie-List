

(*List.nb*)

VerificationTest[
	Begin["Global`"];
	ClearAll["`*"]
	,
	Null
	,
	TestID->"0-List.nb"
]

VerificationTest[
	Get["Yurie`List`"]
	,
	Null
	,
	TestID->"1-List.nb"
]

VerificationTest[
	complementSet[{a, a}, {a}]
	,
	{}
	,
	TestID->"2-List.nb"
]

VerificationTest[
	complementSet[{a -> 1, b -> 2}, {a -> 1}]
	,
	{b -> 2}
	,
	TestID->"3-List.nb"
]

VerificationTest[
	complementList[{y, x, z, x}, {x, w}]
	,
	{y, z, x}
	,
	TestID->"4-List.nb"
]

VerificationTest[
	complementList[{a -> 1, b -> 2}, {a -> 1}]
	,
	{b -> 2}
	,
	TestID->"5-List.nb"
]

VerificationTest[
	splitHoldSequence[HoldComplete[1 + 1, 2 + 2]]
	,
	{HoldComplete[1 + 1], HoldComplete[2 + 2]}
	,
	TestID->"6-List.nb"
]

VerificationTest[
	associationTranspose[{Association[a -> 1, b -> 1], Association[a -> 2, b -> 2], Association[a -> 3, b -> 3]}]
	,
	Association[a -> {1, 2, 3}, b -> {1, 2, 3}]
	,
	TestID->"7-List.nb"
]

VerificationTest[
	associationTranspose[Association[a -> {1, 2, 3}, b -> {1, 2, 3}]]
	,
	{Association[a -> 1, b -> 1], Association[a -> 2, b -> 2], Association[a -> 3, b -> 3]}
	,
	TestID->"8-List.nb"
]

VerificationTest[
	associationTranspose[Association[x -> Association[a -> 1, b -> 1], y -> Association[a -> 2, b -> 2], z -> Association[a -> 3, b -> 3]]]
	,
	Association[a -> Association[x -> 1, y -> 2, z -> 3], b -> Association[x -> 1, y -> 2, z -> 3]]
	,
	TestID->"9-List.nb"
]

VerificationTest[
	mergeByKey[{a -> f, b -> g}][{Association[a -> 1, b -> 1, c -> 1], Association[a -> 2, b -> 2], Association[a -> 3, b -> 3]}]
	,
	Association[a -> f[{1, 2, 3}], b -> g[{1, 2, 3}], c -> {1}]
	,
	TestID->"10-List.nb"
]

VerificationTest[
	mergeByKey[{a -> f}, g][{Association[a -> 1, b -> 1, c -> 1], Association[a -> 2, b -> 2], Association[a -> 3, b -> 3]}]
	,
	Association[a -> f[{1, 2, 3}], b -> g[{1, 2, 3}], c -> g[{1}]]
	,
	TestID->"11-List.nb"
]

VerificationTest[
	mergeByKey[{}][{Association[a -> 1], Association[a -> 2]}]
	,
	Association[a -> {1, 2}]
	,
	TestID->"12-List.nb"
]

VerificationTest[
	mergeByKey[{}][{}]
	,
	Association[]
	,
	TestID->"13-List.nb"
]

VerificationTest[
	list1 = {"f", "g"}; 
	list2 = {"x", "y", "z"}; 
	(data = Outer[StringJoin, list1, list2]; )
	,
	Null
	,
	TestID->"14-List.nb"
]

VerificationTest[
	associationFromTable[list1, list2][data]
	,
	Association["f" -> Association["x" -> "fx", "y" -> "fy", "z" -> "fz"], "g" -> Association["x" -> "gx", "y" -> "gy", "z" -> "gz"]]
	,
	TestID->"15-List.nb"
]

VerificationTest[
	associationFromTable[list1, None][data]
	,
	Association["f" -> {"fx", "fy", "fz"}, "g" -> {"gx", "gy", "gz"}]
	,
	TestID->"16-List.nb"
]

VerificationTest[
	associationFromTable[None, list2][data]
	,
	{Association["x" -> "fx", "y" -> "fy", "z" -> "fz"], Association["x" -> "gx", "y" -> "gy", "z" -> "gz"]}
	,
	TestID->"17-List.nb"
]

VerificationTest[
	ClearAll["`*"];
	End[]
	,
	"Global`"
	,
	TestID->"∞-List.nb"
]