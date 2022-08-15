# documetation

This program use the tools **[manopt](https://www.manopt.org/)** and **[penality method](https://en.wikipedia.org/wiki/Penalty_method)** in order to constructions a DSD 's kernel 

## functions

```python
funobj(K, X, I)
``` 
arguments:
- K a numpy dim-2
- X a numpy dim-2
- I a numpy dim-2

returns:
- a numpy float

algorithms:
- calculate the objective function.


```python
penobj(K, Pi)
```
arguments:
- K a numpy dim-2
- Pi a numpy dim-1

returns:
- a numpy float

algorithms:
- calculate the penality function.
```python
fungrad(K, X, I)
``` 
arguments:
- K a numpy dim-2
- X a numpy dim-2
- I a numpy dim-2

returns:
- a numpy dim-2

algorithms:
- calculate the gradient euclidiean of the objective function.

```python
pengrad(K, Dpi,I)
```
arguments:
- K a numpy dim-2
- DPi a numpy dim-2
- I a numpy dim-2

returns:
- a numpy dim-2

algorithms:
- calculate the gradient of the penality function.

```python
funhess(K, X, I)
``` 
arguments:
- K a numpy dim-2
- X a numpy dim-2
- I a numpy dim-2

returns:
- a numpy dim-2

algorithms:
- calculate the hessian of the objective function.

```python
penhess(K, Dpi,I)
```
arguments:
- K a numpy dim-2
- Dpi a numpy dim-2
- I a numpy dim-2

returns:
- a numpy dim-2

algorithms:
- calculate the hessian euclidiean of the penality function.

```python
checking_Pi(Pi)
```
arguments:
- Pi a numpy dim-1

returns:
- int
- int

algorithms:
- checking Pi conforms
- return population size $N$ and the number of individuals selected $n$.


```python
checking_X(X)
```
arguments:
- Pi a numpy dim-2

returns:
- None

algorithms:
- checking X is conforms


```python
checking_r(r)
```
arguments:
- r int or float 

returns:
- None

algorithms:
- checking r is conforms

```python
create_cost_derivate(manifold, Pi, X, r, backend)
```
arguments:
- manifold a class of pymanopt
- Pi a numpy dim-1
- X a numpy dim-2
- r a int or float
- backend a string

returns:
- cost a function
- euclidean_gradient a function or None
- euclidean_hessian a function or None

algorithms:
- define the problem

```python
solver_pymanopt(Pi, X, r, optimizer, backend, initial_point)
```
arguments:
- Pi a numpy dim-1
- X a numpy dim-2
- r a int or float
- optimizer a class of pymanopt
- backend a string
- initial_point a numpy dim-2 or None

returns:
- result.point a numpy dim-2
- result.cost a float
- iteration a int
- time a float

algorithms:
- checking Pi,X,r are conforms
- checking dim X and dim Pi match
- solver the problem in function optimizer and backend and initial_point
