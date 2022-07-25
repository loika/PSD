function res = Cost(v,Pi,X,I,r)
    %args:
    %v : a projection vector 
    %Pi : a proability vector 
    %X : a matrix
    %I : a identity matrix
    %r : a penality factor
    %returns:
    %res : real number
    %algorithme:
    %calculation of the cost of the objective function
    %and of the penalty function
    K = v*v';
    res =  f(K,X,I) +r * penobj(K,Pi) ;
end