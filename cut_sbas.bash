#!/bin/bash

region=$(grep region_cut ../../../batch_tops.config | awk '{print $3}')

rm re_*.grd im_*.grd
cat list_sbas | while read a b c d e
do
  echo $a
  gmt grdmath real_$a.grd FLIPUD = tmp.grd=bf
  gmt grdsample tmp.grd -T -Gtmp.grd 
  gmt grdcut tmp.grd -R$region -Gre_$a.grd=bf
  gmt grdmath imag_$a.grd FLIPUD = tmp.grd=bf
  gmt grdsample tmp.grd -T -Gtmp.grd 
  gmt grdcut tmp.grd -R$region -Gim_$a.grd=bf
done
rm tmp.grd
