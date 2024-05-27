:- use_module(library(clpfd)).

requirements(Rs) :-
        Goal = class_subject_teacher_times(Class,Subject,Teacher,Number),
        setof(req(Class,Subject,Teacher,Number), Goal, Rs0),
        maplist(req_with_slots, Rs0, Rs).

req_with_slots(R, R-Slots) :- R = req(_,_,_,N), length(Slots, N).

classes(Classes) :-
        setof(C, S^N^T^class_subject_teacher_times(C,S,T,N), Classes).

teachers(Teachers) :-
        setof(T, C^S^N^class_subject_teacher_times(C,S,T,N), Teachers).
		
rooms(Rooms) :-
        findall(Room, room_alloc(Room,_C,_S,_Slot), Rooms0),
        sort(Rooms0, Rooms).
		
pairs_slots(Ps, Vs) :-
        pairs_values(Ps, Vs0),
        append(Vs0, Vs).
		
requirements_variables(Rs, Vars) :-
        requirements(Rs),
        pairs_slots(Rs, Vars),
        slots_per_week(SPW),
        Max #= SPW - 1,
        Vars ins 0..Max,
        maplist(constrain_subject, Rs),
        classes(Classes),
        teachers(Teachers),
        rooms(Rooms),
        maplist(constrain_teacher(Rs), Teachers),
        maplist(constrain_class(Rs), Classes),
        maplist(constrain_room(Rs), Rooms).		
/*
Constrain Subject
  - By default, lessons have diffent days of the week,
    with the exception of coupling lessons.
  

*/
constrain_subject(req(Class,Subj,_Teacher,_Num)-Slots) :-
        strictly_ascending(Slots), % break symmetry
        maplist(slot_quotient, Slots, Qs0),
        findall(F-S, coupling(Class,Subj,F,S), Cs),
        maplist(slots_couplings(Slots), Cs),
        pairs_values(Cs, Seconds0),
        sort(Seconds0, Seconds),
        list_without_nths(Qs0, Seconds, Qs),
        strictly_ascending(Qs).
		
/* list_without_nths(+List, +Remove, -R)
      it is true if R unify with a list that contains
	  elements of Lists without elements that ocupied
	  positions in Remove starting with 0.	
*/	

list_without_nths(List, [], List).
list_without_nths(List, [Head|Tail], R):-
  list_without_nths(List, Tail, RTail),
  remove_pos(Head, RTail, R).
  
/* remove_pos(+Pos, +List,  -R).
      it is true if R unify with a list with
      the elements of List without elem at 
      position Pos.	 
*/
  
remove_pos(0, [_|Tail], Tail).  
  
remove_pos(Pos, [Head|Tail], [Head|R]):- Pos > 0,
   Pos2 is Pos - 1,
   remove_pos(Pos2, Tail, R).  
  
  
%:- list_without_nths("abcd", [3], "abc").
%:- list_without_nths("abcd", [1,2], "ad").

slots_couplings(Slots, F-S) :-
        nth0(F, Slots, S1),
        nth0(S, Slots, S2),
        S2 #= S1 + 1.		
		
strictly_ascending(Ls) :- chain(Ls, #<).


constrain_teacher(Rs, Teacher) :-
        % tfilter(teacher_req(Teacher), Rs, Sub),
		filter_req_teacher(Rs, Teacher, Sub),
        pairs_slots(Sub, Vs),
        all_different(Vs),
        findall(F, teacher_freeday(Teacher, F), Fs),
        maplist(slot_quotient, Vs, Qs),
        maplist(all_diff_from(Qs), Fs).

teacher_req(T0, req(_C,_S,T1,_N)-_, T) :- =(T0,T1,T).

all_diff_from(Vs, F) :- maplist(#\=(F), Vs).

/*
filter_req_teacher(+Req, +Teacher, -R)


*/

filter_req_teacher([], _, []).

filter_req_teacher([req(C,S,Teacher,N)-Slots|Tail], Teacher, [req(C,S,Teacher,N)-Slots|R]):-   
   filter_req_teacher(Tail, Teacher, R).
   
filter_req_teacher([req(_C,_S,TeacherList,_N)-_Slots|Tail], Teacher, R):-  
   TeacherList \= Teacher, 
   filter_req_teacher(Tail, Teacher, R).   


constrain_class(Rs, Class) :-
        tfilter(class_req(Class), Rs, Sub),
        pairs_slots(Sub, Vs),
        all_different(Vs),
        findall(S, class_freeslot(Class,S), Frees),
        maplist(all_diff_from(Vs), Frees).   
   
   
constrain_room(Reqs, Room) :-
        findall(r(Class,Subj,Less), room_alloc(Room,Class,Subj,Less), RReqs),
        maplist(sameroom_var(Reqs), RReqs, Roomvars),
        all_different(Roomvars).
		
sameroom_var(Reqs, r(Class,Subject,Lesson), Var) :-
        memberchk(req(Class,Subject,_Teacher,_Num)-Slots, Reqs),
        nth0(Lesson, Slots, Var).		
   
% 
slot_quotient(S, Q) :-
        slots_per_day(SPD),
        Q #= S // SPD.		


%----------------------------------------

slots_per_week(35).

slots_per_day(7).

class_subject_teacher_times('1a', deu, sjk1, 4).
class_subject_teacher_times('1a', mat, mat1, 5).
class_subject_teacher_times('1a', eng, anj1, 3).
class_subject_teacher_times('1a', h, zgo1, 2).
class_subject_teacher_times('1a', geo, geo1, 2).
class_subject_teacher_times('1a', ch, kem1, 2).
class_subject_teacher_times('1a', bio, bio1, 2).
class_subject_teacher_times('1a', ph, fiz1, 2).
class_subject_teacher_times('1a', f, rai1, 2).
class_subject_teacher_times('1a', lat, atvz1, 3).
class_subject_teacher_times('1b', deu, sjk1, 4).

room_alloc(r1, '1a', deu, 0).
room_alloc(r2, '1a', deu, 1).

coupling('1a', deu, 2, 3).
coupling('1a', mat, 0, 1).

