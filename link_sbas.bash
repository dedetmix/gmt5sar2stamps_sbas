#!/bin/bash 

rm real_*grd imag_*grd
cat list_sbas | while read name prm_master prm_slave date_master date_slave
do
  echo $name  
  ln -s ../../../intf_all/"$name"/real.grd real_"$name".grd 
  ln -s ../../../intf_all/"$name"/imag.grd imag_"$name".grd 
done
