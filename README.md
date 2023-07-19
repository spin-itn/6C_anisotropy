# 6Canisotropy
If you use this code, we would appreciate a citation:[DOI:10.5281/zenodo.8163782](https://zenodo.org/badge/latestdoi/596467362).
This is a static version of the code. For an up-to-date version, please check the repository on tangle0129 github: [tangle0129/6Canisotropy](https://github.com/tangle0129/6Canisotropy)

The code provides an example of real data to estimate the phase velocity from one earthquake. It is used to analyze the seismic anisotropy from 6C observations based on the proposed new method.

The associated theory paper "Le Tang, Heiner Igel, and Jean-Paul Montagner. Single-Point Dispersion Measurement of Surface Waves Combining Translation, Rotation and Strain in Weakly
Anisotropic Media: Theory" can be found on GJI (2023) [DOI: 10.1093/gji/ggad199].

The real data are from seisimc arrays in Southern California region and the associated paper 'Anisotropy and deformation processes in
Southern California from rotational observations' by Le Tang, Heiner Igel and Jean-Paul Montagner, will be submitted to a Journal soon (2023).

"Rot_x.mseed, Rot_y.mseed, Rot_z.mseed, Tra_x.mseed, Tra_y.mseed, Tra_z.mseed" : 6C data

"california_data.ipynb " is used to retrieve the earthquke 6C data based on ADR (Array Derived Rotation) method.

"california_code.m, cwt_cmor.m, est_azimuth.m est_disp.m " are used to estimate the phase velocity and azimuth.

This work is funded by the European Union’s Horizon 2020 research and innovation program under the Marie Skłodowska-Curie grant agreement No 955515.
