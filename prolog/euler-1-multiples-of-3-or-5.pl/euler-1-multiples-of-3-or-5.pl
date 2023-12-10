% run with `swipl -s euler-1-multiples-of-3-or-5 -g start -t halt -- <cmdline argument>`
:- initialization(start).

start :-
    current_prolog_flag(argv, Arguments),
    (  checkValidArguments(Arguments)
    -> extractArgument(Arguments, UpperBound),
       sumNumbers(UpperBound - 1, A), writeln(A), halt
    ;  writeln('Invalid Arguments!'),
       halt(1)
    ).

% Predicate to check if a list of arguments contains a single valid integer
checkValidArguments([Arg]) :-
    catch(atom_number(Arg, Num), _, fail),
    integer(Num),
    Num > 0.

extractArgument([H|_], Num) :-
    atom_number(H, Num),
    integer(Num).

% div5 checks to see if X is a multiple of 5
div5(X) :-
    N is mod(X, 5),
    N =:= 0.

% div3 checks to see if X is a multiple of 3
div3(X) :-
    N is mod(X, 3),
    N =:= 0.

% validNumber is true if X is divisible by 3 OR divisible by 5.
validNumber(X) :-
    div5(X).
validNumber(X) :-
    div3(X).

% sumNumbers will sum all numbers from 0 to N if they are valid numbers (validNumber), returning A as the answer.
sumNumbers(0, 0).
sumNumbers(N, A) :-
    N > 0,
    N1 is N - 1,
    sumNumbers(N1, A1),
    ( 
    validNumber(N) 
        -> A is N + A1 
        ; A = A1 
    ).
