clc, clear

h = 0.1;
A = [1 h;0.5*h 1];
B = [h^2/2; h];
q = 3.8;
r = 1;
syms p1 p2 p12
Q = eye(2)*q;

[K, S, e] = lqrd(A, B, Q, r, h)
