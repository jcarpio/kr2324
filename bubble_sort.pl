/*

bubble_sort(+List, -Result)
  is true if Result unify with a list with same elements
  that contai List in ascendent order
  
   bubble_sort([1,3,2,5,4,6,7,8],R).
   R = [1, 2, 3, 4, 5, 6, 7, 8] .
*/

% We build the induction with the number
% of changes we need to get the solution



% P(n-1) -> P(n)
bubble_sort(List, R):- append(L1,[E1,E2|L2], List),
                       E1 > E2,
                       append(L1,[E2, E1|L2], Temp),
					   bubble_sort(Temp, R).
					   
% P(n0) -> 0 changes are needed 
bubble_sort(List, List):- sorted(List).					   
					   
					   
/*
sorted(+List)
  is true if List unify with a list with all elements
  sorted in ascendent order.
*/

sorted([]).

sorted([_]).

sorted([H1, H2|Tail]):-
    sorted([H2|Tail]), H1 =< H2.
