function [penm] = create_penlab(Pi,X,K)
    %args:
    %Pi : a proability vector
    %X : a matrix
    %K : a matrix
    %returns:
    %penm : struct
    %algorithme:
    %completed the structure in order to solve the problem in function of K

  penm = [];

  penm.probname = 'constrained optimization';
  penm.comment  = 'the program does not work';



  % keep the whole structure

  N = length(Pi);
  n = floor(sum(Pi));
  penm.userdata.Pi = Pi;
  penm.userdata.X = X;
  penm.userdata.I = eye(N,N);
  [dum,idiag] = svec2(penm.userdata.I); clear dum
  penm.userdata.idiag = idiag;

  % zeros 'normal' variable
  penm.Nx = 0;
  % one matrix variable
  penm.NY = 1;
  penm.Y{1} = ones(N,N); % to define sparsity structure of Y

  % box constraints on matrix variables
  penm.lbY = [0];
  penm.ubY = [1];
  
  % nonlinear constraints
  penm.NgNLN = N;
  penm.lbg = Pi;
  penm.ubg = Pi;

  penm.objfun  = @objfun;
  penm.objgrad = @objgrad;
  penm.objhess = @objhess;

  penm.confun  = @confun;
  penm.congrad = @congrad;
  penm.conhess = @conhess; 
  
  % starting point
  penm.Yinit{1} = K;

