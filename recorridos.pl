
/*

preorden(+A, -R)
  es cierto si R unifica con el recorrido en
  preorden del árbol A (etiqueta, izquierda en preoden y derecha en preorden)
  
  arbol1(A), preorden(A, [1,2,3,4,5,6,7,8]

arbol1(a(1, a(2, a(3, nil, nil), a(4, nil, nil)), a(5, a(6, nil, nil), a(7, nil, a(8, nil, nil)))) ).
  
                1
			   / \ 
			  /   \ 
			 2     5
            / \   / \
           3   4 6	 7
                      \		   
                       8
*/
  
preorden(a(Et, HI, HD),  ):- preorden(HI, RI), preorden(HD, RD),  
  
/*

inorden(+A, -R)
  es cierto si R unifica con el recorrido en
  preorden del árbol A (izquierda en inorden, etiquete y derecha en inorden)
  
  arbol1(A), inorden(A, [3,2,4,1,6,5,7,8]

arbol1(a(1, a(2, a(3, nil, nil), a(4, nil, nil)), a(5, a(6, nil, nil), a(7, nil, a(8, nil, nil)))) ).
  
                1
			   / \ 
			  /   \ 
			 2     5
            / \   / \
           3   4 6	 7
                      \		   
                       8
*/



/*

postorden(+A, -R)
  es cierto si R unifica con el recorrido en
  preorden del árbol A (izquierda en inorden, etiquete y derecha en inorden)
  
  arbol1(A), inorden(A, [3,4,2,6,8,7,5,1]).

arbol1(a(1, a(2, a(3, nil, nil), a(4, nil, nil)), a(5, a(6, nil, nil), a(7, nil, a(8, nil, nil)))) ).
  
                1
			   / \ 
			  /   \ 
			 2     5
            / \   / \
           3   4 6	 7
                      \		   
                       8
*/
