function [problem] = create_manopt(manifold,Pi,X,r)
    %args:
    %manifold : struct Manifold of manopt
    %Pi : a probability vector
    %X : a matrix
    %r : a penality factor
    %returns:
    %problem : struct
    %algorithme:
    %defines the cost,gradiant,hessian 
    %in the problem in function of manifold,Pi,X,r
    
    Dpi = diag(Pi);
    problem.M = manifold;
    problem.cost  = @(v) Cost(v,Pi,X,r);
    problem.egrad = @(v) Egrad(v,Dpi,X,r);
    problem.ehess = @(v,H) Ehess(v,H,Dpi,X,r);
    
end