% Sudoku Solver

% Define the domain: the grid is 4x4 and the values are from 1 to 4
num(1..4).
row(1..4).
col(1..4).

% Load initial clues from the file
sudoku(R, C, V) :- initial(R, C, V).

% Define the input: known cells are pre-filled, others are guessed
1 { sudoku(R, C, V) : num(V) } 1 :- row(R), col(C), not initial(R, C, _).

% Row constraint: each row must contain all numbers from 1 to 4 without duplicates
:- sudoku(R, C1, V), sudoku(R, C2, V), C1 != C2.

% Column constraint: each column must contain all numbers from 1 to 4 without duplicates
:- sudoku(R1, C, V), sudoku(R2, C, V), R1 != R2.

% Subgrid constraint: each 2x2 subgrid must contain all numbers from 1 to 4 without duplicates
:- sudoku(R1, C1, V), sudoku(R2, C2, V), 
   subgrid(R1, C1, G), subgrid(R2, C2, G), (R1, C1) != (R2, C2).

% Define subgrid mapping: assign each cell (R,C) to a subgrid G
subgrid(1,1,1). subgrid(1,2,1). subgrid(2,1,1). subgrid(2,2,1). % Top-left
subgrid(1,3,2). subgrid(1,4,2). subgrid(2,3,2). subgrid(2,4,2). % Top-right
subgrid(3,1,3). subgrid(3,2,3). subgrid(4,1,3). subgrid(4,2,3). % Bottom-left
subgrid(3,3,4). subgrid(3,4,4). subgrid(4,3,4). subgrid(4,4,4). % Bottom-right

% Ensure every number between 1 and 4 appears exactly once per row
:- row(R), num(V), not 1 { sudoku(R, _, V) } 1.

% Ensure every number between 1 and 4 appears exactly once per column
:- col(C), num(V), not 1 { sudoku(_, C, V) } 1.

% Ensure every number between 1 and 4 appears exactly once per subgrid
:- subgrid(R, C, G), num(V), not 1 { sudoku(R, C, V) : subgrid(R, C, G) } 1.

% Only show sudoku facts
#show sudoku/3.
