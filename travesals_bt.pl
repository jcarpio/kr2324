
/*

pre_order(+BinaryTree, -List)
  it is true if List unify with pre_order travesal of BinaryTree.
  
     1
	/ \
   2   3
   
   [1,2,3]

      1 
     / \
	/   \
   2     3
  / \   / \
 4   5 6   7
   
   [1,2,4,5,3,6,7]
   
   
*/


tree1( node(node(node(nil,4,nil), 2, node(nil, 5, nil)), 1, node(node(nil, 5, nil), 3, node(nil, 7, nil))) ).
