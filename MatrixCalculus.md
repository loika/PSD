# <a href="http://www.matrixcalculus.org/"> Matrix Calculus</a>



We derive a function of K,cost function : 
$$C(K) = f(K,X) + r\cdot p(K)$$

where:
- $f$ objective function
- $p$ penality function
- $r$ real number

## proposition

A,B,C are matrix

- $A \odot B = B \odot A$

- $A \odot (B + C) = A \odot B + A \odot C$

- $\mathbb{I} \odot A = \mathbb{I} \odot A^\top \Rightarrow \mathbb{I} \odot (A + A^\top) = 2\cdot \mathbb{I}\odot A = 2\cdot \mathbb{I}\odot A^\top$


## objective function

### function

$$ f(K,X) = \mathrm{tr}(X^\top \cdot \mathrm{inv}(K\odot \mathbb{I})\cdot (K\odot (\mathbb{I}-K))\cdot \mathrm{inv}(K\odot \mathbb{I})\cdot X) $$

### gradient

<img src="docs/img/fungrad.png?raw=true" width="800" >

factorize form:


$$ \nabla f =  \mathbb{I} \odot (T_1 \odot(\mathbb{I} - 2 \cdot T_2 \cdot T_0)) - 2 \cdot T_1 \odot K  $$

where :
- $T_0 = \mathrm{inv}(K\odot \mathbb{I})$
- $T_1 = T_0 \cdot X \cdot X^\top \cdot T_0 $
- $T_3 = K \odot (\mathbb{I} - K)$

### hessian

#### derive1

$$\nabla \text{derive1} = \mathrm{tr}(mathbb{I} \odot (T_5 \cdot (\mathbb{I} - 2 \cdot (K \odot T_2) \cdot T_0)))$$

<img src="docs/img/funhess1.png?raw=true" width="800">

factorize form:

$$\nabla \text{derive1} = -2\odot(T_6 \odot (\mathbb{I}- 2\cdot K) + \mathbb{I}(T_0 \odot T_4 \odot T_5 - T_3 \cdot T_5 \odot T_0))$$

where:
- $T_0 = \mathrm{inv}(K\odot \mathbb{I})$
- $T_2 = (\mathbb{I} - K)$
- $T_3 = T_0 \cdot (K \odot T_2)$
- $T_4 = \mathbb{I} - 2\cdot T_3$
- $T_5 = T_0 \cdot X \cdot X^\top \cdot T_0$
- $T_6 = T_5 \cdot T_0$

#### derive2

$$\nabla \text{derive2} = -2 \cdot \mathrm{tr}(T_1 \odot K )$$

<img src="docs/img/funhess2.png?raw=true" width="800">

factorize form:

$$\nabla \text{derive2} = -2 \cdot \mathbb{I} \odot (T_1 - 2 \odot T_0 \odot T_2 \odot T_1)$$

where:
- $T_0 = \mathrm{inv}(K\odot \mathbb{I})$
- $T_1 = T_1 = T_0 \cdot X \cdot X^\top \cdot T_0$
- $T_2 = K \odot \mathbb{I}$

## penality function

## checking gradient of cost function

## checking hessian of cost function