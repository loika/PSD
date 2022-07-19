function [Kr,f_Kr,cpt] = rotation(K,X)
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
    N = length(K);
    I = eye(size(K));
    W = sparse(I);
    Kr = K;
    f_Kr = f(Kr,X,I);
    boucle = true;
    cpt = 0;
    
    while true
        
        boucle = false;
        
        for l = 1:N
            
            for k = (l+1):N
                t = 2*real(Kr(l,k))/(Kr(l,l) - Kr(k,k));
                cos_theta = 1/sqrt(1+t*t);
                sin_theta = t *  cos_theta;
                W(l,l) = cos_theta;
                W(k,k) = cos_theta;
                W(l,k) = sin_theta;
                W(k,l) = -sin_theta;
                K2 = W * Kr * W';
                f_K2 = f(K2,X,I);

                if f_K2 < f_Kr
                    Kr = K2;
                    f_Kr = f_K2;
                    boucle = true;
                end
                
                W(l,l) = 1;
                W(k,k) = 1;
                W(l,k) = 0;
                W(k,l) = 0;

            end
            
        end
        
        if boucle
            cpt = cpt + 1;
        else
            break
        end
        
    end
    
end