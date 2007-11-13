sr	=  48000
ksmps	=  32
nchnls	=  2

#include "base_macros.h.orc"
#include "fgen.h.orc"
#include "spat.h.orc"
#include "uhjmacros.h.orc"
#include "ctrl.h.orc"

	zakinit 1, 2048

ichn	=  1
l01:
	massign ichn, 2		; assign all MIDI channels to instr 2
$M_CTRLINIT(0'ichn'24'127)	; initialize controllers
$M_CTRLINIT(0'ichn'25'64)
$M_CTRLINIT(0'ichn'26'64)
ichn	=  ichn + 1
	if (ichn < 16.5) igoto l01

	pgmassign 0, 0		; disable program changes

ga01	init 0
ga02	init 0
ga03	init 0
ga04	init 0

	instr 1

$M_CTRL0(0'1'24)	; get controller data and store in zak space
$M_CTRL0(0'2'24)	; filter frequency
$M_CTRL0(0'3'24)
$M_CTRL0(0'4'24)

$M_CTRL0(0'1'25)	; filter resonance
$M_CTRL0(0'2'25)
$M_CTRL0(0'3'25)
$M_CTRL0(0'4'25)

$M_CTRL0(0'1'26)	; filter bend up/down (-64 to 63 semitones / beat)
$M_CTRL0(0'2'26)
$M_CTRL0(0'3'26)
$M_CTRL0(0'4'26)

	endin

	instr 2

ichn	midichn			; MIDI channel

/* ------------------------------------------------------------------------- */

ivol	=  2000			/* volume				    */
ibpm	=  134			/* tempo				    */

/* ------------------------------------------------------------------------- */

imx01	=  1.0			/* OSC 1 mix				    */
imx02	=  0.25			/* OSC 2 mix				    */

ifmd	=  5			/* OSC window freq. (Hz, = 1 / grain dur.)  */
ipmd	=  0.5			/* OSC 2 pm depth			    */
iovrlp	=  6			/* OSC 2 overlap			    */

/* ------------------------------------------------------------------------- */

ibtime	=  60/ibpm		/* beat time				    */

iatt	=  0.002		/* attack time (sec.)			    */
imaxamp	=  1.0			/* max. amplitude of envelope		    */
imaxt	=  0.0625 * ibtime	/* time in sec. when max. amp. is reached   */
idect	=  1.5 * ibtime		/* decay time (in seconds)		    */
idecamp	=  0.0625		/* amp. at decay end			    */
irel	=  0.05			/* release time (sec.)			    */

ifrqs	=  1.0			/* osc. start frequency / note freq.	    */
ifrqd	=  128			/* osc. freq. envelope speed		    */

/* ------------------------------------------------------------------------- */

iEQ1fa	=  1046.5		/* EQ 1 frequency (Hz)			*/
iEQ1fn	=  0			/* EQ 1 frequency / note frequency	*/
iEQ1l	=  4.0			/* EQ 1 level				*/
iEQ1q	=  0.7071		/* EQ 1 Q				*/
iEQ1m	=  2			/* EQ 1 mode				*/

iEQ2fa	=  12500		/* EQ 2 frequency (Hz)			*/
iEQ2fn	=  0			/* EQ 2 frequency / note frequency	*/
iEQ2l	=  1.4			/* EQ 2 level				*/
iEQ2q	=  1.0			/* EQ 2 Q				*/
iEQ2m	=  0			/* EQ 2 mode				*/

iLP1fa	=  20000		/* 1st order LP filter freq. (Hz)	*/
iLP1fn	=  0			/* LP filter frequency / note frq.	*/

iLP2f0a	=  16000		/* butterlp filter start frequency (Hz)	*/
iLP2f0r	=  0			/* butterlp filter start frq. / note f.	*/
iLP2f1a	=  4000			/* butterlp filter end frequency (hz)	*/
iLP2f1r	=  0			/* butterlp filter end frq. / note f.	*/
iLP2d	=  4.0			/* butterlp filter envelope speed	*/

/* ------------------------------------------------------------------------- */

igdur	=  1 / ifmd			; grain duration
igdens	=  iovrlp * ifmd		; density
imx02	=  imx02 * 4 / sqrt(iovrlp)	; correct amplitude for overlap
iovrlp	=  iovrlp + 1

;	if (ichn > 0.5) goto l02
;
;S_NOTEPARM(irel'0.01)			; ---- score note ----
;kcps	=  icps
;
;	goto l03
;l02:
$M_NOTEPARM(irel'0.01)			; ---- MIDI note ----
$PITCHBEND(kcps'2'0.03)

;l03:

kcpsx	port 1, ibtime / ifrqd, ifrqs
kcps	=  kcps * kcpsx

/* amp. envelopes */

aamp1	linseg 0, iatt, 1, 1, 1					/* attack */
aamp3	expseg 1, imaxt, imaxamp, idect, idecamp, 1, idecamp	/* decay */
aamp	=  aamp1 * aamp3 * (aenv * aenv) * ivol * iamp

kfnum	=  int($CPS2MIDI(kcps)+256.5)		/* ftable number */

$Z_CTRLI(klpf1'0'ichn'24'0.05)		; lowpass filter frequency
klpf1	=  $MIDI2CPS(klpf1 + 12)
klpf1	limit klpf1, 20, sr * 0.48
$Z_CTRLI(klpq1'0'ichn'25'0.05)		; lowpass filter resonance
klpq1	=  exp(log(10) * (klpq1 - 64) / 64)
; lowpass bend up/down
$Z_CTRLI(klpfx'0'ichn'26'0.02)
klpfx	=  (klpfx - 64) * 1.0 / (ibtime * kr)
klpf1x	init 1.0
klpf1	=  klpf1 * klpf1x
klpf1x	=  klpf1x * $NOTE2FRQ(klpfx)

; output lowpass envelope
kffrq2	port iLP2f1a + iLP2f1r*icps, ibtime/iLP2d, iLP2f0a + iLP2f0r*icps

#define OSC1Y(aout'name'amp'phs0'phs1'spd) #

; aout: output variable
; name: unique name to avoid variable name conflicts
; amp:  amplitude
; phs0: start phase
; phs1: end phase
; spd:  phase envelope speed

/* detune osc. for phase shift */

iphsx_$name	=  ($phs1) - ($phs0)	; phase difference
iphsy_$name	=  ibtime / ($spd)	; phase env. time
iphsz_$name	=  iphsx_$name / iphsy_$name
kcps1_$name	expseg iphsz_$name, iphsy_$name, iphsz_$name / 2.7182818
kcps1_$name	=  kcps + kcps1_$name

; osc 2

atmp	grain3	kcps1_$name, $phs0, 0, ipmd, igdur, igdens, iovrlp,	\
		kfnum, 3, 0, -0.25, 0, 66
a0	=  imx02 * ($amp) * atmp

; osc 1

atmp	phasor kcps1_$name, $phs0
atmp	tablexkt atmp, kfnum, 0, 2, 1, 0, 0
	vincr a0, imx01 * ($amp) * atmp

; filters

a0	pareq a0, klpf1, 0, klpq1, 2

a0	pareq a0, kcps*iEQ1fn + iEQ1fa, iEQ1l, iEQ1q, iEQ1m	; EQ
a0	pareq a0, kcps*iEQ2fn + iEQ2fa, iEQ2l, iEQ2q, iEQ2m

a0	tone a0, kcps*iLP1fn + iLP1fa		; 1st order lowpass

a0	pareq a0, kffrq2, 0, 0.7071, 2

	vincr $aout, a0 * aamp

#

$OSC1Y(ga01'X0'1.0'0.0000'0.9999'3.0)
$OSC1Y(ga02'X1'1.0'0.9999'0.0000'3.0)
$OSC1Y(ga03'X2'0.7'0.5000'0.9999'2.0)
$OSC1Y(ga04'X3'0.7'0.5000'0.0000'2.0)

	endin

	instr 80

$SPAT2(ga01'-50'1.5)
$SPAT2(ga02'-15'1.5)
$SPAT2(ga03'20'1.5)
$SPAT2(ga04'55'1.5)

	clear ga01, ga02, ga03, ga04

	endin

$OUT3CH(90'"synth_12_2.pcm")

