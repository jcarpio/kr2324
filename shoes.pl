/*

Taks:
1. order_wool
2. hummer_wool
3. shape_wool
4. cut_sole
5. glue_sole

Task connection:
task hummer_wool need task order_wool
task shape_wool need task hummer_wool
task glue_sole need task cut_sole and task shape_wool

product_task_worker_time(mel, order, order1, 1).
product_task_worker_time(mel, hummer, hummer1, 2).
product_task_worker_time(mel, shape_wool, shaper1, 2).
product_task_worker_time(mel, cut_sole, cutter1, 1).
product_task_worker_time(mel, glue_sole, glue1, 3).

product_task_worker_time(yves, order, order1, 1).
product_task_worker_time(yves, hummer, hummer1, 2).
product_task_worker_time(yves, shape_wool, shaper1, 2).
product_task_worker_time(yves, cut_sole, cutter1, 1).
product_task_worker_time(yves, glue_sole, glue1, 3).

1. Representation:

req(P, T, W, T)-[ _, _]


*/

:- use_module(library(clpfd)).
:- use_module(library(reif)).

requirements(Rs) :-
        Goal = product_task_worker_time(Prod, Task, Worker, Time),
        setof(req(Prod, Task, Worker, Time), Goal, Rs0),
        maplist(req_with_slots, Rs0, Rs).

req_with_slots(R, R-Slots) :- R = req(_,_,_,N), length(Slots, N).

pairs_slots(Ps, Vs) :-
        pairs_values(Ps, Vs0),
        append(Vs0, Vs).

requirements_variables(Rs, Vars) :-
        requirements(Rs),
        pairs_slots(Rs, Vars),
        slots_per_week(SPW),
        Max #= SPW - 1,
        Vars ins 0..Max,
		maplist(constrain_task(Rs), Rs),
        products(Products),
        workers(Workers),
		maplist(constrain_worker(Rs), Workers),
		maplist(constrain_product(Rs), Products).

% Task slots can overlap and must respect the defined order
% by task_a_needs_task_b. If a task has several slots, they must be consecutive


constrain_task(Rs, req(_Product, FTask,_Worker,_Time)-_Slots) :-        
		findall(FTask-STask, task_a_needs_task_b(STask, FTask), Ts),		
		maplist(task_couplings(Rs), Ts).

task_couplings(Rs, F-S) :-
        member(req(Product, F,_, _)-FSlots, Rs),
		member(req(Product, S,_,_)-SSlots, Rs),
		slots_first(FSlots, SSlots).
		
slots_first([], _).		
slots_first([FSlot|FSlots], SSlots):-
  maplist(greater(FSlot), SSlots),
  slots_first(FSlots, SSlots).
 
greater(X, Y):- X #< Y.
  	
% A worker's slots have to be different,
% a worker cannot be doing two tasks at the same time
constrain_worker(Rs, Worker) :-
        tfilter(worker_req(Worker), Rs, Sub),
		pairs_slots(Sub, Vs),
        all_different(Vs).		
		
% The product does not need its slots to be different. They can be
% overlap different tasks of a product
constrain_product(Rs, Product) :-
        tfilter(product_req(Product), Rs, Sub),
		pairs_slots(Sub, Vs),
        all_different(Vs).		
				
task_req(T0, req(_P,T1,_W,_N)-_, T) :- =(T0,T1,T).	

worker_req(W0, req(_P,_T,W1,_N)-_, W) :- =(W0,W1,W).

product_req(P0, req(P1,_T,_W,_N)-_, P) :- =(P0,P1,P).
		
workers(Workers) :-
        setof(W, P^T^N^product_task_worker_time(P,T,W,N), Workers).		
		
products(Products) :-
        setof(P, T^W^N^product_task_worker_time(P,T,W,N), Products).

tasks(Tasks) :-
        setof(T, P^W^N^product_task_worker_time(P,T,W,N), Tasks).	

strictly_ascending(Ls) :- chain(#<, Ls).


/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Relate teachers and classes to list of days.

   Each day is a list of subjects (for classes), and a list of
   class/subject terms (for teachers). The predicate days_variables/2
   yields a list of days with the right dimensions, where each element
   is a free variable.

   We use the atom 'free' to denote a free slot, and the compound terms
   class_subject(C, S) and subject(S) to denote classes/subjects.
   This clean symbolic distinction is used to support subjects
   that are called 'free', and to improve generality and efficiency.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

days_variables(Days, Vs) :-
        slots_per_week(SPW),
        slots_per_day(SPD),
        NumDays #= SPW // SPD,
        length(Days, NumDays),
        length(Day, SPD),
        maplist(same_length(Day), Days),
        append(Days, Vs).

product_days(Rs, Product, Days) :-
        days_variables(Days, Vs),
        tfilter(product_req(Product), Rs, Sub),
        foldl(v(Sub), Vs, 0, _).

v(Rs, V, N0, N) :-
        (   member(req(_,Task,_,_)-Times, Rs),
            member(N0, Times) -> V = task(Task)
        ;   V = free
        ),
        N #= N0 + 1.

worker_days(Rs, Worker, Days) :-
        days_variables(Days, Vs),
        tfilter(worker_req(Worker), Rs, Sub),
        foldl(v_worker(Sub), Vs, 0, _).

v_worker(Rs, V, N0, N) :-
        (   member(req(Prod, Task,_,_)-Times, Rs),
            member(N0, Times) -> V = product_task(Prod, Task)
        ;   V = free
        ),
        N #= N0 + 1.

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Print objects in roster.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */		
				
print_products(Rs) :-
        products(Ps),
        format_products(Ps, Rs).

format_products([], _).
format_products([Product|Products], Rs):- 
        product_days(Rs, Product, Days0),
        transpose(Days0, Days),
        format("Product: ~w~2n", [Product]),
        weekdays_header,
        align_rows(Days),
        format_products(Products, Rs).

align_rows([]):-  format("\n\n\n").
align_rows([R|Rs]):- 
        align_row(R),
        format("\n"),
        align_rows(Rs).

align_row([]).
align_row([R|Rs]):-
        align_(R),
        align_row(Rs).	

align_(free):- format('').
align_(product_task(P,T)):- format("~w/~w", [P,T]).
align_(task(T)):- format("~w", [T]).
align_(verbatim(Element)):- format("~t~w~t~8+", [Element]).


print_workers(Rs) :-
        workers(Ws),
        format_workers(Ws, Rs).

format_workers([], _).
format_workers([W|Ws], Rs):-
        worker_days(Rs, W, Days0),
          transpose(Days0, Days),
        format("Worker: ~w~2n", [W]),
        weekdays_header,
        align_rows(Days),
        format_workers(Ws, Rs).

weekdays_header :- 
        maplist(with_verbatim,
                  ['Mon','Tue','Wed','Thu','Fri'],
                  Vs),
        align_row(Vs),
        format("~n~`=t~40|~n").

with_verbatim(T, verbatim(T)).		

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   ?- consult('reqs_example.pl'),
      requirements_variables(Rs, Vs), labeling([ff], Vs), print_products(Rs).
   %@ Class: 1a
   %@
   %@   Mon     Tue     Wed     Thu     Fri
   %@ ========================================
   %@   mat     mat     mat     mat     mat
   %@   eng     eng     eng
   %@    h       h

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
		
%---------------------------------------------------------------		
		
slots_per_week(294). % 7 days a week 

slots_per_day(42).	 % 10 minutes slot, 7 hours a day	

product_task_worker_time(mel, order_wool, orderer1, 1).
product_task_worker_time(mel, hummer_wool, hummer1, 2).
product_task_worker_time(mel, shape_wool, shaper1, 2).
product_task_worker_time(mel, cut_sole, cutter1, 1).
product_task_worker_time(mel, glue_sole, gluer1, 3).

product_task_worker_time(yves, order_wool, orderer1, 1).
product_task_worker_time(yves, hummer_wool, hummer1, 2).
product_task_worker_time(yves, shape_wool, shaper1, 2).
product_task_worker_time(yves, cut_sole, cutter1, 1).
product_task_worker_time(yves, glue_sole, gluer1, 3).

/*
Task connection:
task hummer_wool need task order_wool
task shape_wool need task hummer_wool
task glue_sole need task cut_sole and task shape_wool

*/

task_a_needs_task_b(hummer_wool, order_wool).
task_a_needs_task_b(shape_wool, hummer_wool).
task_a_needs_task_b(glue_sole, cut_sole).
task_a_needs_task_b(glue_sole, shape_wool).
