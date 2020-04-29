#!/bin/bash

echo "arguments are" $*

for id in $*
do
#	while true
#	do
#		echo "testing $id ..."
		echo "==>" $id
		f="freedesktop/stereo/$id.sound"
		if [ -s "$f" ]
		then
			sw=$(cat "$f"|sed -n '/^SpokenWords=/{s,SpokenWords=,,;p;q}')
			dn=$(cat "$f"|sed -n '/^DisplayName=/{s,DisplayName=,,;p;q}')
			text=
			[ -z "$text" ] && text="$sw"
			[ -z "$text" ] && text="$dn"
			if [ -n "$text" ]
			then
				 #for v in axb clb eey ljm lnh slp slt ; do
				for v in slt ; do
					echo " -> Speaking: $v"
					echo "    \"$text\""
					flite -voice /usr/lib/flite/cmu_us_${v}.flitevox -t "$text"
					sleep 1
				done
				#flite_cmu_us_slt -t "$text"
				f="flite-F/stereo/$id.ogg"
				[ -s "$f" ] || f="flite-F/stereo/$id.oga"
				[ -s "$f" ] || f="flite-F/stereo/$id.wav"
				if [ -s "$f" ]
				then
					echo " -> Playing $f:"
					echo "    \"$dn\""
					echo -n "    "
					sndfile-play "$f"
				fi
			else
				echo "WARNING: missing text for $id" >&2
			fi
		fi
#		prefix=$(echo "$id"|sed 's,-[^-]*$,,')
#		if [ "$prefix" = "$id" ]
#		then
#			break
#		fi
#		id="$prefix"
#	done
done
