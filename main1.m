%
%---Basic system model
%
clear all, clc
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

AA = [eye(2); eye(2); eye(2); eye(2); eye(2); zeros(2); zeros(2); zeros(1,2)];

no = zeros(2);
no1 = zeros(2,1);

% Aeq = [A^(-1), no, no, no, no, -A^(-1)*B, no1,       no1,       no1,       no1;
%        no, A^(-2), no, no, no, -A^(-1)*B, -A^(-2)*B, no1,       no1,       no1;
%        no, no, A^(-3), no, no, -A^(-1)*B, -A^(-2)*B, -A^(-3)*B, no1,       no1;
%        no, no, no, A^(-4), no, -A^(-1)*B, -A^(-2)*B, -A^(-3)*B, -A^(-4)*B, no1;
%        no, no, no, no, A^(-5), -A^(-1)*B, -A^(-2)*B, -A^(-3)*B, -A^(-4)*B, -A^(-5)*B
%        no1', no1', no1', no1', no1', 0, 0, 0, 0, 0;
%        no1', no1', no1', no1', no1', 0, 0, 0, 0, 0;
%        no1', no1', no1', no1', no1', 0, 0, 0, 0, 0;
%        no1', no1', no1', no1', no1', 0, 0, 0, 0, 0;
%        no1', no1', no1', no1', no1', 0, 0, 0, 0, 0];

no = zeros(2);
no1 = zeros(2,1);

A11 = [A^(-1), no, no, no, no, no, no, no, no, no;
       no, A^(-2), no, no, no, no, no, no, no, no;
       no, no, A^(-3), no, no, no, no, no, no, no;
       no, no, no, A^(-4), no, no, no, no, no, no;
       no, no, no, no, A^(-5), no, no, no, no, no;
       no, no, no, no, no, A^(-6), no, no, no, no;
       no, no, no, no, no, no, A^(-7), no, no, no;
       no, no, no, no, no, no, no, A^(-8), no, no;
       no, no, no, no, no, no, no, no, A^(-9), no;
       no, no, no, no, no, no, no, no, no, A^(-10)];

A12 = [-A^(-1)*B, no1, no1, no1, no1, no1, no1, no1, no1, no1;
       -A^(-1)*B, -A^(-2)*B, no1, no1, no1, no1, no1, no1, no1, no1;
       -A^(-1)*B, -A^(-2)*B, -A^(-3)*B, no1, no1, no1, no1, no1, no1, no1;
       -A^(-1)*B, -A^(-2)*B, -A^(-3)*B, -A^(-4)*B, no1, no1, no1, no1, no1, no1;
       -A^(-1)*B, -A^(-2)*B, -A^(-3)*B, -A^(-4)*B, -A^(-5)*B, no1, no1, no1, no1, no1;
       -A^(-1)*B, -A^(-2)*B, -A^(-3)*B, -A^(-4)*B, -A^(-5)*B, -A^(-6)*B, no1, no1, no1, no1;
       -A^(-1)*B, -A^(-2)*B, -A^(-3)*B, -A^(-4)*B, -A^(-5)*B, -A^(-6)*B, -A^(-7)*B, no1, no1, no1;
       -A^(-1)*B, -A^(-2)*B, -A^(-3)*B, -A^(-4)*B, -A^(-5)*B, -A^(-6)*B, -A^(-7)*B, -A^(-8)*B, no1, no1;
       -A^(-1)*B, -A^(-2)*B, -A^(-3)*B, -A^(-4)*B, -A^(-5)*B, -A^(-6)*B, -A^(-7)*B, -A^(-8)*B, -A^(-9)*B, no1;
       -A^(-1)*B, -A^(-2)*B, -A^(-3)*B, -A^(-4)*B, -A^(-5)*B, -A^(-6)*B, -A^(-7)*B, -A^(-8)*B, -A^(-9)*B, -A^(-10)*B];

A21 = [no1', no1', no1', no1', no1', no1', no1', no1', no1', no1';
       no1', no1', no1', no1', no1', no1', no1', no1', no1', no1';
       no1', no1', no1', no1', no1', no1', no1', no1', no1', no1';
       no1', no1', no1', no1', no1', no1', no1', no1', no1', no1';
       no1', no1', no1', no1', no1', no1', no1', no1', no1', no1';
       no1', no1', no1', no1', no1', no1', no1', no1', no1', no1';
       no1', no1', no1', no1', no1', no1', no1', no1', no1', no1';
       no1', no1', no1', no1', no1', no1', no1', no1', no1', no1';
       no1', no1', no1', no1', no1', no1', no1', no1', no1', no1';
       no1', no1', no1', no1', no1', no1', no1', no1', no1', no1'];

A22 = zeros(10,10);

Aeq = [A11, A12; A21, A22]

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