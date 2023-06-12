
#!/bin/bash

if [[ "$1" == "previous" ]] ; then
	playerctl previous
elif [[ "$1" == "next" ]] ; then
	playerctl next
elif [[ "$1" == "toggle" ]] ; then
	playerctl play-pause
elif [[ "$1" == "getTitle" ]] ; then
	playerctl metadata title
elif [[ "$1" == "getImage" ]] ; then
	playerctl metadata artUrl
elif [[ "$1" == "getArtist" ]] ; then
	playerctl metadata artist
fi

