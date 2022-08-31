%setting the example
liste_N = [20,40,60];
liste_n = [3,6,9];
nb = length(liste_N);

i = 1;%couples (N,n) i = 1,2,3
N_ = liste_N(i);
n_ = liste_n(i);
x = [2];%variable Xq q:2,3,4

%data set-up part
data1 = readtable("../data/train/K_"+N_+"_"+n_+".csv");
K = table2array(data1(:,2:end));
data2 = readtable("../data/train/X_"+N_+"_"+n_+".csv");
X = table2array(data2(:,x));
problem.K = K;
problem.X = X;
[Kr,f_Kr,cpt] = solver_rotation(problem);