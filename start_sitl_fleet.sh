#!/bin/sh
echo "Note: It is not recommended to generate multiple instances of a vehicle when running it for the first time, as it will need to be compiled."

# Configurables
ARDUPILOT_LOC="../ardupilot/" # Location of ardupilot, either absolute path or relative to where this script is being executed from
CLOUDSTATION_IP="54.219.7.188" # IP of CloudStation instance
UDP_PORT=14550 # First UDP open port on CloudStation (will be incremented for each drone)


echo "ArduPilot location: $ARDUPILOT_LOC"

echo "# of copters to start:"
read copters
# echo "# of planes to start:"
# read planes
# echo "# of subs to start:"
# read subs
echo "# of rovers to start:"
read rovers

vehicle=0

cd $ARDUPILOT_LOC

# Launch Rovers
echo "Launching $rovers rovers..."

for (( i=0; i<rovers; i++ ))
do
	echo "Assigning UDP port $UDP_PORT"
	mintty Tools/autotest/sim_vehicle.py -v Rover --no-extra-ports -I $vehicle --out=udp:$CLOUDSTATION_IP:$UDP_PORT &
	((UDP_PORT++))
	((vehicle++))
	sleep 8s
done

echo "Launching $copters copters..."

for (( i=0; i<copters; i++ ))
do
	echo "Assigning UDP port $UDP_PORT"
	mintty Tools/autotest/sim_vehicle.py -v ArduCopter --no-extra-ports -I $vehicle --out=udp:$CLOUDSTATION_IP:$UDP_PORT &
	((UDP_PORT++))
	((vehicle++))
	sleep 8s
done

