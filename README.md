# PSD

"plan de sandage déterminantaux"

This project is to provide tools in several programming languages to find kernels that best minimize the objective function.  
For more information there is a documentation.  

- [![forthebadge](http://forthebadge.com/images/badges/made-with-python.svg)](http://forthebadge.com)
- [[shields](https://img.shields.io/badge/with--made-python-informational.svg)](https://shields.io)
- [[shields](http://img.shields.io/badges/made with-matlab-informational.svg)](https://shields.io)
<!-- - [![shield](http://img.shields.io/badges/made with-r-informational)](http://forthebadge.com) -->
<!-- - [![shield](http://img.shields.io/badges/made with-matlab-informational)](http://forthebadge.com) -->


## descriptive

sample is directory, where there are csv files to use for the programs.  
python_ is directory, where thre are python programs.  
matlab_ is directory, where thre are matalab programs 
<!-- --> 
## to get started

### PYTHON
To use the program with the manopt method, it is neccessary in the progpymanopt file to change the variable Pi and X and r in the "if __name__ == '__main__'". Pi must be of type numpy dim-1 and X must be of type numpy dim-2 and r must be of type int or float.

### MATLAB
To use the program with the manopt method, it is neccessary in the progmanopt file to change the variable Pi and X and r. Pi must be of real column vector and X must be of real matrice and r must be of type int or float.  
To use the program with the rotation method, it is neccessary in the progrotation file to change the variable K and X. K must be of real or imaginary matrix and X must be of real matrice.  
To use the program with the penlab method, it is neccessary in the progpenlab file to change the variable K and X. K must be of real matrix and and Pi real column vector and X must be of real matrice.  

disclamers the programs penlab runs but they do not give satisfactory results.
<!--
### R
### Julia
-->

## pre-requisites

### PYTHON

<!--**[python](https://www.python.org/)** version 3.5 +-->
- [[shields](http://img.shields.io/badges/python-3.5+-brightgreen.svg)](https://shields.io/)
the use of program progmanopt requires :  

- pandas  
- autograd 1.4  
- pymanopt 2.0  
- pytorch  
- tensorflow to be continued

### MATLAB

<!--**[matlab](https://fr.mathworks.com/products/matlab.html)** version R2018b +-->
- [[shields](http://img.shields.io/badges/matlab-r2018b-brightgreen.svg)](https://shields.io/)

the use of program progpenlab requires the installation of the package [[shield](http://img.shields.io/badges/penlab-1.04-brightgreen.svg)](https://shields.io/).  
the use of program progmanopt requires the installation of the package [[shield](http://img.shields.io/badges/manopt-7.0.0-brightgreen.svg)](https://shields.io/).   
the use of program progrotation in matlab requires no packages.

<!--
### JULIA


-->

## Contibutor

@Vincent LOONIS
@Fabrice Nathan TCHAZOU KAMWA
@Loik-Johan ACAKPO-ADDRA

## LinkS

### packages

- **[penlab]https://web.mat.bham.ac.uk/kocvara/penlab)**
- **[manopt](https://www.manopt.org/)**
- **[pandas](https://pandas.pydata.org/)**
- **[autograd](https://pypi.org/project/autograd/)**
- **[pytorch](https://pytorch.org/)**
<!-- **[tensorflow](https://www.manopt.org/tutorial.html)** -->



### Documentation
- **[rotattion](www.elsevier.com/locate/jspi)** page 60-88  
- **[PSD](https://www.researchgate.net/publication/359095103_Construire_tous_les_plans_de_sondage_determinantaux)**
<!-- liks -->





