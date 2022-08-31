import pandas as pd
import csv
import numpy as np


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


def write_csv(path, matrix, liste=[]):
    if liste == []:
        N = 0
    else:
        N = 1
    N += matrix.shape[0]
    names = ["C" + str(i) for i in range(1, N + 1)]
    File = open(path + ".csv", "w")
    obj = csv.writer(File)
    obj.writerow(names)

    for i in range(len(liste)):
        obj.writerow(np.append(matrix[i], liste[i]))

    for elem in matrix[len(liste) :]:
        obj.writerow(elem)
    File.close()


def eigenvector(K, M):
    return anp.linalg.eig(K)[1][:, :M]
