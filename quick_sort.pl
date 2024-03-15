/*

quick_sort(+List, -Result)
  is true if Result unify with a list with same elements
  that contai List in ascendent order
  
   insert_sort([1,3,2,5,4,6,7,8],R).
   R = [1, 2, 3, 4, 5, 6, 7, 8] .
*/

/*
division(+Pivot, +List, -Less, -High).
  is true if Less unify wih the elements of List that
  are Less or equal than the Pivot and High unify with
  the elements in List that are great than Pivot.
*/

division(_, [], [], []).

division(Pivot, [Head|Tail],  ,  ):-
  division(Pivot, Tail, Less, High),
