function res = penhess(K,Dpi,I)
    %args:
    %K : a projection matrix 
    %Dpi : a diagonal matrix of probability vectors Pi
    %I : a identity matrix
    %returns:
    %res : a matrix
    %algorithme:
    %calculation of the euclidean hessian of the penality function
    res = 2 * I;    
end