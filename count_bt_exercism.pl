
/*

Using this representation for Binary Trees node(Left, Label, Right) create a predicate
to count the number of nodes in a tree.


count(+BinaryTree, -N).
  it is true if N unify with the number of nodes in BinaryTree.

Induction

1) P(n0) -> n0 is an empty tree "nil"

2) P(n-1)-> p(n)

   P(Left) and P(Right) -> P(Tree)


*/


count(nil, 0).

count(node(Left, _, Right), R):-
  count(Left, RL), count(Right, RR), R is RL + RR + 1.
  
tree1( node(node(nil, 2, nil), 1, node(nil, 3,nil)) ).








