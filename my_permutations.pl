/*

my_permutation(+List, -R)
 is true if R unify with a list that constains all elements in List
 in a different order. We will get all possible permutations by 
 backtraking using ";"

 
 bagof(R ,my_permutation([1,2,3,4,5], R), List), length(List, N).
 List = List = [[1, 2, 3, 4, 5], [2, 1, 3, 4, 5], [2, 3, 1, 4, 5], [2, 3, 4, 1, 5], [2, 3, 4, 5|...], [1, 3, 2|...], [3, 1|...], [3|...], [...|...]|...],
 N = 120
*/

my_permutation([], []).

my_permutation([Head|Tail], R2):-  my_permutation(Tail, R), 
   append(L1, L2, R), append(L1, [Head|L2], R2). 
   
   
my_permutation2([], []).

my_permutation2([Head|Tail], R2):- my_permutation2(Tail, R), insert_all(Head, R, R2).

/*
insert_all(+Elem, +List, -R)
  it is true if R unify with a list that contains elements of List
  with Elem inserted in any position.
*/  

insert_all(E, List, [E|List]).

insert_all(E, [Head|Tail], [Head|R]):- insert_all(E, Tail, R).
