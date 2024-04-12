
/*
more_times(+List, -Elem, -N)
  it is true if Elem unify with the element that appear more times
  in List an N is the number of occurrences.

*/

more_times(List, E, N):- msort(List, ListSort), 
                      compress(ListSort, ListComp),
					  higher_n(ListComp, E, N).
					  
/*					  
higher_n(+List, -Elem, -N).
  it is true if Elem unify with the element with higher N in List
  (a list of pairs (Elem, N) ). 

  higher_n([(a,4), (b,1), (c,2), (d,1), (a,1), (e,1)], E, N).
  E = a
  N = 2
  
  higher_n([(b,1), (c,2), (d,1), (a,1), (e,1)], E, N).
  E = c
  N = 2
  
*/


higher_n([Elem], Elem, 1).

higher_n([(Elem, N)|Tail], Elem, N):-  higher_n(Tail, _, NR), N >= NR.

higher_n([(_, N)|Tail], ER, NR):-  higher_n(Tail, ER, NR), N < NR.
					  

/*

 compress(+List, -Result)
   it is true if Result unify with a list in this form:
   
  (n)   compress([a,a,b,c,c,d,a,e], R).
  R = [(a,2), (b,1), (c,2), (d,1), (a,1), (e,1)]
  
  (n-1) compress([a,b,c,c,d,a,e], R)
  R = [(a,1), (b,1), (c,2), (d,1), (a,1), (e,1)]
  
  (n) compress([a,b,c,c,d,a,e], R).
  R = [(a,1), (b,1), (c,2), (d,1), (a,1), (e,1)]
  
  (n-1) compress([b,c,c,d,a,e], R).
  R = [(b,1), (c,2), (d,1), (a,1), (e,1)]
  
*/

compress([], []).

compress([Elem], [(Elem,1)]).

compress([Head, Head|Tail],  [(Head,N2)|R]):-  
   compress([Head|Tail], [(Head,N)|R]), 
   N2 is N + 1.
   
compress([Head1, Head2|Tail], [(Head1,1)|R]):- Head1 \= Head2, 
   compress([Head2|Tail], R).
   
   
   

