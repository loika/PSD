%setting the example
liste_N = [20,40,60];
liste_n = [3,6,9];
nb = length(liste_N);
for n = [2 3]
    i = 1;%couples (N,n) i = 1,2,3
    N_ = liste_N(i);
    n_ = liste_n(i);
    q = 1; %variable Xq q:1,2,3
    data = readtable("../sample/X_"+N_+"_"+n_+".csv");



    %data set-up part
    Pi = table2array(data(:,5));
    X = table2array(data(:,q+1));
    %r = 1;
    N = length(Pi);
    n = floor(sum(Pi));
    vector = zeros(size(Pi));

    %algorithm part
    manifold = grassmannfactory(N,n);
    methode = @trustregions;
    v = [];
    for j = 0:10
        r = 10^j;
        problem = create_manopt(manifold,Pi,X,r);
        [v,vcost,iter,time] = solve_manopt(problem,methode,v);
        K = v*v';
        vector(1) = vcost;
        vector(2) = f(K,X,eye(size(K)));
        vector(3) = iter;
        vector(3) = time;
        csvwrite("man/r"+j+"_"+"X"+q+"_"+N+"_"+n+".csv",[K vector])
    end
end
%fprintf("%2.6f",f(K,X,eye(size(K))));






