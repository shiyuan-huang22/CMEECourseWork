#!/bin/bash
#PBS -lwalltime=11:30:00
#PBS -lselect=1:ncpus=1:mem=1gb

module load anaconda3/personal
echo "R is about to run"
R --vanilla < $HOME/sh422_HPC_2022_neutral_cluster.R
mv neutral_simulation_result* $HOME
echo "R has finished running"