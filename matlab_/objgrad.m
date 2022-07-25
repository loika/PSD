function [df, userdata] = objgrad(x,Y,userdata)
    %args:
    %x : a vector of real number
    %Y : a vector of matrix
    %userdata : a struct
    %returns:
    %df: a vector
    %userdata : a struct
    %algotithme:
    %calculate gradient of the objective function
    df = svec2(fungrad(Y{1},userdata.X,userdata.I));
end

