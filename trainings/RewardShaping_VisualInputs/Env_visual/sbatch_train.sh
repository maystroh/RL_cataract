#!/bin/bash

#SBATCH -p 1080GPU
#SBATCH -J RLVis
#SBATCH --output=cataract_RL_%j.out
#SBATCH --gres=gpu
#SBATCH -c 14
#SBATCH -w cn15

Path=${PWD#"/data_GPU/hassan/"}

Path="data_GPU/$Path"

file_path="$Path/train.sh"
echo "file : $file_path"

srun singularity exec --bind /data_GPU/hassan:/home/hassan/data_GPU --nv /data_GPU/hassan/Containers/mlagents_gpu_gym_optimized.simg sh $file_path $Path
