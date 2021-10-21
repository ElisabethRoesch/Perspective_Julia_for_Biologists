import numpy as np
import timeit
import numba

def f(u,p,t):
  x, y = u
  α, β, δ, γ = p
  du1 = dx = α*x - β*x*y
  du2 = dy = -δ*y + γ*x*y
  [du1,du2]

u = np.ones(2)
p = np.asarray([1.5,1.0,3.0,1.0])
f(u,p,0.0)

def time_func():
    f(u,p,0.0)

timeit.Timer(time_func).timeit(number=100)/100 # 1.5365599999995538e-06 seconds

numba_f = numba.jit(f,nopython=True)
def time_func():
    numba_f(u,p,0.0)

timeit.Timer(time_func).timeit(number=100)/100 # 4.2500000006384655e-07 seconds
