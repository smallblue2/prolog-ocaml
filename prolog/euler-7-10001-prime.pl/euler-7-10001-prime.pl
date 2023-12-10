% run with `swipl -s euler-6-sum-square-difference.pl -g start -t halt -- <cmdline argument>`
:- initialization(start).

start :-
    current_prolog_flag(argv, Arguments),
    (   checkValidArguments(Arguments)
    ->  extractArgument(Arguments, PrimeNumber),
        nth_prime(PrimeNumber, Ans),
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

% Checks for factors incrementally
% Factor is a factor to Number if division leaves no remainder.
has_factor(Number, Factor) :- Number mod Factor =:= 0.
% Go to square root max (there must exist a factor below).
% We've already checked for even numbers (2), only check odds (L + 2).
has_factor(Number, Factor) :- 
    Factor * Factor < Number, 
    Factor2 is Factor + 2, 
    has_factor(Number, Factor2).

% Predicate is true if P is a prime
is_prime(2).
is_prime(3).
is_prime(P) :-
    P > 3, % ensure this is only true for P > 3
    P mod 2 =\= 0, % cross off even numbers straight away
    \+ has_factor(P, 3). % ensure it doesn't have a factor (starting at 3).

% Predicate is true if N is the nth prime.
nth_prime(1,2). % 2 is the 1st prime
nth_prime(N, Prime) :-
    nth_prime(1, 2, N, Prime). % Call the recursive case

nth_prime(Count, Candidate, Number, Prime) :-
    ( is_prime(Candidate) % If the current Candidate number is prime
    -> ( Count = Number % If the prime Count has reached the Number we're looking for
       -> Prime = Candidate % Prime = Candidate
       ;   NextCount is Count + 1, % Otherwise increase the Counter and Candidate
           NextCandidate is Candidate + 1,
           nth_prime(NextCount, NextCandidate, Number, Prime)
       )
    ;  NextCandidate is Candidate + 1, % Otherwise increase the Candidate number and try again
       nth_prime(Count, NextCandidate, Number, Prime)
    ).
