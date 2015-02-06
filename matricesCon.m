function [H, Aeq, AA, f, Ain, bin] = matricesCon(N, n, A, B, C, q, r)


Cc = C'*C;
H11 = kron(eye(N), Cc*q);
H11((end-n+1):end, (end-n+1):end) = q*eye(n);
H = [H11, zeros(n*N,N); zeros(n*N,N)', eye(N)*r];

f = zeros(N*n+N,1);

AA = [kron(ones(N,1), eye(2)); zeros(N, n)];

A11 = zeros(N*n);
for k = 0:N-1
    
   A11(k*n+1:k*n+n, k*n+1:k*n+n) = A^(-(k+1));
    
end

A12 = [];
for k = 0:N-1
    A12 = [A12, kron([zeros(k, 1); ones(N-k, 1)], -A^(-(k+1))*B)];
    
end
A21 = zeros(N, N*n);
A22 = zeros(N,N);

Aeq = [A11, A12; A21, A22];

bin = [ones(N,1); zeros(N,1); ones(N,1)];

Ain = [zeros(N, n*N), eye(N);
       zeros(N, N*n+N);
       zeros(N, N*n), -1*eye(N)];

