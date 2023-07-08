
#!/bin/bash

OUTPUT=`acpi`

IS_DISCHARGING=`echo "$OUTPUT" | grep -c "Discharging"`
IS_NOT_CHARGING=`echo "$OUTPUT" | grep -c "Not charging"`
IS_CHARGING=`echo "$OUTPUT" | grep -c "Charging"`

if [[ "$IS_CHARGING" != "0" ]] ; then
	VALUE=`echo "$OUTPUT" | awk '{print $4}' | sed 's/..$//'`
	echo "${VALUE}C"
elif [[ "$IS_DISCHARGING" != "0" ]] ; then
	VALUE=`echo $OUTPUT | awk '{print $4}' | sed 's/..$//'`
	echo "${VALUE}N"
elif [[ "$IS_NOT_CHARGING" != "0" ]] ; then
	VALUE=`echo $OUTPUT | awk '{print $5}' | sed 's/.$//'`
	echo "${VALUE}N"
fi
