#!/bin/bash

OUTPUT=`acpi`
CHARGING=$(echo $OUTPUT | grep -c "Not charging")

if [[ "$CHARGING" == 1 ]] ; then
	VALUE=$(echo $OUTPUT | awk '{print $5}' | sed 's/.$//')
else
	VALUE=$(echo $OUTPUT | awk '{print $4}' | sed 's/..$//')
fi


if [[ $1 == "value" ]] ; then
	echo "$VALUE"
elif [[ $1 == "charging" ]] ; then
	echo "$CHARGING"
fi
