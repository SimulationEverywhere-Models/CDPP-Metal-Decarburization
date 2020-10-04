
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
localtransition : Reaction-rule
initialCellsValue : Reaction.val %Initial value file

[Reaction-rule]
%%%% Iron = 0, Carbon = 1, Oxygen = 2, Carbon Monoxide (CO) = 3

%Reaction rules
%If a cell with state 1 (i.e. carbon) has a cell with state 2 (i.e. oxygen) in its Newman neighbourhood, 
%then the reaction can occur and the state of cell is changed to 3 (i.e. carbon monoxide or CO).

%Case 1: Carbon has only 1 oxygen cell in its neighborhood
rule : {11} 100 { (0,0) = 1  AND #macro(North) = 2 AND stateCount(2) = 1 } %Oxygen is in the North
rule : {12} 100 { (0,0) = 1  AND #macro(East) = 2 AND stateCount(2) = 1} %Oxygen is in the East
rule : {13} 100 { (0,0) = 1  AND #macro(South) = 2 AND stateCount(2) = 1} %Oxygen is in the South
rule : {14} 100 { (0,0) = 1  AND #macro(West) = 2 AND stateCount(2) = 1} %Oxygen is in the West

%If more than one cell with state 2 is present, one of them is randomly selected for the reaction

%Case 2: Carbon has 2 oxygen cells in its neighborhood (randomly select one Oxygen cell)
rule : { if(randInt(1) = 1, 11,12) } 100 { (0,0) = 1 AND #macro(North) = 2 AND #macro(East) = 2 AND stateCount(2) = 2} %Oxygen is in the North and East
rule : { if(randInt(1) = 1, 11,13) } 100 { (0,0) = 1 AND #macro(North) = 2 AND #macro(South) = 2 AND stateCount(2) = 2} %Oxygen is in the North and South
rule : { if(randInt(1) = 1, 11,14) } 100 { (0,0) = 1 AND #macro(North) = 2 AND #macro(West) = 2 AND stateCount(2) = 2} %Oxygen is in the North and West
rule : { if(randInt(1) = 1, 13,12) } 100 { (0,0) = 1 AND #macro(South) = 2 AND #macro(East) = 2 AND stateCount(2) = 2} %Oxygen is in the South and East
rule : { if(randInt(1) = 1, 13,14) } 100 { (0,0) = 1 AND #macro(South) = 2 AND #macro(West) = 2 AND stateCount(2) = 2} %Oxygen is in the South and West
rule : { if(randInt(1) = 1, 12,14) } 100 { (0,0) = 1 AND #macro(East) = 2 AND #macro(West) = 2 AND stateCount(2) = 2} %Oxygen is in the East and West

%Case 3: Carbon has 3 oxygen cells in its neighborhood (randomly select one Oxygen cell)
rule : { if(randInt(1) = 1, if(randInt(1) = 0, 11,13), 12) } 100 { (0,0) = 1 AND #macro(North) = 2 AND #macro(South) = 2 AND #macro(East) = 2 AND stateCount(2) = 3} %Oxygen is in the North,South and East
rule : { if(randInt(1) = 1, if(randInt(1) = 0, 11,13), 14) } 100 { (0,0) = 1 AND #macro(North) = 2 AND #macro(South) = 2 AND #macro(West) = 2 AND stateCount(2) = 3} %Oxygen is in the North,South and West
rule : { if(randInt(1) = 1, if(randInt(1) = 0, 11,12), 14) } 100 { (0,0) = 1 AND #macro(North) = 2 AND #macro(East) = 2 AND #macro(West) = 2 AND stateCount(2) = 3} %Oxygen is in the North,East and West
rule : { if(randInt(1) = 1, if(randInt(1) = 0, 13,12), 14) } 100 { (0,0) = 1 AND #macro(South) = 2 AND #macro(East) = 2 AND #macro(West) = 2 AND stateCount(2) = 3} %Oxygen is in the South,East and West

%Case 4: Carbon has 4 oxygen cells in its neighborhood (randomly select one Oxygen cell)
rule : { round(uniform(11,14)) } 100 { (0,0) = 1 AND #macro(North) = 2 AND #macro(South) = 2 AND #macro(East) = 2 AND #macro(West) = 2 AND stateCount(2) = 4} %Oxygen is in the North,South,East and West

%Change the reacted oxygen cells to 0
rule : {0} 0 { #macro(South) = 11 } 
rule : {0} 0 { #macro(West) = 12 } 
rule : {0} 0 { #macro(North) = 13 } 
rule : {0} 0 { #macro(East) = 14 }
 
%Change the reacted carbon cells to 3 (i.e. CO)
rule : {3} 0 { (0,0) = 11 } 
rule : {3} 0 { (0,0) = 12 } 
rule : {3} 0 { (0,0) = 13 } 
rule : {3} 0 { (0,0) = 14 }

rule : {(0,0)} 0 { t }
