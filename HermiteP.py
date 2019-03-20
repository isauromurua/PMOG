#%%
import numpy as np
import matplotlib.pyplot as plt

hermite = np.polynomial.hermite

def waist(z):
    q0 = np.pi * w0**2 / lamb
    return w0**2 * (1 + (z / q0)**2)

def GaussianP(x, y, z):
    r2 = x**2 + y**2
    G = w0 * np.exp(-r2 / waist(z**2)) / waist(z)
    G /= np.linalg.norm(G)
    return G

def GuoysP(z):
    q0 = np.pi * w0**2 / lamb
    return np.exp(-1j * np.arctan(z / q0))

def HermiteM(x, y, z, a, b):
    argx = np.sqrt(2) * x / waist(z)
    argy = np.sqrt(2) * y / waist(z)
    coeff = np.zeros((a+1, b+1))
    coeff[a, b] = 1
    M = hermite.hermgrid2d(argx, argy, coeff)
    M /= np.linalg.norm(M)
    return M

def curved_wf(x, y, z):
    R = rad_curvature(z)
    curvature = 2 * np.pi / (2 * R * lamb)
    return np.exp(1j * curvature * (x**2 + y**2))

def rad_curvature(z):
    q0 = np.pi * w0**2 / lamb;
    return z * (1 + (q0 / z)**2);

# ejemplo de uso
lamb = 500e-9
w0 = 1
x = np.linspace(-5, 5, 1000)
y = np.linspace(-5, 5, 1000)
z = 1e-10
a, b = 4, 5
#z = 2000

def herm_beam(x, y, z, a, b):
    # Hermite modulator
    X, Y = np.meshgrid(x, y)

    M = HermiteM(x, y, z, a, b)
    P = GaussianP(X, Y, z)
    G = GuoysP(z)
    cwf = curved_wf(x, y, z)

    return M * P * G * cwf

img = herm_beam(x, y, z, a, b)

amplitude = np.absolute(img)
phase = np.angle(img)

plt.subplot(1, 2, 1)
plt.imshow(phase, cmap='gray')

plt.subplot(1, 2, 2)
plt.imshow(amplitude, cmap='gray')

plt.tight_layout()
plt.show()
#%%
import matplotlib.animation as animation
fig2 = plt.figure()
ims = []
for z_i in np.arange(100):
    ims.append(herm_beam(x, y, z + z_i * 100, a, b))

im_ani = animation.ArtistAnimation(fig2, ims, interval=50, repeat_delay=3000,
                                   blit=True)
plt.show()


#%%
