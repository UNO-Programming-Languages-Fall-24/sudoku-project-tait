% Sudoku Solver for 4x4 Grid
% The grid is filled with numbers 1 to 4, and each number appears exactly once in each row, column, and subgrid.

% Define the grid size and possible numbers
num(1..4).
row(1..4).
col(1..4).

% A valid number must be placed in each cell of the grid
1 { sudoku(X, Y, N) : num(N) } 1 :- row(X), col(Y).

% Row constraint: each number appears exactly once in each row
:- sudoku(X, Y1, N), sudoku(X, Y2, N), Y1 != Y2, num(N).

% Column constraint: each number appears exactly once in each column
:- sudoku(X1, Y, N), sudoku(X2, Y, N), X1 != X2, num(N).

% Subgrid constraint: each number appears exactly once in each 2x2 subgrid
:- sudoku(X1, Y1, N), sudoku(X2, Y2, N), X1 != X2, Y1 != Y2,
   (1 + ((X1 - 1) / 2) * 2 + (Y1 - 1) / 2) == (1 + ((X2 - 1) / 2) * 2 + (Y2 - 1) / 2), num(N).

% Only show the sudoku solution
#show sudoku/3.
