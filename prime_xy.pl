

/*

prime_xy(+X, +Y, +List)
  is true if List unify with a list that contains
  prime numbers between X and Y.

*/



/* The use of Range is trick

factors_list(+N, +Range, -List)
  is true if List unify with a list that contains all
  factors of N in the range [1, Range]
  
  factors(8, 8, R).
  R=[1, 2, 4, 8]
