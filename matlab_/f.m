function res = f(K,X,I)
    %args:
    %K : a projection matrix
    %X : a matrix
    %I : a identity matrix
    %returns:
    %res : real number 
    %algorithme:
    %calculation of the objective function 
    D = K.* I;
    invD = inv(D);
    invD_X = inv(D)*X;
    res = trace(invD_X' * (K .* (I - K)) * invD_X);
end