#!/bin/bash 
#01
#prepare to make interferogram list

#run matlab , sb_find(rho_min, Ddiffmax, Bdiff_max) to get small_baselines.list

rm -f intf_sbas.in list_sbas

cat stack/PS/small_baselines.list | while read master slave 
do
echo S1A"$master"_ALL_F2:S1A"$slave"_ALL_F2 >> intf_sbas.in
cd raw
master_id=$(grep SC_clock_start S1A"$master"_ALL_F2.PRM | awk '{print int($3)}')
slave_id=$(grep SC_clock_start S1A"$slave"_ALL_F2.PRM | awk '{print int($3)}')
cd ..
echo "$master_id"_"$slave_id" S1A"$master"_ALL_F2 S1A"$slave"_ALL_F2 $master $slave >> list_sbas
done

#rm tmp*
