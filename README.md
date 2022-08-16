<a href="https://www.insee.fr/fr/accueil"> <img src="docs/img/Logo_Insee.svg.png?raw=true" width="150" align="right"> </a>

# PSD

"plan de sondage déterminantal" in French , "determinal sampling design" in English.

## Introduction

The goal of sampling theory is to acquire knowledge of a parameter of interest using only partial information. This is done by means of a sampling design, through which a random subset is observed, and the construction of an estimator. The properties of the
sampling design are thus of crucial importance to get “good” estimators.

## Determinantal Sampling Designs

Determinantal Sampling Designs are a family of sampling designs that adresses all theses issues. They are indexed by Hermitian contracting matrices, called kernel, and have known inclusion probabilities for any order, among many others properties.

### Definition

 A sampling design $\mathbb{P}$ on a finite set $U$ is a **determinantal sampling design** if there exists a Hermitian matrix $K$ indexed by $U$, called kernel, such that for all $s \in 2^U \quad \sum_{s' \sqsupseteq s}\mathbb{P}( s' ) = \mathrm{det} ( K_{|s} )$. This sampling design is denoted by **$\mathrm{DSD}(K)$**.

### Notation

- $N$  population size
- $n$ number of individual select
- $Q$ number of auxiliary variables 
- $\Pi$ a probability vector
- $X$ a  auxilary matrix 
- $r$ a real number, penality factor
- $K$ a hermitian projection matrix, kernel
- $D_\pi$ a diagonal matrix

subject to :

- $N$ is a interger such that $N > 1$
- $n$ is a interger such that $1 < n < N$
- $Q$ is a interger such that $Q > 1$
- $\Pi$ a vector such that $\Pi = (\Pi_1,\cdots,\Pi_N)$ and $0 < \Pi_i < 1 , i=1\cdots=N$ and $\mathrm{sum}(\Pi)= n$
- $X$ is a matrix such that $\mathrm{size}(X) = (N,Q)$
- $r$ is a number such that $r \in \mathbb{R}$
- $K$ is a matrix such that $\mathrm{size}(K) = (N,N)$, $\mathrm{diag}(K) = \Pi$, $K = v \cdot v^\top$ with $v$ a matrix $v^\top \cdot v = \mathbb{I}_n$ $\mathrm{size}(v) = (N,n)$
- $D_\pi = \mathrm{diag}(\Pi)$ 

For more information there is a documentation.

- [![Generic badge](https://img.shields.io/badge/with--made-python-informational.svg)](https://shields.io/)
- [![Generic badge](https://img.shields.io/badge/with--made-matlab-informational.svg)](https://shields.io)
<!-- - [![shield](http://img.shields.io/badges/made with-r-informational)](http://forthebadge.com) -->
<!-- - [![shield](http://img.shields.io/badges/made with-matlab-informational)](http://forthebadge.com) -->


## descriptive on the directorys

### data

`data` is a directory, where there are directory to use for the programs. Each directory is composed of a descriptive file and a csv file.

#### name of the sub-directory
- **[fickus](data/fickus/)**
- **[Kr](data/Kr/)**
- **[Ppi](data/Ppi/)**  
- **[train](data/Ppi/)**


### docs

docs is a directory where the **[images](docs/img/)** and **[documentation](docs/documentation/)** are stored.

### python_ 
**[python_](python_/)** is a directory, where thre are python programs.

### matlab_
**[matlab_](matlab_/)** is directory, where thre are matalab programs.

<!-- --> 
## to get started

### PYTHON
To use the program with the manopt method, it is neccessary in `progpymanopt.py` to change the variable Pi and X and r in the 
```python 
if __name__ == '__main__'
```
Pi must be of type numpy dim-1 and X must be of type numpy dim-2 and r must be of type int or float.  

### MATLAB

#### manopt
To use the program with the manopt method, it is neccessary in `progmanopt.m`  to change the variable Pi and X and r. Pi must be of real column vector and X must be of real matrice and r must be of type int or float.
#### penlab
disclamers the programs penlab runs but they do not give satisfactory results.

To use the program with the penlab method, it is neccessary in `progpenlab.m` to change the variable $K$ and X. K,Pi. K must be of real matrix and and Pi real column vector and X must be of real matrice.
#### rotation    
To use the program with the rotation method, it is neccessary in `progrotation.m`  to change the variable K and X. K must be of real or hermitian matrix and X must be of real matrice.         
<!--
 $\Omega \sim \mathcal{U}([0,1]^{N \times n})$
### R
### Julia
-->

## pre-requisites

### PYTHON

- [![Generic badge](https://img.shields.io/badge/python-3.7.3-brightgreen.svg)](https://shields.io)

the use of program progmanopt requires :  

- [![Generic badge](https://img.shields.io/badge/pandas-0.24.2-brithtgreen.svg)](https://shields.io)
- [![Generic badge](https://img.shields.io/badge/autograd-1.4-brithtgreen.svg)](https://shields.io)
- [![Generic badge](https://img.shields.io/badge/manopt-2.0-brithtgreen.svg)](https://shields.io)
- [![Generic badge](https://img.shields.io/badge/pytorch-1.12-brithtgreen.svg)](https://shields.io)
<!-- - [![Generic badge](https://img.shields.io/badge/tensorflow-?-brithtgreen.svg)](https://shields.io) -->

if the packages are not installed. you can install them the command line in directory `python_`:

```
pip install -r requirements.txt
```


if the command did not work, you can install the packages one by one with the command  
```
pip install [package]
```

### MATLAB


<!--**[matlab](https://fr.mathworks.com/products/matlab.html)** version R2018b +-->
- [![Generic badge](https://img.shields.io/badge/matlab-R2018b-brithtgreen.svg)](https://shields.io)

the use of program progpenlab requires the installation of the package [![Generic badge](https://img.shields.io/badge/pelab-1.04-brithtgreen.svg)](https://shields.io).  
the use of program progmanopt requires the installation of the package [![Generic badge](https://img.shields.io/badge/manopt-7.0.0-brithtgreen.svg)](https://shields.io).   
the use of program progrotation in matlab requires no packages.
<!-- dépandance --> 

<!--
### JULIA


-->

## Contibutor

- **Vincent LOONIS**
- **Fabrice Nathan TCHAZOU KAMWA**
- **Loik johan ACAKPO-ADDRA** _alias_ [@loik77360](https://github.com/loik77360/PSD)

## Links

### packages

- **[penlab](https://web.mat.bham.ac.uk/kocvara/penlab)**
- **[manopt](https://www.manopt.org/)**
- **[pandas](https://pandas.pydata.org/)**
- **[autograd](https://pypi.org/project/autograd/)**
- **[pytorch](https://pytorch.org/)**
<!-- **[tensorflow](https://www.manopt.org/tutorial.html)** -->



### Documentation
- **[rotation](https://www.sciencedirect.com/journal/journal-of-statistical-planning-and-inference)**   
- **[PSD and fickus](docs/documentation/Techniques_d_enquete.pdf)**
<!-- liks -->





