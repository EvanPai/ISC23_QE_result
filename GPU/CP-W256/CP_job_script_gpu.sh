#!/bin/bash
#SBATCH -N 1
#SBATCH -p GPU-shared
#SBATCH -t 00:30:00
#SBATCH --gpus=v100-32:4
#SBATCH --cpus-per-task=4        # Number of cores per srun task
#SBATCH --ntasks-per-node=4      # allocates each node with 4 srun task

#SBATCH -o cp256-71-%j.out                # Path to the standard output file
#SBATCH -e cp256-71-%j.err                # Path to the standard error ouput file

#type 'man sbatch' for more information and options
#this job will ask for 4 V100 GPUs on a v100-32 node in GPU-shared for 5 hours
#this job would potentially charge 20 GPU SUs

#echo commands to stdout
set -x
module load mkl/2020.4.304 openmpi/4.0.5-nvhpc22.9

# move to working directory
# this job assumes:
# - all input data is stored in this directory
# - all output should be stored in this directory
# - please note that groupname should be replaced by your groupname
# - username should be replaced by your username
# - path-to-directory should be replaced by the path to your directory where the executable is

cd /jet/home/hpeng1/qe_john/CP-W256


#run pre-compiled program which is already in your project space
#-x LD_PRELOAD=/ocean/projects/bio220064p/hpeng1/opt/IPM_lib_intel_openMPI/lib/libipm.so.0
mpirun -n 4 -x LD_PRELOAD=/ocean/projects/bio220064p/hpeng1/opt/IPM_lib_intel_openMPI/lib/libipm.so.0 /jet/home/hpeng1/qe_john/builds/qe-7.1-PSC-ompi-O3-with-scalapack-21.9/bin/cp.x -inp ./cp.in
