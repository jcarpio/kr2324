
/*

num_elem(+List, -Result)
 is true if Result unify with the number
 of elements in List

*/

/*
Induction 
1) P(n0) is true
   n0 in lists is []
*/   
   
num_elem([], 0).

/*
2) if P(n-1) -> P(n)
   P(n) :- P(n-1)
   n > n0
*/    
   
num_elem([_|Tail], R) :- num_elem(Tail, Result), R is Result + 1.



