%% Section-1
A = rand(8);
A;
max_in_col = max(A, [], 1);
max_in_row = max(A, [], 2);
max_all = max(A, [], "all");
max_in_row;
max_in_col;
max_all;


%% Section-2
[r, c] = find(A > 0.25);
[r c];
%% 
B = [1, 2; 3,6;];
[x, y] = find(max(max(B)) == B);
x,y