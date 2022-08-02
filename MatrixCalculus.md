<a href="http://www.matrixcalculus.org/"> <img src="docs/img/MatrixCalculus.PNG?raw=true" width="150" align="center"> </a>

# Matrix Calculus


We derive a function of K,cost function : 
$$C(K,X,\Pi) = f(K,X) + r\cdot p(K,\Pi)$$

where:
- $f$ objective function
- $p$ penality function
- $r$ real number

## proposition

A,B,C are matrix

- $A \odot B = B \odot A$

- $A \odot (B + C) = A \odot B + A \odot C = (B + C) \odot A$

- $A \cdot B + A \cdot C = A \cdot (B + C)$

- $\mathbb{I} \odot A = \mathbb{I} \odot A^\top \Rightarrow \mathbb{I} \odot (A + A^\top) = 2\cdot \mathbb{I}\odot A = 2\cdot \mathbb{I}\odot A^\top$


## objective function

### function

$$ f(K,X) = \mathrm{tr}(X^\top \cdot \mathrm{inv}(K\odot \mathbb{I})\cdot (K\odot (\mathbb{I}-K))\cdot \mathrm{inv}(K\odot \mathbb{I})\cdot X) $$

### gradient

<img src="docs/img/fungrad.png?raw=true" width="800" >

factorize form:


$$ \nabla f =  \mathbb{I} \odot (T_1 \odot(\mathbb{I} - 2 \cdot T_2 \cdot T_0)) - 2 \cdot T_1 \odot K $$

where :
- $T_0 = \mathrm{inv}(K\odot \mathbb{I})$
- $T_1 = T_0 \cdot X \cdot X^\top \cdot T_0 $
- $T_3 = K \odot (\mathbb{I} - K)$

### hessian

for the calculation of the hessian, we split in two parts.

#### derive1

$$ \nabla \text{derive1} = \mathrm{tr}(mathbb{I} \odot (T_5 \cdot (\mathbb{I} - 2 \cdot (K \odot T_2) \cdot T_0))) $$

<img src="docs/img/funhess1.png?raw=true" width="800">

factorize form:

$$ \nabla \text{derive1} = -2\odot(T_6 \odot (\mathbb{I}- 2\cdot K) + \mathbb{I}(T_0 \odot T_4 \odot T_5 - T_3 \cdot T_5 \odot T_0)) $$

where:
- $T_0 = \mathrm{inv}(K\odot \mathbb{I})$
- $T_2 = (\mathbb{I} - K)$
- $T_3 = T_0 \cdot (K \odot T_2)$
- $T_4 = \mathbb{I} - 2\cdot T_3$
- $T_5 = T_0 \cdot X \cdot X^\top \cdot T_0$
- $T_6 = T_5 \cdot T_0$

$\nabla \text{derive1}$ is not symetric.

#### derive2

$$ \nabla \text{derive2} = -2 \cdot \mathrm{tr}(T_1 \odot K ) $$

<img src="docs/img/funhess2.png?raw=true" width="800">

factorize form:

$$ \nabla \text{derive2} = -2 \cdot \mathbb{I} \odot (T_1 - 2 \odot T_0 \odot T_2 \odot T_1) $$

where:
- $T_0 = \mathrm{inv}(K\odot \mathbb{I})$
- $T_1 = T_1 = T_0 \cdot X \cdot X^\top \cdot T_0$
- $T_2 = K \odot \mathbb{I}$

$\nabla \text{derive2}$ is symmetric.

## penality function

### function

$$ p(K,\Pi) = \mathrm{tr}((K \odt \mathbb{I}- \mathrm{diag}(\Pi))^2) $$

### gradient

<img src="docs/img/pengrad.PNG?raw=true" width="800">

$$ \nabla p = 2 \cdot \mathbb{I} \codot (K \odot \mathbb{I} - \mathrm{diag}(\Pi)) $$

### hessian

<img src="docs/img/penhess.PNG?raw=true" width="800">

$$ \nabla^2 p = 2 \cdot \mathbb{I} $$


## checking gradient of cost function

<img src="docs/img/costgradient.PNG?raw=true" width="800">

the cost gradient is good.

## checking hessian of cost function

<img src="docs/img/costhessian.PNG?raw=true" width="800">

the cost is not symmetric because the derive1 therefore false. I don't know  the reason that the objective function hessian is incorrect.