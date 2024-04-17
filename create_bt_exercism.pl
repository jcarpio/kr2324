

/*

create_bt(+List, -BinaryTree)
  it is true if BinaryTree unify with a balanced binary tree 
  incliding all labels in List.
  
  create_bt([1,2,3], R).
  R = node(node(nil, 2, nil), 1, node(nil, 3,nil))
  
       unbalanced               balanced (difference between left 
	                                      and right length are not  
										  great that 1 in absulute value.
         1                         1
		/                         / \
       2                         2   3
	  /                         /
     3                         4 
	/
   4 

*/


create_bt([], nil).

create_bt([Head|Tail], node(Left, Head, Right)):- 
  length(Tail, L), L2 is L div 2, 
  length(List1, L2), append(List1, List2, Tail),
  create_bt(List1, Left), create_bt(List2, Right).  
  
  
  
  
  
  

