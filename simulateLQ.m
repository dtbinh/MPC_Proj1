function [y, u] = simulateLQ(K, x0, M, A, B, C)

xk = x0;
u = [];
y = C*x0;

for i = 1:M
   
    uk = -K*xk;
    xk = A*xk + B*uk;
%     xk = (A-B*K)*xk;
    
    y = [y; C*xk];
    u = [u; uk];
    
end



end