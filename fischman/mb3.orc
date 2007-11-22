; MB3.ORC    Filters the output of BUZZ and 
;            gives the output an  amplitude envelope
;            (c) Rajmil Fischman, 1997
;---------------------------------------- 
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 3                       
;---------------------------------------     ;PARAMETER LIST
; p4:     SCALING AMPLITUDE FACTOR: SCALES THE FILTER OUTPUT
; p5:     OVERALL ATTACK
; p6:     OVERALL DECAY
; p7:     TRAIN OF PULSES FUNDAMENTAL
; p8:     TRAIN OF PULSES NUMBER OF HARMONICS
; p9:     TRAIN OF PULSES GENERATING FUNCTION TABLE (SINEWAVE)
; p10:    PULSATION FREQUENCY
; p11:    PULSATION ENVELOPE FUNCTION
; p12:    CENTRE FREQUENCY OF BAND-PASS FILTER
; p13:    FILTER BANDWIDTH
;-----------------------------               ;INITIALIZATION BLOCK
  idur      =  p3                                 ; DURATION
  iampf     =  p4                                 ; SCALING AMPLITUDE FACTOR
  iatt      =  p5                                 ; OVERALL ATTACK
  idec      =  p6                                 ; OVERALL DECAY
  itpamp    =  20000                              ; PULSE AMPLITUDE
  itpfreq   =  p7                                 ; PULSE FUNDAMENTAL
  itpharm   =  p8                                 ; PULSE NUMBER OF HARMONICS
  itpfunc   =  p9                                 ; PULSE FUNCTION TABLE
  ipeamp    =  1.00                               ; PULSATION NORMALISED AMPLITUDE
  ipefreq   =  p10                                ; PULSATION FREQUENCY
  ipefunc   =  p11                                ; PULSATION ENVELOPE FUNCTION TABLE
  icfreq    =  p12                                ; FILTER CENTRE FEQUENCY
  ibw       =  p13                                ; FILTER BANDWIDTH
  iampbal   =  1                                  ; FILTER POWER BALANCING
;----------------------------------------------------
  kpenv     oscil     ipeamp,ipefreq,ipefunc      ; PULSATION ENVELOPE
  kenv      linen     iampf,iatt,idur,idec        ; OVERALL ENVELOPE
  kenv      =  kenv*kpenv                         ; MULTIPLY ENVELOPES
  ain       buzz      itpamp,itpfreq,itpharm,itpfunc ; TRAIN OF PULSES
  afilt     reson     ain,icfreq,ibw,iampbal      ; FILTER
            out       kenv*afilt                  ; OUTPUT
endin
