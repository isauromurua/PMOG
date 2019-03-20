import numpy as np
import matplotlib.pyplot as plt
pi = np.pi

def beam(x,y,z,radial,angular,lamb=500e-9,w0=1,conj=0,modul='lag',norm=1,C=1):
    
    # Paraxial approximation modulated beams.
    #
    #   beem = beam(x,y,z,radial,angular) returns an array
    #   evaluated point-wise at x,y,z with modes angular and radial.
    #       
    #    Accepts the following name-value pairs:
    #               'modul' – 'lag' is Laguerre modulator
    #                       – 'herm' is Hermite modulator
    #               'lambda'– Wavelength in nm.
    #               'w0'    – Waist of the beam at z=0
    #               'conj'  – Flag to return phasor conjugate
    
    if modul == 'lag':
        modulator = laguerre_modulator(radial,angular,x,y,z)
    elif modul == 'herm':
        modulator = hermite_modulator(radial,angular,x,y,z)
    else:
        modulator = hermite_modulator(radial,angular,x,y,z)
    
    curved_wf = 1
    guoys_phase = guoys_p(z)
    gauss = gaussian(x,y,z); 
    
    # Join all terms together for the output
    if conjugate:
        beem = np.conj(C * modulator * gauss * curved_wf * guoys_phase);
    else:
        beem = C * modulator * gauss * curved_wf * guoys_phase;
        
    return beem

# ===================== 1.1 Laguerre modulation =======================
def laguerre_modulator(radial,angular,x,y,z)
    # Returns the Laguerre function as modulating wave
    r2 = x**2 + y**2
    f = (np.sqrt(2*r2)/waist(z)).**abs(angular) * \
        laguerg(abs(angular), radial, 2*r2/waist(z)**2) * \
        np.exp(1j*angular*np.arctan2(y,x)) * \
        np.exp(1j*guoys_p(z)*(2*radial+abs(angular)+1))
    return f

# ===================== 1.2 Hermite modulation =======================

def hermite_modulator(a, n, x, y, z)
    # Returns the Hermite-Gauss function as modulating wave
    
    argx = sqrt(2) * x / waist(z) # Rescaling
    argy = sqrt(2) * y / waist(z) # Rescaling
    hmn = hermite(a, argx) * hermite(n, argy)
    return hmn

# ===================== 2. Gaussian profile =======================

def gaussian(x,y,z)
    prof = w0 * exp(-(x**2 + y**2) / waist(z)**2) / waist(z)
    return prof

def waist(z)
    # Returns the waist of the beam at distance z of propagation.
    global lambda w0
    w = (1 / pi) * sqrt(lambda**2 * z**2 + pi**2 * w0**2)
    return w

# ===================== 3. Curved wavefront =======================

def curved_wavefront(x, y, z)
    # Returns the curved wafvefront resulting from spherical
    # wave distortion
    R = rad_curvature(z);
    curvature = 2 * pi / (2 * R * lamb)
    curved_wf = exp(1j * curvature * (x**2 + y**2))
    return curved_wf

# ===================== 4. Guoys phase =======================
def guoys_p(z)
    global lambda w0
    q0 = pi * w0**2 / lambda;
    guoys_phase = exp(-1j) * atan(z / q0))
    return guoys_phase


    