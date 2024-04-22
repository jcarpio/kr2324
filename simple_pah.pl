
graph1(
  g([1,2,3,4,5], [e(1,2), e(2,3), e(3,4), e(2,5), e(5,3)])
).

/*        20      40
1 ---> 2 ----> 3 ----> 4
   10    \    /
        10\  /20
           \/		
            5 
		  
?- graph1(G), path(G, 1, 4, [1], Path).
G = g([1, 2, 3, 4, 5], [e(1, 2), e(2, 3), e(3, 4), e(2, 5), e(5, 3)]),
Path = [1, 2, 3, 4] ;
G = g([1, 2, 3, 4, 5], [e(1, 2), e(2, 3), e(3, 4), e(2, 5), e(5, 3)]),
Path = [1, 2, 5, 3, 4] ;
false.		  
		  
*/

connected(g(_, Lines), Start, End):- member(e(Start,End), Lines).

path(_, Start, Start, _, [Start]).
path(g(Dots, Lines), Start, End, Visited, [Start|Path]):-
  connected(g(Dots, Lines), Start, Tmp), 
  \+ member(Tmp, Visited),
  path(g(Dots, Lines), Tmp, End, [Tmp|Visited], Path). 
  