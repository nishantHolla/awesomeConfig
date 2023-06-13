#!/bin/bash

OUTPUT=`acpi`
VALUE=$(echo $OUTPUT | awk '{print $4}' | sed 's/..$//')
CHARGING=$(echo $OUTPUT | grep -c "Charging")

if [[ $1 == "value" ]] ; then
	echo "$VALUE"
elif [[ $1 == "charging" ]] ; then
	echo "$CHARGING"
fi
