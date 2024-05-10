:- use_module(library(clpfd)).

samurai(Samurai):- 
  sudoku(S5), maplist(label, S5),
  sudoku(S1), maplist(label, S1),
  corner(4, S1, C1), corner(1, S5, C1),
  % sudoku(S2), maplist(label, S2), 
  % sudoku(S3), maplist(label, S3), 
  % sudoku(S4), maplist(label, S4), maplist(portray_clause, S4),
  sudoku(S5), maplist(label, S5),
  Samurai = [S1, S5].
  % corner(4, S1, C1), corner(1, S5, C1).
  % corner(3, S2, C2), corner(2, S5, C2),
  % corner(2, S3, C3), corner(3, S5, C3),
  % corner(1, S4, C4), corner(5, S5, C4).

corner(1, [[A1, A2, A3|_],[B1,B2,B3|_],[C1,C2,C3|_]|_],   
           [[A1,A2,A3],[B1,B2,B3],[C1,C2,C3]]).
corner(2, [A, B, C|_], [A1, B1, C1]):- 
  maplist(same_length([_,_,_]), [A1, B1, C1]),
  append(_, A1, A),
  append(_, B1, B),
  append(_, C1, C).
  
corner(3, Rows, [A1,B1, C1]):-  length(Last3, 3), 
  append(_, Last3, Rows),
  Last3 = [A, B, C],
  maplist(same_length([_,_,_]), [A1, B1, C1]),
  append(A1, _, A),
  append(B1, _, B),
  append(C1, _, C).
  
corner(4, Rows, [A1, B1, C1]):-  length(Last3, 3), 
  append(_, Last3, Rows),
  Last3 = [A, B, C],
  maplist(same_length([_,_,_]), [A1, B1, C1]),
  append(_,A1, A),
  append(_,B1, B),
  append(_,C1, C).  
  
sudoku(Rows) :-
        length(Rows, 9),
        maplist(same_length(Rows), Rows),
        append(Rows, Vs), Vs ins 1..9,
        maplist(all_distinct, Rows),
        transpose(Rows, Columns),
        maplist(all_distinct, Columns),
        Rows = [As,Bs,Cs,Ds,Es,Fs,Gs,Hs,Is],
        blocks(As, Bs, Cs),
        blocks(Ds, Es, Fs),
        blocks(Gs, Hs, Is).

blocks([], [], []).
blocks([N1,N2,N3|Ns1], [N4,N5,N6|Ns2], [N7,N8,N9|Ns3]) :-
        all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
        blocks(Ns1, Ns2, Ns3).
% ?- sudoku(Rows), maplist(label, Rows), maplist(portray_clause, Rows).		
