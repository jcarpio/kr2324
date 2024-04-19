
/*

count_leaves_gt(+GenericTree, +N)
  it is true if N unify with the number of leaves in GenericTree.

*/

count_leaves_tree(t(_, TreeList), R):- TreeList \= [],
  count_leaves_tree_list(TreeList, R).
  
count_leaves_tree(t(_, []), 1).
  
count_leaves_tree_list([], 0).
count_leaves_tree_list([Head|Tail], R):- 
  count_leaves_tree(Head, RH),
  count_leaves_tree_list(Tail, RT), R is RH + RT.
