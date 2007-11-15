  sr        =  44100
  kr        =  2205
  ksmps     =  20
  nchnls    =  2


instr 3 ; This instrument uses oscili to read a sample that has
        ; been stored in a function table using GEN01.

  ifn       =  p6
  ilength   =  ftlen(ifn)
  isampfreq =  p4 * (sr/ilength)                  ; calculates the frequency (the speed or rate)
                              ; for the oscili so that
                              ; p4 is a scalar on the frequency
                              ; of the sample. When p4 is 1
                              ; there will be no change from the
                              ; samples original frequency.
                              ; P4=.5 will cause it to sound one octave
                              ; lower, p4=2 will be an octavce higher, etc...
                               
  iamp      =  p5 * 32000

; amplitude envelope for sample playback oscillator
  kenv      linseg    0, .01, 1, p3 - .11, 1, .1, 0
  asig      oscili    kenv, isampfreq, ifn

; Envelope controlling bandwidth of reson filters. At the beginning of the
; composition, the bandwidth is narrow, and the output of the reson filter 
; strongly emphasizes a few harmonics of the sample, while attenuating all 
; others.  The bandwidth gradually widens throughout the piece, until the 
; 40 second mark, at which point the bandwidth is 100 times wider than at
; the beginning of the piece. From 40 seconds until the end of the piece,
; the bandwidth narrows to the original starting width.
  kq1       expseg    .01, 40, 1, p3, .01     
  kq        =  kq1 * 500

; Envelope controlling center frequency of afilt.  
  kfreq     linseg    0, 40, 2000 * p4, p3 - 2, 300, p3, 0

; asig is filtered by a reson filter, with changing
; bandwidth and center frequency.
  afilt     reson     asig, kfreq, kq, 1

; Delayed output of afilt
  adelay1   delay     afilt, .6

; Envelope controlling center frequency of afilt2. The direction
; of frequency change is roughly opposite to afilt.
  kfreq2    linseg    3000 * p4, 40, 0, p3 - 2, 2500 * p4, p3, 0

; Again, asig is filtered by a reson filter, with changing
; bandwidth and center frequency (in this case, the frequency
; is moving in opposite directions.
  afilt2    reson     asig, kfreq2, kq, 1

; Delayed output of afilt2.
  adelay2   delay     afilt2, .6

; Each output channel consists of the output of one reson
; filter, and the delayed output of the other reson filter.
  aleft     =  (afilt + adelay2) * 2
  aright    =  (afilt2 + adelay1) * 2

            outs      aleft, aright

endin