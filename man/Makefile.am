xde_man7_files = \
	sound.man

nodist_man7_MANS = $(xde_man7_files)

CLEANFILES = $(xde_man7_files)

EXTRA_DIST = \
	     sound.pod

$(xde_man7_files): %.man: %.pod
	$(AM_V_GEN)pod2man --center="Conventions and Miscellaneous Information" \
		--date="$(DATE)" \
		--errors="none" \
		--fixed="CW" \
		--fixedbold="CB" \
		--fixeditalic="CI" \
		--fixedbolditalic="CX" \
		--nourls \
		--release="$(PACKAGE) $(VERSION)" \
		--section="7" \
		$< >$@

