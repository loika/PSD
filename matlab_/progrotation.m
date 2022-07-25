%setting the example
liste_N = [20,40,60];
liste_n = [3,6,9];
nb = length(liste_N);

i = 1;%couples (N,n) i = 1,2,3
N_ = liste_N(i);
n_ = liste_n(i);
q = 1;

%data set-up part
data1 = readtable("../sample/K_"+N_+"_"+n_+".csv");
K = table2array(data1(:,2:end));
data2 = readtable("../sample/X_"+N_+"_"+n_+".csv");
X = table2array(data2(:,1+q));

[Kr,f_Kr,cpt] = algo_rotation(K,X);% algo_rotation(K,X)