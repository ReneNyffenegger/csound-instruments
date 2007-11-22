;JASON D. VANTOMME
;MUSIC TECHNOLOGY AREA,  FACULTY OF MUSIC
;MCGILL UNIVERSITY,  MONTREAL, PQ  CANADA
;email:   vantomme@music.mcgill.ca

;GRANULAR GENERATOR FOR SEVERAL TYPES (SIN/FM/WHATEVER...)
;03/23/93

  sr        =  44100                              ; SAMPLE RATE
  kr        =  4410                               ; CONTROL RATE
  ksmps     =  10                                 ; SR/KR = # OF SAMPLES/CONTROL PERIOD
  nchnls    =  2                                  ; STEREO

instr          1
            massign   1,1
  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01

  i3        =  .0012                              ; DURATION
;   i4         =              p4                  ; FREQUENCY
  i5        =  6781                               ; AMPLITUDE
  i6        =  3                                  ; DETERMINES FUNCTION TABLE
                                                  ; AND THUS WHAT TIMBRE

if         (i6==4)        kgoto sine2             ; SINE2 TIMBRE
if         (i6==3)        kgoto sine1             ; SINE1 TIMBRE
if         (i6==2)        kgoto fm2               ; FM2 TIMBRE
if         (i6==1)        kgoto fm1               ; FM1 TIMBRE

;THESE COULD BE WHATEVER YOU WANT.
;FM, SINE, SAMPLES, ETC.

sine2:
  kamp      linseg    0, (i3*0.4), i5, i3*.2, i5, (i3*0.4), 0
  aout      oscili    kamp, knote, i6
            kgoto     out

sine1:
  kamp      linseg    0, (i3*0.4), i5, i3*.2, i5, (i3*0.4), 0
  aout      oscili    kamp, knote, i6
            kgoto     out

fm2:
  kamp      linseg    0, (i3*0.4), i5, i3*.2, i5, (i3*0.4), 0
  aout      foscili   kamp, knote, 1, 2.0, 1, i6
            kgoto     out

fm1:
  kamp      linseg    0, (i3*0.4), i5, i3*.2, i5, (i3*0.4), 0
  aout      foscili   kamp, knote, 1, 1.5, 1, i6
            kgoto     out

out:
            outs      (aout)*kgate, (aout)*kgate

endin
