

/*

  SWI PROLOG = Programming in Logic
  
  my_append(?List1, ?List2, ?Result) 
  
     is true if Result unify with a list
	 that contains the elements in List1 followed
	 by the elements in List2
	 
	 
	 ? my_append([1,2,3], [4,5,6], R).
	 R = [1,2,3,4,5,6]
	 
	 
	 Induction
	 
	 1) P(n0)  In list n0 = []
	 2) n> n0, P(n-1) -> P(n)

*/

my_append([], L, L).

my_append([Head|Tail], L2, [Head|R]):- % solution for n
  my_append(Tail, L2, R).    % solution for n-1
