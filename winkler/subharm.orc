;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;COPYRIGHT 1998 Paul M. Winkler, zarmzarm@hotmail.com
;****++++
;**** Last modified: Fri Jun 18 00:52:34 1999
;****----
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2


instr 1
                                                                                        ; SUBHARMONIC SYNTHESIS
                                                                                        ; VERSION ONE -- DOWNSAMPLING
                                                                                        ; LOW KSMPS (1 OR 2) GIVES BEST-SOUNDING RESULTS.
  istraightgain       =   ampdb(p4)               ; USED AS GAINS,
  idown1gain   =      ampdb(p5)                   ; NOT AMPLITUDES.
  idown2gain   =      ampdb(p6)                   ; E.G. IF ARG IS
                                                                ; 6, THE GAIN IS 2.
                                                                ; IF ARG. IS -6, 
                                                                ; GAIN IS 0.5.
; FIRST GENERATE SOME SOUND

  kcount    init      0
  ktest     init      0
  kamp      expseg    .001, 0.5, 1, p3 -1, 1, 0.5, .0001 
  kpitch    linseg    0.9, p3, 1.3
  a1        diskin    "drumloop.aif", kpitch
; afilt1        tonex   a1, 400, 4                              ; HEAVY PRE-FILTERING.
  afilt1    resonx    a1, 150, 200, 2, 1          ; THIS COULD USE SOME TWEAKING
  k1        downsamp  afilt1

; NOW PROCESS CHANNEL 1.
; THIS WORKS BY COUNTING UPWARD ZERO CROSSINGS IN THE 
; WAVEFORM.
; THE COUNT IS USED TO SET THE OUTPUT TO EITHER 1 OR -1
; SO WE GET A SQUARE WAVES AT HALF (AND A QUARTER) OF
; THE INPUT FREQUENCY.

  kdetect   trigger   k1, 0, 0                    ; NOTICE ONLY UPWARD ZERO-CROSSINGS
if kdetect ==   0 goto next1
  kcount    =  kcount + 1
  ktest     =  kcount % 4
next1:
if ktest    !=      1 goto next2
  adown1    =  1
  adown2    =  1
            goto      output
next2:
if ktest    !=      2 goto next3
  adown1    =  -1
  adown2    =  1
            goto      output
next3:
if ktest    !=      3 goto next4
  adown1    =  1
  adown2    =  -1
            goto      output
next4:
  adown1    =  -1
  adown2    =  -1
output:

; CHOOSE YOUR FILTER...

; adown1        tone    adown1, kfreq * .04                     ; TAKES OUT SOME HIGH END, BUT
                                                                        ; STILL SYNTH-SOUNDING... LOOKS LIKE A TRIANGLE WAVE.
; adown1        rezzy   adown1, 40, 30                  ; PRETTY SMOOTH BUT ASYMMETRICAL.
; adown1        tonex   adown1, 40, 7                   ; DISTORTS WITH SOME INPUTS.
  adown1    resonx    adown1, 35, 60, 4           ; VERY NICE, NEAR-SINE OUTPUT.
  adown2    resonx    adown2, 30, 50, 4
; adown1        butterbp        adown1, 30, 10                  ; OUTPUT LOOKS LIKE A TRIANGLE WAVE!
  adown1    dcblock   adown1
  adown2    dcblock   adown2
  adown1    balance   adown1, afilt1              ; RESTORE DYNAMICS.
  adown2    balance   adown2, afilt1              ; IT'S IMPORTANT TO USE FILTERED SIGNAL!
  a1        =  a1 * istraightgain
            outs      a1 + (adown1 * idown1gain),  a1 + (adown2 * idown2gain)
endin







