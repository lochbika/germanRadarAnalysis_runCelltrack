#!/bin/bash

set -ex

months=("03" "04" "05" "06" "07" "08" "09" "10" "11")

celltrack_bin=celltrack
outpath=/home/kai/nobackup/german_radar/get_DWD_Radar_data/celltrack_bin/
data_dir=/home/kai/nobackup/german_radar/get_DWD_Radar_data/processed_bin/

for year in $(seq -f "%04g" 2001 2020)
do
  for month in ${months[@]}
  do
    mkdir -p ${outpath}/${year}/${month}
  done
done

for year in $(seq -f "%04g" 2001 2020)
do
  printf '%s\n' "${months[@]}" | xargs -I "%" -P 4 /bin/bash -c "cd ${outpath}/${year}/% && ${celltrack_bin} -i ${data_dir}/raa01-yw2017.002_10000-${year}%-dwd---bin.nc -var precipitation -thres  0.05 -advcor -tstep 300 -cx 300 -cy 275 -nadviter 6 -nometamstr -metanc -tracknc -maxv 40 -minarea 16 |& tee output_${year}%.txt" 
done

exit 0
