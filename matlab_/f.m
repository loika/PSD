function res = f(K,X)
    %args:
    %K : a projection matrix
    %X : a matrix
    %returns:
    %res : real number 
    %algorithme:
    %calculation of the objective function
    I = eye(size(K));
    D = K.* I;
    invD = inv(D);
    invD_X = inv(D)*X;
    res = trace(invD_X' * (K .* (I - K)) * invD_X);
end