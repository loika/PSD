function res = penobj(K,Pi)
    %args:
    %K : a matrix
    %Pi : a probability vector
    %returns:
    %res : real number
    %algorithme:
    %calculation of the penality function 
    res = sum((diag(K) - Pi).^2);
end