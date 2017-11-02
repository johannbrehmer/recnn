#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=25
#SBATCH --time=80:00:00
#SBATCH --mem=32GB
#SBATCH --job-name=recnn
#SBATCH --mail-type=ALL
#SBATCH --mail-user=johann.brehmer@nyu.edu
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err
##SBATCH --gres=gpu:1
#SBATCH --array=1-10

module purge

SRCDIR=$HOME/learning_substructure/recnn
cd $SRCDIR
DATA_DIR=$SCRATCH/data/w-vs-qcd/anti-kt
MODEL_DIR=$SCRATCH/models/pileup/

let 'SEED=SLURM_ARRAY_TASK_ID * 345'

python train.py $DATA_DIR/antikt-kt-pileup25-new-train.pickle $MODEL_DIR/model-pileup-50epochs-$SLURM_ARRAY_TASK_ID.pickle --random_state=$SEED --n_epochs=50
