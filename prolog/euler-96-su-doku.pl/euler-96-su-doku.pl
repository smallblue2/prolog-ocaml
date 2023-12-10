% Run with: `swipl -s euler-96-su-doku.pl -g main -- <nine rows of the sudoku puzzle>`


% Importing the CLP(FD) library for constraint logic over finite domains
:- use_module(library(clpfd)).

sudoku(Rows) :-
    % Ensure all rows are the same length (9)
    length(Rows, 9), maplist(same_length(Rows), Rows),

    % Flatten the 2D list into a 1D list and use contrains logic programming 
    % to state the domain of each variable in the sudoku grid to be any 
    % number between 1 and 9
    append(Rows, Vs), Vs ins 1..9,

    % Force all elements in the row to be distinct
    maplist(all_distinct, Rows),

    % Force all elements in the rows (columns) of the transpose to be distinct
    transpose(Rows, Columns), maplist(all_distinct, Columns),

    % Group the elements into 3x3 blocks, and state that elements in the blocks
    % must be distinct as well
    Rows = [A,B,C,D,E,F,G,H,I],
    blocks(A, B, C), blocks(D, E, F), blocks(G, H, I).

% The blocks predicate checks 3x3 subgrids (blocks) for the all_distinct constraint.
blocks([], [], []).
blocks([A,B,C|Bs1], [D,E,F|Bs2], [G,H,I|Bs3]) :-
    % Apply the all_distinct constraint to each 3x3 block
    all_distinct([A,B,C,D,E,F,G,H,I]),
    % recursivley call to process 
    blocks(Bs1, Bs2, Bs3).

% Predicate to solve a puzzle from command-line arguments
solve_puzzle_from_args :-
    % Retrieve command-line arguments
    current_prolog_flag(argv, Args),
    % Process each argument (each row of the puzzle)
    maplist(parse_row_from_arg, Args, Puzzle),
    % Solve the puzzle
    sudoku(Puzzle),
    % Force the unknowns in our sudoku puzzle to be evaluated through
    % constraint logic programming
    maplist(label, Puzzle),
    % Print the solution
    maplist(portray_clause, Puzzle).

% Parse a single row from a string argument
parse_row_from_arg(Arg, Row) :-
    % Split the string by commas and parse it into a list
    split_string(Arg, ",", "", StrList),
    % Convert each string in the list to an integer or an underscore
    maplist(str_to_int_or_underscore, StrList, Row).

% Convert string to integer or underscore
str_to_int_or_underscore(Str, Num) :- 
    (   Str = "_" -> Num = _ ; number_string(Num, Str) ).

% Entry point for the program
:- initialization(main, main).

start :-
    % Retrieve command-line arguments
    current_prolog_flag(argv, Args),
    % Check if any arguments are provided
    (Args \= [] ->
        % Call the predicate to solve the puzzle from command-line arguments
        solve_puzzle_from_args,
        % Exit the program
        halt
    ;
        % If no arguments, print a message and halt
        writeln('No puzzle provided.'),
        halt(1)
    ).
