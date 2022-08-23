%setting the example
liste_N = [20,40,60];
liste_n = [3,6,9];
nb = length(liste_N);
i = 3;%couples (N,n) i = 1,2,3
N_ = liste_N(i);
n_ = liste_n(i);
x = [2];%variable Xq q:2,3,4
data = readtable("../sample/X_"+N_+"_"+n_+".csv");



%data set-up part
Pi = table2array(data(:,5));
X = table2array(data(:,x));
r = 1;
N = length(Pi);
n = floor(sum(Pi));
vector = zeros(size(Pi));

%algorithm part
manifold = grassmannfactory(N,n);
methode = @trustregions;
v = [];
problem = create_manopt(manifold,Pi,X,r);
[v,vcost,iter,time] = solve_manopt(problem,methode,v);






