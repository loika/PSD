%setting the example
liste_N = [20,40,60];
liste_n = [3,6,9];
nb = length(liste_N);

i = 1;%couples (N,n) i = 1,2,3
N_ = liste_N(i);
n_ = liste_n(i);
x = [2];%variable Xq q:2,3,4
data = readtable("../data/train/X_"+N_+"_"+n_+".csv");

%data set-up part
Pi = table2array(data(:,5));
X = table2array(data(:,x));
N = length(Pi);
data = readtable("../data/train/K_"+N_+"_"+n_+".csv");
K = table2array(data(:,2:end));

penm = create_penlab(Pi,X,K);
prob = penlab(penm);
prob.solve();
disp(prob.Y{1});