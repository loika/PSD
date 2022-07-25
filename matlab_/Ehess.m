function res = Ehess(v,H,Dpi,X,I,r)
    %args:
    %v : a projection vector
    %H : struct manopt link with the derivation of v
    %Dpi : a diagonal matrix of probability vectors Pi
    %X : a matrix
    %I : a identity matrix
    %r : a penality factor
    %returns:
    %res : a matrix
    %algorithme:
    %calculation of the hessian of the objective function
    %and of the penalty function
    K = v * v';
    derive1 = 2 * (funhess(K,X,I) + r*penhess(K,Dpi,I)) * (v*H' + H*v' )*v;
    derive2 = 2 * (fungrad(K,X,I) + r * pengrad(K,Dpi,I) )*H ;
    res = derive1 + derive2;
end