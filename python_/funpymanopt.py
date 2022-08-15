import autograd.numpy as anp
import torch
import pymanopt
import pymanopt.manifolds
import pymanopt.optimizers
import pandas as pd
import tensorflow as tf

SUPPORTED_BACKENDS = ("autograd", "numpy", "pytorch", "tensorflow")

# OBJECTIVE FUNCTION


def funobj(K, X, I):
    """
    args:
    K a numpy dim-2
    X a numpy dim-2
    I a numpy dim-2
    returns:
    a numpy float
    algo:
    calculate the objective function
    """
    D = K * I
    invD = anp.linalg.inv(D)
    invD_X = invD @ X

    return anp.trace(invD_X.T @ (K * (I - K)) @ invD_X)


# PENALITY FUNCTION
def penobj(K, Pi):
    """
    args:
    K a numpy dim-2
    Pi a numpy dim-1
    returns:
    a numpy float
    algo:
    calculate the penality function
    """
    sub = anp.diag(K) - Pi

    return anp.sum(sub * sub)


# EUCLIDIEAN GRADIANT


def fungrad(K, X, I):
    """
    args:
    K a numpy dim-2
    X a numpy dim-2
    I a numpy dim-2
    returns:
    a numpy dim-2
    algo:
    calculate the gradient euclidiean of the objective function
    """
    D = K * I
    T0 = anp.linalg.inv(D)
    X_2 = X @ X.T
    T1 = T0 @ X_2 @ T0
    T2 = I - K
    T3 = K * T2

    return I * (T1 @ (I - 2 * T3 @ T0)) - 2 * K * T1


def pengrad(K, Dpi, I):
    """
    args:
    K a numpy dim-2
    Dpi a numpy dim-2
    I a numpy dim-2
    returns:
    a numpy dim-2
    algo:
    calculate the gradient of the penality function
    """
    return 2 * I * (K - Dpi)


# EUCLIDIEAN HESSIAN


def funhess(K, X, I):
    """
    args:
    K a numpy dim-2
    X a numpy dim-2
    I a numpy dim-2
    returns:
    a numpy dim-2
    algo:
    calculate the hessian of the objective function
    """
    X2 = X @ X.T
    D = K * I
    T0 = anp.linalg.inv(D)
    T1 = T0 @ X2 @ T0
    T2 = T0 @ (K * (I - K))
    T3 = (I * T1) @ T0
    T4 = 2 * T0 @ ((I - 2 * T2) * I) @ T1
    T5 = -T2 @ T3
    derive1 = (T4 + T5) * I + T3 * (I - 2 * K)
    derive2 = ((I - 2 * T0 @ (I * K)) @ T1) * I

    return -2 * (derive1 + derive2)


def penhess(K, Dpi, I):
    """
    args:
    K a numpy dim-2
    Dpi a numpy dim-2
    I a numpy dim-2
    returns:
    a numpy dim-2
    algo:
    calculate the hessian of the penality function
    """
    return 2 * I


def checking_Pi(Pi):
    """
    args:
    Pi a numpy dim-1
    returns:
    the int tuple length-2
    algo:
    checking Pi conforms and return population size N and the number of individuals selected n
    """
    if not (isinstance(Pi, anp.ndarray)):
        raise ValueError(f"Pi is not nympy | type of Pi:'{type(Pi)}'")

    if not (len(Pi.shape) == 1):
        raise ValueError(f"Pi is not vector numpy")

    if not (anp.any((0 < Pi) & (Pi < 1))):
        raise ValueError(
            f"Pi is not vector of probability| the elemeents:'{Pi[~anp.any((0 < Pi) & (Pi < 1))]}'"
        )

    n = anp.sum(Pi)

    if not (anp.isclose(n % 1, 0)):
        raise ValueError(f"sum Pi is very different finterger| sum Pi:'{n}'")

    if not (anp.any((0 < Pi) & (Pi < 1))):
        raise ValueError(
            f"Pi is not vector of probability| the elemeents:'{Pi[~anp.any((0 < Pi) & (Pi < 1))]}'"
        )

    return Pi.shape[0], int(n)


def checking_X(X):
    """
    args:
    X a numpy dim-2
    returns:
    None
    algo:
    checking X is conforms
    """
    if not (isinstance(X, anp.ndarray)):
        raise ValueError(f"Pi is not nympy | type of X:'{type(X)}'")

    if not (len(X.shape) == 2):
        raise ValueError(f"X dimension is not matrix numpy ")

    return None


def checking_r(r):
    """
    args:
    r int or float
    returns:
    None
    algo:
    checking r is conforms
    """
    if not (isinstance(r, int) or isinstance(r, float)):
        raise ValueError(f"r is not int or float| type of r:'{type(r)}'")

    return None


def create_cost_derivate(manifold, Pi, X, r, backend):
    """
    args:
    manifold a class of pymanopt
    Pi a numpy dim-1
    X a numpy dim-2
    r a int or float
    backend a string
    returns:
    a tuple function length-3
    algo:
    define the problem
    """
    euclidean_gradient = euclidean_hessian = None
    N = Pi.shape[0]
    if backend == "autograd":
        Dpi = anp.diag(Pi)
        I = anp.eye(N)

        @pymanopt.function.autograd(manifold)
        def cost(v):
            K = v @ v.T

            return funobj(K, X, I) + r * penobj(K, Pi)

    elif backend == "numpy":
        Dpi = anp.diag(Pi)
        I = anp.eye(N)

        @pymanopt.function.numpy(manifold)
        def cost(v):
            K = v @ v.T
            return funobj(K, X, I) + r * penobj(K, Pi)

        @pymanopt.function.numpy(manifold)
        def euclidean_gradient(v):
            K = v @ v.T
            return 2 * (fungrad(K, X, I) + r * pengrad(K, Dpi, I)) @ v

        @pymanopt.function.numpy(manifold)
        def euclidean_hessian(v, H):
            K = v @ v.T
            return 2 * (
                (funhess(K, X, I) + r * penhess(K, Dpi, I)) @ (v @ H.T + H @ v.T) @ v
                + (fungrad(K, X, I) + r * pengrad(K, Dpi, I)) @ H
            )

    elif backend == "pytorch":
        Pi_ = torch.from_numpy(Pi)
        X_ = torch.from_numpy(X)
        I = torch.eye(N)

        @pymanopt.function.pytorch(manifold)
        def cost(v):
            K = v @ v.T
            D = K * I
            invD = torch.linalg.inv(D)
            invD_X_ = invD @ X_

            return torch.trace(invD_X_.T @ (K * (I - K)) @ invD_X_) + r * torch.sum(
                (torch.diag(K) - Pi_) ** 2
            )

    elif backend == "tensorflow":
        Pi_ = tf.convert_to_tensor(Pi)
        X_ = tf.convert_to_tensor(X)
        I = tf.eye(N)

        @pymanopt.function.tensorflow(manifold)
        def cost(v):
            K = v @ tf.transpose(v)
            D = K * I
            invD = tf.linalg.inv(D)
            invD_X_ = invD @ X_
            return tf.linalg.trace(
                tf.tensordot(
                    tf.transpose(invD_X_),
                    tf.tensordot((K * (I - K)), invD_X_, axes=1),
                    axes=1,
                )
            ) + r * tf.math.reduce_sum((tf.linalg.diag_part(K) - Pi_) ** 2)

    else:
        raise ValueError(f"Unsupported backend '{backend}'")

    return cost, euclidean_gradient, euclidean_hessian


def solver_pymanopt(Pi, X, r, optimizer, backend, initial_point=None):
    """
    args:
    Pi a numpy dim-1
    X a numpy dim-2
    r a int or float
    optimizer a class of pymanopt
    backend a string
    initial_point a numpy dim-2 or None
    returns:
    result.point a numpy dim-2
    result.cost a float
    iteration a int
    time a float
    algo:
    checking Pi,X,r
    checking dim X and dim Pi match
    solver the problem in function optimizer and backend and initial_point
    """
    N, n = checking_Pi(Pi)
    checking_X(X)
    checking_r(r)

    if not (X.shape[0] == N):
        raise ValueError(
            f"X and Pi no match | dimension of X :'{X.shape}' and dimension of Pi :'{Pi.shape}' "
        )

    manifold = pymanopt.manifolds.grassmann.Grassmann(N, n)
    cost, euclidean_gradient, euclidean_hessian = create_cost_derivate(
        manifold, Pi, X, r, backend
    )
    problem = pymanopt.Problem(
        manifold,
        cost,
        euclidean_gradient=euclidean_gradient,
        euclidean_hessian=euclidean_hessian,
    )

    result = optimizer.run(problem, initial_point=initial_point)
    iteration = result.iterations
    time = result.time
    prev_cost = result.cost

    result = optimizer.run(problem, initial_point=result.point)
    iteration += result.iterations
    time += result.time
    new_cost = result.cost

    while not (anp.isclose(prev_cost, new_cost)):
        result = optimizer.run(problem, initial_point=result.point)
        iteration += result.iterations
        time += result.time
        prev_cost = new_cost
        new_cost = result.cost

    return result.point, result.cost, iteration, time
