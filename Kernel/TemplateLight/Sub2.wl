(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`List`Sub2`"];


Needs["Yurie`List`"];


(* ::Section:: *)
(*Public*)


addTwo::usage =
    "add two.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


addTwo[x_Integer] :=
    addOne@addOne@x;


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
