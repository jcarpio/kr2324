:- use_module(library(clpfd)).

sudoku(Rows) :-
        length(Rows, 9),
        maplist(same_length(Rows), Rows),
        append(Rows, Vs), Vs ins 1..9,
        maplist(all_distinct, Rows),
        transpose(Rows, Columns),
        maplist(all_distinct, Columns),
        Rows = [As,Bs,Cs,Ds,Es,Fs,Gs,Hs,Is],
		maplist(same_length([_,_,_]),[L11,L12,L21,L22,L31,L32,L41,L42,L51,L52,L61,L62]),		
		append([[_], L11, [_], L12, [_]], Bs),
		append(L11, L12, L1),
		append([[_], L21, [_], L22, [_]], Cs),		
		append(L21, L22, L2),
		append([[_], L31, [_], L32, [_]], Ds),
		append(L31, L32, L3),
		append([[_], L41, [_], L42, [_]], Fs),
		append(L41, L42, L4),
		append([[_], L51, [_], L52, [_]], Gs),		
		append(L51, L52, L5),
		append([[_], L61, [_], L62, [_]], Hs),
		append(L61, L62, L6),		
        blocks(As, Bs, Cs),
        blocks(Ds, Es, Fs),
        blocks(Gs, Hs, Is),
		blocks(L1, L2, L3),
		blocks(L4, L5, L6).

blocks([], [], []).
blocks([N1,N2,N3|Ns1], [N4,N5,N6|Ns2], [N7,N8,N9|Ns3]) :-
        all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
        blocks(Ns1, Ns2, Ns3).
		
hyper_sudoku(1, 
               [[_,_,_,8,_,_,1,3,_],
			    [4,8,_,2,_,_,6,_,_],
				[_,_,_,_,_,_,_,5,_],
				[_,_,_,4,_,_,_,8,_],
				[_,_,1,5,6,_,4,_,_],
				[_,4,_,_,_,_,9,_,_],
				[_,_,_,_,_,_,5,_,_],
				[_,_,9,_,7,_,_,_,_],
				[_,_,_,_,2,5,8,_,1]
			   ]).
hyper_sudoku(2, 
               [[6,_,1,_,_,7,_,_,4],
			    [5,9,_,_,_,_,7,_,8],
				[_,_,_,_,2,_,_,1,6],
				[_,_,5,1,_,_,_,4,_],
				[_,_,_,_,_,_,_,_,_],
				[8,_,_,2,_,_,_,_,9],
				[_,_,_,_,_,_,_,_,_],
				[_,_,9,_,_,1,_,7,2],
				[_,_,_,7,3,_,_,6,1]
			   ]).
