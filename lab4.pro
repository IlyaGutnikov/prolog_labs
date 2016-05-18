predicates

isnamefunc(symbol)
istype(symbol)
%isparam(symbol)
isspace(symbol)
isleftbrac(symbol)
isrightbrac(symbol)
iscomma(symbol)

word(symbol, integer, integer)

nondeterm namefunc(integer, integer, symbol)
nondeterm type(integer, integer, symbol)
nondeterm parameters(integer, integer, integer, symbol)
nondeterm space(integer, integer, symbol)
nondeterm leftbrac(integer, integer, symbol)
nondeterm rightbrac(integer, integer, symbol)
nondeterm comma(integer, integer, symbol)
nondeterm parameter(integer, integer, symbol)

s(integer, integer, string)
nr(integer, integer, string) %name + result
brac(integer, integer, string) %inside brac

clauses


word(int, 1, 2).
word(space, 2, 3).
word(fun2, 3, 4).
word(leftbracket, 4, 5).
word(float, 5, 6).
word(space, 6, 7).
word(val1, 7, 8).
word(comma, 8, 9).
word(space, 9, 10).
word(char, 10, 11).
word(rightbracket, 11, 12).


s(P1,P3,Result) :- nr(P1,P2,NR), brac(P2,P3,BR), format(Result,"s(%s,%s)", NR, BR).
nr(P1,P4,Result) :- type(P1,P2,Type), space(P2,P3,Space), namefunc(P3,P4,Name),format(Result,"name(%s),result(%s)",Name, Type).
brac(P1,P4,Result) :- leftbrac(P1,P2,LB), parameters(P2,P3,1,Params), rightbrac(P3,P4,RB),format(Result,"param(%s)",Params).

istype(void).
istype(char).
istype(float).
istype(int).
isspace(space).
isleftbrac(leftbracket).
isrightbrac(rightbracket).
iscomma(comma).

isnamefunc(Word) :- istype(Word), !, fail.
isnamefunc(Word) :- isspace(Word), !, fail.
isnamefunc(Word) :- isleftbrac(Word), !, fail.
isnamefunc(Word) :- isrightbrac(Word), !, fail.
isnamefunc(Word) :- iscomma(Word), !, fail.
isnamefunc(Word).

type(From, To, Word) :- word(Word, From, To), istype(Word).
space(From, To, Word) :- word(Word, From, To), isspace(Word).
leftbrac(From, To, Word) :- word(Word, From, To), isleftbrac(Word).
rightbrac(From, To, Word) :- word(Word, From, To), isrightbrac(Word).
comma(From, To, Word) :- word(Word, From, To), iscomma(Word).
namefunc(From,To,Word) :- word(Word, From, To), isnamefunc(Word).

parameters(P1, P2, CurrLevel, Result) :- CurrLevel > 25, !, fail.
parameters(P1, P2, CurrLevel, Result) :- parameter(P1, P2, Result).
parameters(P1, P4, CurrLevel, Result) :- 
NextLevel = CurrLevel+1, 
parameter(P1, P2, Res), 
word(comma, P2, P3), 
parameters(P3, P4, NextLevel, Params), 
format(Result, "%s,%s", Res, Params).

parameter(P1,P4,Result) :- type(P1,P2,Type), space(P2,P3,Space), namefunc(P3,P4,Name),format(Result,"%s", Type).
parameter(P1,P2,Result) :- type(P1,P2,Type),format(Result,"%s", Type).
parameter(P1,P5,Result) :- type(P1,P2,Type), space(P2,P3,Sp), space(P3,P4,Space), namefunc(P4,P5,Name),format(Result,"%s", Type).
parameter(P1,P3, Result) :- space(P1,P2,Sp), parameter(P2,P3,Par), format(Result,"%s", Par).
goal
s(1,12,ParseResult).
