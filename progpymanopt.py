import autograd.numpy as anp
import torch
import pymanopt
import pymanopt.manifolds
import pymanopt.optimizers
import pandas as pd

SUPPORTED_BACKENDS = ("autograd", "numpy","pytorch")#tensorflow will be next version

#OBJECTIVE FUNCTION

def funobj(K,X,I):

    D = K * I
    invD = anp.linalg.inv(D)
    invD_X = invD @ X

    return anp.trace( invD_X.T @ (K * (I-K)) @ invD_X)

#PENALITY FUNCTION
def penobj(K,Pi):

    sub = anp.diag(K) - Pi

    return anp.sum(sub * sub)

#EUCLIDIEAN GRADIANT

def fungrad(K,X,I):

    D = K * I
    T0 = anp.linalg.inv(D)
    X_2 = X @ X.T
    T1 = T0 @ X_2 @ T0
    T2 = I - K
    T3 = K * T2

    return I * (T1 @ (I - 2*T3@T0)) -2*K*T1

def pengrad(K,Dpi,I):

    return 2 * I * (K - Dpi)

#EUCLIDIEAN HESSIAN

def funhess(K,X,I):

    X2 = X @ X.T
    D = K * I
    T0 = anp.linalg.inv(D)
    T1 = T0 @ X2 @ T0
    T2 = T0 @ (K * (I-K))
    T3 = (I * T1) @ T0
    T4 = 2 * T0 @ ((I - 2*T2 )*I) @ T1;
    T5 = -T2 @ T3
    derive1 = (T4 + T5) * I + T3 * (I-2*K)
    derive2 = ((I - 2 * T0 @ (I * K)) @ T1) * I

    return -2 * (derive1 + derive2)

def penhess(K,Dpi,I):

    return 2 * I

def checking_Pi(Pi):

    if not(isinstance(Pi,anp.ndarray)):
        raise ValueError(f"Pi is not nympy | type of Pi:'{type(Pi)}'")

    if not(len(Pi.shape) == 1 ):
        raise ValueError(f"Pi is not vector numpy")

    if not(anp.any((0 < Pi) & (Pi < 1))):
        raise ValueError(f"Pi is not vector of probability| the elemeents:'{Pi[~anp.any((0 < Pi) & (Pi < 1))]}'")

    n = anp.sum(Pi)

    if not( anp.isclose(n%1,0)):
        raise ValueError(f"sum Pi is very different finterger| sum Pi:'{n}'")

    if not(anp.any((0 < Pi) & (Pi < 1))):
        raise ValueError(f"Pi is not vector of probability| the elemeents:'{Pi[~anp.any((0 < Pi) & (Pi < 1))]}'")

    return Pi.shape[0],int(anp.sum(Pi))

def checking_X(X):

    if not(isinstance(X,anp.ndarray)):
        raise ValueError(f"Pi is not nympy | type of X:'{type(X)}'")

    if not(len(X.shape) == 2 ):
        raise ValueError(f"X dimension is not matrix numpy ")

    return None

def checking_r(r):

    if not( isinstance(r,int) or isinstance(r,float) ):
        raise ValueError(f"r is not int or float| type of r:'{type(r)}'")

    return None

def create_cost_derivate(manifold,Pi,X,r,backend):

    euclidean_gradient = euclidean_hessian = None

    if backend == "autograd":
        Dpi = anp.diag(Pi)
        I = anp.eye(N)
        @pymanopt.function.autograd(manifold)
        def cost(v):
            K = v @ v.T

            return funobj(K,X,I)  + r * penobj(K,Pi)

    elif backend == "numpy":
        Dpi = anp.diag(Pi)
        I = anp.eye(N)
        @pymanopt.function.numpy(manifold)
        def cost(v):
            K = v @ v.T
            return funobj(K,X,I) + r * penobj(K,Pi)

        @pymanopt.function.numpy(manifold)
        def euclidean_gradient(v):
            K = v @ v.T
            return 2 * (fungrad(K,X,I) + r * pengrad(K,Dpi,I)) @ v

        @pymanopt.function.numpy(manifold)
        def euclidean_hessian(v,H):
            K = v @ v.T
            return  2 * ((funhess(K,X,I) + r * penhess(K,Dpi,I)) @ (v @ H.T  + H @ v.T) @ v + (fungrad(K,X,I) +  r * pengrad(K,Dpi,I)) @ H)

    elif backend == "pytorch":
        Pi_ = torch.from_numpy(Pi)
        X_  = torch.from_numpy(X)
        I = torch.eye(N)
        @pymanopt.function.pytorch(manifold)
        def cost(v):
            K = v @ v.T
            D = K * I
            invD = torch.linalg.inv(D)
            invD_X_ =  invD @ X_

            return torch.trace( invD_X_.T @ (K * (I-K)) @  invD_X_) + r * torch.sum((torch.diag(K) - Pi_)**2)
    else:
        raise ValueError(f"Unsupported backend '{backend}'")

    return cost,euclidean_gradient,euclidean_hessian

def example(N,n,q):
    data1 = pd.read_csv("../sample/X_"+str(N)+'_'+str(n)+".csv")
    data2 = pd.read_csv("../sample/Ppi_X"+str(q)+'_'+str(N)+'_'+str(n)+".csv")
    data3 = pd.read_csv("../sample/K_"+str(N)+'_'+str(n)+".csv",usecols=['V'+str(i) for i in range(1,N+1)])
    data4 = pd.read_csv("../sample/Kr_X"+str(q)+'_'+str(N)+'_'+str(n)+".csv",usecols=['V'+str(i) for i in range(1,N+1)])
    Pi = data1["pi"].to_numpy()
    X = data1['x'+str(q)].to_numpy().reshape((N,1))
    Ppi = data2.to_numpy()
    K = data3.to_numpy()
    K_r = data4.to_numpy()
    return Pi,X,Ppi,K,K_r.real


def solver_pymanopt(Pi,X,r,optimizer,backend):
    N,n = checking_Pi(Pi)
    checking_X(X)
    checking_r(r)

    if not(X.shape[0] == N):
        raise ValueError(f"X and Pi no match | dimension of X :'{X.shape}' and dimension of Pi :'{Pi.shape}' ")

    manifold = pymanopt.manifolds.grassmann.Grassmann(N, n)
    cost,euclidean_gradient,euclidean_hessian = create_cost_derivate(manifold,Pi,X,r,backend)
    problem = pymanopt.Problem(manifold,cost,euclidean_gradient=euclidean_gradient,euclidean_hessian=euclidean_hessian)


    result = optimizer.run(problem)
    iteration = result.iterations
    time = result.time
    prev_cost = result.cost

    result = optimizer.run(problem,initial_point = result.point)
    iteration += result.iterations
    time += result.time
    new_cost = result.cost

    while not (anp.isclose(prev_cost,new_cost)):
        result = optimizer.run(problem,initial_point = result.point)
        iteration += result.iterations
        time += result.time
        prev_cost = new_cost
        new_cost = result.cost

    return result.point,result.cost,iteration,time


if __name__ == "__main__":
    import csv
    N = 20
    n = 3
    q = 1
    r = 1
    i = 0
    Pi,X,Ppi,K,K_r = example(N,n,q)
    optimizer = pymanopt.optimizers.trust_regions.TrustRegions()

    v,vcost,itereration,time=solver_pymanopt(Pi,X,r,optimizer,"numpy")

