# SITL Fleet Auto-deployment

This script automates the process of launching simulated UAVs (using SITL) and connecting them to a running [CloudStation](https://github.com/CloudStationTeam/cloud_station_web) instance. It creates the desired numbers of each type of SITL vehicle, then appends the appropriate CloudStation UDP port its output list.

[About SITL Deployment](https://cloud-station-docs.readthedocs.io/en/latest/sitl/).

## Prerequisites
This script was developed and tested on a Windows 10 machine using a Cygwin terminal (which is required for SITL to run. Git Bash and other terminals, as far as we know, will not work). It has not been tested with Linux or other environments.

It assumes that [SITL](https://ardupilot.org/dev/docs/SITL-setup-landingpage.html) has already been downloaded on the machine the script is being run on.

Currently, only copters and rovers are supported.

## Launch Options
```
	-h, --help 				Help message
	--loc=/path/to/ardupilot 		Set the location of your ArduPilot directory
	--ip=x.x.x.x 				Set the CloudStation IP
	--udp=xxxxx 				Set the first open UDP port
        --custom_location=<Lat,Lng,Alt,Heading> Set the first location of the drone (optional)
        --other_args Optional 
```

Location, IP, and UDP are required data for the program to run, although you can edit the start_sitl_fleet.sh script directly to change the default variables instead of using the flags.

## Connecting to CloudStation
After logging in to your CloudStation page, in the box labeled "Connect to Vehicle via ID," enter the UDP port number and hit "Connect" for each of the drones you created (they will begin with the UDP port you entered and increment by 1 for each vehicle).

## Notes & Known Issues
Currently, closing one SITL instance will cause all other SITL instances on the same computer to disconnect. This seems to be because of how one of the TCP connections between SITL and MAVProxy is set up.

There also does not seem to be a way to use SITL with CloudStation without MAVProxy at the moment, as local TCP connection between the GCS and SITL is required. If CloudStation is extended to work with TCP as well as UDP, it may be possible to run SITL without MAVProxy on the same machine that CloudStation is hosted on.

## Troubleshooting
If you get errors that look like,
```
start_sitl_fleet.sh: line 2: $'/r': command not found
```
the line endings on the script may have been converted to Windows line endings instead of UNIX line endings. To check this, open the file using Vi:
`vi start_sitl_fleet.sh`
Then enter the commands:
```
:set list
:e ++ff=unix
```
If you see `^M$` at the line endings, it means the line endings are Windows instead of Unix. You can convert them to Unix line endings with:
```
:set ff=unix
```
The `^M`s will disappear, leaving only `$` line endings. After this, you can run the script normally.
