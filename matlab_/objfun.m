function [fY,userdata] = objfun(x,Y,userdata)
    %args:
    %x : a vector of real number
    %Y : a vector of matrix
    %userdata : a struct
    %returns:
    %fY: a real number
    %userdata : a struct
    %algotithme:
    %calculate the objective function
    
    fY = f(Y{1},userdata.X,userdata.I);
 
end

