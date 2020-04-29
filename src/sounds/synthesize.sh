#!/bin/bash

files=$(grep -l DisplayName= freedesktop/stereo/*.sound)

for f in $files ; do
	b=$(basename "$f" .sound)
	g="$b.wav"
	h="$b.oga"
	d="$b.disabled"
	text=
	[ -z "$text" ] && text=$(cat "$f"|sed -n '/^SpokenWords=/{s,SpokenWords=,,;p;q}')
	[ -z "$text" ] && text=$(cat "$f"|sed -n '/^DisplayName=/{s,DisplayName=,,;p;q}')
	if [ -n "$text" ]; then
		disabled=$(cat "$f"|sed -n '/^Disabled=/{s,Disabled=,,;p;q}')
		if [ "$disabled" != "true" ]; then
			if [ ! -s "flite-M/stereo/$h" ] ; then
				echo "==> Synthesizing $g:"
				echo "    \"$text\""
				flite_cmu_us_rms -t "$text" -o $g
				#flite -voice /home/brian/voices/cmu_us_rms.flitevox -t "$text" -o $g
				echo "--> converting $g to flite-M/stereo/$h"
#				sndfile-convert -normalize -vorbis $g flite-M/stereo/$h
				sndfile-convert -vorbis $g flite-M/stereo/$h
			fi
			rm -fv "$g" "flite-M/stereo/$d"
		else
			if [ ! -f "flite-M/stereo/$d" ] ; then
				echo "==> Disabling $d:"
				echo "    \"$text\""
				echo "--> creating flite-M/stereo/$d"
				cat /dev/null >flite-M/stereo/$d
			fi
			rm -fv "$g" "flite-M/stereo/$h"
		fi
	else
		echo "WARNING: missing text for $b" >&2
	fi
done

for f in $files ; do
	b=$(basename "$f" .sound)
	g="$b.wav"
	h="$b.oga"
	d="$b.disabled"
	text=
	[ -z "$text" ] && text=$(cat "$f"|sed -n '/^SpokenWords=/{s,SpokenWords=,,;p;q}')
	[ -z "$text" ] && text=$(cat "$f"|sed -n '/^DisplayName=/{s,DisplayName=,,;p;q}')
	if [ -n "$text" ]; then
		disabled=$(cat "$f"|sed -n '/^Disabled=/{s,Disabled=,,;p;q}')
		if [ "$disabled" != "true" ]; then
			if [ ! -s "flite-F/stereo/$h" ] ; then
				echo "==> Synthesizing $g:"
				echo "    \"$text\""
				flite_cmu_us_slt -t "$text" -o $g
				#flite -voice /home/brian/voices/cmu_us_slt.flitevox -t "$text" -o $g
				echo "--> converting $g to flite-F/stereo/$h"
#				sndfile-convert -normalize -vorbis $g flite-F/stereo/$h
				sndfile-convert -vorbis $g flite-F/stereo/$h
			fi
			rm -fv "$g" "flite-F/stereo/$d"
		else
			if [ ! -f "flite-F/stereo/$d" ] ; then
				echo "==> Disabling $d:"
				echo "    \"$text\""
				echo "--> creating flite-F/stereo/$d"
				cat /dev/null >flite-F/stereo/$d
			fi
			rm -fv "$g" "flite-F/stereo/$h"
		fi
	else
		echo "WARNING: missing text for $b" >&2
	fi
done

