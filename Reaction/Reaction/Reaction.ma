#include(macros.inc)

[top]
components : Reaction

[Reaction]
type : cell
dim : (20,20)
delay : transport
defaultDelayTime : 100
border : nowrapped 
%Von Newmann neighborhood
neighbors :                          Reaction(-1,0) 
neighbors : Reaction(0,-1)   Reaction(0,0)  Reaction(0,1) 
neighbors :                          Reaction(1,0)  

initialvalue : 0
initialvariablesvalue : reaction.stvalues %Initial value file
localtransition : Reaction-rule

%% The 'value' state variable can have values 0 to 3
%% Where Iron = 0, Carbon = 1, Oxygen = 2, Carbon Monoxide (CO) = 3
%% This variable holds the value or state of each cell
statevariables : value 
% Port for the value state variable
neighborports : valueport 
stateValues : 0

[Reaction-rule]

%Reaction rules
%If a cell with state 1 (i.e. carbon) has a cell with state 2 (i.e. oxygen) in its Newman neighbourhood, 
%then the reaction can occur and the state of cell is changed to 3 (i.e. carbon monoxide or CO).

%Case 1: Carbon has only 1 oxygen cell in its neighborhood
rule : {~valueport := $value;} {$value := 11;} 100 { (0,0)~valueport = 1  AND #macro(North) = 2 AND stateCount(2,~valueport) = 1 } %Oxygen is in the North
rule : {~valueport := $value;} {$value := 12;} 100 { (0,0)~valueport = 1  AND #macro(East) = 2 AND stateCount(2,~valueport) = 1} %Oxygen is in the East
rule : {~valueport := $value;} {$value := 13;} 100 { (0,0)~valueport = 1  AND #macro(South) = 2 AND stateCount(2,~valueport) = 1} %Oxygen is in the South
rule : {~valueport := $value;} {$value := 14;} 100 { (0,0)~valueport = 1  AND #macro(West) = 2 AND stateCount(2,~valueport) = 1} %Oxygen is in the West

%If more than one cell with state 2 is present, one of them is randomly selected for the reaction

%Case 2: Carbon has 2 oxygen cells in its neighborhood (randomly select one Oxygen cell)
rule : {~valueport := $value;} {$value := if(randInt(1) = 1, 11,12);} 100 { (0,0)~valueport = 1 AND #macro(North) = 2 AND #macro(East) = 2 AND stateCount(2,~valueport) = 2} %Oxygen is in the North and East
rule : {~valueport := $value;} {$value := if(randInt(1) = 1, 11,13);} 100 { (0,0)~valueport = 1 AND #macro(North) = 2 AND #macro(South) = 2 AND stateCount(2,~valueport) = 2} %Oxygen is in the North and South
rule : {~valueport := $value;} {$value := if(randInt(1) = 1, 11,14);} 100 { (0,0)~valueport = 1 AND #macro(North) = 2 AND #macro(West) = 2 AND stateCount(2,~valueport) = 2} %Oxygen is in the North and West
rule : {~valueport := $value;} {$value := if(randInt(1) = 1, 13,12);} 100 { (0,0)~valueport = 1 AND #macro(South) = 2 AND #macro(East) = 2 AND stateCount(2,~valueport) = 2} %Oxygen is in the South and East
rule : {~valueport := $value;} {$value := if(randInt(1) = 1, 13,14);} 100 { (0,0)~valueport = 1 AND #macro(South) = 2 AND #macro(West) = 2 AND stateCount(2,~valueport) = 2} %Oxygen is in the South and West
rule : {~valueport := $value;} {$value := if(randInt(1) = 1, 12,14);} 100 { (0,0)~valueport = 1 AND #macro(East) = 2 AND #macro(West) = 2 AND stateCount(2,~valueport) = 2} %Oxygen is in the East and West

%Case 3: Carbon has 3 oxygen cells in its neighborhood (randomly select one Oxygen cell)
%Oxygen is in the North,South and East
rule : {~valueport := $value;} {$value := if(randInt(1) = 1, if(randInt(1) = 0, 11,13), 12);} 100 { (0,0)~valueport = 1 AND #macro(North) = 2 AND #macro(South) = 2 AND #macro(East) = 2 AND stateCount(2,~valueport) = 3} 
%Oxygen is in the North,South and West
rule : {~valueport := $value;} {$value := if(randInt(1) = 1, if(randInt(1) = 0, 11,13), 14);} 100 { (0,0)~valueport = 1 AND #macro(North) = 2 AND #macro(South) = 2 AND #macro(West) = 2 AND stateCount(2,~valueport) = 3}
%Oxygen is in the North,East and West 
rule : {~valueport := $value;} {$value := if(randInt(1) = 1, if(randInt(1) = 0, 11,12), 14);} 100 { (0,0)~valueport = 1 AND #macro(North) = 2 AND #macro(East) = 2 AND #macro(West) = 2 AND stateCount(2,~valueport) = 3}
%Oxygen is in the South,East and West 
rule : {~valueport := $value;} {$value := if(randInt(1) = 1, if(randInt(1) = 0, 13,12), 14);} 100 { (0,0)~valueport = 1 AND #macro(South) = 2 AND #macro(East) = 2 AND #macro(West) = 2 AND stateCount(2,~valueport) = 3} 

%Case 4: Carbon has 4 oxygen cells in its neighborhood (randomly select one Oxygen cell)
%Oxygen is in the North,South,East and West
rule : {~valueport := $value;} {$value := round(uniform(11,14));} 100 { (0,0)~valueport = 1 AND #macro(North) = 2 AND #macro(South) = 2 AND #macro(East) = 2 AND #macro(West) = 2 AND stateCount(2,~valueport) = 4} 

%Change the reacted oxygen cells to 0
rule : {~valueport := $value;} {$value := 0;} 0 { #macro(South) = 11 } 
rule : {~valueport := $value;} {$value := 0;} 0 { #macro(West) = 12 } 
rule : {~valueport := $value;} {$value := 0;} 0 { #macro(North) = 13 } 
rule : {~valueport := $value;} {$value := 0;} 0 { #macro(East) = 14 }
 
%Change the reacted carbon cells to 3 (i.e. CO)
rule : {~valueport := $value;} {$value := 3;} 0 { (0,0)~valueport = 11 } 
rule : {~valueport := $value;} {$value := 3;} 0 { (0,0)~valueport = 12 } 
rule : {~valueport := $value;} {$value := 3;} 0 { (0,0)~valueport = 13 } 
rule : {~valueport := $value;} {$value := 3;} 0 { (0,0)~valueport = 14 }

rule : {~valueport := $value;} {$value := (0,0);} 0 {t}
