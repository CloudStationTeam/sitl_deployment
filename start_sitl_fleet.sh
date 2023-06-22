#!/bin/sh

HELP_MSG="
	Usage:
		-h, --help 			Help message
		--loc=/path/to/ardupilot 	Set the location of your ArduPilot directory
		--ip=x.x.x.x 			Set the CloudStation IP
		--udp=xxxxx 			Set the first open UDP port
	For more details see README"

# Configurables
ARDUPILOT_LOC="/path/to/ardupilot" # Location of ardupilot, either absolute path or relative to where this script is being executed from
CLOUDSTATION_IP="54.219.7.188" # IP of CloudStation instance
UDP_PORT=14550 # First UDP open port on CloudStation (will be incremented for each drone)

# Command Line Args
for arg in "$@"
do
    case $arg in
        -h|--help)
		echo "$HELP_MSG"
        exit 0
        ;;
        --loc=*)
        ARDUPILOT_LOC="${arg#*=}"
        shift # Remove --cache= from processing
        ;;
        --ip=*)
        CLOUDSTATION_IP="${arg#*=}"
        shift # Remove --cache= from processing
        ;;
        --udp=*)
        UDP_PORT="${arg#*=}"
        shift # Remove --cache= from processing
        ;;
        *)
        shift # Remove generic argument from processing
        ;;
    esac
done

echo "Note: It is not recommended to generate multiple instances of a vehicle when running it for the first time, as it will need to be compiled.
"

echo "ArduPilot location: $ARDUPILOT_LOC"
echo "CloudStation IP: $CLOUDSTATION_IP"
echo "First open UDP port: $UDP_PORT"

echo "
# of copters to start:"
read copters
# echo "# of planes to start:"
# read planes
# echo "# of subs to start:"
# read subs
echo "
# of rovers to start:"
read rovers

vehicle=0

cd $ARDUPILOT_LOC
git submodule update --init --recursive

echo "
Launching $copters copters..."

for (( i=0; i<copters; i++ ))
do
	echo "Assigning UDP port $UDP_PORT"
	mintty Tools/autotest/sim_vehicle.py -v ArduCopter --no-extra-ports -I $vehicle --out=udp:$CLOUDSTATION_IP:$UDP_PORT &
	((UDP_PORT++))
	((vehicle++))
	sleep 8s
done

# Launch Rovers
echo "
Launching $rovers rovers..."

for (( i=0; i<rovers; i++ ))
do
	echo "Assigning UDP port $UDP_PORT"
	mintty Tools/autotest/sim_vehicle.py -v Rover --no-extra-ports -I $vehicle --out=udp:$CLOUDSTATION_IP:$UDP_PORT &
	((UDP_PORT++))
	((vehicle++))
	sleep 8s
done

