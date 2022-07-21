function [g,userdata] = confun(x,Y,userdata)
    %args:
    %x : a vector of real number
    %Y : a vector of matrix
    %userdata : a struct
    %returns:
    %g : a vector
    %userdata : a struct
    %algorithme:
    %completes the constraint vector

    for i=1:length(Y{1})
        g(i,1) = Y{1}(i,i) ;
    end
end
