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

% Define the subgrids: each cell belongs to a subgrid 1, 2, 3, or 4
subgrid(R, C, 1) :- row(R), col(C), R <= 2, C <= 2.  % Top-left subgrid
subgrid(R, C, 2) :- row(R), col(C), R <= 2, C > 2.   % Top-right subgrid
subgrid(R, C, 3) :- row(R), col(C), R > 2, C <= 2.   % Bottom-left subgrid
subgrid(R, C, 4) :- row(R), col(C), R > 2, C > 2.    % Bottom-right subgrid

% Show the subgrid predicates first, then the sudoku predicates
#show subgrid/3.
#show sudoku/3.
