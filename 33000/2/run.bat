#!/bin/tcsh
#SBATCH --ntasks=32
#SBATCH -t 20:00:00
#SBATCH --mem-per-cpu=6000
#SBATCH -A brehm-prj

module load ansys

#Get an unique temporary filename to use for our nodelist
set FLUENTNODEFILE=`mktemp`

#Output the nodes to our nodelist file
scontrol show hostnames > $FLUENTNODEFILE

#Display to us the nodes being used
echo "Running on nodes:"
cat $FLUENTNODEFILE

#Run fluent with the requested number of tasks on the assigned nodes
fluent 2ddp -g -t $SLURM_NTASKS -mpi=intel -ssh -cnf="$FLUENTNODEFILE" -i naca0012.jou

#Clean up
rm $FLUENTNODEFILE
