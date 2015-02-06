%
%---Basic system model
%
clear, clc
h = 0.1;
A = [1 h;0.5*h 1];
B = [h^2/2; h];
C = [1 0];
n = size(A,1);
m = size(B,2);
%
%---Parameters
%
q = 3.8;
r = 1;
N = 10;
x0 = [0.5 1]';
%
%---Define matrices for the QP
%
% For you to do!


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

%
%---For the case with actuator constraints
%
Ain = []; % Use empty matrices for the first case without actuator...
bin = []; % ...constraints and change for the case with constraints!
%
%---Cost function
%
Cc = C'*C;
H11 = kron(eye(N), Cc*q);
H11((end-n+1):end, (end-n+1):end) = q*eye(n);
H = [H11, zeros(n*N,N); zeros(n*N,N)', eye(N)*r];

f = zeros(N*n+N,1);

%
%---MPC algorithm
%
M = 100; % simulation time

xk = x0; % initialize state vector
yvec = [];
uvec = [];
options = optimset('Algorithm', 'interior-point-convex', 'Display', 'off');

for k = 1:M,
    beq = AA*xk; % The matrix AA defines how the last measured state xk
    % determines the right hand side of the inequality condition.
    z = quadprog(H, f, Ain, bin, Aeq, beq, [], [], [], options);
    uk = z(n*N+1);
    xk = A*xk + B*uk;
    yvec = [yvec; C*xk];
    uvec = [uvec; uk];
end

tvec = h*(1:1:M);
subplot(3,1,1) % For the other two sets of parameters you should change
               % the third index to 2 and 3, respectively.
plot(tvec, yvec, '-', tvec, uvec, '--');
grid