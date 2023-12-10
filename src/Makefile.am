
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
	$(flite_F_dis_files) \
	$(flite_M_dis_files)

if HAVE_SOX
nobase_nodist_share_DATA += \
	$(flite_F_oga_files) \
	$(flite_M_oga_files)
else
nobase_nodist_share_DATA += \
	$(flite_F_wav_files) \
	$(flite_M_wav_files)
endif

CLEANFILES = \
	$(flite_F_wav_files) \
	$(flite_F_oga_files) \
	$(flite_F_dis_files) \
	$(flite_M_wav_files) \
	$(flite_M_oga_files) \
	$(flite_M_dis_files)

all-am: $(nobase_nodist_share_DATA)

if EFFECTS
EFFECTS = $$(cat "$<"|sed -n '/^SoxEffects/{s,SoxEffects=,,;p;q}')
endif

$(flite_F_wav_files): sounds/flite-F/stereo/%.wav: $(srcdir)/sounds/freedesktop/stereo/%.sound
	$(AM_V_GEN)test -d sounds/flite-F/stereo || $(MKDIR_P) sounds/flite-F/stereo ; \
	text= ; \
	test -z "$$text" && text=$$(cat "$<"|sed -n '/^SpokenWords/{s,SpokenWords=,,;p;q}') ; \
	test -z "$$text" && text=$$(cat "$<"|sed -n '/^DisplayName/{s,DisplayName=,,;p;q}') ; \
	if test -n "$$text"; then \
		voice=$$(cat "$<"|sed -n '/^Speaker[[]F[]]/{s,Speaker[[]F[]]=,,;p;q}') ; \
		$(FLITE) -voice $(FLITEDIR)/$${voice:-$(FVOICE)}.flitevox -t "$$text" -o "$@" ; \
	fi

$(flite_F_oga_files): sounds/flite-F/stereo/%.oga: $(srcdir)/sounds/freedesktop/stereo/%.sound
	$(AM_V_GEN)test -d sounds/flite-F/stereo || $(MKDIR_P) sounds/flite-F/stereo ; \
	text= ; \
	test -z "$$text" && text=$$(cat "$<"|sed -n '/^SpokenWords/{s,SpokenWords=,,;p;q}') ; \
	test -z "$$text" && text=$$(cat "$<"|sed -n '/^DisplayName/{s,DisplayName=,,;p;q}') ; \
	if test -n "$$text"; then \
		voice=$$(cat "$<"|sed -n '/^Speaker[[]F[]]/{s,Speaker[[]F[]]=,,;p;q}') ; \
		$(FLITE) -voice $(FLITEDIR)/$${voice:-$(FVOICE)}.flitevox -t "$$text" -o /dev/stdout | \
		$(SOX) -t wav - -t ogg "$@" $(EFFECTS) gain -n -3 ; \
	fi

$(flite_F_dis_files): sounds/flite-F/stereo/%.disabled: $(srcdir)/sounds/freedesktop/stereo/%.sound
	$(AM_V_GEN)test -d sounds/flite-F/stereo || $(MKDIR_P) sounds/flite-F/stereo ; \
	cat /dev/null >$@

$(flite_M_wav_files): sounds/flite-M/stereo/%.wav: $(srcdir)/sounds/freedesktop/stereo/%.sound
	$(AM_V_GEN)test -d sounds/flite-M/stereo || $(MKDIR_P) sounds/flite-M/stereo ; \
	text= ; \
	test -z "$$text" && text=$$(cat "$<"|sed -n '/^SpokenWords/{s,SpokenWords=,,;p;q}') ; \
	test -z "$$text" && text=$$(cat "$<"|sed -n '/^DisplayName/{s,DisplayName=,,;p;q}') ; \
	if test -n "$$text"; then \
		voice=$$(cat "$<"|sed -n '/^Speaker[[]M[]]/{s,Speaker[[]M[]]=,,;p;q}') ; \
		$(FLITE) -voice $(FLITEDIR)/$${voice:-$(MVOICE)}.flitevox -t "$$text" -o "$@" ; \
	fi

$(flite_M_oga_files): sounds/flite-M/stereo/%.oga: $(srcdir)/sounds/freedesktop/stereo/%.sound
	$(AM_V_GEN)test -d sounds/flite-M/stereo || $(MKDIR_P) sounds/flite-M/stereo ; \
	text= ; \
	test -z "$$text" && text=$$(cat "$<"|sed -n '/^SpokenWords/{s,SpokenWords=,,;p;q}') ; \
	test -z "$$text" && text=$$(cat "$<"|sed -n '/^DisplayName/{s,DisplayName=,,;p;q}') ; \
	if test -n "$$text"; then \
		voice=$$(cat "$<"|sed -n '/^Speaker[[]M[]]/{s,Speaker[[]M[]]=,,;p;q}') ; \
		$(FLITE) -voice $(FLITEDIR)/$${voice:-$(MVOICE)}.flitevox -t "$$text" -o /dev/stdout | \
		$(SOX) -t wav - -t ogg "$@" tempo -s 1.2 $(EFFECTS) gain -n -3 ; \
	fi

$(flite_M_dis_files): sounds/flite-M/stereo/%.disabled: $(srcdir)/sounds/freedesktop/stereo/%.sound
	$(AM_V_GEN)test -d sounds/flite-M/stereo || $(MKDIR_P) sounds/flite-M/stereo ; \
	cat /dev/null >$@


