% Fibonacci using memoization in Prolog reference;
% https://www.swi-prolog.org/pldoc/man?section=tabling-memoize
:- table fib/2. % Memoize the fib/2 predicate

% run with `swipl -s euler-25-1000-digit-fibonacci-number.pl -g start -t halt -- <cmdline argument>`
:- initialization(start).

start :-
    current_prolog_flag(argv, Arguments),
    (   checkValidArguments(Arguments)
    ->  extractArgument(Arguments, UpperBound),
        nth_long_fib_index(UpperBound, Index),
        writeln(Index),
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

% Fibonacci sequence optimised through cuts
fib(0, 0) :- !.
fib(1, 1) :- !.
fib(2, 1) :- !.
fib(N, F) :-
        N > 1,
        N1 is N-1,
        N2 is N-2,
        fib(N1, F1),
        fib(N2, F2),
        F is F1+F2.

% Predicate is true if Length is the number of digits in Number
digit_count(Number, Length) :-
    number_chars(Number, Chars),
    length(Chars, Length).

% Predicate to find the index of the first Fibonacci number with 'Length' digits
nth_long_fib_index(Length, Index) :-
    find_fib_with_length(1, Length, Index).

% Helper predicate to generate Fibonacci numbers until one with the desired length is found
find_fib_with_length(CurrIndex, Length, Index) :-
    fib(CurrIndex, FibNum),
    digit_count(FibNum, FibLength),
    (   FibLength =:= Length
    ->  Index = CurrIndex
    ;   NextIndex is CurrIndex + 1,
        find_fib_with_length(NextIndex, Length, Index)
    ).
