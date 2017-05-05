#!/bin/bash 
#02
#process SBAS GMT5SAR to STAMPS SMALL BASELINE format

# PATH FORMAT : >> stack/PS/SMALL_BASELINES --> go to PATCH dir to do SBAS processing!

#step 1 , use PRM.list
# [option] if PS has not been processed
region=$(grep region_cut batch_tops.config | awk '{print $3}')
cd raw
dispersion.csh PRM.list scatter.grd $region #make sure PRM.list is suitable with your data processing
cd ..

#step 2
intf_tops.csh intf_sbas.in batch_tops.config
# make sure proc_stage = 2, dec_factor = 1

#step 3
cd stack/PS
mkdir SMALL_BASELINES
cd SMALL_BASELINES
cp ../../../list_sbas .
link_sbas.bash

#step 4
cut_sbas.bash

#step 5
#cd ../raw
#cat ../stack_sbas/list_sbas | while read name prm_master prm_slave date_master date_slave
#do
#baseline_table.csh "$prm_master".PRM "$prm_slave".PRM >> baseline_info.dat
#done
#cd ../stack_sbas
#mv ../raw/baseline_info.dat .

#copy bperp.1.in day.1.in master_day.1.in from PS STAMPS

mt_extract_info_gmtsar_sbas

#step 6
mt_extract_cands_gmtsar_sbas

matlab -nojvm -nosplash -nodisplay < $STAMPS/matlab/sb_parms_initial.m > sb_parms_initial.log
#matlab -nojvm -nosplash -nodisplay < $STAMPS/matlab/ps_parms_initial.m > ps_parms_initial.log

#step 7
correct_forum_sbas #swap_pixel to have stamps format
#echo PATCH > patch.list
mkdir PATCH
cd PATCH
cp ../pscands* .

# finally, open MATLAB and run STAMPS

