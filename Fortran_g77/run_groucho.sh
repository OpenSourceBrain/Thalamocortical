#!/bin/bash
# run this file on the master by typing ./run_groucho.sh &
# the groucho program will then start up on 14 nodes on colossus with
# two of the rank on master (see colossusnodes)
GROUCHO_TIME_FILE=master_output.txt
echo Starting groucho `date`,  will write time data to $GROUCHO_TIME_FILE
echo groucho start: `date` >  $GROUCHO_TIME_FILE
nice mpirun -machinefile colossusnodes -np 14 ./groucho >&  tempfile.x
cat  tempfile.x >> $GROUCHO_TIME_FILE
echo groucho end: `date` >>  $GROUCHO_TIME_FILE
echo Finished groucho `date`
