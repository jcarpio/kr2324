
% Natural number

% Mathematic Induction

% 1) 

natural(1).   % number 1 is natural
 
% 2) n > 1, P(n-1) -> P(n)
%     P = natural
	 
natural(N) :- N > 1, N2 is N-1, natural(N2). 
	

% Horn clauses only have one term in consequent

% P(n) -> P(n+1)

% P(N) -> N2 is N+1, P(N2).

% we translate that

% P(N-1) -> P(N)

% N2 is, N-1, P(N2) -> P(N).
