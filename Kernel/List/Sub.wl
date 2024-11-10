(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["Yurie`List`Sub`"];


Needs["Yurie`List`"];

Needs["Yurie`List`Common`"];


(* ::Section:: *)
(*Public*)


addOne::usage =
    "add one.";


(* ::Section:: *)
(*Private*)


(* ::Subsection:: *)
(*Begin*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Main*)


addOne[x_Integer] :=
    adder@x;


(* ::Subsection:: *)
(*End*)


End[];


(* ::Section:: *)
(*End*)


EndPackage[];
