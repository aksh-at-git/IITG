A = [[1,1,0]',[1,0,1]',[0,1,1]'];
% A = eye(3);

% [Q,R] = qr(A)
% disp(Q*R)

[Q1,R1] = householderQR_efficient(A);
disp(Q1*R1);

[Q2,R2] = householderQR_direct(A);
disp(Q2*R2);

[Q3,R3] = givensQR_efficient(A);
disp(Q3*R3);

[Q4,R4] = givensQR_direct(A);
disp(Q4*R4);

[Q5,R5] = cgsQR(A);
disp(Q5*R5);

[Q6,R6] = mgsQR(A);
disp(Q6*R6);

Function Definitions
function [Q,R] = householderQR_efficient(A)
    [m,n] = size(A);
    Q = eye(m);
    for i=1:min(m-1,n)
        u = A(i:m,i);
        sigma = norm(u);
        if sigma~=0
            if u(1)~=0
                sigma = sign(u(1))*sigma;
            end
            u(1) = u(1) + sigma;
            alpha = 1/(conj(sigma)*u(1));
            v = u' * A(i:m,i+1:n);
            w = u' * Q(i:m,:);
            A(i,i) = -sigma;
            A(i+1:m,i) = 0;
            A(i:m,i+1:n) = A(i:m,i+1:n) - (alpha*u)*v;
            Q(i:m,:) = Q(i:m,:) - (alpha*u)*w;
        end
    end
    R = A;
    Q = Q';
end


function [Q,R] = householderQR_direct(A)
    [m,n] = size(A);
    Q = eye(m);
    R = A;
    for i=1:min(m-1,n)
        u = R(i:m,i);
        u(1) = u(1) + sign(u(1))*norm(u);
        u = u/norm(u);
        Hk = eye(m);
        Hk(i:m,i:m) = Hk(i:m,i:m) - 2*(u*u');
        R = Hk * R;
        Q = Q * Hk';
    end
end

function [Q,R] = givensQR_direct (A)
    [m,n] = size(A);
    Q = eye(m);
    for i=1:min(m-1,n)
        for j=m:-1:i+1
            G = eye(m);
            v = A([j-1,j],i);
            if (norm(v)==0 && v(2)==0)
                c = v(1)/norm(v); s = v(2)/norm(v);
                G(j-1,j-1) = c; G(j,j) = c;
                G(j-1,j) = s; G(j,j-1) = -s;
                A = G*A;
                Q = Q*G';
            end
        end
    end
    R = A;
end

function [Q,R] = givensQR_efficient (A)
    [m,n] = size(A);
    Q = eye(m);
    for i=1:min(m-1,n)
        for j=m:-1:i+1
            v = A([j-1,j],i);
            if (norm(v)==0 && v(2)==0)
                c = v(1)/norm(v); s = v(2)/norm(v);
                A = givens_multiplication(c,s,A,j-1,j);
                Q = givens_multiplication(c,s,Q',j-1,j)';
            end
        end
    end
    R = A;
end

function [A] = givens_multiplication(faci, facj, A, i, j)
    rowi = A(i,:) .* faci + A(j,:) .* facj;
    rowj = A(i,:) .* (-facj) + A(j,:) .* faci;
    A(i,:) = rowi;
    A(j,:) = rowj;
end

function [Q,R] = cgsQR(A)
    [m,n] = size(A);
    R = eye(m,n);
    for i=1:n
        for j=1:i-1
            R(j,i) = A(:,j)'*A(:,i);
            A(:,i) = A(:,i) - R(j,i)*A(:,j);
        end
        R(i,i) = norm(A(:,i));
        if R(i,i) ~= 0
            A(:,i) = A(:,i)/R(i,i);
        end
    end
    Q = A;
end

function [Q,R] = mgsQR(A)
    [m,n] = size(A);
    R = eye(m,n);
    for i=1:n
        R(i,i) = norm(A(:,i));
        A(:,i) = A(:,i)/R(i,i);
        for j=i+1:n
            R(i,j) = A(:,i)' * A(:,j);
            A(:,j) = A(:,j) - R(i,j)*A(:,i);
        end
    end
    Q = A;
end