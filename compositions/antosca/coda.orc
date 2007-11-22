; coda.orc                                        ; FM INSTR WITH EXCESSIVE REVERB

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  garvbsig  init      0                           ; GLOBAL AUDIO REVERB SIGNAL

; INITIALIZATION

; p4      =         amplitude of output wave
; p5      =         carrier frequency specified in Hz
; p6      =         modulating frequency in Hz
; p7      =         modulation index 1
; p8      =         modulation index 2

instr 1                                 ; FM INSTRUMENT

  iamp1     =  p7 * p6                            ; amp for amod
  iamp2     =  (p8-p7) * p6                       ; amp for ampmod
  k1        randi     120, 10                     ; xamp, xcps
  k2        randi     200, 20                     ; xamp, xcps
  ampcar    oscil     p4, 1/p3, 1                 ; amp for carrier
  ampmod    oscil     iamp2, 1/p3, 1              ; amp for modulator

  amod      oscili    ampmod+iamp1, p6 + k1, 1    ; mod freq for global signal
  gasig     oscili    ampcar, k2 + p5 + amod, 1   ; global signal
            outs1     gasig * .25                 ; left direct audio output
            outs2     gasig * .25                 ; right direct audio output
  garvbsig  =  garvbsig + gasig * .25             ; add audio to audio receiver
; PRIOR TO PAN
endin


instr 99                                ; global reverb instrument

  irvbtime  =  p4                                 ; seconds for signal to decay
; 60 dB
  asig2     reverb    garvbsig, irvbtime          ; put global sig into reverb
            outs1     asig2                       ; output reverb signal left
            outs2     asig2                       ; output reverb signal right
  garvbsig  =  0                                  ; reinitialize
endin
