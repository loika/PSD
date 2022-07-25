function [dg, userdata] = congrad(x,Y,userdata)
    
    %args:
    %x : a vector of real number
    %Y : a vector of matrix
    %userdata : a struct
    %returns:
    %dg : a matrix
    %userdata : a struct
    %algorithme:
    %completes the constraint gradient
    
    n = length(Y{1});
    nn = n*(n+1)/2;
    idiag = userdata.idiag;

    dg = sparse(nn,n);

    for i=1:n
      dg(idiag(i),i) = 1;
    end
 
end
