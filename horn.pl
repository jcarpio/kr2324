

% (any number of terms separate by and)antecedent -> consequent (0 or 1 term)

% a /\ b /\ c -> d

d :- a, b, c. 

% 2.
% a -> b /\ c.

a -> b.
a -> c.

% 3. a \/ b -> c.

a -> c.
b -> c.

4. a -> b \/ c.

is_raining -> go_beach \/ go_city.

a -> b
b :- a.
