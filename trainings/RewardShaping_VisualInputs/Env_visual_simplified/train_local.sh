#!/bin/bash

Path=${PWD#"/data_GPU/hassan/"}

Path="data_GPU/$Path"

file_path="$Path/train.sh"
echo "file : $file_path"

singularity exec --bind /data_GPU/hassan:/home/hassan/data_GPU /data_GPU/hassan/Containers/mlagents_gpu.simg sh $file_path $Path
