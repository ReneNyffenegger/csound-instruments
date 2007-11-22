; MB4.ORC       Filters the output of any soundfile (file code SOUNDIN.NNN)
;               with time-varying pulsation frequency, 
;               filter centre frequency and bandwidth
;               (c) Rajmil Fischman, 1997
;---------------------------------------- 
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 4                       
;----------------------------------------    ; PARAMETER LIST
; p4:     SCALING AMPLITUDE FACTOR, SCALES THE FILTER OUTPUT
; p5:     OVERALL ATTACK
; p6:     OVERALL DECAY
; p7:     SOUNDFILE CODE
; p8:     SOUNDFILE SKIP
; p9:     MINIMUM PULSATION FREQUENCY
; p10:    MAXIMUM PULSATION FREQUENCY
; p11:    PULSATION FREQUENCY FLUCTUATION FUNCTION
; p12:    PULSATION ENVELOPE FUNCTION
; p13:    MINIMUM CENTRE FREQUENCY OF BAND-PASS FILTER
; p14:    MAXIMUM CENTRE FREQUENCY OF BAND-PASS FILTER
; p15:    CENTRE FREQUENCY FUNCTION
; p16:    MINIMUM BANDWIDTH OF BAND-PASS FILTER (% OF CENTRE FREQUENCY)
; p17:    MAXIMUM BANDWIDTH OF BAND-PASS FILTER (% OF CENTRE FREQUENCY)
; p18:    BANDWIDTH FUNCTION
;--------------------------------------------; INITIALIZATION BLOCK
  idur      =  p3                                 ; DURATION
  iampf     =  p4                                 ; SCALING AMPLITUDE FACTOR
  iatt      =  p5                                 ; OVERALL ATTACK
  idec      =  p6                                 ; OVERALL DECAY
  isfcode   =  p7                                 ; SOUNDFILE CODE
  isfskip   =  p8                                 ; SOUNDFILE SKIP
  ipeamp    =  1.0                                ; PULSATION FREQUENCY AMPLITUDE
  ipfmin    =  p9                                 ; MINIMUM PULSATION FREQUENCY
  ipffluc   =  p10-p9                             ; PULSATION FREQUENCY FLUCTUATION
  ipffunc   =  p11                                ; PULSATION FREQUENCY FLUCTUATION FUNCTION
  ipefunc   =  p12                                ; PULSATION ENVELOPE FUNCTION
  icfmin    =  p13                                ; FILTER MINIMUM CENTER FREQUENCY
  icffluc   =  p14-p13                            ; FILTER CENTER FREQUENCY FLUCTUATION
  icffunc   =  p15                                ; FILTER CENTER FEQUENCY FUNCTION
  ibwmin    =  p16                                ; FILTER MINIMUM BANDWITH
  ibwfluc   =  p17-p16                            ; FILTER BANDWIDTH FLUCTUATION
  ibwfunc   =  p18                                ; FILTER BANDWIDTH FUNCTION
  iampbal   =  1                                  ; FILTER POWER BALANCING
;--------------------------------------------; PULSATION
  kpfreq    oscil1    0,ipffluc,idur,ipffunc      ; FREQUENCY VARIATION
  kpfreq    =  ipfmin+kpfreq
  kpenv     oscil     ipeamp,kpfreq,ipefunc       ; ENVELOPE
;--------------------------------------------; OVERALL ENVELOPE
  kenv      linen     iampf,iatt,idur,idec       
  kenv      =  kenv*kpenv                         ; MULTIPLY BY PULSATION ENVELOPE
;--------------------------------------------; FILTER PARAMETERS
  kcf       oscil1    0,icffluc,idur,icffunc      ; CENTER FREQUENCY
  kcf       =  icfmin+kcf
  kbw       oscil1    0,ibwfluc,idur,ibwfunc      ; bandwidth
  kbw       =  (ibwmin+kbw)*kcf/100.0
;--------------------------------------------; PROCESS
  ain       soundin   isfcode,isfskip             ; INPUT SOUNDFILE
  afilt     reson     ain,kcf,kbw,iampbal         ; FILTER
            out       kenv*afilt                  ; OUTPUT
endin
