domains
il=integer*

predicates
nondeterm scored(string, integer)    % (name, number of goals)
nondeterm hasRedCard(string, integer) %(name, number of red cards)
nondeterm hasYellowCard(string, integer) %(name, number of yellow cards)
nondeterm durationMatch(integer) % duration of the match
nondeterm scoreMatch(integer) % final score of the match
nondeterm totalNumberRedCards(integer) %total number of red cards
nondeterm totalNumberYellowCards(integer) %total number of yellow cards
nondeterm totalNumberGoals(integer) %total number of goals
nondeterm numberReplacement(string, integer) %number of replacments in team_name
totalNumbeReplacement(integer) %total number of replacments

getdatalist(il)
sum(il, integer)            % raschet dliny spiska

clauses
scored("Player1", 1).
scored("Player2", 2).
scored("Player3", 0).
scored("Player4", 0).
scored("Player5", 0).
scored("Player6", 1).
scored("Player7", 0).
scored("Player8", 0).
scored("Player9", 0).
scored("Player10", 0).
scored("Player11", 1).
scored("Player12", 0).

hasRedCard("Player3", 1).
hasYellowCard("Player4", 1).
hasYellowCard("Player5", 1).

durationMatch(60).

numberReplacement("Team", 1).


sum( [ ], 0 ).
sum( [H|T], S1 ):-sum(T,S2 ), S1=S2+H.

getdatalist(IL) :- findall(Y, scored(X,Y), IL).
getdatalist(RC) :- findall(Y, hasRedCard(X,Y), RC).
getdatalist(YC) :- findall(Y, hasYellowCard(X,Y), YC).

scoreMatch(C):-getdatalist(IL), sum(IL,C).
totalNumberGoals(C):-getdatalist(IL), sum(IL,C).
totalNumberRedCards(G):-getdatalist(RC), sum(RC,G).
totalNumberYellowCards(H):-getdatalist(YC), sum(YC,H).

totalNumbeReplacement(L) :- numberReplacement(U,L).


goal
%write("Total score of the match: "), scoreMatch(U), write(U," ").
%write("Players with red card: "), hasRedCard(X,_), write(X," "), nl, write("Players with yellow card: "), hasYellowCard(Y,_), write(Y," "), fail.
write("Scored players:"), scored(Z,I),I>0,write(Z," "), fail.
