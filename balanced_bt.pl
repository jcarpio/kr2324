/*

balanced(+BinaryTree)
  is true if BinaryTree is balanced. For all nodes
  the differece between left tree deep and right tree
  deep is maximum 1 is absolute value.
  
         1                          1
    	/ \                        / \
       2   5                      2   3
      /     \                    /
     3       6                  4
    /         \
   4	       7
   
   Diff = 4 - 1 = 3           Diff = For all nodes   
                                     Deep left - Deep right 
                                     Max 1 in absolute value.
*/

balanced(nil).
balanced(t(_, Left, Right)):-
  deep(Left, LD),
  deep(Right, RD),
  Dif is LD - RD, 1 =< abs(Dif),
  balanced(Left), balanced(Right).



/*
deep(+BinaryTree, -N)
  it is true if N unify with the maximum deep of BinaryTree.
  
*/

deep(nil, 0).
deep(t(_, Left, Right), Deep):-
  deep(Left, DL),
  deep(Right, DR),
  Deep is 1 + max(DL, DR).
