
; ============ drums.sco - written by Istvan Varga, 2002 ============

; ---- tempo ----

t 0 132

; -- instr 1: render tables for cymbal instruments --

; p3 : note length (should be 0)
; p4 : ftable number
; p5 : number of partials
; p6 : amp. scale
; p7 : transpose (in semitones)
; p8 : random seed (1 to 2^31 - 2)
; p9 : amplitude distribution

; ---- generate cymbal tables ----

i 1 0 0 101 600 1 0 114 3		; crash 2
i 1 0 0 102 600 1 0 4 6			; hihat
i 1 0 0 103 600 1 0 213 3		; crash 1
;i 1 0 0 104 600 1 0 427 4		; crash 3 (not used)
f 99 0 16 -2	0.3	7500	0	1	10500	0.2	\
		0.3	14000	0.4	1	18000	0.8
f 105 0 524288 -34 99 4 1 -4		; tambourine
i 1 0 0 106 600 1 0 193 6		; hihat 2
i 1 0 0 107 600 1 2 19 4		; ride
;i 1 0 0 108 600 1 0 7 4			; ride 2 (not used)

; ---- misc. tables ----

; square wave

#include "fgen_h.sco"

f 301 0 16384 7 1 8192 1 0 -1 8192 -1
$FGEN128(300'4096'301'1)

; sawtooth wave

f 501 0 16384 7 1 16384 -1
$FGEN128(500'4096'501'1)

; sine

f 700 0 4096 10 1

; window for cymbal instruments

f 100 0 16385 5 1 16385 0.01

; ---- include room parameters ----

#include "room.sco"

; ================ instrument definitions ================

/* ---- crash cymbal 1 ---- */

f 10 0 32 -2	900	; amplitude scale
		0.015	; delay
		0.1	; release time
		-1	; X
		1.87	; Y
		0	; Z
		103	; input table
		100	; window table
		0.225	; start grain duration in seconds
		0.10	; grain druaton envelope half-time
		0.1	; end grain duration
		40	; number of overlaps
		10000	; EQ start frequency
		1	; EQ frequency envelope half-time
		10000	; EQ end frequency
		1	; EQ start level (Q is level * 0.7071)
		0.14	; EQ level envelope half-time
		4	; EQ end level
		500	; highpass frequency
		20000	; lowpass frequency
		0.16	; decay env. half-time (n.a. in reverse mode)
		1	; reverse cymbal mode (0: on, 1: off)
		0.001	; delay time for chorus effect
		1	; non-delayed signal level
		0	; delayed signal level

/* ---- crash cymbal 2 ---- */

f 11 0 32 -2	900	; amplitude scale
		0.015	; delay
		0.1	; release time
		0.5	; X
		1.9	; Y
		0	; Z
		101	; input table
		100	; window table
		0.225	; start grain duration in seconds
		0.10	; grain druaton envelope half-time
		0.1	; end grain duration
		40	; number of overlaps
		11000	; EQ start frequency
		1	; EQ frequency envelope half-time
		11000	; EQ end frequency
		1	; EQ start level (Q is level * 0.7071)
		0.16	; EQ level envelope half-time
		3	; EQ end level
		500	; highpass frequency
		20000	; lowpass frequency
		0.18	; decay env. half-time (n.a. in reverse mode)
		1	; reverse cymbal mode (0: on, 1: off)
		0.001	; delay time for chorus effect
		1	; non-delayed signal level
		0	; delayed signal level

/* ---- reverse cymbal ---- */

f 12 0 32 -2	400	; amplitude scale
		0.016	; delay
		0.03	; release time
		-1.5	; X
		-1.7	; Y
		0	; Z
		103	; input table
		100	; window table
		0.1	; start grain duration in seconds
		0.2	; grain druaton envelope half-time
		0.1	; end grain duration
		50	; number of overlaps
		10000	; EQ start frequency
		1	; EQ frequency envelope half-time
		10000	; EQ end frequency
		2	; EQ start level (Q is level * 0.7071)
		0.2	; EQ level envelope half-time
		2	; EQ end level
		500	; highpass frequency
		18000	; lowpass frequency
		0.2	; decay env. half-time (n.a. in reverse mode)
		0	; reverse cymbal mode (0: on, 1: off)
		0.001	; delay time for chorus effect
		1	; non-delayed signal level
		0	; delayed signal level

/* ---- open hi-hat ---- */

f 13 0 32 -2	700	; amplitude scale
		0.012	; delay
		0.02	; release time
		1.5	; X
		1.5	; Y
		0	; Z
		102	; input table
		100	; window table
		0.001	; start grain duration in seconds
		0.05	; grain druaton envelope half-time
		0.1	; end grain duration
		50	; number of overlaps
		10000	; EQ start frequency
		1	; EQ frequency envelope half-time
		10000	; EQ end frequency
		2	; EQ start level (Q is level * 0.7071)
		1	; EQ level envelope half-time
		2	; EQ end level
		1000	; highpass frequency
		22000	; lowpass frequency
		0.1	; decay env. half-time (n.a. in reverse mode)
		1	; reverse cymbal mode (0: on, 1: off)
		0.015	; delay time for chorus effect
		0.2	; non-delayed signal level
		1	; delayed signal level

/* ---- closed hi-hat ---- */

f 14 0 32 -2	700	; amplitude scale
		0.0035	; delay
		0.02	; release time
		2.0	; X
		0.7	; Y
		0	; Z
		102	; input table
		100	; window table
		0.0001	; start grain duration in seconds
		0.01	; grain druaton envelope half-time
		0.1	; end grain duration
		50	; number of overlaps
		10000	; EQ start frequency
		1	; EQ frequency envelope half-time
		10000	; EQ end frequency
		2	; EQ start level (Q is level * 0.7071)
		1	; EQ level envelope half-time
		2	; EQ end level
		500	; highpass frequency
		22000	; lowpass frequency
		0.02	; decay env. half-time (n.a. in reverse mode)
		1	; reverse cymbal mode (0: on, 1: off)
		0.015	; delay time for chorus effect
		0	; non-delayed signal level
		1	; delayed signal level

/* ---- tambourine ---- */

f 15 0 32 -2	6500	; amplitude scale
		0.018	; delay
		0.02	; release time
		1.75	; X
		-1.2	; Y
		0	; Z
		105	; input table
		100	; window table
		0.002	; start grain duration in seconds
		0.01	; grain druaton envelope half-time
		0.03	; end grain duration
		20	; number of overlaps
		1000	; EQ start frequency
		1	; EQ frequency envelope half-time
		1000	; EQ end frequency
		1	; EQ start level (Q is level * 0.7071)
		1	; EQ level envelope half-time
		1	; EQ end level
		100	; highpass frequency
		22000	; lowpass frequency
		0.03	; decay env. half-time (n.a. in reverse mode)
		1	; reverse cymbal mode (0: on, 1: off)
		0.001	; delay time for chorus effect
		1	; non-delayed signal level
		0	; delayed signal level

/* ---- hi-hat 2 ---- */

f 16 0 32 -2	400	; amplitude scale
		0.008	; delay
		0.02	; release time
		-1.75	; X
		1.2	; Y
		0	; Z
		106	; input table
		100	; window table
		0.08	; start grain duration in seconds
		0.05	; grain druaton envelope half-time
		0.08	; end grain duration
		50	; number of overlaps
		8000	; EQ start frequency
		1	; EQ frequency envelope half-time
		8000	; EQ end frequency
		2	; EQ start level (Q is level * 0.7071)
		1	; EQ level envelope half-time
		2	; EQ end level
		1000	; highpass frequency
		14000	; lowpass frequency
		0.25	; decay env. half-time (n.a. in reverse mode)
		1	; reverse cymbal mode (0: on, 1: off)
		0.015	; delay time for chorus effect
		0.3	; non-delayed signal level
		1	; delayed signal level

/* ---- ride cymbal ---- */

f 17 0 32 -2	450	; amplitude scale
		0.02	; delay
		0.05	; release time
		-1.2	; X
		-1.75	; Y
		0	; Z
		107	; input table
		100	; window table
		0.0005	; start grain duration in seconds
		0.01	; grain druaton envelope half-time
		0.4	; end grain duration
		50	; number of overlaps
		12000	; EQ start frequency
		1	; EQ frequency envelope half-time
		12000	; EQ end frequency
		2	; EQ start level (Q is level * 0.7071)
		1	; EQ level envelope half-time
		2	; EQ end level
		1000	; highpass frequency
		22000	; lowpass frequency
		0.1	; decay env. half-time (n.a. in reverse mode)
		1	; reverse cymbal mode (0: on, 1: off)
		0.001	; delay time for chorus effect
		1	; non-delayed signal level
		0	; delayed signal level

/* ---- bass drum ---- */

f 20 0 64 -2	0.6	; volume
		0.020	; delay (in seconds)
		0.03	; release time (sec.)
		0	; X
		1	; Y
		0	; Z
		140	; tempo
		31	; base frequency (MIDI note number)
		5.3333	; oscillator start frequency / base frequency
		0.0714	; oscillator freq. envelope half-time in beats
		0.5	; bandpass 1 bandwidth / oscillator frequency
		0.0625	; highpass 1 freq. / oscillator frequency
		0.5	; "allpass" 1 start freq. / oscillator frq.
		0.125	; "allpass" 1 envelope half-time in beats
		1.0	; "allpass" 1 end frq. / oscillator frequency
		8	; highpass 2 frequency / base frequency
		-3	; highpass 2 output gain
		0.5	; highpass 3 freq. / base frequency
		-0.4	; highpass 3 output gain
		1.5	; output highpass frequency / base frequency
		2	; output highpass resonance
		16	; output lowpass start freq 1 / oscillator frq.
		0.01	; output lowpass frequency 1 half-time in beats
		16	; output lowpass start freq 2 / oscillator frq.
		0.08	; output lowpass frequency 2 half-time in beats
		7040	; noise bandpass start frequency in Hz
		7040	; noise bandpass end frequency in Hz
		2	; noise bandpass bandwidth / frequency
		3520	; noise lowpass start frequency (Hz)
		55	; noise lowpass end frequency (Hz)
		0.0833	; noise filter envelope half-time in beats
		0.01	; noise attack time (in seconds)
		0.3333	; noise decay half-time (in beats)
		0.5	; noise mix

/* ---- TR-808 bass drum ---- */

f 25 0 16 -2	30000			/* amplitude scale	     */
		0.0215			/* delay		     */
		0.08			/* release time		     */
		0	1	0	/* X, Y, Z coordinates	     */
		32			/* base freq. (MIDI note)    */
		4			/* start freq. / base frq.   */
		0.007			/* frq. envelope half-time   */
		0.25			/* start phase (0..1)	     */
		3000			/* lowpass filter frequency  */
		0.25			/* decay half-time	     */

/* ---- hand clap ---- */

f 30 0 32 -2	550000000		/* amplitude scale	     */
		0.010			/* delay		     */
		0.02			/* release time		     */
		-0.5	2	0	/* X, Y, Z coordinates	     */
		1046.5			/* bandpass frequency	     */
		4186	0.03	261.63	/* bandwidth envelope start, */
					/* half-time, and end value  */
		0.011	0.023	0.031	/* delay 2, 3, and 4	     */
		0.0167	0.0167	0.0167	/* decay 1, 2, and 3	     */
		0.5			/* decay 4		     */

/* ---- TR-808 cowbell ---- */

f 35 0 16 -2	10000			/* amplitude scale	     */
		0.018			/* delay		     */
		0.05			/* release time		     */
		1.3	-1.5	0	/* X, Y, Z coordinates	     */
		73	80		/* osc 1, 2 freq (MIDI note) */
		20000			/* lowpass filter start frq. */
		0.025			/* filter envelope half-time */
		4000			/* lowpass filter end freq.  */
		0.002			/* attack time		     */
		0.03	0.3		/* decay time 1, level 1     */
		0.05			/* decay 2 half-time	     */
		4			/* resonance at osc 2 freq.  */

/* ---- TR-808 hi-hat (open) ---- */

; oscillator frequencies taken from Steven Cook's 808HiHat.orc

f 40 0 32 -2	20000			/* amplitude scale	     */
		0.02			/* delay		     */
		0.04			/* release time		     */
		-0.7	-2	0	/* X, Y, Z coordinates	     */
		73			/* base freq. (MIDI note)    */
		1.4471	1.6170		/* osc 2, 3 freq. / base frq */
		1.9265	2.5028	2.6637	/* osc 4, 5, 6 frq / base f. */
		0.25			/* distort start (see orc)   */
		1			/* distortion env. half-time */
		0.25			/* distort end		     */
		5400	1.0		/* highpass freq, resonance  */
		0.0005			/* attack time		     */
		0.2	0.5		/* decay time 1, level 1     */
		0.2			/* decay 2 half-time	     */

/* ---- TR-808 hi-hat (closed) ---- */

f 41 0 32 -2	20000			/* amplitude scale	     */
		0.02			/* delay		     */
		0.04			/* release time		     */
		-1.87	-1	0	/* X, Y, Z coordinates	     */
		73			/* base freq. (MIDI note)    */
		1.4471	1.6170		/* osc 2, 3 freq. / base frq */
		1.9265	2.5028	2.6637	/* osc 4, 5, 6 frq / base f. */
		0.25			/* distort start (see orc)   */
		1			/* distortion env. half-time */
		0.25			/* distort end		     */
		5400	1.0		/* highpass freq, resonance  */
		0.0005			/* attack time		     */
		0.025	0.5		/* decay time 1, level 1     */
		0.025			/* decay 2 half-time	     */

/* ---- TR-808 cymbal ---- */

f 42 0 32 -2	22000			/* amplitude scale	     */
		0.018			/* delay		     */
		0.1			/* release time		     */
		0.7	2.5	0	/* X, Y, Z coordinates	     */
		73			/* base freq. (MIDI note)    */
		1.4471	1.6170		/* osc 2, 3 freq. / base frq */
		1.9265	2.5028	2.6637	/* osc 4, 5, 6 frq / base f. */
		1.0			/* distort start (see orc)   */
		0.2			/* distortion env. half-time */
		0.0625			/* distort end		     */
		5400	0.7071		/* highpass freq, resonance  */
		0.0005			/* attack time		     */
		0.04	0.5		/* decay time 1, level 1     */
		0.4			/* decay 2 half-time	     */

/* ---- TR-909 snare drum 1 ---- */

f 50 0 32 -2	20000			/* amplitude scale	     */
		0.02			/* delay		     */
		0.04			/* release time		     */
		-0.5	1.25	0	/* X, Y, Z coordinates	     */
		49			/* base freq. (MIDI note)    */
		3			/* start freq. / base frq.   */
		0.005			/* frequency env. half-time  */
		0.5	0.005	0.2	/* FM depth start, envelope  */
					/*   half-time, end	     */
		1.4983			/* osc 2 frq. / osc 1 frq.   */
		1.0	0.01	0	/* osc 2 amp. start, env.    */
					/*   half-time, end	     */
		2500	10000		/* noise BP freq., bandwidth */
		0	0.01	0.7	/* noise amp. start, env.    */
					/*   half-time, end	     */
		0.04			/* decay envelope half-time  */

/* ---- TR-909 snare drum 2 ---- */

f 51 0 32 -2	20000			/* amplitude scale	     */
		0.02			/* delay		     */
		0.04			/* release time		     */
		1	0.25	0	/* X, Y, Z coordinates	     */
		52			/* base freq. (MIDI note)    */
		2			/* start freq. / base frq.   */
		0.005			/* frequency env. half-time  */
		1.0	0.002	0	/* FM depth start, envelope  */
					/*   half-time, end	     */
		1.4983			/* osc 2 frq. / osc 1 frq.   */
		1	0.02	0	/* osc 2 amp. start, env.    */
					/*   half-time, end	     */
		5000	7500		/* noise BP freq., bandwidth */
		0	0.008	0.35	/* noise amp. start, env.    */
					/*   half-time, end	     */
		0.03			/* decay envelope half-time  */

/* ---- TR-909 snare drum 3 ---- */

f 52 0 32 -2	17000			/* amplitude scale	     */
		0.02			/* delay		     */
		0.04			/* release time		     */
		0.75	1	0	/* X, Y, Z coordinates	     */
		52			/* base freq. (MIDI note)    */
		2.0			/* start freq. / base frq.   */
		0.005			/* frequency env. half-time  */
		0.2	0.01	0	/* FM depth start, envelope  */
					/*   half-time, end	     */
		1.4983			/* osc 2 frq. / osc 1 frq.   */
		1	0.04	0	/* osc 2 amp. start, env.    */
					/*   half-time, end	     */
		5000	7500		/* noise BP freq., bandwidth */
		0	0.005	1	/* noise amp. start, env.    */
					/*   half-time, end	     */
		0.03			/* decay envelope half-time  */

/* ---- TR-909 snare drum 4 ---- */

f 53 0 32 -2	15000			/* amplitude scale	     */
		0.02			/* delay		     */
		0.04			/* release time		     */
		-0.75	0.75	0	/* X, Y, Z coordinates	     */
		56			/* base freq. (MIDI note)    */
		2			/* start freq. / base frq.   */
		0.0015			/* frequency env. half-time  */
		2.0	0.001	0	/* FM depth start, envelope  */
					/*   half-time, end	     */
		1.4983			/* osc 2 frq. / osc 1 frq.   */
		1	0.02	0	/* osc 2 amp. start, env.    */
					/*   half-time, end	     */
		5000	7500		/* noise BP freq., bandwidth */
		0	0.005	1	/* noise amp. start, env.    */
					/*   half-time, end	     */
		0.03			/* decay envelope half-time  */

/* ---- hi tom ---- */

f 57 0 32 -2	25000			/* amplitude scale	     */
		0.018			/* delay		     */
		0.04			/* release time		     */
		2	-1	0	/* X, Y, Z coordinates	     */
		49			/* base freq. (MIDI note)    */
		1.3333			/* start freq. / base frq.   */
		0.135			/* frequency env. half-time  */
		2.0			/* osc 2 frq. / osc 1 frq.   */
		1	0.01	0	/* osc 2 amp. start, env.    */
					/*   half-time, end	     */
		0			/* osc 1 and 2 phase (0 - 1) */
		0.083			/* invert 1 delay * base frq */
		0.135			/* invert 2 delay * base frq */
		10000			/* lowpass frequency	     */
		208	208		/* noise BP freq., bandwidth */
		1			/* noise comb freq / base f. */
		0.4			/* noise comb feedback	     */
		6000			/* noise lowpass frequency   */
		5	0.08	0	/* noise amp. start, env.    */
					/*   half-time, end	     */
		0.18			/* decay envelope half-time  */

/* ---- mid tom ---- */

f 58 0 32 -2	25000			/* amplitude scale	     */
		0.018			/* delay		     */
		0.04			/* release time		     */
		1	-2	0	/* X, Y, Z coordinates	     */
		44			/* base freq. (MIDI note)    */
		1.3333			/* start freq. / base frq.   */
		0.135			/* frequency env. half-time  */
		2.0			/* osc 2 frq. / osc 1 frq.   */
		1	0.01	0	/* osc 2 amp. start, env.    */
					/*   half-time, end	     */
		0			/* osc 1 and 2 phase (0 - 1) */
		0.083			/* invert 1 delay * base frq */
		0.135			/* invert 2 delay * base frq */
		10000			/* lowpass frequency	     */
		208	208		/* noise BP freq., bandwidth */
		1			/* noise comb freq / base f. */
		0.4			/* noise comb feedback	     */
		6000			/* noise lowpass frequency   */
		5	0.08	0	/* noise amp. start, env.    */
					/*   half-time, end	     */
		0.18			/* decay envelope half-time  */

/* ---- low tom ---- */

f 59 0 32 -2	25000			/* amplitude scale	     */
		0.018			/* delay		     */
		0.04			/* release time		     */
		-2	-1	0	/* X, Y, Z coordinates	     */
		37			/* base freq. (MIDI note)    */
		1.3333			/* start freq. / base frq.   */
		0.135			/* frequency env. half-time  */
		2.0			/* osc 2 frq. / osc 1 frq.   */
		1	0.01	0	/* osc 2 amp. start, env.    */
					/*   half-time, end	     */
		0			/* osc 1 and 2 phase (0 - 1) */
		0.083			/* invert 1 delay * base frq */
		0.135			/* invert 2 delay * base frq */
		10000			/* lowpass frequency	     */
		208	208		/* noise BP freq., bandwidth */
		1			/* noise comb freq / base f. */
		0.4			/* noise comb feedback	     */
		6000			/* noise lowpass frequency   */
		5	0.08	0	/* noise amp. start, env.    */
					/*   half-time, end	     */
		0.18			/* decay envelope half-time  */

/* ---- rim shot ---- */

f 56 0 32 -2	10000			/* amplitude scale	     */
		0.0195			/* delay		     */
		0.04			/* release time		     */
		-1.5	0.5	0	/* X, Y, Z coordinates	     */
		56			/* base freq. (MIDI note)    */
		2			/* start freq. / base frq.   */
		0.0025			/* frequency env. half-time  */
		3	0.02	0	/* FM depth start, envelope  */
					/*   half-time, end	     */
		0.1	2000		/* noise amp., lowpass frq.  */
		4	0.006	0	/* amplitude (before	     */
					/*   distortion) start, env. */
					/*   half-time, end	     */
		-4	4000	0.0002	/* highpass filtered signal  */
					/*   (after distortion) amp, */
					/*   cutoff frequency, delay */
		20000	0.009	100	/* output lowpass start frq, */
					/*   env. half-time, end frq */

; ======== list of available instruments ========

; p-fields for all instruments:
;
;   p2: start time
;   p3: duration
;   p5: velocity
;
; instruments are selected by p1 and p4:
;
;   +------------------+------+------+
;   |    instrument    |  p1  |  p4  |
;   +------------------+------+------+
;   | crash cymbal 1   |  10  |  10  |
;   +------------------+------+------+
;   | crash cymbal 2   |  10  |  11  |
;   +------------------+------+------+
;   | reverse cymbal   |  10  |  12  |
;   +------------------+------+------+
;   | open hi-hat      |  10  |  13  |
;   +------------------+------+------+
;   | closed hi-hat    |  10  |  14  |
;   +------------------+------+------+
;   | tambourine       |  10  |  15  |
;   +------------------+------+------+
;   | open hi-hat 2    |  10  |  16  |
;   +------------------+------+------+
;   | ride cymbal      |  10  |  17  |
;   +------------------+------+------+
;   | bass drum        |  20  |  20  |
;   +------------------+------+------+
;   | TR-808 bass drum |  21  |  25  |
;   +------------------+------+------+
;   | hand clap        |  30  |  30  |
;   +------------------+------+------+
;   | TR-808 cowbell   |  31  |  35  |
;   +------------------+------+------+
;   | TR-808 open      |  40  |  40  |
;   | hi-hat           |      |      |
;   +------------------+------+------+
;   | TR-808 closed    |  40  |  41  |
;   | hi-hat           |      |      |
;   +------------------+------+------+
;   | TR-808 cymbal    |  40  |  42  |
;   +------------------+------+------+
;   | TR-909 snare 1   |  50  |  50  |
;   +------------------+------+------+
;   | TR-909 snare 2   |  50  |  51  |
;   +------------------+------+------+
;   | TR-909 snare 3   |  50  |  52  |
;   +------------------+------+------+
;   | TR-909 snare 4   |  50  |  53  |
;   +------------------+------+------+
;   | high tom         |  51  |  57  |
;   +------------------+------+------+
;   | mid tom          |  51  |  58  |
;   +------------------+------+------+
;   | low tom          |  51  |  59  |
;   +------------------+------+------+
;   | rim shot         |  52  |  56  |
;   +------------------+------+------+

; ---------------------------------------------------------------------

#include "score.sco"

; ---------------------------------------------------------------------

; output instrument (p6: volume)

i 99 0 53 0.3

e	; end of score

