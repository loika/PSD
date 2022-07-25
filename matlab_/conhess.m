function [ddgk, userdata] = conhess(x,Y,k,userdata)
    %args:
    %x : a vector of real number
    %Y : a vector of matrix
    %k : a interger
    %userdata : a struct
    %returns:
    %ddgk : a matrix
    %userdata : a struct
    %algotithme:
    %completes the constraint hessian

    n = length(Y{1});
    nn = n*(n+1)/2;

    ddgk = zeros(nn,nn);

