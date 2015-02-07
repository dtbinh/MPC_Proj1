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

