A = rand(4); 
b = A*(1:1:4)';
x1 = A\b;
[L,U] = GENP(A); 

x2 = U\(L\b); 
disp(x1);
disp(x2); 
[L1, U1, P1] = GEPP(A);
x3 = U1\(L1\(P1*b));
disp(x3);
[L2, U2, P2, Q2] = GECP(A);
x4 = Q2*(U2\(L2\(P2*b)));
disp(x4);

function [L, U] = GENP(A)
    [~,n] = size(A);
    for k = 1: n-1
        for i = k+1:n
            A(i,k) = A(i,k)/A(k,k); 
            A(i,k+1:n) = A(i,k+1:n) - A(i,k).*A(k,k+1:n);
        end
    end
    U = triu(A);
    L = tril(A, -1) + eye(n); 
end

function [L, U, P] = GEPP(A)
    [~,n] = size(A);
    P = eye(n);
    for k = 1: n-1
        [~, idx] = max(abs(A(k:n,k)));
        idx = idx + k -1; 
        if idx ~= k
            A([k idx], :) = A([idx k], :);
            P([k idx], :) = P([idx k], :);
        end
        for i = k+1:n
            A(i,k) = A(i,k)/A(k,k); 
            A(i,k+1:n) = A(i,k+1:n) - A(i,k).*A(k,k+1:n);
        end
    end
    U = triu(A);
    L = tril(A, -1) + eye(n); 
end

function [L, U, P, Q] = GECP(A)
    [~,n] = size(A);
    P = eye(n);
    Q = eye(n);
    for k = 1: n-1
        [~, idx] = max(abs(A(k:n,k:n)),[],"all");
        [r,c] = ind2sub(size(A(k:n,k:n)),idx);
        r = k-1 + r;
        c = k-1 +c;

        if r ~= k
            A([k r], :) = A([r k], :);
            P([k r], :) = P([r k], :);
        end
        if c ~= k
            A(:, [k c]) = A(:, [c k]);
            Q(:, [k c]) = Q(:, [c k]);
        end
        for i = k+1:n
            A(i,k) = A(i,k)/A(k,k); 
            A(i,k+1:n) = A(i,k+1:n) - A(i,k).*A(k,k+1:n);
        end
    end
    U = triu(A);
    L = tril(A, -1) + eye(n); 
end