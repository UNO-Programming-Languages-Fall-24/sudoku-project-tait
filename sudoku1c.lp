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

% Subgrid definition: 1 for top-left, 2 for top-right, 3 for bottom-left, 4 for bottom-right
subgrid(1,1,1). subgrid(1,2,1). subgrid(2,1,1). subgrid(2,2,1). % Subgrid 1
subgrid(1,3,2). subgrid(1,4,2). subgrid(2,3,2). subgrid(2,4,2). % Subgrid 2
subgrid(3,1,3). subgrid(3,2,3). subgrid(4,1,3). subgrid(4,2,3). % Subgrid 3
subgrid(3,3,4). subgrid(3,4,4). subgrid(4,3,4). subgrid(4,4,4). % Subgrid 4

% Ensure every number between 1 and 4 appears exactly once per row
:- row(R), num(V), not 1 { sudoku(R, C, V) } 1.

% Ensure every number between 1 and 4 appears exactly once per column
:- col(C), num(V), not 1 { sudoku(R, C, V) } 1.

% Ensure every number between 1 and 4 appears exactly once per subgrid
:- subgrid(R, C, G), num(V), not 1 { sudoku(R, C, V) : subgrid(R, C, G) } 1.

% Show only the sudoku/3 and subgrid/3 predicates in the output
#show sudoku/3.
#show subgrid/3.
