from funpymanopt import *

if __name__ == "__main__":
    N = 20
    n = 3
    x = [1]
    r = 1
    Pi,X = example(N,n,x)
    optimizer = pymanopt.optimizers.trust_regions.TrustRegions()
    v,vcost,itereration,time=solver_pymanopt(Pi,X,r,optimizer,"numpy")
