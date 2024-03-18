

/*

list_generator(+N, +Range, -Result)
  is true if Result unify with a list of N random elements in the 
  range from 1 to N.

*/


list_generator(0, _, []).


list_generator(N, Range, [Elem|R]):-  N > 0, N2 is N-1, 
  list_generator(N2, Range, R), random(1, Range, Elem).   
