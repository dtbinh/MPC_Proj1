function [y, u] = simulateMPC(H, f, Ain, bin, Aeq, x0, M, AA, A, B, C, N, n)

xk = x0; % initialize state vector
y = [];
u = [];
options = optimset('Algorithm', 'interior-point-convex', 'Display', 'off');

for k = 1:M,
    beq = AA*xk; % The matrix AA defines how the last measured state xk
    % determines the right hand side of the inequality condition.
    
    z = quadprog(H, f, Ain, bin, Aeq, beq, [], [], [], options);
    uk = z(n*N+1);
    xk = A*xk + B*uk;
    y = [y; C*xk];
    u = [u; uk];
end


