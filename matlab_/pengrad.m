function res = pengrad(K,Dpi,I)
    %args:
    %K : a projection matrix 
    %Dpi : a diagonal matrix of probability vectors Pi
    %I : a identity matrix
    %returns:
    %res : a matrix
    %algorithme:
    %calculation of the euclidean gradient of the penality function
    res = 2 * I .* ((K-Dpi));
end