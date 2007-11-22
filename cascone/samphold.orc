
;============
;CASCONE.ORC
;============

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;=====================
;REVERB INITIALIZATION
;=====================

  garvbsig  init      0

;====================
;DELAY INITIALIZATION
;====================

  gasig     init      0

;============================
;INSTRUMENT 4 - SAMPLE & HOLD
;============================

instr     4

  krt       =  p6                                 ;KRT IS THE FRQ OF RANDH OUTPUT & CLK OSC
  isd       =  p4                                 ;ISD HOLDS THE VALUE OF THE SEED FOR RANDH
  krnd      randh     1000,krt,isd                ;NOISE INPUT TO S&H
  kclk      oscil     100,krt,14                  ;f14 IS A DUTY CYCLE WAVE
  ksh       samphold  krnd, kclk                  ;S&H
  a2        oscil     600, ksh,11
  a3        oscil     a2,1/p3,10                  ;F10=ADSR-A3 IS THE OUTPUT

  kpan      oscil     1,.04,17

  asig1     =  a3*kpan
  asig2     =  a3*(1-kpan)

            outs      asig1,asig2


  garvbsig  =  garvbsig+(a3*.2)

endin

;========================
;INSTR 99 - GLOBAL REVERB
;========================

instr     99

  a1        reverb2   garvbsig,p4,p5
            outs      a1,a1

  garvbsig  =  0

endin

