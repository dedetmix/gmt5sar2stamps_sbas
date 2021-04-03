A simplified version (both for single and multi master intefrerograms) can be processed from  InSAR_G2S (https://github.com/dedetmix/INSAR_G2S)

These are codes that I modified to integrate GMTSAR output to StaMPS software for the small baselines method. The original scripts were from Xiaopeng Tong, et al: 

https://github.com/mohseniaref/gmtsar2stamps

http://gmt.soest.hawaii.edu/boards/6/topics/4346

Read the guideline_SB to use the scripts.

Nt:
from GMTSAR forum (User: Ziyadin), remember to edit the ps_load_intial.m / sb_load_intial.m on STAMPS matlab folder

%[gridX,gridY]=meshgrid(linspace(0,width,50),linspace(0,len,50));

must be replaced with

% For gmtsar output in case ROI is cropped so that xmin and/or xmax are not zero
[gridX,gridY]=meshgrid(linspace((min(ij(:,3))),width+(min(ij(:,3))),50),linspace((min(ij(:,2))),len+(min(ij(:,2))),50));

Related Publication:
- Hayati, N.; Niemeier, W.; Sadarviana, V. Ground Deformation in The Ciloto Landslides Area Revealed by Multi-Temporal InSAR. Geosciences 2020, 10, 156. https://doi.org/10.3390/geosciences10050156
