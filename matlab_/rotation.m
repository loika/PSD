function [Kr,f_Kr,change] = rotation(K,X)
    I = eye(size(K));
    W = sparse(I);
    change = false;
    Kr = K;
    f_Kr = f(Kr,X,I);
    N = length(K);
    for l = 1:(N-1)

        for k = (l+1):N
            sub = Kr(l,l) - Kr(k,k);

            if sub == 0
                continue;
            end

            t = 2*real(Kr(l,k))/sub;
            W = completed_W(W,t,l,k);
            K2 = W * Kr * W';
            f_K2 = f(K2,X,I);

            if f_K2 < f_Kr
                Kr = K2;
                f_Kr = f_K2;
                change = true;        
            end                
            W = reset_W(W,l,k);

        end

    end


end