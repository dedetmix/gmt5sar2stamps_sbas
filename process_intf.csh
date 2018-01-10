#!/bin/bash

################ set PATH ############################
inputfile=intf.in
raw=/home/isya/APPS/ciloto/Sentinel1/batch_asc/raw
topo=/home/isya/APPS/ciloto/Sentinel1/batch_asc/topo
######################################################

ln -s -f "$topo"/topo_ra.grd .
#ln -s -f "$topo"/landmask_ra.grd .
ln -s -f "$topo"/trans.dat .

shopt -s extglob
IFS=":"
while read master slave
do
#master_date=$(echo "$master" | awk '{print substr($0,4,8)}')
#slave_date=$(echo "$slave" | awk '{print substr($0,4,8)}')

ln -s "$raw"/$master.SLC .
ln -s "$raw"/$master.LED .
ln -s "$raw"/$master.PRM .
ln -s "$raw"/$slave.SLC .
ln -s "$raw"/$slave.LED .
ln -s "$raw"/$slave.PRM .

intf.csh $master.PRM $slave.PRM -topo topo_ra.grd

master_id=$(grep SC_clock_start $raw/$master.PRM | awk '{printf("%d",int($3))}')
slave_id=$(grep SC_clock_start $raw/$slave.PRM | awk '{printf("%d",int($3))}')

mv real.grd real_$master_id"_"$slave_id.grd
mv imag.grd imag_$master_id"_"$slave_id.grd

#cleaning...
rm *SLC *LED *PRM
done < $inputfile
