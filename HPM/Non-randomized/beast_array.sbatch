#!/bin/bash
#SBATCH --job-name=HIV_NR
#SBATCH --mail-user=brittany.magalis@temple.edu
#SBATCH --mail-type=END,ABORT
#SBATCH --account=epi
#SBATCH --qos=epi
#SBATCH --output=out_beast_log_%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=2gb
#SBATCH --time=200:00:00

#####################################################################################

module load beast/1.10-pre

file=$(ls *.xml | sed -n ${SLURM_ARRAY_TASK_ID}p)
 
beast -beagle_scaling always -overwrite -threads 2 -beagle_SSE -beagle_instances 2 -seed 666 -errors 1000 $file

#####################################################################################

date
date2=$(date +"%s")
diff=$(($date2-$date1))
echo "$(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
