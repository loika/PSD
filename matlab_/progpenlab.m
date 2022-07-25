%setting the example
liste_N = [20,40,60];
liste_n = [3,6,9];
nb = length(liste_N);

i = 1;%couples (N,n) i = 1,2,3
N_ = liste_N(i);
n_ = liste_n(i);
q = 1; %variable Xq q:1,2,3
data = readtable("../sample/X_"+N_+"_"+n_+".csv");

%data set-up part
Pi = table2array(data(:,5));
X = table2array(data(:,q+1));
N = length(Pi);
data = readtable("../sample/K_"+N_+"_"+n_+".csv");
K = table2array(data(:,2:end));

penm = create_penlab(Pi,X,K);
prob = penlab(penm);
prob.solve();
disp(prob.Y{1});