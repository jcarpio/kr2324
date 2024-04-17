
/*
 tree_traversals(Tree, Preorder, Inorder)

*/

tree_traversals(nil, [], []).
tree_traversals(node(Left, HeadP, Right), [HeadP|TailP], Inorder):-
  append(LeftI, [HeadP|RightI], Inorder),
  length(LeftI, L), length(LeftP, L), append(LeftP, RightP, TailP),  
  tree_traversals(Left, LeftP, LeftI),
  tree_traversals(Right, RightT, RightI).
