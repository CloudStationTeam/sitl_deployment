#!/bin/sh

# Configurables
ARDUPILOT_LOC="../ardupilot/"
CLOUDSTATION_IP="54.219.7.188"
UDP_PORT=14550


echo "ArduPilot location: $ARDUPILOT_LOC"

# echo "# of copters to start:"
# read copters
# echo "# of planes to start:"
# read planes
# echo "# of subs to start:"
# read subs
echo "# of rovers to start:"
read rovers

cd $ARDUPILOT_LOC

# Launch Rovers
echo "Launching $rovers rovers..."

for (( i=0; i<rovers; i++ ))
do
	echo "Assigning UDP port $UDP_PORT"
	mintty Tools/autotest/sim_vehicle.py -v Rover --no-extra-ports -I $i --out=udp:$CLOUDSTATION_IP:$UDP_PORT &
	((UDP_PORT++))
	sleep 5s
done

