
/*

1. Describe State
 
   state(MR, CR, BoatPlace)
   
   Put inside state only variable information. For example, we don't write in state
   that the maximum number of people in boat are two, because that is commun to all
   states. At the same time, boat can't travel alone.
   
2. Describe Initial and Final states

   Initial state = state(3, 3, right)
   
   Final state   = state(0, 0, left)
   
3. Describe Movements

*/

   mov(move(M, 0, left), state(MR, CR, right), state(NewMR, CR, left) ):- MR > 0,
      MR  >= M, NewMR is MR - M.
	  
   mov(move(0, C, left), state(MR, CR, right), state(MR, NewCR, left) ):- CR > 0,
      CR >= C, NewCR is CR - C.
	  
   mov(move(M, 0, right), state(MR, CR, left), state(NewMR, CR, right) ):- ML is 3 - MR,
      ML > 0,
      ML  >= M, NewMR is MR + M.
	  
   mov(move(0, C, right), state(MR, CR, left), state(MR, NewCR, right) ):- CL is 3 - CR,
      CL  > 0,
      CL >= C, NewCR is CR + C.	  


/*
	  
4. Define a valid state 	  

*/
    valid(state(0, CR, _)):- CR =< 3.
	valid(state(MR, 0, _)):- MR = 0; MR = 3.
	valid(state(MR, CR, _)):- ML is 3- MR, CL is 3 - CR, MR > 0, MR >= CR, ML >= CL.
	
/*

 5. path(+Ini, +Fin, +Visited, -Path)
 
*/
	
	
   path(Ini, Ini, _, []).	
   
   path(Ini, Fin, Visited, [Mov|Path]):-
     mov(Mov, Ini, TMP),
	 valid(TMP),
	 \+ member(TMP, Visited),
	 path(TMP, Fin, [TMP|Visited], Path).
	 


move(M, C, _):- member(M, [0,1,2]), C is 2 - M.
	 
	
