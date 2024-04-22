/*


path(+Graph, +Start, +End, +Visited, -Path)


Graph representation:

graph(VertexList, EdgeList)


1 ---> 2 ----> 3 ----> 4
       \    /
        \  /
         \/		
          5 
		 
g([1,2,3,4,5], [e(1,2), e(2,3), e(3,4), e(2,5), e(5,3)])


           a
		  /  \
         /    \
        /	   \	  
       b--------c
	   | \     /|
       |   \ /  |
	   |  /  \  |
	   |/      \|  
       d--------e
	   
	   
	   
	   
directed graph   1 ----> 2 1 is connected with 2
                           2 is not connected wiht 1
						  
undirected graph 1 ----- 2  1 is connected with 2
                            2 is connected wiht 1 
It is possible to represent path and visited in two ways.

Path as 
 - list of points (vertex) or
 - list of lines  (edges)
 
Visited
 - list of points (vertex)
 - list of lines  (edges)

							
*/

graph2(
   g([a,b,c,d,e], [e(a,b), e(a,c), e(b,c), 
                   e(b,d), e(b,e), e(c,d), e(c,e), e(d,e)])
).

/* path represented with lines and visited also points 
   in a undirected graph */

connected(Start, End, g(_, Lines)):- member(e(Start, End), Lines).
connected(Start, End, g(_, Lines)):- member(e(End, Start), Lines).


path(_, Start, Start, _, []).


path(g(Dots, Lines), Start, End, Visited, [e(Start,Tmp)|Path]):-
  connected(Start, Tmp, g(Dots, Lines)), 
  \+ member(Tmp, Visited), 
  path(g(Dots, Lines), Tmp, End, [e(Start,Tmp), e(Tmp,Start)|Visited], Path). 
   


graph1(
  g([1,2,3,4,5], [e(1,2), e(2,3), e(3,4), e(2,5), e(5,3)])
).




