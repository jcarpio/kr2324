/*

my_reverse(+List, -Result)
  is true if Result unify with a list with 
  same elements of List in reverse order

*/


/*
1) P(n0)
*/

my_reverse([], []).

/*
2) P(n-1) -> P(n)
   P(n) :- P(n-1)
   
   [1,2,3,4,5] -> reverse([2,3,4,5]) = [5,4,3,2]
   
*/
   my_reverse([Head|Tail], R) :- my_reverse(Tail, Result),
      insert_end(Result, Head, R).
 
   
/*
insert_end(+List, +Elem, -Result)
  is true if Result unify with a list 
  with elements in List and Elem inserted to the the end.
*/ 

insert_end([], Elem, [Elem]).

insert_end([Head|Tail], Elem, [Head|Result]) :- insert_end(Tail, Elem, Result).


