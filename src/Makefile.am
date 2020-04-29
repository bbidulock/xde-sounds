
-include files.mkf

files.mkf: Makefile $(srcdir)/genfiles.sh
	$(SHELL) $(srcdir)/genfiles.sh $@

DISTCLEANFILES = files.mkf

EXTRA_DIST = genfiles.sh files.mkf

nobase_dist_share_DATA = \
	$(sound_data_files) \
	sounds/flite-F/index.theme \
	$(flite_F_ogg_files) \
	sounds/flite-M/index.theme \
	$(flite_M_ogg_files) \
	sounds/Incredibles/index.theme \
	$(incredible_files) \
	sounds/xde/index.theme \
	$(xde_data_files)

nobase_nodist_share_DATA = \
	$(flite_F_wav_files) \
	$(flite_F_dis_files) \
	$(flite_M_wav_files) \
	$(flite_M_dis_files)

CLEANFILES = \
	$(flite_F_wav_files) \
	$(flite_F_dis_files) \
	$(flite_M_wav_files) \
	$(flite_M_dis_files)

all-am: $(nobase_nodist_share_DATA)

$(flite_F_wav_files): sounds/flite-F/stereo/%.wav: $(srcdir)/sounds/freedesktop/stereo/%.sound
	$(AM_V_GEN)test -d sounds/flite-F/stereo || mkdir -p sounds/flite-F/stereo ; \
	text= ; \
	[ -z "$$text" ] && text=$$(cat "$<"|sed -n '/^SpokenWords/{s,SpokenWords=,,;p;q}') ; \
	[ -z "$$text" ] && text=$$(cat "$<"|sed -n '/^DisplayName/{s,DisplayName=,,;p;q}') ; \
	if [ -n "$$text" ]; then \
		flite -voice /usr/lib/flite/cmu_us_slt.flitevox -t "$$text" -o "$@" ; \
	fi

$(flite_M_wav_files): sounds/flite-M/stereo/%.wav: $(srcdir)/sounds/freedesktop/stereo/%.sound
	$(AM_V_GEN)test -d sounds/flite-M/stereo || mkdir -p sounds/flite-M/stereo ; \
	text= ; \
	[ -z "$$text" ] && text=$$(cat "$<"|sed -n '/^SpokenWords/{s,SpokenWords=,,;p;q}') ; \
	[ -z "$$text" ] && text=$$(cat "$<"|sed -n '/^DisplayName/{s,DisplayName=,,;p;q}') ; \
	if [ -n "$$text" ]; then \
		flite -voice /usr/lib/flite/cmu_us_rms.flitevox -t "$$text" -o "$@" ; \
	fi

$(flite_F_dis_files): sounds/flite-F/stereo/%.disabled: $(srcdir)/sounds/freedesktop/stereo/%.sound
	$(AM_V_GEN)test -d sounds/flite-F/stereo || mkdir -p sounds/flite-F/stereo ; \
	cat /dev/null >$@

$(flite_M_dis_files): sounds/flite-M/stereo/%.disabled: $(srcdir)/sounds/freedesktop/stereo/%.sound
	$(AM_V_GEN)test -d sounds/flite-M/stereo || mkdir -p sounds/flite-M/stereo ; \
	cat /dev/null >$@


