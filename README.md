# 6Canisotropy
The code provides an example of real data to estimate the phase velocity from one earthquake. It is used to analyze the seismic anisotropy from 6C observations based on the proposed new method.

The associated theory paper "Le Tang, Heiner Igel, and Jean-Paul Montagner. Single-Point Dispersion Measurement of Surface Waves Combining Translation, Rotation and Strain in Weakly
Anisotropic Media: Theory" can be found on GJI (2023).
The real data are from seisimc arrays in Southern California region and the associated paper 'Anisotropy and deformation processes in
Southern California from rotational observations' by Le Tang, Heiner Igel and Jean-Paul Montagner, will be submitted to a Journal soon (2023).

"Rot_x.mseed, Rot_y.mseed, Rot_z.mseed, Tra_x.mseed, Tra_y.mseed, Tra_z.mseed" : 6C data

"california_data.ipynb " is used to retrieve the earthquke 6C data based on ADR (Array Derived Rotation) method.

"california_code.m, cwt_cmor.m, est_azimuth.m est_disp.m " are used to estimate the phase velocity and azimuth.
