#!/bin/bash

echo "arguments are" $*

sexes="F"

declare -A subdir
declare -A defvox
declare -A voxs

subdir=([F]=flite-F [M]=flite-M)
defvox=([F]=cmu_us_slt [M]=cmu_us_rms)
voxs=([F]="axb clb eey ljm lnh slp slt" [M]="aup fem gka ahw rxr bdl jmk awb ksp aew rms")

echo "subdir[F] = ${subdir[F]}"
echo "subdir[M] = ${subdir[M]}"
echo "defvox[F] = ${defvox[F]}"
echo "defvox[M] = ${defvox[M]}"
echo "voxes[F] = ${voxes[F]}"
echo "voxes[M] = ${voxes[M]}"

for id in $*
do
#	while true
#	do
#		echo "testing $id ..."
		echo "==>" $id
		file="freedesktop/stereo/$id.sound"
		if [ -s "$file" ]
		then
			sw=$(cat "$file"|sed -n '/^SpokenWords=/{s,SpokenWords=,,;p;q}')
			dn=$(cat "$file"|sed -n '/^DisplayName=/{s,DisplayName=,,;p;q}')
			text=
			[ -z "$text" ] && text="$sw"
			[ -z "$text" ] && text="$dn"
			if [ -n "$text" ]
			then
				for sex in $sexes ; do
					voice=$(cat "$file"|sed -n "/^Speaker[[]$sex[]]=/{s,Speaker[[]$sex[]]=,,;p;q}")
					echo " -> Speaking (w/o effects): $sex ${voice:-${defvox[$sex]}}"
					echo "    \"$text\""
					flite -voice /usr/lib/flite/${voice:-${defvox[$sex]}}.flitevox -t "$text" -o /dev/stdout | \
						play -t wav - gain -n -3
					effect=$(cat "$file"|sed -n '/^SoxEffects=/{s,SoxEffects=,,;p;q}')
					if test -n "$effect" ; then
						echo " -> Speaking (w/  effects): $sex ${voice:-${defvox[$sex]}}"
						echo "    \"$text\""
						flite -voice /usr/lib/flite/${voice:-${defvox[$sex]}}.flitevox -t "$text" -o /dev/stdout | \
							play -t wav - ${effect} gain -n -3
					else
						echo " -> No effects for $file (skipping)"
					fi
					play="${subdir[$sex]}/stereo/$id.ogg"
					[ -s "$play" ] || play="${subdir[$sex]}/stereo/$id.oga"
					[ -s "$play" ] || play="${subdir[$sex]}/stereo/$id.wav"
					if [ -s "$play" ]
					then
						echo " -> Playing $sex $play:"
						echo "    \"$dn\""
						echo -n "    "
						play "$play"
					else
						echo " -> No file for $play (skipping)"
					fi
				done
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
