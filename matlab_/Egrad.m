function res = Egrad(v,Dpi,X,I,r)
    %args:
    %v : a projection vector
    %Dpi : a diagonal matrix of probability vectors Pi
    %X : a matrix
    %I : a identity matrix
    %r : a penality factor
    %returns:
    %res : a matrix
    %algorithme:
    %calculation of the gradiant of the objective function
    %and of the penalty function
    K = v*v';    
    res = 2*(fungrad(K,X,I) + r * pengrad(K,Dpi,I) )*v ;
end