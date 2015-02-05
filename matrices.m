clc, clear variables

syms x1 x2

x = [x1;x2];

% AA = [eye(2); eye(2); eye(2); eye(2); eye(2)];
AA = [eye(2); eye(2); eye(2); eye(2); eye(2); zeros(2); zeros(2); zeros(1,2)];

beq = AA*x

%% 
clear, clc

syms x11 x12 x21 x22 x31 x32 u0 u1 u2 q r

x1 = [x11, x12].';
x2 = [x21, x22].';
x3 = [x31, x32].';

z = [x1; x2; x3; u0; u1; u2];

C = [1, 0];
Cc = C'*C;
noll = zeros(2);
I = eye(2);
z1 = zeros(2,1);
N = 5;
n = 2;

H1 = kron(eye(N), Cc*q);
H1((end-n+1):end, (end-n+1):end) = q*eye(n);

H = [H1, zeros(n*N,N); zeros(n*N,N)', eye(N)*r]

% z.'*H*z

%% 
clc, clear

h = 0.1;
A = [1 h;0.5*h 1];
B = [h^2/2; h];

no = zeros(2);
no1 = zeros(2,1);

Aeq = [A^(-1), no, no, no, no, -A^(-1)*B, no1, no1, no1, no1
       no, A^(-2), no, no, no, -A^(-1)*B, -A^(-2)*B, no1, no1, no1;
       no, no, A^(-3), no, no, -A^(-1)*B, -A^(-2)*B, -A^(-3)*B, no1, no1;
       no, no, no, A^(-4), no, -A^(-1)*B, -A^(-2)*B, -A^(-3)*B, -A^(-4)*B, no1;
       no, no, no, no, A^(-5), -A^(-1)*B, -A^(-2)*B, -A^(-3)*B, -A^(-4)*B, -A^(-5)*B];
