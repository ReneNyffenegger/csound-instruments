sr	=  48000
kr	=  1000
nchnls	=  2

/* ======== drum instruments by Istvan Varga, Mar 10 2002 ======== */

	seed 0

/* ----------------------- global variables ----------------------- */

giflen	=  131072	/* table length in samples	*/
giovr	=  4		/* oversample			*/
gibwd	=  24000	/* max. bandwidth in Hz		*/
gitmpfn	=  99		/* tmp ftable number		*/

; spatializer parameters

gisptd	=  0.5		/* unit circle distance (see spat3d manual)  */
gisptf	=  225		/* room table number (0: no room simulation) */
gisptm	=  2		/* spat3di mode (see manual)		     */

gisptx	=  0.2		/* extra time for room echoes		     */

gidsts	=  0.35		/* distance scale			     */

ga0	init 0		; mono output
ga1	init 0		; spat3di out 1
ga2	init 0		; spat3di out 2
ga3	init 0		; spat3di out 3
ga4	init 0		; spat3di out 4

; mono output file name (for external convolve unit)

#define SNDFL_MONO # "mono_out.pcm" #

/* ---------------------- some useful macros ---------------------- */

; spatialize and send output

#define SPAT_OUT #

a1	rnd31 0.000001 * 0.000001 * 0.000001 * 0.000001, 0, 0
a0	=  a0 + a1

iX	=  iX * gidsts
iY	=  iY * gidsts
iZ	=  iZ * gidsts

a1, a2, a3, a4	spat3di a0, iX, iY, iZ, gisptd, gisptf, gisptm

	vincr ga0, a0
	vincr ga1, a1
	vincr ga2, a2
	vincr ga3, a3
	vincr ga4, a4

#

; convert velocity to amplitude

#define VELOC2AMP(VELOCITY'MAXAMP) # (($MAXAMP) * (0.0039 + ($VELOCITY) * ($VELOCITY) / 16192)) #

; convert MIDI note number to frequency

#define MIDI2CPS(NOTNUM) # (440 * exp(log(2) * (($NOTNUM) - 69) / 12)) #

; power of two number greater than x

#define POW2CEIL(P2C_X) # (int(0.5 + exp(log(2) * int(1.01 + log($P2C_X) / log(2))))) #

; semitones to frequency ratio

#define NOTE2FRQ(XNOTE) # (exp(log(2) * ($XNOTE) / 12)) #

; frequency to table number

#define CPS2FNUM(XCPS'BASE_FNUM) # int(69.5 + ($BASE_FNUM) + 12 * log(($XCPS) / 440) / log(2)) #

/* ---------------- constants ---------------- */

#define PI	# 3.14159265 #
#define TWOPI	# (2 * 3.14159265) #

; ---- instr 1: render tables for cymbal instruments ----

	instr 1

ifn	=  p4		/* ftable number		*/
inumh	=  p5		/* number of partials		*/
iscl	=  p6		/* amp. scale			*/
itrns	=  p7		/* transpose (in semitones)	*/
isd	=  p8		/* random seed (1 to 2^31 - 2)	*/
idst	=  p9		/* amplitude distribution	*/

imaxf	=  $NOTE2FRQ(itrns) * gibwd		; max. frequency
itmp	rnd31 1, 0, isd				; initialize seed

; create empty table for parameters

ifln	=  $POW2CEIL(3 * inumh)
itmp	ftgen gitmpfn, 0, ifln, -2, 0

i1	=  0
l01:
iamp	rnd31 1, idst, 0	; amplitude
icps	rnd31 imaxf, 0, 0	; frequency
iphs	rnd31 1, 0, 0		; phase
iphs	=  abs(iphs)
; cut off partials with too high frequency
iamp	=  (icps > (sr * 0.5) ? 0 : iamp)
iphs	=  (icps > (sr * 0.5) ? 0 : iphs)
icps	=  (icps > (sr * 0.5) ? 0 : icps)
; write params to table
	tableiw iamp, i1 * 3 + 0.25, gitmpfn
	tableiw icps, i1 * 3 + 1.25, gitmpfn
	tableiw iphs, i1 * 3 + 2.25, gitmpfn
i1	=  i1 + 1
	if (i1 < (inumh - 0.5)) igoto l01

; render table

ifln	=  giflen * giovr + 0.25	; length with oversample
itmp	ftgen ifn, 0, ifln, -33, gitmpfn, inumh, iscl, -(giovr)

	endin


/* ---- instr 10: cymbal ---- */

	instr 10

ilnth	=  p3		/* note length				     */
ifn	=  p4		/* function table with instrument parameters */
ivel	=  p5		/* velocity (0 - 127)			     */

iscl	table  0, ifn	; amplitude scale
idel	table  1, ifn	; delay
irel	table  2, ifn	; release time
iX	table  3, ifn	; X
iY	table  4, ifn	; Y
iZ	table  5, ifn	; Z
ixfn	table  6, ifn	; input table
iwfn	table  7, ifn	; window table
igdurs	table  8, ifn	; start grain duration in seconds
igdurt	table  9, ifn	; grain druaton envelope half-time
igdure	table 10, ifn	; end grain duration
iovrlp	table 11, ifn	; number of overlaps
iEQfs	table 12, ifn	; EQ start frequency
iEQft	table 13, ifn	; EQ frequency envelope half-time
iEQfe	table 14, ifn	; EQ end frequency
iEQls	table 15, ifn	; EQ start level (Q is level * 0.7071)
iEQlt	table 16, ifn	; EQ level envelope half-time
iEQle	table 17, ifn	; EQ end level
ihpf	table 18, ifn	; highpass frequency
ilpf	table 19, ifn	; lowpass frequency
idec	table 20, ifn	; decay env. half-time (n.a. in reverse mode)
irvmod	table 21, ifn	; reverse cymbal mode (0: on, 1: off)
idel2	table 22, ifn	; delay time for chorus effect
ilvl1	table 23, ifn	; non-delayed signal level
ilvl2	table 24, ifn	; delayed signal level

ixtime	=  gisptx + idel + irel + idel2		; expand note duration
p3	=  p3 + ixtime

; release envelope

aenv1	linseg 1, ilnth, 1, irel, 0, 1, 0
aenv1	=  aenv1 * aenv1

; output amplitude
iamp	=  $VELOC2AMP(ivel'iscl)
; grain duration
kgdur	port igdure, igdurt, igdurs
; 4 * sr = 192000Hz (sample rate of input file)
a1	grain3	giovr * sr / ftlen(ixfn), 0.5, 0, 0.5,		      \
		kgdur, iovrlp / kgdur, iovrlp + 2,		      \
		ixfn, iwfn, 0, 0, 0, 16

; filters

kEQf	port iEQfe, iEQft, iEQfs
kEQl	port iEQle, iEQlt, iEQls
a1	pareq a1, kEQf, kEQl, kEQl * 0.7071, 0
a1	butterhp a1, ihpf
a1	butterlp a1, ilpf

; amp. envelope

aenv2	expon 1, idec, 1 - 0.5 * irvmod
aenv3	linseg irvmod, ilnth, 1, 1, 1
a1	=  a1 * iamp * aenv1 * aenv2 * (aenv3 * aenv3)

; delays

a2	delay a1 * ilvl2, idel2
a0	delay a2 + a1 * ilvl1, idel

$SPAT_OUT

	endin

/* ---------------------- instr 20: bass drum ---------------------- */

	instr 20

; +------------+             +------------+     +------------+
; | oscillator |--->---+-->--| highpass 1 |-->--| bandpass 1 |-->--+
; +------------+       |     +------------+     +------------+     |
;                      |                                           V
;          +-----<-----+                        +-------------+    |
;          |           |              +----<----| "allpass" 1 |----+
;          |           V              |         +-------------+
;          |           |              |
;          |    +------------+      +---+       +-----------------+
;          |    | highpass 2 |      | + |--->---| output highpass |--+
;          |    +------------+      +---+       +-----------------+  |
;          |           |              |                              V
;          |           V              ^         +----------------+   |
;          |           |              |         | output lowpass |-<-+
;          |         +---+     +------------+   +----------------+
;          +---->----| + |-->--| highpass 3 |           |
;                    +---+     +------------+           +---->-----+
;                                                                  |
; +-----------------+   +----------------+   +---------------+   +---+ output
; | noise generator |->-| noise bandpass |->-| noise lowpass |->-| + |-------->
; +-----------------+   +----------------+   +---------------+   +---+

ilnth	=  p3		; note length
ifn	=  p4		; table number
ivel	=  p5		; velocity

iscl	table  0, ifn	; volume
idel	table  1, ifn	; delay (in seconds)
irel	table  2, ifn	; release time (sec.)
iX	table  3, ifn	; X
iY	table  4, ifn	; Y
iZ	table  5, ifn	; Z

ibpm	table  6, ifn	; tempo

ibsfrq	table  7, ifn	; base frequency (MIDI note number)
ifrqs	table  8, ifn	; oscillator start frequency / base frequency
ifrqt	table  9, ifn	; oscillator freq. envelope half-time in beats

ibw01	table 10, ifn	; bandpass 1 bandwidth / oscillator frequency
ihp1	table 11, ifn	; highpass 1 freq. / oscillator frequency
iapf1	table 12, ifn	; "allpass" 1 start freq. / oscillator frq.
iapdx	table 13, ifn	; "allpass" 1 envelope half-time in beats
iapf2	table 14, ifn	; "allpass" 1 end frq. / oscillator frequency

ihp2	table 15, ifn	; highpass 2 frequency / base frequency
imx2	table 16, ifn	; highpass 2 output gain
ihp3	table 17, ifn	; highpass 3 freq. / base frequency
imx3	table 18, ifn	; highpass 3 output gain

ihpx	table 19, ifn	; output highpass frequency / base frequency
iq0x	table 20, ifn	; output highpass resonance

ifr1	table 21, ifn	; output lowpass start freq 1 / oscillator frq.
ifdx1	table 22, ifn	; output lowpass frequency 1 half-time in beats
ifr2	table 23, ifn	; output lowpass start freq 2 / oscillator frq.
ifdx2	table 24, ifn	; output lowpass frequency 2 half-time in beats

insbp1	table 25, ifn	; noise bandpass start frequency in Hz
insbp2	table 26, ifn	; noise bandpass end frequency in Hz
insbw	table 27, ifn	; noise bandpass bandwidth / frequency
inslp1	table 28, ifn	; noise lowpass start frequency (Hz)
inslp2	table 29, ifn	; noise lowpass end frequency (Hz)
insht	table 30, ifn	; noise filter envelope half-time in beats
insatt	table 31, ifn	; noise attack time (in seconds)
insdec	table 32, ifn	; noise decay half-time (in beats)
insmx	table 33, ifn	; noise mix

ixtim	=  gisptx + idel + irel		; expand note length
p3	=  p3 + ixtim
; note amplitude
iamp	=  $VELOC2AMP(ivel'iscl)
; release envelope
aenv	linseg 1, ilnth, 1, irel, 0, 1, 0
aenv	=  aenv * aenv
; beat time
ibtime	=  60 / ibpm

; ---- noise generator ----

a_ns	rnd31 32768 * insmx, 0, 0
k_nsf	expon 1, ibtime * insht, 0.5
k_nsbp	=  insbp2 + (insbp1 - insbp2) * k_nsf
k_nslp	=  inslp2 + (inslp1 - inslp2) * k_nsf
; noise bandpass
a_ns	butterbp a_ns, k_nsbp, k_nsbp * insbw
; noise lowpass
a_ns	pareq a_ns, k_nslp, 0, 0.7071, 2
; noise amp. envelope
a_nse1	linseg 0, insatt, 1, 1, 1
a_nse2	expon 1, ibtime * insdec, 0.5
a_ns	=  a_ns * a_nse1 * a_nse2

; ---- oscillator ----

; base frequency
icps	=  $MIDI2CPS(ibsfrq)
; oscillator frequency
kfrq	expon 1, ibtime * ifrqt, 0.5
kfrq	=  icps * (1 + (ifrqs - 1) * kfrq)
; table number
kfn	=  $CPS2FNUM(kfrq'300)
a1	phasor kfrq
a2	tablexkt a1, kfn, 0, 2, 1, 0, 1
a1	=  a2 * 16384
a2	=  a1				; a1 = a2 = osc. signal

; ---- filters ----

; highpass 1
a1	butterhp a1, ihp1 * kfrq
; bandpass 1
a1	butterbp a1, kfrq, ibw01 * kfrq
; "allpass" 1
k_apf	expon 1, ibtime * iapdx, 0.5
k_apf	=  (iapf2 + (iapf1 - iapf2) * k_apf) * kfrq
atmp	tone a1, k_apf
a1	=  2 * atmp - a1
; highpass 2
a3	butterhp a2, ihp2 * icps
; highpass 3
a2	butterhp a2 + a3 * imx2, ihp3 * icps
a1	=  a1 + a2 * imx3
; output highpass
a1	pareq a1, ihpx * icps, 0, iq0x, 1
; output lowpass
k1	expon 1, ibtime * ifdx1, 0.5
k2	expon 1, ibtime * ifdx2, 0.5
kfrx	limit (k1 * ifr1 + k2 * ifr2) * kfrq, 10, sr * 0.48
a1	pareq a1, kfrx, 0, 0.7071, 2

a0	delay (a1 + a_ns) * iamp * aenv, idel

$SPAT_OUT

	endin

/* ------------------ instr 21: TR-808 bass drum ------------------ */

	instr 21

ilnth	=  p3		; note length
ifn	=  p4		; table number
ivel	=  p5		; velocity

iscl	table  0, ifn	; amp. scale
idel	table  1, ifn	; delay
irel	table  2, ifn	; release time
iX	table  3, ifn	; X
iY	table  4, ifn	; Y
iZ	table  5, ifn	; Z
ibsfrq	table  6, ifn	; base frequency (MIDI note)
ifrqs	table  7, ifn	; start frequency / base frq
ifrqt	table  8, ifn	; frequency envelope half-time
iphs	table  9, ifn	; start phase (0..1)
ilpfrq	table 10, ifn	; lowpass filter frequency
idect	table 11, ifn	; decay half-time

ixtim	=  gisptx + idel + irel		; expand note length
p3	=  p3 + ixtim
; note amplitude
iamp	=  $VELOC2AMP(ivel'iscl)

icps	=  $MIDI2CPS(ibsfrq)
kcps	port 1, ifrqt, ifrqs
kcps	=  icps * kcps

a1	oscili 1, kcps, 700, iphs
a1	butterlp a1, ilpfrq

aenv	expon 1, idect, 0.5
aenv2	linseg 1, ilnth, 1, irel, 0, 1, 0

a0	delay a1 * iamp * aenv * (aenv2 * aenv2), idel

$SPAT_OUT

	endin

/* ---------------------- instr 30: hand clap ---------------------- */

	instr 30

ilnth	=  p3		; note length
ifn	=  p4		; table number
ivel	=  p5		; velocity

iscl	table  0, ifn	; amp. scale
idel	table  1, ifn	; delay
irel	table  2, ifn	; release time
iX	table  3, ifn	; X
iY	table  4, ifn	; Y
iZ	table  5, ifn	; Z
ibpfrq	table  6, ifn	; bandpass frequency
ibws	table  7, ifn	; bandwidth envelope start
ibwt	table  8, ifn	; bw. envelope half-time
ibwe	table  9, ifn	; bandwidth envelope end
idel2	table 10, ifn	; delay 2
idel3	table 11, ifn	; delay 3
idel4	table 12, ifn	; delay 4
idec1	table 13, ifn	; decay 1
idec2	table 14, ifn	; decay 2
idec3	table 15, ifn	; decay 3
idec4	table 16, ifn	; decay 4

ixtim	=  gisptx + idel + irel		; expand note length
p3	=  p3 + ixtim
; note amplitude
iamp	=  $VELOC2AMP(ivel'iscl)
; bandwidth envelope
kbwd	port ibwe, ibwt, ibws
; amp. envelope
a1	=  1
a2	delay1 a1
a1	=  a1 - a2
a2	delay a1, idel2
a3	delay a1, idel3
a4	delay a1, idel4
a1	tone a1 * idec1, 1 / idec1
a2	tone a2 * idec2, 1 / idec2
a3	tone a3 * idec3, 1 / idec3
a4	tone a4 * idec4, 1 / idec4
; noise generator with bandpass filter
a0	rnd31 iamp, 0, 0
a0	butterbp a0 * (a1 + a2 + a3 + a4), ibpfrq, kbwd
; release envelope and delay
a1	linseg 1, ilnth, 1, irel, 0, 1, 0
a1	=  a1 * a1 * a0
a0	delay a1, idel

$SPAT_OUT

	endin

/* ------------------- instr 31: TR-808 cowbell ------------------- */

	instr 31

ilnth	=  p3		; note length
ifn	=  p4		; table number
ivel	=  p5		; velocity

iscl	table  0, ifn	; amp. scale
idel	table  1, ifn	; delay
irel	table  2, ifn	; release time
iX	table  3, ifn	; X
iY	table  4, ifn	; Y
iZ	table  5, ifn	; Z
ifrq1	table  6, ifn	; frequency 1
ifrq2	table  7, ifn	; frequency 2
iffrqs	table  8, ifn	; lowpass filter start frequency
iffrqt	table  9, ifn	; lowpass filter envelope half-time
iffrqe	table 10, ifn	; lowpass filter end frequency
iatt	table 11, ifn	; attack time
idect1	table 12, ifn	; decay time 1
idecl1	table 13, ifn	; decay level 1
idect2	table 14, ifn	; decay 2 half-time
iresn	table 15, ifn	; resonance at osc2 frequency

ixtim	=  gisptx + idel + irel		; expand note length
p3	=  p3 + ixtim
; note amplitude
iamp	=  $VELOC2AMP(ivel'iscl)

ifrq1	=  $MIDI2CPS(ifrq1)
ifn1	=  $CPS2FNUM(ifrq1'500)
ifrq2	=  $MIDI2CPS(ifrq2)
ifn2	=  $CPS2FNUM(ifrq2'500)

a1	oscili 1, ifrq1, ifn1
a2	oscili 1, ifrq2, ifn2

kffrq	port iffrqe, iffrqt, iffrqs
kffrq	limit kffrq, 10, sr * 0.48

aenv1	linseg 0, iatt, 1, 1, 1				; attack
aenv2	expseg 1, idect1, idecl1, idect2, idecl1 * 0.5	; decay
aenv3	linseg 1, ilnth, 1, irel, 0, 1, 0		; release

a0	tone a1 + a2, kffrq
a1	pareq a0, ifrq2, iresn, iresn, 0

a0	delay a1 * iamp * aenv1 * aenv2 * (aenv3 * aenv3), idel

$SPAT_OUT

	endin

/* -------------------- instr 40: TR-808 hi-hat -------------------- */

	instr 40

ilnth	=  p3		; note length
ifn	=  p4		; table number
ivel	=  p5		; velocity

iscl	table  0, ifn	; amp. scale
idel	table  1, ifn	; delay
irel	table  2, ifn	; release time
iX	table  3, ifn	; X
iY	table  4, ifn	; Y
iZ	table  5, ifn	; Z
ibsfrq	table  6, ifn	; base frequency (MIDI note)
ifrq2	table  7, ifn	; osc 2 frequency / base frq
ifrq3	table  8, ifn	; osc 3 frequency / base frq
ifrq4	table  9, ifn	; osc 4 frequency / base frq
ifrq5	table 10, ifn	; osc 5 frequency / base frq
ifrq6	table 11, ifn	; osc 6 frequency / base frq
idsts	table 12, ifn	; distortion start
idstt	table 13, ifn	; distortion envelope half-time
idste	table 14, ifn	; distortion end
ihpfrq	table 15, ifn	; highpass frequency
ihpres	table 16, ifn	; highpass resonance
iatt	table 17, ifn	; attack time
idect1	table 18, ifn	; decay time 1
idecl1	table 19, ifn	; decay level 1
idect2	table 20, ifn	; decay 2 half-time

ixtim	=  gisptx + idel + irel		; expand note length
p3	=  p3 + ixtim
; note amplitude
iamp	=  $VELOC2AMP(ivel'iscl)

ifrq1	=  $MIDI2CPS(ibsfrq)		; oscillator frequencies
ifrq2	=  ifrq1 * ifrq2
ifrq3	=  ifrq1 * ifrq3
ifrq4	=  ifrq1 * ifrq4
ifrq5	=  ifrq1 * ifrq5
ifrq6	=  ifrq1 * ifrq6

ifn1	=  $CPS2FNUM(ifrq1'300)		; table numbers
ifn2	=  $CPS2FNUM(ifrq2'300)
ifn3	=  $CPS2FNUM(ifrq3'300)
ifn4	=  $CPS2FNUM(ifrq4'300)
ifn5	=  $CPS2FNUM(ifrq5'300)
ifn6	=  $CPS2FNUM(ifrq6'300)

iphs1	unirand 1			; start phase
iphs2	unirand 1
iphs3	unirand 1
iphs4	unirand 1
iphs5	unirand 1
iphs6	unirand 1

a1	oscili 1, ifrq1, ifn1, iphs1	; oscillator
a2	oscili 1, ifrq2, ifn2, iphs2
a3	oscili 1, ifrq3, ifn3, iphs3
a4	oscili 1, ifrq4, ifn4, iphs4
a5	oscili 1, ifrq5, ifn5, iphs5
a6	oscili 1, ifrq6, ifn6, iphs6

a0	=  a1 + a2 + a3 + a4 + a5 + a6

a1	limit a0 * 1000000, -1, 1			; distort
a0	limit abs(a0), 0.000001, 1000000
adst	expon 1, idstt, 0.5
a0	=  a1 * exp(log(a0) * (idste + (idsts - idste) * adst))

a0	pareq a0, ihpfrq, 0, sqrt(ihpres), 1		; highpass
a0	pareq a0, ihpfrq, 0, sqrt(ihpres), 1

aenv1	linseg 0, iatt, 1, 1, 1				; envelopes
aenv2	expseg 1, idect1, idecl1, idect2, 0.5 * idecl1
aenv3	linseg 1, ilnth, 1, irel, 0, 1, 0

a1	=  a0 * iamp * aenv1 * aenv2 * (aenv3 * aenv3)

a0	delay a1, idel

$SPAT_OUT

	endin

/* ------------------ instr 50: TR-909 snare drum ------------------ */

	instr 50

ilnth	=  p3		/* note length				     */
ifn	=  p4		/* function table with instrument parameters */
ivel	=  p5		/* velocity (0 - 127)			     */

iscl	table  0, ifn	; amplitude scale
idel	table  1, ifn	; delay
irel	table  2, ifn	; release time
iX	table  3, ifn	; X
iY	table  4, ifn	; Y
iZ	table  5, ifn	; Z
ibsfrq	table  6, ifn	; base freq. (MIDI note)
ifrqs	table  7, ifn	; start freq. / base frq.
ifrqt	table  8, ifn	; frequency env. half-time
ifmds	table  9, ifn	; FM depth start
ifmdt	table 10, ifn	; FM depth envelope half-time
ifmde	table 11, ifn	; FM depth end
ifrq2	table 12, ifn	; osc 2 frq. / osc 1 frq.
iamp2s	table 13, ifn	; osc 2 amplitude start
iamp2t	table 14, ifn	; osc 2 amplitude envelope half-time
iamp2e	table 15, ifn	; osc 2 amplitude end
insbpf	table 16, ifn	; noise BP frequency
insbpb	table 17, ifn	; noise BP bandwidth
insamps	table 18, ifn	; noise amplitude start
insampt	table 19, ifn	; noise amplitude env. half-time
insampe	table 20, ifn	; noise amplitude end
idect	table 21, ifn	; decay half-time

ixtime	=  gisptx + idel + irel			; expand note duration
p3	=  p3 + ixtime

; release envelope

aenv1	linseg 1, ilnth, 1, irel, 0, 1, 0
aenv1	=  aenv1 * aenv1

; output amplitude
iamp	=  $VELOC2AMP(ivel'iscl)

icps0	=  $MIDI2CPS(ibsfrq)	; frequency envelope
icps1	=  ifrqs * icps0
acps	expon 1, ifrqt, 0.5
acps	=  icps0 + (icps1 - icps0) * acps	; osc 1 frequency
acps2	=  acps * ifrq2				; osc 2 frequency

afmd	expon 1, ifmdt, 0.5		; FM depth
afmd	=  ifmde + (ifmds - ifmde) * afmd

afm1	oscili afmd, acps, 700		; FM
afm2	oscili afmd, acps2, 700

aamp2	expon 1, iamp2t, 0.5		; osc 2 amplitude
aamp2	=  iamp2e + (iamp2s - iamp2e) * aamp2

a1	oscili 1, acps * (1 + afm1), 700	; oscillators
a2	oscili aamp2, acps2 * (1 + afm2), 700

a3	rnd31 1, 0, 0			; noise
aamp3	expon 1, insampt, 0.5
a3	butterbp a3, insbpf, insbpb
a3	=  a3 * (insampe + (insamps - insampe) * aamp3)

aenv2	expon 1, idect, 0.5
a1	=  iamp * aenv1 * aenv2 * (a1 + a2 + a3)

a0	delay a1, idel

$SPAT_OUT

	endin

/* ------------------------- instr 51: tom ------------------------- */

	instr 51

ilnth	=  p3		/* note length				     */
ifn	=  p4		/* function table with instrument parameters */
ivel	=  p5		/* velocity (0 - 127)			     */

iscl	table  0, ifn	; amplitude scale
idel	table  1, ifn	; delay
irel	table  2, ifn	; release time
iX	table  3, ifn	; X
iY	table  4, ifn	; Y
iZ	table  5, ifn	; Z
ibsfrq	table  6, ifn	; base freq. (MIDI note)
ifrqs	table  7, ifn	; start freq. / base frq.
ifrqt	table  8, ifn	; frequency env. half-time
ifrq2	table  9, ifn	; osc 2 frq. / osc 1 frq.
iamp2s	table 10, ifn	; osc 2 amplitude start
iamp2t	table 11, ifn	; osc 2 amplitude envelope half-time
iamp2e	table 12, ifn	; osc 2 amplitude end
iphs	table 13, ifn	; osc 1 and 2 start phase
idel_1	table 14, ifn	; invert 1 delay * base frequency
idel_2	table 15, ifn	; invert 2 delay * base frequency
ilpfrq	table 16, ifn	; lowpass frequency
insbpf	table 17, ifn	; noise BP frequency
insbpb	table 18, ifn	; noise BP bandwidth
inscfr	table 19, ifn	; noise comb frequency / base frequency
inscfb	table 20, ifn	; noise comb feedback
inslpf	table 21, ifn	; noise lowpass frequency
insamps	table 22, ifn	; noise amplitude start
insampt	table 23, ifn	; noise amplitude env. half-time
insampe	table 24, ifn	; noise amplitude end
idect	table 25, ifn	; decay half-time

ixtime	=  gisptx + idel + irel			; expand note duration
p3	=  p3 + ixtime

; release envelope

aenv1	linseg 1, ilnth, 1, irel, 0, 1, 0
aenv1	=  aenv1 * aenv1

; output amplitude
iamp	=  $VELOC2AMP(ivel'iscl)

icps0	=  $MIDI2CPS(ibsfrq)	; frequency envelope
icps1	=  ifrqs * icps0
acps	expon 1, ifrqt, 0.5
acps	=  icps0 + (icps1 - icps0) * acps	; osc 1 frequency
acps2	=  acps * ifrq2				; osc 2 frequency

aamp2	expon 1, iamp2t, 0.5		; osc 2 amplitude
aamp2	=  iamp2e + (iamp2s - iamp2e) * aamp2

a1	oscili 1, acps, 700, iphs	; oscillators
a2	oscili aamp2, acps2, 700, iphs

a3	rnd31 1, 0, 0			; noise
aamp3	expon 1, insampt, 0.5
a3	butterbp a3, insbpf, insbpb
a3	=  a3 * (insampe + (insamps - insampe) * aamp3)

ax1	=  1		; invert amplitude to add click
ax2	delay ax1, (int(idel_1 * sr / icps0 + 0.5) + 0.01) / sr
ax3	delay ax1, (int(idel_2 * sr / icps0 + 0.5) + 0.01) / sr

a1	=  (a1 + a2) * (ax1 - 2 * ax2 + 2 * ax3)

a1	butterlp a1, ilpfrq		; lowpass

a3x	delayr (int(sr / (inscfr * icps0) + 0.5) + 0.01) / sr
a3	=  a3 - a3x * inscfb
	delayw a3

a3	butterlp a3, inslpf

aenv2	expon 1, idect, 0.5
a1	=  iamp * aenv1 * aenv2 * (a1 + a3)

a0	delay a1, idel

$SPAT_OUT

	endin

/* ---------------------- instr 52: rim shot ---------------------- */

	instr 52

ilnth	=  p3		/* note length				     */
ifn	=  p4		/* function table with instrument parameters */
ivel	=  p5		/* velocity (0 - 127)			     */

iscl	table  0, ifn	; amplitude scale
idel	table  1, ifn	; delay
irel	table  2, ifn	; release time
iX	table  3, ifn	; X
iY	table  4, ifn	; Y
iZ	table  5, ifn	; Z
ibsfrq	table  6, ifn	; base freq. (MIDI note)
ifrqs	table  7, ifn	; start freq. / base frq.
ifrqt	table  8, ifn	; frequency env. half-time
ifmds	table  9, ifn	; FM depth start
ifmdt	table 10, ifn	; FM depth envelope half-time
ifmde	table 11, ifn	; FM depth end
insamp	table 12, ifn	; noise amplitude
inslpf	table 13, ifn	; noise lowpass frequency
idecs	table 14, ifn	; amplitude (before distortion) start
idect	table 15, ifn	; amplitude envelope half-time
idece	table 16, ifn	; amplitude end
ihpamp	table 17, ifn	; HP filtered signal (after distortion) gain
ihpfrq	table 18, ifn	; highpass frequency
ihpdel	table 19, ifn	; highpass filtered signal delay
ilpfs	table 20, ifn	; output lowpass frequency start
ilpft	table 21, ifn	; lowpass envelope half-time
ilpfe	table 22, ifn	; output lowpass frequency end

ixtime	=  gisptx + idel + irel		; expand note duration
p3	=  p3 + ixtime

; release envelope

aenv1	linseg 1, ilnth, 1, irel, 0, 1, 0
aenv1	=  aenv1 * aenv1

iamp	=  $VELOC2AMP(ivel'1)		; velocity

icps	=  $MIDI2CPS(ibsfrq)		; base frequency
acps	expon 1, ifrqt, 0.5
acps	=  icps * (1 + (ifrqs - 1) * acps)

a1a	phasor acps, 0			; square wave
a1b	phasor acps, 0.5

afmd	expon 1, ifmdt, 0.5		; FM envelope
afmd	=  ifmde + (ifmds - ifmde) * afmd

a1	=  (a1a - a1b) * 2 * afmd
acps	=  acps * (1 + a1)		; frequency with FM

a0	oscili 1, acps, 700		; sine oscillator

a1	rnd31 insamp, 0, 0		; add some noise
a1	tone a1, inslpf
	vincr a0, a1

aenv	expon 1, idect, 0.5		; amp. envelope
aenv	=  idece + (idecs - idece) * aenv

a0	limit aenv * iamp * a0, -1, 1	; distortion
a0	tablei a0 * 0.25, 700, 1, 0, 1

a2	tone a0, ihpfrq			; highpass filter
a2	=  a0 - a2
a1	delay a2, ihpdel
	vincr a0, a1 * ihpamp

klpfr	port ilpfe, ilpft, ilpfs	; output lowpass
a1	pareq a0, klpfr, 0, 0.7071, 2

a0	delay a1 * iscl * aenv1, idel

$SPAT_OUT

	endin

/* ------------ instr 99: decoder and output instrument ------------ */

	instr 99

iamp	=  0.000001 * 0.000001 * 0.000001 * 0.000001

a0	rnd31 iamp, 0, 0	; low level noise to avoid denormals
a1	rnd31 iamp, 0, 0
a2	rnd31 iamp, 0, 0
a3	rnd31 iamp, 0, 0
a4	rnd31 iamp, 0, 0

	vincr a0, ga0 * p4	; get input from global variables
	vincr a1, ga1 * p4
	vincr a2, ga2 * p4
	vincr a3, ga3 * p4
	vincr a4, ga4 * p4

	clear ga0	; clear global vars
	clear ga1
	clear ga2
	clear ga3
	clear ga4

; decode to 2 chnls with phase shift

a1re, a1im	hilbert a1
a2re, a2im	hilbert a2
a3re, a3im	hilbert a3

aL	=  0.7071 * (a1re - a1im) + 0.5 * (a2re + a2im + a3re - a3im)
aR	=  0.7071 * (a1re + a1im) + 0.5 * (a2re - a2im - a3re - a3im)

	outs aL, aR

; mono output

	soundout a0, $SNDFL_MONO, 6

	endin

