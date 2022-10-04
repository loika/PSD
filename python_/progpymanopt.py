from funpymanopt import *
from tools import *


if __name__ == "__main__":
    Pi, X = example(20, 3, [1, 2])
    optimizer = pymanopt.optimizers.trust_regions.TrustRegions()
    K, vcost, iteration, time, pf,r = psm(
        Pi, X, 11, optimizer, "numpy", initial_point=None, cost="normal"
    )

    print("------------------------------------------------------------------")
    print("objective function :", f(K, X))
    print("cost function :", vcost)
    print("penality function :", pf)
    print("factor of penality :",r)
    print("iteration :", iteration)
    print("time :", time)

    write_csv("res", K)
