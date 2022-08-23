function res = fungrad(K,X)
    %args:
    %K : a projection matrix 
    %X : a matrix

    %return:
    %res : a matrix
    %algorithmes:
    %calculation of the euclidean gradient of the objective function
    I = eye(size(K));
    X2 = X*X';
    T0 = inv(K.*I);
    T1 = T0*X2*T0;
    T2 = I - K; 
    T3 = K .* T2;
    T4 = T1 * T3 * T0;
    
    res = I .* (T1 * (I - 2*(K.*(I-K))*T0 )) - 2 * T1 .* K;
 end