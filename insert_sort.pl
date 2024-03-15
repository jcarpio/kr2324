/*

insert_sort(+List, -Result)
  is true if Result unify with a list with same elements
  that contai List in ascendent order
  
   insert_sort([1,3,2,5,4,6,7,8],R).
   R = [1, 2, 3, 4, 5, 6, 7, 8] .
*/

insert_sort([], []).

insert_sort([Head|Tail], R2):-
  insert_sort(Tail, R),
  insert_in_sorted(Head, R, R2).
  
/*  
insert_in_sorted(+Elem, +List, -R)
  is true if R unify with a list tha contains the 
  elements of List with Elem inserted in right position. R
  is ascendent sorted.
  
  ? insert_in_sorted(4, [1,2,3,5,6], R).
  R = [1,2,3,4,5,6].
  
*/


insert_in_sorted(Elem, [], [Elem]).

insert_in_sorted(Elem, [Head|Tail], [Elem, Head|Tail]):-
  Elem =< Head.
  
insert_in_sorted(Elem, [Head|Tail], [Head|R]):-
  Elem > Head, insert_in_sorted(Elem, Tail, R).  


  
