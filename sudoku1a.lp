% Sudoku Solver

% Define the domain: the grid is 4x4 and the values are from 1 to 4
num(1..4).
row(1..4).
col(1..4).

% Load initial clues from the file
sudoku(R, C, V) :- initial(R, C, V).

% Define the input: known cells are pre-filled, others are guessed
1 { sudoku(R, C, V) : num(V) } 1 :- row(R), col(C), not initial(R, C, _).

% Sudoku constraints
:- sudoku(R, C1, V), sudoku(R, C2, V), C1 != C2.  % Row constraint: no duplicates
:- sudoku(R1, C, V), sudoku(R2, C, V), R1 != R2.  % Column constraint: no duplicates

% Subgrid constraint: no duplicates in each 2x2 block
:- sudoku(R1, C1, V), sudoku(R2, C2, V),
   subgrid(R1, C1, G), subgrid(R2, C2, G), (R1, C1) != (R2, C2).

% Show only the sudoku/3 and subgrid/3 predicates in the output
#show sudoku/3.