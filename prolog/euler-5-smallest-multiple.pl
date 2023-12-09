% run with `swipl -s euler-5-smallest-multiple.pl -g start -t halt -- <cmdline argument>`
:- initialization(start).

start :-
    current_prolog_flag(argv, Arguments),
    (   checkValidArguments(Arguments)
    ->  extractArgument(Arguments, UpperBound),
        find_smallest_multiple(UpperBound, SmallestMultiple),
        writeln(SmallestMultiple),
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

% Calculate the LCM of all numbers from 1 to UpperBound
find_smallest_multiple(UpperBound, SmallestMultiple) :-
    range(1, UpperBound, Range), % generate our range of divisors
    foldl(lcm, Range, 1, SmallestMultiple). % apply the lowest common multiple iteratively throughout the list

% Generate a list from Start to End, returns the List that contains all integers from 1 to the cmdline argument
range(Start, End, List) :- findall(X, between(Start, End, X), List).

% Calculate the least common multiple of two numbers
lcm(A, B, LCM) :-
    GCD is gcd(A, B),
    LCM is A * B // GCD.

