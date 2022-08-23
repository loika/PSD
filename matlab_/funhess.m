function res = funhess(K,X)
    %args:
    %K : a projection matrix 
    %X : a matrix
    %return:
    %res : a matrix
    %algorithmes:
    %calculation of the euclidean hessian of the objective function
    I = eye(size(K));
    X2 = X*X';
    T0 = inv(K .* I);
    T1 = T0 * X2 * T0;
    T2 = I - K;
    T3 = T0 * (K .* T2);
    T4 = I- 2*T3;
    T5 = T1 * T0; 
    dev1 = I.* ( T0*T4*T1 -  T3*T1*T0) +  T5.*(I-2*K) ;
    dev2 = I .* ( (I - 2* T0 * (I.*K)) *T1 );
    res = -2*(dev1 + dev2);
    end

    