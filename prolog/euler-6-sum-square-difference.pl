% run with `swipl -s euler-6-sum-square-difference.pl -g start -t halt -- <cmdline argument>`
:- initialization(start).

start :-
    current_prolog_flag(argv, Arguments),
    (   checkValidArguments(Arguments)
    ->  extractArgument(Arguments, UpperBound),
        compareSums(UpperBound, Ans),
        writeln(Ans),
        halt
    ;   writeln('Invalid Arguments!'),
        halt(1)
    ).

% Predicate to check if a list of arguments contains a single valid integer
checkValidArguments([Arg]) :-
    catch(atom_number(Arg, Num), _, fail),
    integer(Num),
    Num > 0.

% Predicate to extract the argument if it is a valid integer
extractArgument([H|_], Num) :-
    atom_number(H, Num),
    integer(Num).

% Predicate is true if A is all numbers 0 -> N summed
sumNumbers(0, 0).
sumNumbers(N, A) :-
    N > 0,
    N1 is N - 1,
    sumNumbers(N1, A1),
    A is N + A1.

% Predicate is true if A is all numbers 0 -> N squared and summed
sumSquareNumbers(0, 0).
sumSquareNumbers(N, A) :-
    N > 0,
    N1 is N - 1,
    sumSquareNumbers(N1, A1),
    A is (N * N) + A1.

% Predicate is true if Ans is the difference between all numbers 0 -> Limit summed and squared and all numbers 0 -> Limit squared summed
compareSums(Limit, Ans) :-
    sumNumbers(Limit, Tmp1),
    sumSquareNumbers(Limit, Y),
    X is Tmp1 * Tmp1,
    Difference is Y - X,
    (Difference < 0 -> Ans is -Difference; Ans is Difference).
