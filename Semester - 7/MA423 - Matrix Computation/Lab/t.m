A = [3 2; 4 5;];
[M, I] = max(A, [], "all");
[r, c] = find(A == M);

if r ~= 1
    A([1, r], : ) = A([r, 1], : );
end

if c ~= 1
    A(:, [1, c]) = A(:, [c, 1]);
end

A
