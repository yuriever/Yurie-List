(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`List`Association`"];


Needs["Yurie`List`"];


(* ::Section:: *)
(*Public*)


associationTranspose::usage =
    "GeneralUtilities`AssociationTranspose.";

associationFromTable::usage =
    "transform a two-dimensional table to dataset.";

associationDiff::usage =
    "compare in the two associations which elements are added, removed and changed.";

associationInvert::usage =
    "invert keys and values in rule, rule list or association.";

mergeByKey::usage =
    "merge a list of associations using different merge functions according to keys.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


(* ::Subsubsection:: *)
(*associationTranspose*)


associationTranspose :=
    GeneralUtilities`AssociationTranspose;


(* ::Subsubsection:: *)
(*associationFromTable*)


associationFromTable[row_List,column_List][table_]/;Dimensions@table==={Length@row,Length@column} :=
    table//Map[AssociationThread[column,#]&]//AssociationThread[row,#]&;

associationFromTable[row_List,None][table_]/;First@Dimensions@table===Length@row :=
    table//AssociationThread[row,#]&;

associationFromTable[None,column_List][table_]/;Last@Dimensions@table===Length@column :=
    table//Map[AssociationThread[column,#]&]

associationFromTable[__][_] :=
    Failure["DimensionNotMatch",<|
        "MessageTemplate"->"The dimensions of row/column and table do not match."
    |>];


(* ::Subsubsection:: *)
(*associationDiff*)


associationDiff[assoc1_,assoc2_] :=
    Module[ {keyList1,keyList2},
        keyList1 =
            Keys@assoc1;
        keyList2 =
            Keys@assoc2;
        <|
            "Added"->Complement[keyList2,keyList1],
            "Removed"->Complement[keyList1,keyList2],
            "Changed"->Select[
                Intersection[keyList1,keyList2],
                UnsameQ[assoc1[#],assoc2[#]]&
            ]
        |>
    ];


(* ::Subsubsection:: *)
(*associationInvert*)


associationInvert[Verbatim[Rule][key_,value_]] :=
    value->key;

associationInvert[ruleList:{___Rule}] :=
    Reverse[ruleList,2];

associationInvert[assoc_Association] :=
    AssociationThread[Values@assoc,Keys@assoc];


(* ::Subsubsection:: *)
(*mergeByKey*)


mergeByKey[ruleList:{___Rule},default:_:Identity][assocList:{___Association}] :=
    mergeByKeyKernel[assocList,ruleList,default];

mergeByKey[assocList:{___Association},ruleList:{___Rule},default:_:Identity] :=
    mergeByKeyKernel[assocList,ruleList,default];


mergeByKeyKernel[{<||>...},_,_] :=
    <||>;

mergeByKeyKernel[assocList_,{},Identity] :=
    (*in this case queryRuleList=={}, and Query[{}][...] will unexpectedly return an empty association.*)
    getTransposedAssocListAndKeyList[assocList,{}]//First;

mergeByKeyKernel[assocList_,ruleList_,default_] :=
    Module[ {keyList,dataMerged,queryRuleList},
        {dataMerged,keyList} =
            getTransposedAssocListAndKeyList[assocList,ruleList];
        queryRuleList =
            prepareQueryRuleList[ruleList,keyList,default];
        Query[queryRuleList]@dataMerged
    ];


getTransposedAssocListAndKeyList[assocList_,ruleList_] :=
    Module[ {keyList,keyListList,dataPadded,dataMerged,missing},
        keyListList =
            Keys[assocList];
        (*pad the list of associations by the placeholder missing if necessary.*)
        If[ SameQ@@keyListList,
            keyList =
                First@keyListList;
            dataMerged =
                AssociationThread[
                    keyList,
                    Transpose@Values[assocList]
                ],
            (*Else*)
            dataPadded =
                KeyUnion[assocList,missing&];
            keyList =
                Keys@First@dataPadded;
            dataMerged =
                AssociationThread[
                    keyList,
                    DeleteCases[Transpose@Values[dataPadded],missing,{2}]
                ];
        ];
        {dataMerged,Key/@keyList}
    ];


(*prepare the rules for query and delete the unnecessary Identity query.*)

prepareQueryRuleList[ruleList_,keyList_,default_] :=
    DeleteCases[
        Thread[
            keyList->Lookup[ruleList,keyList,default]
        ],
        _->Identity
    ];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
