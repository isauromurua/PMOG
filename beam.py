import numpy as np

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
    r2 = x^2 + y^2
    f = (np.sqrt(2*r2)/waist(z)).^abs(angular) * \
        laguerg(abs(angular), radial, 2*r2/waist(z)^2) * \
        np.exp(1j*angular*np.arctan2(y,x)) * \
        np.exp(1j*guoys_p(z)*(2*radial+abs(angular)+1))
    return f

# ===================== 1.2 Hermite modulation =======================

def 
    





    