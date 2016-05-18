DOMAINS
 ListI = integer*
PREDICATES
 list_to_10(ListI, ListI)
 press(ListI, ListI)
CLAUSES
 list_to_10([],[]).
 list_to_10([H|T],[2|T1]) :- H>1, !, list_to_10(T, T1).
 list_to_10([H|T],[1|T1]) :- H=1, !, list_to_10(T, T1).
 list_to_10([H|T],[0|T1]) :- list_to_10(T, T1).

 press([],[]).
 press([0],[0]).
 press([1],[1]).
 press([2],[2]).
 
 press([2|[2|T]],[2|T1]) :- press([2|T],[2|T1]).
 press([1|[1|T]],[1|T1]) :- press([1|T],[1|T1]).
 press([0|[0|T]],[0|T1]) :- press([0|T],[0|T1]).
 
 press([2|[1|T]],[2|[1|T1]]) :- press([1|T],[1|T1]).
 press([1|[2|T]],[1|[2|T1]]) :- press([2|T],[2|T1]).
 
 press([2|[0|T]],[2|[0|T1]]) :- press([0|T],[0|T1]).
 press([0|[2|T]],[0|[2|T1]]) :- press([2|T],[2|T1]).
 
 press([0|[1|T]],[0|[1|T1]]) :- press([1|T],[1|T1]).
 press([1|[0|T]],[1|[0|T1]]) :- press([0|T],[0|T1]).
