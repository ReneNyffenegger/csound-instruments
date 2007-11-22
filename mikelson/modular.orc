;===========================================================================
; This instrument is an attempt at simulating a modular synthesizer.
;===========================================================================
; Modules
; 1. Simple Trigger
; 2. Keyboard Trigger
; 5. Envelope
; 6. Table LFO
;15. VCO
;20. VCF
;25. VCA
;100. Mixer
;110. Channel Clear

  sr        =  44100
  kr        =  22050
  ksmps     =  2
  nchnls    =  2
            zakinit   30,30

;---------------------------------------------------------------------------
; Simple Trigger
;---------------------------------------------------------------------------
instr  1

  idur      init      p3                          ; Just send the duration out
  idurch    init      p4                          ; on the duration channel

            zkw       idur, idurch

endin

;---------------------------------------------------------------------------
; Keyboard Trigger
;---------------------------------------------------------------------------
instr  2

  kdur      init      p3
  kamp      init      p4
  kfqc      init      cpspch(p5)
  idurch    init      p6
  iampch    init      p7
  ifqcch    init      p8

            zkw       kdur, idurch                ; Just send out triggers for duration
            zkw       kamp, iampch                ; amplitude
            zkw       kfqc, ifqcch                ; and pitch as if someone had hit a keyboard

endin

;---------------------------------------------------------------------------
; Envelope
;---------------------------------------------------------------------------
instr   5

  idurch    init      p4
  iamp      init      p5
  itab1     init      p6
  iout      init      p7

  kdur      zkr       idurch
  kenv      oscil     iamp, 1/kdur, itab1         ;Envelope for the duration on the channel

            zkw       kenv, iout                  ;Write to output

endin

;---------------------------------------------------------------------------
; Table LFO
;---------------------------------------------------------------------------
instr   6

  iamp      init      p4
  ifqc      init      p5
  itab1     init      p6
  ioffset   init      p7
  iout      init      p8

  koscil    oscil     iamp, ifqc, itab1           ;Table oscillator
  kout      =  koscil+ioffset

            zkw       kout, iout                  ;Send to output channel

endin

;---------------------------------------------------------------------------
; VCO  
; Allows for pulse width mod
; saw ramp transform and oscillator sync all though not quite the same type
; of oscillator sync as my Matrix 6R.
;---------------------------------------------------------------------------
instr   15   

  ifqch     init      p4                          ; Frequency channel
  isynch    init      p5                          ; Oscillator synch channel
  ipwmch    init      p6                          ; Pulse width modulation channel
  ktri      init      -1                          ; Initialize triangle wave generator
  kmax      init      1                           ; Use a scale it to 1.
  kpulse    init      1                           ; Initialize the pulse
  ksynch    init      -1                          ; Initialize the synch value
  ioutch    init      p7                          ; Audio output channel
  isyncout  init      p8                          ; Synch output channel (k)
  ishape    init      p9                          ; Shape 0=Triangular, 1=Square
  ipwdth    init      p10                         ; Initial pulse width -1 to 1
  ifqcadj   init      p11                         ; Frequency multiplier
  kdx       init      -1                          ; Delta X

  koldsync  =  ksynch                             ; Save the old value
  kfqc      zkr       ifqch                       ; Read new values for
  kfqc      =  kfqc*ifqcadj
  ksynch    zkr       isynch                      ; frequency, synch and PWM.
  kpwmi     zkr       ipwmch

  kpwm      =  kpwmi+ipwdth                       ; If this equals 1 or -1 it will crash

  kfsr      =  4*kfqc/kr                          ; Calculate frequency/sample rate constant
  kdx1      =  kfsr/(1+kpwm)                      ; that allows for going from -1 to 1 in 
  kdx2      =  kfsr/(1-kpwm)                      ; the right amount of time.  Likewise 1 to -1.
  knew      =  ktri+kdx                           ; Suggest the next value and check it below
                               ; to make sure it is OK.
if (koldsync>=0 || ksynch<=0) goto next1          ; If it is the end of a cycle
  kdx       =  -kdx2                              ; Reset the oscillator
  kpulse    =  kmax
  knew      =  kmax
            goto      next4

next1:
if (knew<=kmax) goto next3                        ; The new value is beyond the maximum
  knew      =  kmax-kdx2*(kdx1-kmax+ktri)/kdx1    ; so calculate the correct position.
  kdx       =  -kdx2                              ; and new slope, set pulse to the other
  kpulse    =  kmax                               ; extreme.
            goto      next4

next3:
if (knew>=-kmax) goto next4                       ; Same as above
  knew      =  -kmax+kdx1*(kdx2-kmax-ktri)/kdx2
  kdx       =  kdx1
  kpulse    =  -kmax

next4:
  ktri      =  knew                               ; The new value is now OK so update.

  aout      =  (ishape=0 ? ktri : kpulse)         ; Output either pulse or triangle waveform

            zawm      aout, ioutch
            zkw       kdx, isyncout

endin

;---------------------------------------------------------------------------
; 4 Pole Low Pass Resonant Filter
;---------------------------------------------------------------------------
instr   20

  ifcoch    =  p4                                 ; Cut-Off Frequency
  irezch    =  p5                                 ; Resonance
  irzmix    =  p6                                 ; Resonance Mix
  izin      =  p7                                 ; Input channel
  izout     =  p8                                 ; Output channel
  icut      =  .000001

  kfco      zkr       ifcoch                      ; Cut-off Frequency envelope from channel
  kfcort    =  sqrt(kfco)                         ; Needed for the filter
  krezo     zkr       irezch                      ; Resonance envelope from channel
  krez      =  krezo*kfco/500                     ; Add more resonance at high Fco
  kdclick   linseg    0, .002, 1, p3-.004, 1, .002, 0 ; Declick


  axn       zar       izin                        ; Read input channel

  ka1       =  1000/krez/kfco-1                   ; Compute filter coeff. a1
  ka2       =  100000/kfco/kfco                   ; Compute filter coeff. a2
  kb        =  1+ka1+ka2                          ; Compute filter coeff. b
  ay1       nlfilt    axn/kb, (ka1+2*ka2)/kb, -ka2/kb, 0, 0, 1 ; Use the non-linear filter
  ay        nlfilt    ay1/kb, (ka1+2*ka2)/kb, -ka2/kb, 0, 0, 1 ; as an ordinary filter.

  ka1lp     =  1000/kfco-1                        ; Resonance of 1 is a low pass filter
  ka2lp     =  100000/kfco/kfco
  kblp      =  1+ka1lp+ka2lp
  ay1lp     nlfilt    axn/kblp, (ka1lp+2*ka2lp)/kblp, -ka2lp/kblp, 0, 0, 1 ; Low-pass filter
  aylp      nlfilt    ay1lp/kblp, (ka1lp+2*ka2lp)/kblp, -ka2lp/kblp, 0, 0, 1

  ayrez     =  ay - aylp                          ; Extract the resonance part.
  ayrz      =  ayrez/kfco/(1+icut*kfco*kfco*kfco) ; Use lower amplitudes at higher Fco
;ayrz    =       ayrez/kfco                      ; Use lower amplitudes at higher Fco

  ay2       =  aylp*6*(1-irzmix) + ayrz*300*irzmix ; Scale the low pass and resonance separately

            zaw       ay2*kdclick, izout          ; Write to the output channel

endin

;---------------------------------------------------------------------------
; Contolled Amplifier
;---------------------------------------------------------------------------
instr   25

  imaxch    =  p4
  igainch   =  p5
  inch      =  p6
  ioutch    =  p7

  kmax      zkr       imaxch
  kgain     zkr       igainch
  asig      zar       inch

  aout      =  kmax*kgain*asig                    ; Use the envelope to control the gain.

            zaw       aout, ioutch

endin

;---------------------------------------------------------------------------
; Mixer Section
;---------------------------------------------------------------------------
instr 100

  asig1     zar       p4                          ; Read input channel 1
  igl1      init      p5*p6                       ; Left gain
  igr1      init      p5*(1-p6)                   ; Right gain

  asig2     zar       p7                          ; Read input channel 2
  igl2      init      p8*p9                       ; Left gain
  igr2      init      p8*(1-p9)                   ; Right gain

  kdclick   linseg    0, .001, 1, p3-.002, 1, .001, 0 ; Declick

  asigl     =  asig1*igl1 + asig2*igl2            ; Scale and sum
  asigr     =  asig1*igr1 + asig2*igr2

            outs      kdclick*asigl, kdclick*asigr ; Output stereo pair

endin

; Clear audio
instr 110

            zacl      0, 30                       ; Clear audio channels 0 to 30

endin
