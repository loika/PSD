from funpymanopt import *
import pandas as pd


def example(N, n, x):
    """
    args:
    N a int
    n a int
    x a list int
    return:
    Pi a numpy dim-1
    X a numpy dim-2
    algo:
    data load in the directory sample
    col corresponds to the name of the columns in the csv file X_N_n.csv
    """
    data = pd.read_csv("../data/train/X_" + str(N) + "_" + str(n) + ".csv")
    Pi = data["pi"].to_numpy()
    col = ["x" + str(c) for c in x]
    X = data[col].to_numpy().reshape((N, len(x)))

    return Pi, X


if __name__ == "__main__":
    r = 1
    Pi, X = example(20, 3, [1])
    optimizer = pymanopt.optimizers.trust_regions.TrustRegions()
    v, vcost, itereration, time = solver_pymanopt(Pi, X, r, optimizer, "numpy")

    print("------------------------------------------------------------------")
    print("objective function :", funobj(v @ v.T, X, anp.eye(X.shape[0])))
