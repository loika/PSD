function [v,vcost,iter,time] = solve_manopt(problem,methode,v)
    %args:
    %problem : struct of manopt
    %methode :solver of manopt
    %v : a projection vector
    %returns:
    %v : a matrix of projection
    %vcost : the cost value attained by v
    %iter : total number of iterations
    %time : total tumber of time
    %algorithme:
    %find the best projection matrix for the problem and methode
    %and projection matrix 
    [v, vcost, info, options] = methode(problem,v);
    Iter = [info.iter];
    Time = [info.time];
    Cost = [info.cost];
    iter = Iter(end);
    time = Time(end);
   while ~(Cost(end) == Cost(end - 1)) && Iter(end) == 1000
        [v, vcost, info, options] = methode(problem,v,options);
        Iter = [info.iter];
        Time = [info.time];
        Cost = [info.cost];
        iter = iter + Iter(end);
        time = time + Time(end);
    end
end