
#!/bin/bash

OUTPUT=`acpi`
IS_CHARGING=`echo $OUTPUT | grep -c "Charging"`
IS_NOT_CHARGING=`echo $OUTPUT | grep -c "Not charging"`

if [[ "$IS_NOT_CHARGING" == "1" ]] ; then
	VALUE=`echo "$OUTPUT" | awk '{print $5}' | sed 's/..$//'`
else
	VALUE=`echo "$OUTPUT" | awk '{print $4}' | sed 's/..$//'`
fi

if [[ "$IS_CHARGING" == "1" ]] ; then
	echo -en "${VALUE}C"
else
	echo -en "${VALUE}N"
fi
