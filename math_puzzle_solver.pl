:- ensure_loaded(library(clpfd)).

%!   puzzle_solution(+Puzzle) is nondet
%    Holds when Puzzle is the representation of a solved maths puzzle.
puzzle_solution(Puzzle) :-
    Puzzle = [[_|ColHeads]|RowsWithH],  
    transpose(RowsWithH, [RowHeads|Cols]),
    transpose(Cols, Rows),
    append(Cols, Squares), 
    equal_diagonal(Cols),
    Squares ins 1..9,  
    maplist(all_distinct, Cols),
    maplist(all_distinct, Rows),
    fill_puzzle(Rows, RowHeads), 
    fill_puzzle(Cols, ColHeads),
    label(Squares).
    
%!   equal_diagonal(+SqMatrix) is det
%    True if all squares on the diagonal line from upper left to lower right  
%    of SqMatrix contain the same value. SqMatrix is assumed to be a 
%    squared matrix, stored as a list of lists.
equal_diagonal(SqMatrix) :-
    SqMatrix = [[DiagVal|_]|RemRows],
    equal_diagonal(RemRows, 2, DiagVal).

%!   equal_diagonal(+SqMatrix, ++Postion, +DiagVal) is det
%    True if the Position(th) (1-based indexing) element of the Position(th) 
%    row in SqMatrix has the same value as DiagVal. 
equal_diagonal([], _, _).
equal_diagonal([Row|Rows], Position, DiagVal) :-
    nth1(Position, Row, DiagVal),
    NewPos is Position + 1,
    equal_diagonal(Rows, NewPos, DiagVal).

%!   product(+List, -Product) is semidet
%    Similar to sum/3 with Rel being #=, except the product of the elements of 
%    List is computed.
product([], 1).
product([X|Xs], Product) :-
    Product #= Product1 * X,
    product(Xs, Product1).

%!   fill_puzzle(+Lists, ++ListHeads) is nondet
%    Instantiate unbound elements in each list in Lists to a value such that 
%    the sum of the nth list or the product of the nth list has the same value 
%    as the nth element of ListHeads. 
fill_puzzle([], []).
fill_puzzle([List|Lists], [Val|ListHeads]) :-
    (sum(List, #=, Val); product(List, Val)),
    fill_puzzle(Lists, ListHeads).
