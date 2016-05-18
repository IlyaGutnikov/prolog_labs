DOMAINS
 ListI = real* 
PREDICATES
 sum(ListI, real)
 length(ListI, real)
 avr(ListI, real)
 mod(ListI, real, ListI)
 norma(ListI, real)
 prod(ListI,ListI,real)
 first_N(ListI, real, ListI)
 abs_dev2(ListI, ListI, ListI)
 kor(real,real,real,real)
 max_kor(ListI, ListI, real)
 find_maxelem(ListI, real)
 find_maxelem_re(ListI, real, real)
 indexof(real,real,ListI)
 execute
 
CLAUSES
 sum([],0).
 sum([H|T],S) :- sum(T,S2), S=S2+H.
 
 length([], 0).
 length([_|T], L) :- length(T, L_T), L=L_T+1.
 
 avr(SP,M) :- sum(SP,S), length(SP,L), M=S/L. 
 
 mod([],K,[]).
 mod([H1|T1],K,[H|T]) :- H=H1-K, mod(T1, K, T).
 
 norma([],0).
 norma([H|T],X) :- norma(T,S2), A=H*H,X=S2+A.
 
 prod([],[],0).
 prod([H|T],[H1|T1],X) :- prod(T,T1,S2), A=H*H1,X=S2+A.
 
 kor(PROD,NA,NB,Z) :- Y = PROD * PROD, X = NA * NB, Z = Y/X.
 
 max_kor(A,B,C) :- avr(A, AVRA), avr(B,AVRB), mod(A,AVRA,MODA), mod(B,AVRB,MODB), norma(MODA, NORMA),norma(MODB, NORMB),prod(MODA,MODB,PR),kor(PR,NORMA,NORMB,C). 
 
 first_N([], _, []).
 first_N(_, 0, []).
 first_N([H|T], N, [H|T1]) :- N2=N-1, first_N(T, N2, T1).
 
 abs_dev2([], [], []).
 abs_dev2(List1, List2, []) :-
  length(List1, L1), length(List2, L2),
  L1<L2.
 abs_dev2([H1|T1], List2, [H3|T3]) :-
  length(List2, L2),
  first_N([H1|T1],L2,NewList1),
  max_kor(NewList1,List2,H3),
  abs_dev2(T1, List2, T3).
  
find_maxelem([H | Tail], Max) :- find_maxelem_re(Tail, H, Max).
  find_maxelem_re([], Max, Max).
  find_maxelem_re([H | Tail], CurMax, Max) :- H > CurMax,find_maxelem_re(Tail, H, Max),!.
  find_maxelem_re([_ | Tail], CurMax, Max) :- find_maxelem_re(Tail, CurMax, Max).
  
indexof(A,0,[A|_]).
indexof(_,-1,[]).
indexof(A,D,[_|C]):- indexof(A,B,C), B > -1, D = B+1. 
indexof(A,D,[_|C]):- indexof(A,B,C), B = -1, D = B.
  
  execute:-abs_dev2([6,7,4,300,200,100,1,2,4],[1,2,4],K), find_maxelem(K,M),write(K), nl,write(M),nl,indexof(M,B,K),write(B),nl.

GOAL
execute.
