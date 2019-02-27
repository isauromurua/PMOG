#%%
import numpy as np
import matplotlib.pyplot as plt

def HermiteP(x, n):
    v = np.zeros(n+1)
    v[n] = 1
    h = np.polynomial.hermite.hermval(x, v)
    h = h / np.linalg.norm(h)
    return h

# ejemplo de uso
x = np.linspace(-10,10,100)
plt.plot(x, HermiteP(x, 6))