#!/bin/bash
#SBATCH -n 1
#SBATCH -t 0-12:00
#SBATCH -p short
#SBATCH --mem 4G

set -eu -o pipefail

PNAME=svcall
bcbio_vm.py cwlrun cromwell --no-container -q short -s slurm -r timelimit=0-12:00 -r account=tester $PNAME-workflow
