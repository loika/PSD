function [Kr,f_Kr,cpt] = solver_rotation(problem)
    %args:
    %K : a matrix
    %X : a matrix
    %returns:
    %Kr : a matrix
    %f_Kr : a real number
    %cpt : a interger
    %algorithme:
    %Kr is a K-simular matrix obtained
    %by matrix multiplication of rotation matrix.
    %Kr is the simular matrix at K that minimizes the objective function.
    %f_Kr objective function of Kr
    %cpt is rotation number
    cpt = 0;
    K = problem.K;
    X = problem.X;
    [Kr,f_Kr,change] = rotation(K,X);
    cpt = cpt + change;
    while change        
        [Kr,f_Kr,change] = rotation(Kr,X);
        cpt = cpt + change;                
    end
    
end