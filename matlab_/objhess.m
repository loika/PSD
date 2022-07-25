function [ddf, userdata] = objhess(x,Y,userdata)
    %args:
    %x : a vector of real number
    %Y : a vector of matrix
    %userdata : a struct
    %returns:
    %ddf: a matrix
    %userdata : a struct
    %algotithme:
    %calculate hessian of the objective function
	ddf = diag(svec2(funhess(Y{1},userdata.X,userdata.I)));
    
    
  
  
end
