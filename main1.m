%
%---Basic system model
%
clear;
h=0.1;
A=[1 h;0.5*h 1];
B=[h^2/2; h];
C=[1 0];
n=size(A,1);
m=size(B,2);
%
%---Parameters
%
q=3.8;
r=1;
N=5;
x0=[0.5 1]';
%
%---Define matrices for the QP
%
For you to do!
%
%---For the case with actuator constraints
%
Ain = []; % Use empty matrices for the first case without actuator...
bin = []; % ...constraints and change for the case with constraints!
%
%---Cost function
%
For you to do!
%
%---MPC algorithm
%
M=100; % simulation time

xk=x0; % initialize state vector
yvec=[];
uvec=[];
options = optimset('Algorithm', 'interior-point-convex', 'Display', 'off');

for k = 1:M,
    beq = AA*xk; % The matrix AA defines how the last measured state xk
    % determines the right hand side of the inequality condition.
    z = quadprog(H,f,Ain,bin,Aeq,beq,[],[],[],options);
    uk = z(n*N+1);
    xk = A*xk+B*uk;
    yvec = [yvec; C*xk];
    uvec = [uvec; uk];
end

tvec = h*(1:1:M);
subplot(3,1,1) % For the other two sets of parameters you should change
               % the third index to 2 and 3, respectively.
plot(tvec, yvec, '-', tvec, uvec, '--');
grid