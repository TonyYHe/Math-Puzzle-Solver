# Math-Puzzle-Solver
Solve a maths puzzle, that is a square grid of squares, which is subjected to multiple constraints.

## Math Puzzle
Each non-header square is to be filled in with a single digit 1–9 (zero is 
not permitted) satisfying these constraints:
1. Each row and each column contains no repeated digits.
2. All squares on the diagonal line from upper left to lower right contain the 
same value.
3. The heading of each row and column (leftmost square in a row and topmost 
square in a column) holds either the sum or the product of all the digits in 
that row or column.

Note:
1. The row and column headings are not considered to be part of the row or 
column, and so may be filled with a number larger than a single digit. 
2. The upper left corner of the puzzle is not meaningful.

Here is an example puzzle as posed (left) and solved (right) :
```
 ____ ____ ____ ____    ____ ____ ____ ____ 
|    | 14 | 10 | 35 |  |    | 14 | 10 | 35 |
| 14 |    |    |    |  | 14 |  7 |  2 |  1 |
| 15 |    |    |    |  | 15 |  3 |  7 |  5 |
| 28 |    |    |    |  | 28 |  4 |  1 |  7 |
 ---- ---- ---- ----    ---- ---- ---- ----  
```
## Representation of Puzzle
1. A maths puzzle will be represented as a proper list of proper lists, each of 
the same length, and each representing a single row of the puzzle.
2. The first element of each list is considered to be the header for that row.
3. Each element but the first of the first list in the puzzle is onsidered to be 
he header of the corresponding column of the puzzle.
4. The first element of the first element of the list is the corner square of 
the puzzle, and thus is ignored.

## Program Overview
The program file supplies a predicate puzzle_solution(Puzzle) that holds when 
Puzzle is the representation of a solved maths puzzle. It also defines a series 
of predicates helping to solve the puzzle.

Input Assumptions: 
1. The input argument is a proper puzzle, which has at most one solution
2. All the header squares of the puzzle (plus the ignored corner square) are 
bound to integers.
3. Some non-header squares may also be bound to integers, but the others will be 
unbound.

Post Condition: When puzzle_solution/1 succeeds, its argument must be ground.

## Approach
1. The non-header columns and rows are extracted using transpose/2 (clpfd)
2. The aforementioned constraints are applied using:
    - ins/2 (clpfd) for the contraint on digits
    - maplist/2 and all_distinct/1 (clpfd) for constraint (1)
    - equal_diagonal/1 for constraint (2)
    - sum/3 (clpfd) and product/3 for the constraint (3)
3. Finally label/1 (clpfd) to determine the solutions