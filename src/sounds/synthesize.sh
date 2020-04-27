#!/bin/bash

files=$(grep -l DisplayName= freedesktop/stereo/*.sound)

for f in $files ; do
	b=$(basename "$f" .sound)
	g="$b.wav"
	h="$b.oga"
	if [ ! -s "flite-M/stereo/$h" ] ; then
		text=$(cat "$f"|sed -n '/^DisplayName=/{s,DisplayName=,,;p;q}')
		if [ -n "$text" ]; then
			echo "==> Syntesizing $g:"
			echo "    \"$text\""
			flite_cmu_us_kal16 -t "$text" -o $g
			echo "--> converting $g to flite-M/stereo/$h"
			sndfile-convert -normalize -vorbis $g flite-M/stereo/$h
			rm -fv $g
		else
			echo "WARNING: missing text for $b" >&2
		fi
	fi
done

for f in $files ; do
	b=$(basename "$f" .sound)
	g="$b.wav"
	h="$b.oga"
	if [ ! -s "flite-F/stereo/$h" ] ; then
		text=$(cat "$f"|sed -n '/^DisplayName=/{s,DisplayName=,,;p;q}')
		if [ -n "$text" ]; then
			echo "==> Syntesizing $g:"
			echo "    \"$text\""
			flite_cmu_us_slt -t "$text" -o $g
			echo "--> converting $g to flite-F/stereo/$h"
			sndfile-convert -normalize -vorbis $g flite-F/stereo/$h
			rm -fv $g
		else
			echo "WARNING: missing text for $b" >&2
		fi
	fi
done

