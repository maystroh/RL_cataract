#!/bin/bash

#SBATCH -p 1080GPU
#SBATCH -J V_scratch
#SBATCH --output=cataract_RL_%j.out
#SBATCH --gres=gpu
#SBATCH -w cn11

Path=${PWD#"/data_GPU/hassan/"}

Path="data_GPU/$Path"

file_path="$Path/train.sh"
echo "file : $file_path"

srun singularity exec --bind /data_GPU/hassan:/home/hassan/data_GPU --nv /data_GPU/hassan/Containers/mlagents_gpu_gym_optimized.simg sh $file_path $Path

#sh -c "echo a && echo b"
