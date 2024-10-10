% Sudoku Solver

% Define the domain: the grid is 4x4 and the values are from 1 to 4
num(1..4).
row(1..4).
col(1..4).

% Define subgrid mapping
subgrid(1, 1, 1). subgrid(1, 2, 1). subgrid(1, 3, 2). subgrid(1, 4, 2). %Top Left
subgrid(2, 1, 1). subgrid(2, 2, 1). subgrid(2, 3, 2). subgrid(2, 4, 2). %Top Right
subgrid(3, 1, 3). subgrid(3, 2, 3). subgrid(3, 3, 4). subgrid(3, 4, 4). %Bottom Left
subgrid(4, 1, 3). subgrid(4, 2, 3). subgrid(4, 3, 4). subgrid(4, 4, 4). %Bottom Right

% Load initial clues from the file
sudoku(R, C, V) :- initial(R, C, V).

% Define the input: known cells are pre-filled, others are guessed
1 { sudoku(R, C, V) : num(V) } 1 :- row(R), col(C), not initial(R, C, _).

% Sudoku constraints
:- sudoku(R, C1, V), sudoku(R, C2, V), C1 != C2.  % Row constraint: no duplicates
:- sudoku(R1, C, V), sudoku(R2, C, V), R1 != R2.  % Column constraint: no duplicates

% Subgrid constraint: no duplicates in each 2x2 block
:- sudoku(R1, C1, V), sudoku(R2, C2, V),
   rubgrid(R1, C1, G), rubgrid(R2, C2, G), (R1, C1) != (R2, C2).


% Show only the sudoku
#show sudoku/3.
#show subgrid/3.
