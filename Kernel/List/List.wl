(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`List`List`"];


Needs["Yurie`List`"];


(* ::Section:: *)
(*Public*)


complementSet::usage =
    "complement of sets that keeps element ordering.";

complementList::usage =
    "complement of lists.";

splitHoldSequence::usage =
    "split Hold[exprs___] into list of Hold[expr].";

deleteEmptyList::usage =
    "delete all empty list in expressions.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


(* ::Subsubsection:: *)
(*complement*)


complementSet[list1_List,list2_List] :=
    DeleteCases[list1,Alternatives@@list2];

(*complementSet[list1_List,rulelist:{(_Rule|_RuleDelayed)..}] :=
    DeleteCases[list1,Alternatives@@Verbatim/@rulelist];*)


(* ::Subsubsection:: *)
(*complementList*)


complementList[list1_List,list2_List]/;Length[list1]<=32 :=
    Fold[
        Function[{list,tallied},DeleteCases[list,tallied[[1]],{1},tallied[[2]]]],
        list1,
        Tally@list2
    ];


complementList[list1_List,list2_List]/;Length[list1]>32 :=
    With[ {t1 = 2Tally[list1],t2 = Tally@Join[list1,list2]},
        {
            t2[[;;Length@t1,1]],
            t1[[All,2]]-t2[[;;Length@t1,2]]
        }//Transpose//Pick[#,Sign@#[[All,2]],1]&//MapApply[ConstantArray]//Apply[Join]//Sort
    ];


(* ::Subsubsection:: *)
(*splitHoldSequence*)


splitHoldSequence[(fun:Hold|HoldComplete)[args___]] :=
    List@@Map[fun,HoldComplete[args]];


(* ::Subsubsection:: *)
(*deleteEmptyList*)


deleteEmptyList[expr_] :=
    expr//ReplaceRepeated[list_List:>DeleteCases[list,{},All]];


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
