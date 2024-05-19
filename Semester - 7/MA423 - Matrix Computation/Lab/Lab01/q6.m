A = diag(-1*ones(16, 1)+(-1)*ones(16,1)) + diag(ones(15, 1), 1) + diag(ones(15, 1), -1);
A(end, 1) = 1
A(1, end) = 1