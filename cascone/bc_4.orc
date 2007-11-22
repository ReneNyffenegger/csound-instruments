
  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2


;=================================================================
;   INSTRUMENT 4 - SAMPLE & HOLD
;=================================================================

instr          4

;krt           =              p6                  ;THIS IS THE FRQ OF THE RANDH OUTPUT & CLK OSC
;isd           =              p4                  ;P4 HOLDS THE VALUE OF THE SEED OF RANDH UG

  krt       midic7    16, 5, 15
  isd       =  .5

  krn       randh     1000,krt,isd                ;NOISE INPUT TO S&H
  kclk      oscil     100,krt,14                  ;KCLK CLOCKS THE S&H -- F14 IS A DUTY CYCLE WAVE
  ksh       samphold  krn, kclk                   ;S&H
  a2        oscil     600, ksh,11                 ;SINE OSC CONTROLLED BY S&H;;;amp=600
  a3        oscil     a2,1/5,10                   ;f10=ADSR -- a3 IS THE OUTPUT
  kpan      oscil     1,.04,17


  asig1     =  a3*kpan
  asig2     =  a3*(1-kpan)

  kmgate    linsegr   0, .01, 1, 1, 0
            outs      asig1 * kmgate,asig2 * kmgate

endin

