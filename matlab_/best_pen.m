function [best] = best_pen(manifold,methode,Pi,X,L)
    %args:
    %manifold : struct Manifold of manopt
    %Pi : a probability vector
    %methode : solver of manopt
    %X : matrix
    %L : vector of penalization factors
    %returns:
    %best : struct best.K is a ker, best.r is a penality factor,
    %best.P a penality factor multiply penality function
    %best.v a projection vector
    %algorithme:
    %find the best in function
    %of min penality factor multiply penality function
    P = [];
    Ker = [];
    V = [];
    problem = create_manopt(manifold,Pi,X,L(1));
    [v,vcost,iter,time] = solve_manopt(problem,methode,[]);clear vcost;clear iter;clear time;
    K = v * v';
    P(1) =  lambda * penobj(K,Pi);
    Ker(1) = K;
    V(1) = v; 
    for i = 2:length(L)
        r = L(i);
        problem = create_manopt(manifold,Pi,X,r);
        [v,vcost,iter,time] = solve_manopt(problem,methode,v);clear vcost;clear iter;clear time;
        K = v * v';
        P(i) =  lambda * penobj(K,Pi);
        Ker(i) = K;
        V(i) = v;
    end
    index = find(P == min(P));
    best.K = Ker(index);
    best.P = P(index);
    best.r = L(index);
    best.v = V(index):

end