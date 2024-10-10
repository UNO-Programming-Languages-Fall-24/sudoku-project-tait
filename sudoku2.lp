% Sudoku Solver for 9x9 grid

% Define the domain: the grid is 9x9 and the values are from 1 to 9
num(1..9).
row(1..9).
col(1..9).

% Define subgrid mapping for 9x9 grid (3x3 subgrids)
subgrid(1, 1, 1). subgrid(1, 2, 1). subgrid(1, 3, 1). subgrid(1, 4, 2). subgrid(1, 5, 2). subgrid(1, 6, 2). subgrid(1, 7, 3). subgrid(1, 8, 3). subgrid(1, 9, 3).
subgrid(2, 1, 1). subgrid(2, 2, 1). subgrid(2, 3, 1). subgrid(2, 4, 2). subgrid(2, 5, 2). subgrid(2, 6, 2). subgrid(2, 7, 3). subgrid(2, 8, 3). subgrid(2, 9, 3).
subgrid(3, 1, 1). subgrid(3, 2, 1). subgrid(3, 3, 1). subgrid(3, 4, 2). subgrid(3, 5, 2). subgrid(3, 6, 2). subgrid(3, 7, 3). subgrid(3, 8, 3). subgrid(3, 9, 3).

subgrid(4, 1, 4). subgrid(4, 2, 4). subgrid(4, 3, 4). subgrid(4, 4, 5). subgrid(4, 5, 5). subgrid(4, 6, 5). subgrid(4, 7, 6). subgrid(4, 8, 6). subgrid(4, 9, 6).
subgrid(5, 1, 4). subgrid(5, 2, 4). subgrid(5, 3, 4). subgrid(5, 4, 5). subgrid(5, 5, 5). subgrid(5, 6, 5). subgrid(5, 7, 6). subgrid(5, 8, 6). subgrid(5, 9, 6).
subgrid(6, 1, 4). subgrid(6, 2, 4). subgrid(6, 3, 4). subgrid(6, 4, 5). subgrid(6, 5, 5). subgrid(6, 6, 5). subgrid(6, 7, 6). subgrid(6, 8, 6). subgrid(6, 9, 6).

subgrid(7, 1, 7). subgrid(7, 2, 7). subgrid(7, 3, 7). subgrid(7, 4, 8). subgrid(7, 5, 8). subgrid(7, 6, 8). subgrid(7, 7, 9). subgrid(7, 8, 9). subgrid(7, 9, 9).
subgrid(8, 1, 7). subgrid(8, 2, 7). subgrid(8, 3, 7). subgrid(8, 4, 8). subgrid(8, 5, 8). subgrid(8, 6, 8). subgrid(8, 7, 9). subgrid(8, 8, 9). subgrid(8, 9, 9).
subgrid(9, 1, 7). subgrid(9, 2, 7). subgrid(9, 3, 7). subgrid(9, 4, 8). subgrid(9, 5, 8). subgrid(9, 6, 8). subgrid(9, 7, 9). subgrid(9, 8, 9). subgrid(9, 9, 9).

% Load initial clues from the file
sudoku(R, C, V) :- initial(R, C, V).

% Define the input: known cells are pre-filled, others are guessed
1 { sudoku(R, C, V) : num(V) } 1 :- row(R), col(C), not initial(R, C, _).

% Sudoku constraints
:- sudoku(R, C1, V), sudoku(R, C2, V), C1 != C2.  % Row constraint: no duplicates
:- sudoku(R1, C, V), sudoku(R2, C, V), R1 != R2.  % Column constraint: no duplicates

% Subgrid constraint: no duplicates in each 3x3 block
:- sudoku(R1, C1, V), sudoku(R2, C2, V),
   subgrid(R1, C1, G), subgrid(R2, C2, G), (R1, C1) != (R2, C2).

% Ensure each number appears exactly once per row
:- num(V), row(R), #count{C : sudoku(R,C,V)} != 1.

% Ensure each number appears exactly once per column
:- num(V), col(C), #count{R : sudoku(R,C,V)} != 1.

% Show only the sudoku facts
#show sudoku/3.
