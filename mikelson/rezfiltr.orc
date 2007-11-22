; ************************************************************************
; Resonant Low-Pass Filter Instruments
;*************************************************************************
; 1. Table Based Rezzy Synth
; 2. Table Based PWM Rezzy Synth
; 3. Table Based Rezzy Synth with distortion
; 4. Noise Based Rezzy Synth
; 5. Buzz  Based Rezzy Synth
; 6. FM Based Rezzy Synth
; 7. 4 Pole Rezzy
; 8. 6 Pole Filter
; 9. Mandelbrot's Snowflake Waveform with 4 Pole Filter
;10. Flowsnake Waveform with 4 Pole Filter
;11. Saw Ramp Transform
;12. Oscillator Sync
;*************************************************************************

  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  1

;******************************************************************
instr 1   ; Table Based Rezzy Synth

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  irez      =  p7
  itabl1    =  p8

; Amplitude envelope
  kaenv     linseg    0, .01, 1, p3-.02, 1, .01, 0

; Frequency Sweep
  kfco      linseg    .1*p6, .5*p3, p6, .5*p3, .1*p6

; This relationship attempts to separate Freq from Res.
  ka1       =  100/irez/sqrt(kfco)-1
  ka2       =  1000/kfco

; Initialize Yn-1 & Yn-2 to zero
  aynm1     init      0
  aynm2     init      0

; Oscillator
  axn       oscil     iamp, ifqc, itabl1

; Replace the differential eq. with a difference eq.
  ayn       =  ((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2)
  aynm2     =  aynm1
  aynm1     =  ayn

; Amp envelope and output
  aout      =  ayn * kaenv
            out       aout

endin

;*************************************************************
instr 2   ; Table Based PWM Rezzy Synth

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  irez      =  p7
  itabl1    =  p8

; Amplitude envelope
  kaenv     linseg    0, .01, 1, p3-.02, 1, .01, 0

; Frequency Sweep
  kfco      linseg    .1*p6, .5*p3, p6, .5*p3, .1*p6

; This relationship attempts to separate Freq from Res.
  ka1       =  100/irez/sqrt(kfco)-1
  ka2       =  1000/kfco

; Initialize Yn-1 & Yn-2 to zero
  aynm1     init      0
  aynm2     init      0

; PWM Oscillator
  ksine     oscil     1.5,        ifqc/440,     1
  ksquare   oscil     ifqc*ksine, ifqc,         2
  axn       oscil     iamp,       ifqc+ksquare, itabl1

; Replace the differential eq. with a difference eq.
  ayn       =  ((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2)
  aynm2     =  aynm1
  aynm1     =  ayn

; Amp envelope and output
  aout      =  ayn * kaenv
            out       aout

endin

;******************************************************************
instr 3   ; Table Based Rezzy Synth with Distortion

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  irez      =  p7
  itabl1    =  p8

; Amplitude envelope
  kaenv     linseg    0, .01, 1, p3-.02, 1, .01, 0

; Frequency Sweep
  kfco      linseg    p6, .5*p3, .2*p6, .5*p3, .1*p6

; This relationship attempts to separate Freq from Res.
  ka1       =  100/irez/sqrt(kfco)-1
  ka2       =  1000/kfco

; Initialize Yn-1 & Yn-2 to zero
  aynm1     init      0
  aynm2     init      0

; Oscillator
  axn       oscil     iamp, ifqc, itabl1

; Replace the differential eq. with a difference eq.
  ayn       =  ((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2)

  atemp     tone      axn, kfco
  aclip1    =  (ayn-atemp)/100000
  aclip     tablei    aclip1, 7, 1, .5
  aout      =  aclip*20000+atemp

  aynm2     =  aynm1
  aynm1     =  ayn

; Amp envelope and output
            out       kaenv*aout

endin

;************************************************
instr 4   ; Noise Based Rezzy Synth

  iamp      =  p4
  irez      =  p6

; Amplitude envelope
  kaenv     linseg    0, .01, 1, p3-.02, 1, .01, 0

; Frequency Sweep
  kfco      linseg    .1*p5, .5*p3, p5, .5*p3, .1*p5

; This relationship attempts to separate Freq from Res.
  ka1       =  100/irez/sqrt(kfco)-1
  ka2       =  1000/kfco

; Initialize Yn-1 & Yn-2 to zero
  aynm1     init      0
  aynm2     init      0

; Noise Source
  axn       rand      iamp

; Replace the differential eq. with a difference eq.
  ayn       =  ((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2)
  aynm2     =  aynm1
  aynm1     =  ayn

; Amp envelope and output
  aout      =  ayn * kaenv
            out       aout

endin

;************************************************
instr 5   ; Buzz Based Rezzy Synth

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  irez      =  p7
  itabl1    =  p8

; Amplitude envelope
  kaenv     linseg    0, .01, 1, p3-.02, 1, .01, 0

; Frequency Sweep
  kfco      linseg    .1*p6, .5*p3, p6, .5*p3, .1*p6

; This relationship attempts to separate Freq from Res.
  ka1       =  100/irez/sqrt(kfco)-1
  ka2       =  1000/kfco

; Initialize Yn-1 & Yn-2 to zero
  aynm1     init      0
  aynm2     init      0

; Buzz Source
;               pitch,  amp, #partials, function
  axn       buzz      iamp, ifqc,  itabl1,      1

; Replace the differential eq. with a difference eq.
  ayn       =  ((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2)
  aynm2     =  aynm1
  aynm1     =  ayn

; Amp envelope and output
  aout      =  ayn * kaenv
            out       aout

endin

instr 6   ; FM Based Rezzy Synth

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  irez      =  p7
  itabl1    =  p8

; Amplitude envelope
  kaenv     linseg    0, .01, 1, p3-.03, 1, .01, 0, .01, 0
  kfmenv    linseg    .2, .2*p3, 2, .6*p3, .5, .2*p3, .2

; Frequency Sweep
  kfco      linseg    .1*p6, .5*p3, p6, .5*p3, .1*p6

; This relationship attempts to separate Freq from Res.
  ka1       =  100/irez/sqrt(kfco)-1
  ka2       =  1000/kfco

; Initialize Yn-1 & Yn-2 to zero
  aynm1     init      0
  aynm2     init      0

; Oscillator
  axn       foscil    iamp, ifqc, p9, p10, kfmenv, itabl1

; Replace the differential eq. with a difference eq.
  ayn       =  ((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2)
  aynm2     =  aynm1
  aynm1     =  ayn

; Amp envelope and output
  aout      =  ayn * kaenv
            out       aout

endin

;******************************************************************
instr 7   ; 4 Pole Filter

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  irez1     =  p7
  irez2     =  p9
  itabl1    =  p10

; Amplitude envelope
  kaenv     linseg    0, .01, 1, p3-.03, 1, .01, 0, .01, 0

; Frequency Sweep
  kfco1     linseg    .1*p6, .3*p3, p6, .7*p3, .1*p6
  kfco2     linseg    .1*p8, .3*p3, p8, .7*p3, .1*p8

; This relationship attempts to separate Freq from Res.
  ka1       =  100/irez1/sqrt(kfco1)-1
  ka2       =  1000/kfco1
  kb1       =  100/irez2/sqrt(kfco2)-1
  kb2       =  1000/kfco2

; Initialize Yn-1 to Yn-4 to zero
  ayn1m1    init      0
  ayn1m2    init      0
  ayn2m1    init      0
  ayn2m2    init      0

; Oscillator
  axn       oscil     iamp, ifqc, itabl1

; Replace the differential eq. with a difference eq.
  ayn1      =  ((ka1+2*ka2)*ayn1m1-ka2*ayn1m2+axn)/(1+ka1+ka2)

  ayn1m2    =  ayn1m1
  ayn1m1    =  ayn1

  ayn       =  ((kb1+2*kb2)*ayn2m1-kb2*ayn2m2+ayn1)/(1+kb1+kb2)

  ayn2m2    =  ayn2m1
  ayn2m1    =  ayn

; Amp envelope and output
  aout      =  ayn * kaenv
            out       aout

endin

;******************************************************************
instr 8   ; 6 Pole Filter

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  irez1     =  p7
  irez2     =  p9
  irez3     =  p11
  itabl1    =  p12

; Amplitude envelope
  kaenv     linseg    0, .01, 1, p3-.03, 1, .01, 0, .01, 0

; Frequency Sweep
  kfco1     linseg    .1*p6,  .5*p3, p6,  .5*p3, .1*p6
  kfco2     linseg    .1*p8,  .2*p3, p8,  .8*p3, .1*p8
  kfco3     linseg    .1*p10, .8*p3, p10, .2*p3, .1*p10

; This relationship attempts to separate Freq from Res.
  ka1       =  100/irez1/sqrt(kfco1)-1
  ka2       =  1000/kfco1
  kb1       =  100/irez2/sqrt(kfco2)-1
  kb2       =  1000/kfco2
  kc1       =  100/irez3/sqrt(kfco3)-1
  kc2       =  1000/kfco3

; Initialize Yn-1 to Yn-2 to zero
  ayn1m1    init      0
  ayn1m2    init      0
  ayn2m1    init      0
  ayn2m2    init      0
  ayn3m1    init      0
  ayn3m2    init      0

; Oscillator
  axn       oscil     iamp, ifqc, itabl1

; Replace the differential eq. with a difference eq.
  ayn1      =  ((ka1+2*ka2)*ayn1m1-ka2*ayn1m2+axn)/(1+ka1+ka2)

  ayn1m2    =  ayn1m1
  ayn1m1    =  ayn1

  ayn2      =  ((kb1+2*kb2)*ayn2m1-kb2*ayn2m2+ayn1)/(1+kb1+kb2)

  ayn2m2    =  ayn2m1
  ayn2m1    =  ayn2

  ayn       =  ((kc1+2*kc2)*ayn3m1-kc2*ayn3m2+ayn2)/(1+kc1+kc2)

  ayn3m2    =  ayn3m1
  ayn3m1    =  ayn

; Amp envelope and output
  aout      =  ayn * kaenv
            out       aout

endin

;******************************************************************
instr 9   ; Mandelbrot's Snowflake 4 Pole Filter

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  irez1     =  p7
  irez2     =  p7
  iamp2     =  p8
  iamp3     =  p9

; Amplitude envelope
  kaenv     linseg    0, .01, 1, p3-.03, 1, .01, 0, .01, 0

; Frequency Sweep
  kfcoe     expseg    .1*p6, .1*p3, p6, .9*p3, .01*p6
  kfcoo     oscil     1,6,1

  kfco1     =  kfcoe+(kfcoo+1)*kfcoe*.6
  kfco2     =  kfco1

; This relationship attempts to separate Freq from Res.
  ka1       =  100/irez1/sqrt(kfco1)-1
  ka2       =  1000/kfco1
  kb1       =  100/irez2/sqrt(kfco2)-1
  kb2       =  1000/kfco2

; Initialize Yn-1 to Yn-4 to zero
  ayn1m1    init      0
  ayn1m2    init      0
  ayn2m1    init      0
  ayn2m2    init      0

; Oscillator
  ax1       oscil     iamp,  ifqc, 6
  ax2       oscil     iamp2, ifqc*4, 6
  ax3       oscil     iamp3, ifqc/4, 6
  axn       =  ax1 + ax2 + ax3

; Replace the differential eq. with a difference eq.
  ayn1      =  ((ka1+2*ka2)*ayn1m1-ka2*ayn1m2+axn)/(1+ka1+ka2)

  ayn1m2    =  ayn1m1
  ayn1m1    =  ayn1

  ayn       =  ((kb1+2*kb2)*ayn2m1-kb2*ayn2m2+ayn1)/(1+kb1+kb2)

  ayn2m2    =  ayn2m1
  ayn2m1    =  ayn

; Amp envelope and output
  aout      =  ayn * kaenv
            out       aout

endin

;******************************************************************
instr 10  ; Flowsnake 4 Pole Filter

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  irez1     =  p7
  irez2     =  p7
  iamp2     =  p8
  iamp3     =  p9

; Amplitude envelope
  kaenv     linseg    0, .01, 1, p3-.03, 1, .01, 0, .01, 0

; Frequency Sweep
  kfco1     linseg    .1*p6, .1*p3, p6, .9*p3, .1*p6
  kfco2     linseg    .1*p6, .1*p3, p6, .9*p3, .1*p6

; This relationship attempts to separate Freq from Res.
  ka1       =  100/irez1/sqrt(kfco1)-1
  ka2       =  1000/kfco1
  kb1       =  100/irez2/sqrt(kfco2)-1
  kb2       =  1000/kfco2

; Initialize Yn-1 to Yn-4 to zero
  ayn1m1    init      0
  ayn1m2    init      0
  ayn2m1    init      0
  ayn2m2    init      0

; Oscillator
  ax1       oscil     iamp,  ifqc, 4
  ax2       oscil     iamp2, ifqc*2, 4
  ax3       oscil     iamp3, ifqc/2, 4
  axn       =  ax1 + ax2 + ax3

; Replace the differential eq. with a difference eq.
  ayn1      =  ((ka1+2*ka2)*ayn1m1-ka2*ayn1m2+axn)/(1+ka1+ka2)

  ayn1m2    =  ayn1m1
  ayn1m1    =  ayn1

  ayn       =  ((kb1+2*kb2)*ayn2m1-kb2*ayn2m2+ayn1)/(1+kb1+kb2)

  ayn2m2    =  ayn2m1
  ayn2m1    =  ayn

; Amp envelope and output
  aout      =  ayn * kaenv
            out       aout

endin

;-------------------------------------------------------------------------
; Saw-Ramp Transform Rezzy Synth
;-------------------------------------------------------------------------
instr 11   

  idur      init      p3
  iamp      init      p4
  ifqc      init      cpspch(p5)                  ;Convert to cycles/second
  irez      init      p7 
  aynm1     init      0                           ;Initialize Yn-1
  aynm2     init      0                           ;& Yn-2 to zero.
  kx        init      -p4
  kdx       init      p4*4*ifqc/sr
  kmax      init      p4

  klfo      oscil     .9,1,1                      ;Low Frequency Oscillator
  klfo      =  klfo+1                             ;for triangle ramp transform.
  kdx1      =  4*p4*ifqc/sr/klfo
  kdx2      =  2*p4*ifqc/(sr-sr/2*klfo)

;-------------------------------------------------------------------------
  kaenv     linseg    0,.01,1,p3-.02,1,.01,0      ;Amplitude envelope
  kfco      expseg    10,.2*p3,p6,.4*p3,.5*p6,.4*p3,.1*p6 ;Frequency sweep

;-------------------------------------------------------------------------
  ka1       =  100/irez/sqrt(kfco)-1              ;Adjust Q and Fco for
  ka2       =  1000/kfco                          ;coefficients A1 & A2.

;-------------------------------------------------------------------------

;Bouncing ball algorithm-a ball bouncing between two parallel walls ie:Pong
;-------------------------------------------------------------------------
  knewx     =  kx+kdx                             ;Find next position 

if (knewx<=kmax) goto next1                       ;If next is beyond the top wall
  knewx     =  kmax-kdx2*(kdx1-kmax+kx)/kdx1      ;then find the bounce position
  kdx       =  -kdx2                              ;and downward slope.

next1:
if (knewx>=-kmax) goto next2                      ;If next is beyond the bottom wall
  knewx     =  -kmax+kdx1*(kdx2-kmax-kx)/kdx2     ;then find the bounce position
  kdx       =  kdx1                               ;and upward slope.

next2:
  kx        =  knewx

  axn       =  kx

;-------------------------------------------------------------------------
  ayn       =  ((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2) ;Difference eq. app.
  aynm2     =  aynm1                              ;of differential eq.
  aynm1     =  ayn                                ;Save Yn-1 & Yn-2.

;-------------------------------------------------------------------------
  aout      =  ayn*kaenv                          ;Scale and output
            out       aout

endin


;-------------------------------------------------------------------------
; Oscillator Sync Rezzy Synth
;-------------------------------------------------------------------------
instr 12   

  idur      init      p3
  iamp      init      p4
  ifqc      init      cpspch(p5)                  ;Convert to cycles/second
  ifqcs     init      cpspch(p5)*p8
  irez      init      p7 
  aynm1     init      0                           ;Initialize Yn-1
  aynm2     init      0                           ;& Yn-2 to zero.
  kxn       init      -p4
  kdx       init      p4*8*ifqc/sr
  kmax      init      p4
  ksyncm    init      -1
  ksyncs    init      -1

;-------------------------------------------------------------------------
  kaenv     linseg    0,.001,1,p3-.002,1,.001,0   ;Amplitude envelope
  kfco      expseg    10,.2*p3,p6,.4*p3,.5*p6,.4*p3,.1*p6 ;Frequency sweep

;-------------------------------------------------------------------------
  ka1       =  100/irez/sqrt(kfco)-1              ;Adjust Q and Fco for
  ka2       =  1000/kfco                          ;coefficients A1 & A2.

;-------------------------------------------------------------------------
  kxn       =  kxn+kdx                            ;Find next position 

  ksmprev   =  ksyncm                             ;Watch master for transition
  ksyncm    oscil     1,ifqc,2                    ;from -1 to 1 then reset axn.
  kxn       =  ((ksmprev=-1)&&(ksyncm=1) ? -kmax : kxn)

  kssprev   =  ksyncs                             ;Watch slave for transition
  ksyncs    oscil     1,ifqcs,2                   ;from -1 to 1 then reset axn.
  kxn       =  ((kssprev=-1)&&(ksyncs=1) ? -kmax : kxn)

  axn       =  kxn
;-------------------------------------------------------------------------
  ayn       =  ((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2) ;Difference eq. app.
  aynm2     =  aynm1                              ;of differential eq.
  aynm1     =  ayn                                ;Save Yn-1 & Yn-2.

;-------------------------------------------------------------------------
  aout      =  ayn*kaenv                          ;Scale and output
            out       aout

endin