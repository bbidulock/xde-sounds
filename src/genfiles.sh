#!/bin/bash

# Generates automake includes files

file="$1"
srcdir=$(dirname "$0")
test "$srcdir" = "." && srcdir=

d=sounds/freedesktop/stereo
test -n "$srcdir" && d="$srcdir/$d"

files=$(find "$d" -name '*.sound'|sort)

echo -n "Generating $file for srcdir=$srcdir ... (this will take a minute) ..."
echo -n "" >$file

echo -e -n "sound_data_files =" >>$file
for f in $files; do
	test -n "$srcdir" && f=$(echo "$f"|sed "s,^$srcdir/,,")
	echo -e " \\" >>$file
	echo -e -n "\t$f" >>$file
done
echo -e "\n" >>$file

for dir in flite-M flite-F; do
	var=$(echo "$dir"|sed 's,-,_,')
	echo -n "${var}_oga_files =" >tmp1.$$
	echo -n "${var}_dis_files =" >tmp2.$$
	echo -n "${var}_ogg_files =" >tmp3.$$
	for f in $files; do
		g=$(echo "$f"|sed "s,/freedesktop/,/$dir/,")
		wav=$(echo "$g"|sed 's,\.sound,.wav,')
		oga=$(echo "$g"|sed 's,\.sound,.oga,')
		ogg=$(echo "$g"|sed 's,\.sound,.ogg,')
		dis=$(echo "$g"|sed 's,\.sound,.disabled,')
		text=
		[ -z "$text" ] && text=$(cat "$f"|sed -n '/^SpokenWords=/{s,SpokenWords=,,;p;q}')
		[ -z "$text" ] && text=$(cat "$f"|sed -n '/^DisplayName=/{s,DisplayName=,,;p;q}')
		if [ -n "$text" ]; then
			disabled=$(cat "$f"|sed -n '/^Disabled=/{s,Disabled=,,;p;q}')
			if [ "$disabled" != "true" ]; then
				test -n "$srcdir" && oga=$(echo "$oga"|sed "s,^$srcdir/,,")
				echo -e " \\" >>tmp1.$$
				echo -e -n "\t$oga" >>tmp1.$$
			else
				test -n "$srcdir" && dis=$(echo "$dis"|sed "s,^$srcdir/,,")
				echo -e " \\" >>tmp2.$$
				echo -e -n "\t$dis" >>tmp2.$$
			fi
			[ -s "$ogg" ] && {
				test -n "$srcdir" && ogg=$(echo "$ogg"|sed "s,^$srcdir/,,")
				echo -e " \\" >>tmp3.$$
				echo -e -n "\t$ogg" >>tmp3.$$
			}
		else
			echo "WARNING: missing text for $f" >&2
		fi
	done
	cat tmp1.$$ >>$file
	echo -e "\n" >>$file
	cat tmp2.$$ >>$file
	echo -e "\n" >>$file
	cat tmp3.$$ >>$file
	echo -e "\n" >>$file
#	echo -n "${var}_files =" >>$file
#	echo " \\" >>$file
#	echo -e -n "\t\$(${var}_oga_files)" >>$file
#	echo " \\" >>$file
#	echo -e -n "\t\$(${var}_dis_files)" >>$file
#	echo " \\" >>$file
#	echo -e -n "\t\$(${var}_ogg_files)" >>$file
#	echo "" >>$file
	rm -f tmp1.$$ tmp2.$$ tmp3.$$
done

echo -e -n "incredible_files =" >>$file
d=sounds/Incredibles/stereo
test -n "$srcdir" && d="$srcdir/$d"
find "$d" -name '*.oga' -o -name '*.ogg' -o -name '*.wav' -o -name '*.disabled' -o -name '*.sound' | \
sort | while read f; do
	test -n "$srcdir" && f=$(echo "$f"|sed "s,^$srcdir/,,")
	echo -e " \\" >>$file
	echo -e -n "\t$f" >>$file
done
echo -e "\n" >>$file

echo -e -n "xde_data_files =" >>$file
d=sounds/xde/stereo
test -n "$srcdir" && d="$srcdir/$d"
find "$d" -name '*.oga' -o -name '*.ogg' -o -name '*.wav' -o -name '*.disabled' -o -name '*.sound' | \
sort | while read f; do
	test -n "$srcdir" && f=$(echo "$f"|sed "s,^$srcdir/,,")
	echo -e " \\" >>$file
	echo -e -n "\t$f" >>$file
done
echo -e "\n" >>$file

echo " done."

