<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in
-odac           -iadc    ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o partikkel_softsync.wav -W ;;; for file output any platform
</CsOptions>

<CsInstruments>

sr = 44100
ksmps = 20
nchnls = 2

; Example by Oeyvind Brandtsegg 2007

giSine		ftgen	0, 0, 65537, 10, 1
giCosine	ftgen	0, 0, 8193, 9, 1, 1, 90

instr 1

; example of soft synchronization of two partikkel instances

kgrainfreq	= 4			; 4 grains per second
kdistribution	= 0			; periodic grain distribution
idisttab	= -1			; (default) flat distribution used
                                        ; for grain distribution
async		= 0			; no sync input
kenv2amt	= 0			; no secondary enveloping
ienv2tab	= -1			; default secondary envelope (flat)
ienv_attack	= -1 ;			; default attack envelope (flat)
ienv_decay	= -1 ;			; default decay envelope (flat)
ksustain_amount	= 0.5			; time (in fraction of grain dur) at
                                        ; sustain level for each grain
ka_d_ratio	= 0.5 			; balance between attack and decay time
kduration	= 10			; set grain duration in ms
kamp		= 20000 		; amp
igainmasks	= -1			; (default) no gain masking
kwavfreq	= 440			; fundamental frequency of source waveform
ksweepshape	= 0			; shape of frequency sweep (0=no sweep)
iwavfreqstarttab = -1			; default frequency sweep start
                                        ; (value in table = 1, which give
                                        ; no frequency modification)
iwavfreqendtab	= -1			; default frequency sweep end
                                        ; (value in table = 1, which give
                                        ; no frequency modification)
awavfm		= 0			; no FM input
ifmamptab	= -1			; default FM scaling (=1)
kfmenv		= -1			; default FM envelope (flat)
icosine		= giCosine		; cosine ftable
kTrainCps	= kgrainfreq		; set trainlet cps equal to grain
                                        ; rate for single-cycle trainlet in
                                        ; each grain
knumpartials	= 3			; number of partials in trainlet
kchroma		= 1			; balance of partials in trainlet
ichannelmasks	= -1			; (default) no channel masking,
                                        ; all grains to output 1
krandommask	= 0			; no random grain masking
kwaveform1	= giSine		; source waveforms
kwaveform2	= giSine		;
kwaveform3	= giSine		;
kwaveform4	= giSine		;
iwaveamptab	= -1			; mix of 4 source waveforms and
                                        ; trainlets (set to default)
asamplepos1	= 0			; phase offset for reading source waveform
asamplepos2	= 0			;
asamplepos3	= 0			;
asamplepos4	= 0			;
kwavekey1	= 1			; original key for source waveform
kwavekey2	= 1			;
kwavekey3	= 1			;
kwavekey4	= 1			;
imax_grains	= 100			; max grains per k period
iopcode_id	= 1			; id of opcode, linking partikkel
                                        ; to partikkelsync

a1  partikkel kgrainfreq, kdistribution, idisttab, async, kenv2amt, \
       ienv2tab,ienv_attack, ienv_decay, ksustain_amount, ka_d_ratio, \
       kduration, kamp, igainmasks, kwavfreq, ksweepshape, \
       iwavfreqstarttab, iwavfreqendtab, awavfm, ifmamptab, kfmenv, \
       icosine, kTrainCps, knumpartials, kchroma, ichannelmasks, \
       krandommask, kwaveform1, kwaveform2, kwaveform3, kwaveform4, \
       iwaveamptab, asamplepos1, asamplepos2, asamplepos3, asamplepos4, \
       kwavekey1, kwavekey2, kwavekey3, kwavekey4, imax_grains, iopcode_id

async1		partikkelsync	iopcode_id   ; clock pulse output of the 
                                             ; partikkel instance above
ksyncGravity 	line 0, p3, 0.3	     ; strength of synchronization
aphase2		init 0					
asyncPolarity	limit (int(aphase2*2)*2)-1, -1, 1
; use the phase of partikkelsync instance 2 to find sync 
; polarity for partikkel instance 2.
; If the phase of instance 2 is less than 0.5, we want to
; nudge it down when synchronizing,
; and if the phase is > 0.5 we want to nudge it upwards.
async1		= async1*ksyncGravity*asyncPolarity  ; prepare sync signal
                                                  ; with polarity and strength

kgrainfreq2	= 3		; grains per second
iopcode_id2	= 2
a2 partikkel kgrainfreq2, kdistribution, idisttab, async1, kenv2amt, \
       ienv2tab, ienv_attack, ienv_decay, ksustain_amount, ka_d_ratio, \
       kduration, kamp, igainmasks, kwavfreq, ksweepshape, \
       iwavfreqstarttab, iwavfreqendtab, awavfm, ifmamptab, kfmenv, \
       icosine, kTrainCps, knumpartials, kchroma, ichannelmasks, \
       krandommask, kwaveform1, kwaveform2, kwaveform3, kwaveform4, \
       iwaveamptab, asamplepos1, asamplepos2, asamplepos3, \ 
       asamplepos4, kwavekey1, kwavekey2, kwavekey3, kwavekey4, \
       imax_grains, iopcode_id2

async2, aphase2	partikkelsync	iopcode_id2
; clock pulse and phase 
; output of the partikkel instance above,
; we will only use the phase

outs	a1, a2

endin

</CsInstruments>
<CsScore>

i1 0 20 	; partikkel

e
</CsScore>
</CsoundSynthesizer>