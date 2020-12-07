# SITL Fleet Auto-deployment

This script automates the launching of SITL vehicles for testing purposes with CloudStation. It launches the desired numbers of each type of SITL vehicle, then appends the appropriate CloudStation UDP port its output list.

## Prerequisites
This script was developed and tested on a Windows 10 machine using a Cygwin terminal (which is required for SITL to run. Git Bash and other terminals, as far as we know, will not work). It has not been tested with Linux or other environments.

It assumes that [SITL](https://ardupilot.org/dev/docs/SITL-setup-landingpage.html) has already been downloaded on the machine the script is being run on.

## Launch Options
	-h, --help 				Help message
	--loc=/path/to/ardupilot 		Set the location of your ArduPilot directory
	--ip=x.x.x.x 				Set the CloudStation IP
	---udp=xxxxx 				Set the first open UDP port

Location, IP, and UDP are required data for the program to run, although you can edit the start_sitl_fleet.sh script directly to change the default variables instead of using the flags.

## Connecting to CloudStation
After logging in to your CloudStation page, in the box labeled "Connect to Vehicle via ID," enter the UDP port bumber and hit "Connect" for each of the drones you created (they will begin with the UDP port you entered and increment by 1 for each vehicle).