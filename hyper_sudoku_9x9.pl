:- use_module(library(clpfd)).

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
        blocks(Gs, Hs, Is),		
		length(Bs1,3), length(Bs2,3),
		append([[_], Bs1, [_], Bs2, _], Bs),
		append(Bs1, Bs2, BsN),
		length(Cs1,3), length(Cs2,3),
		append([[_], Cs1, [_], Cs2, _], Cs),
		append(Cs1, Cs2, CsN),
		length(Ds1,3), length(Ds2,3),
		append([[_], Ds1, [_], Ds2, _], Ds),
		append(Ds1, Ds2, DsN),
		blocks(BsN, CsN, DsN),
		length(Fs1,3), length(Fs2,3),
		append([[_], Fs1, [_], Fs2, _], Fs),
		append(Fs1, Fs2, FsN),
		length(Gs1,3), length(Gs2,3),
		append([[_], Gs1, [_], Gs2, _], Gs),
		append(Gs1, Gs2, GsN),
		length(Hs1,3), length(Hs2,3),
		append([[_], Hs1, [_], Hs2, _], Hs),
		append(Hs1, Hs2, HsN),
		blocks(FsN, GsN, HsN).
	

blocks([], [], []).
blocks([N1,N2,N3|Ns1], [N4,N5,N6|Ns2], [N7,N8,N9|Ns3]) :-
        all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
        blocks(Ns1, Ns2, Ns3).
		
		
hyper_sudoku(1, [ [_,_,_,8,_,_,1,3,_], 
                  [4,8,_,2,_,_,6,_,_], 
			      [_,_,_,_,_,_,_,5,_], 
				  [_,_,_,4,_,_,_,8,_], 
				  [_,_,1,5,6,_,4,_,_], 
				  [_,4,_,_,_,_,9,_,_], 
				  [_,_,_,_,_,_,5,_,_], 
				  [_,_,9,_,7,_,_,_,_], 
				  [_,_,_,_,2,5,8,_,1] 
				  ] ).		
