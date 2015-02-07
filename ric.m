clc, clear


h = 0.1;
A = [1 h;0.5*h 1];
B = [h^2/2; h];
C = [1 0];

n=2;

x0 = [0.5 1]';

r = 1;
q = 3.8;
Q = eye(n)*q;

P = Q;


for i = 1:100
    
   P = Q + A'*P*A - A'*P*B*inv(r + B'*P*B)*B'*P*A;
    
end

K = inv(r+B'*P*B)*B'*P*A

M = 100;
ssd = ss(A-B*K, zeros(2,1), C, 0, h);
t = (0:M-1)*h;
figure(2)
lsim(ssd, zeros(size(t)), t, x0)


