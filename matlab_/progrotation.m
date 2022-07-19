%setting the example
liste_N = [20,40,60];
liste_n = [3,6,9];
nb = length(liste_N);

i = 1;%couples (N,n) i = 1,2,3
N_ = liste_N(i);
n_ = liste_n(i);

%data set-up part
data = readtable("../sample/K_"+N_+"_"+n_+".csv");
K = table2array(data(:,2:end));

[Kr,f_Kr,cpt] = rotation(K,X);