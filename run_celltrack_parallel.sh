#!/bin/bash

celltrack_bin=celltrack
project_dir=/home/kai/germanRADARanalysis/
output_dir=${project_dir}/celltracking/
data_dir=${project_dir}/RADARdata/

# first create the output directory structure
for year in $(seq -f "%04g" 2001 2020)
do
  for month in $(seq -f "%02g" 3 11)
  do
    mkdir -p ${outpath}/${year}/${month}
  done
done

# now run parallel instances of celltrack
for year in $(seq -f "%04g" 2001 2020)
do
  printf '%s\n' "${months[@]}" | xargs -I "%" -P 8 /bin/bash -c "cd ${output_dir}/${year}/% && ${celltrack_bin} -i ${data_dir}/raa01-yw2017.002_10000-${year}%-dwd---bin.nc -var precipitation -thres  0.05 -advcor -tstep 300 -cx 300 -cy 275 -nadviter 6 -nometamstr -metanc -tracknc -maxv 0.04 -minarea 16 |& tee output_${year}%.txt" 
done

exit 0
