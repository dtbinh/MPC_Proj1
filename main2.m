clear, clc

% Constrained control signal

h = 0.1;
A = [1 h;0.5*h 1];
B = [h^2/2; h];
C = [1 0];
n = size(A,1);
m = size(B,2);

%
%---Parameters
%

x0 = [0.5 1]';



%
%---For the case with actuator constraints
%
Ain = []; % Use empty matrices for the first case without actuator...
bin = []; % ...constraints and change for the case with constraints!

r = 1;

N = 5;
q = 3.8;

[H1, Aeq1, AA1, f1] = matrices(N, n, A, B, C, q, r);

N = 10;
q = 3.8;

[H2, Aeq2, AA2, f2] = matrices(N, n, A, B, C, q, r);

N = 10;
q = 10;

[H3, Aeq3, AA3, f3] = matrices(N, n, A, B, C, q, r);


%
%---MPC algorithm
%
M = 300; % simulation time

[y1, u1] = simulateMPC(H1, f1, Ain, bin, Aeq1, x0, M, AA1, A, B, C, 5, n);
[y2, u2] = simulateMPC(H2, f2, Ain, bin, Aeq2, x0, M, AA2, A, B, C, 10, n);
[y3, u3] = simulateMPC(H3, f3, Ain, bin, Aeq3, x0, M, AA3, A, B, C, 10, n);


t = h*(0:M-1);
figure(1)
clf
subplot(3,1,1) % For the other two sets of parameters you should change
               % the third index to 2 and 3, respectively.
plot(t, y1, '-', t, u1, '--');
grid

subplot(3,1,2)
plot(t, y2, '-', t, u2, '--');
grid
subplot(3,1,3)
plot(t, y3, '-', t, u3, '--');
grid


