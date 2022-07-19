function res = funhess(K,X,I)
    %args:
    %K : a projection matrix 
    %X : a matrix
    %I : a identity matrix
    %return:
    %res : a matrix
    %algorithmes:
    %calculation of the euclidean hessian of the objective function
    X2 = X*X';
    T0 = inv(K .* I);
    T1 = T0 * X2 * T0;
    T2 = T0 * (K .* (I-K));
    T3 = (I.*T1)*T0;
    T4 = 2 * T0 * ((I - 2*T2 ).*I) * T1;
    T5 = -T2*T3; 
    dev1 = (T4 + T5).*I +  T3 .* (I-2*K) ;
    dev2 = I .* ( (I - 2* T0 * (I.*K)) *T1 );
    res = -2 * (dev1 + dev2);
    end

    