
#!/bin/bash

case "$1" in
	"get")
		IS_MUTE=`amixer -D pulse sget Master | grep "\[off\]"`

		if [[ "$IS_MUTE" == "" ]] ; then
			VOLUME=`amixer -D pulse sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }' | sed 's/.$//'`
			echo -e "$VOLUME"
		else
			echo -e "0"
		fi

		exit;;
	
	"set")
		amixer -D pulse sset Master "$2" --quiet
		exit;;
	
	"mute")
		amixer -D pulse sset Master mute --quiet
		exit;;

	"unmute")
		amixer -D pulse sset Master unmute --quiet
		exit;;

	"toggle")
		amixer -D pulse sset Master toggle --quiet
		exit;;

esac

