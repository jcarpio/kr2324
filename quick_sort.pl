:- set_prolog_stack(global, limit(16 000 000 000)).
:- set_prolog_stack(trail,  limit(16 000 000 000)).
:- set_prolog_stack(local,  limit(16 000 000 000)).

/*

quick_sort(+List, -Result)
  is true if Result unify with a list with same elements
  that contains List in ascendent order
  
   quick_sort([1,3,2,5,4,6,7,8],R).
   R = [1, 2, 3, 4, 5, 6, 7, 8] .
*/

quick_sort([], []).

quick_sort([Head|Tail], R):-
   division(Head, Tail, Less, High),
   quick_sort(Less, RL),
   quick_sort(High, RH),
   append(RL, [Head|RH], R).

/*
division(+Pivot, +List, -Less, -High).
  is true if Less unify wih the elements of List that
  are Less or equal than the Pivot and High unify with
  the elements in List that are great than Pivot.
*/

division( _, [], [], []).

division(Pivot, [Head|Tail], [Head|Less], High):- Head =< Pivot,
   division(Pivot, Tail, Less, High).
  
division(Pivot, [Head|Tail], Less, [Head|High]):- Head > Pivot,
   division(Pivot, Tail, Less, High).
