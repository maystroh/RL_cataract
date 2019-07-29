#!/usr/bin/env bash
#--docker-use – Is the training running on a docker image?.
#--env=<env> - Specify an executable environment to train.

#--curriculum=<file> – Specify a curriculum JSON file for defining the lessons for curriculum training. See Curriculum Training for more information.
#--lesson=<n> – Specify which lesson to start with when performing curriculum training. Defaults to 0.

#--run-id=<path> – Specifies an identifier for each training run. This identifier is used to name the subdirectories in which the trained model and summary statistics are saved as well as the saved model itself. The default id is "ppo". If you use TensorBoard to view the training statistics, always set a unique run-id for each training run. (The statistics for all runs with the same id are combined as if they were produced by a the same session.)

#--keep-checkpoints=<n> – Specify the maximum number of model checkpoints to keep. Checkpoints are saved after the number of steps specified by the save-freq option. Once the maximum number of checkpoints has been reached, the oldest checkpoint is deleted when saving a new checkpoint. Defaults to 5.
#--save-freq=<n> Specifies how often (in steps) to save the model during training. Defaults to 50000.

#--seed=<n> – Specifies a number to use as a seed for the random number generator used by the training code.

#--slow – Specify this option to run the Unity environment at normal, game speed. The --slow mode uses the Time Scale and Target Frame Rate specified in the Academy's Inference Configuration. By default, training runs using the speeds specified in your Academy's Training Configuration. See Academy Properties.
#--train – Specifies whether to train model or only run in inference mode. When training, always use the --train option.
#--no-graphics - Specify this option to run the Unity executable in -batchmode and doesn't initialize the graphics driver. Use this only if your training doesn't involve visual observations (reading from Pixels). See here for more details
#--load – If set, the training code loads an already trained model to initialize the neural network before training. The learning code looks for the model in models/<run-id>/ (which is also where it saves models at the end of training). When not set (the default), the neural network weights are randomly initialized and an existing model is not loaded.

#--num-runs=<n> - Sets the number of concurrent training sessions to perform. Default is set to 1. Set to higher values when benchmarking performance and multiple training sessions is desired. Training sessions are independent, and do not improve learning performance.
#--worker-id=<n> – When you are running more than one training environment at the same time, assign each a unique worker-id number. The worker-id is added to the communication port opened between the current instance of mlagents-learn and the ExternalCommunicator object in the Unity environment. Defaults to 0.

set -eux

PYTHONPATH="$HOME/data_GPU/SurgerySimulator/ml-agents/:"
export PYTHONPATH

echo  "We do not need to cd to this path: $1"
cd $1

python3 ${HOME}/data_GPU/SurgerySimulator/ml-agents/mlagents/trainers/learn.py config.yaml --run-id=cataractEnv-visual-testGPU-1 \
 --env=cataractEnv.x86_64 --save-freq=25000 --keep-checkpoints=50 --worker-id=1 --train --load --visual-obs-use



