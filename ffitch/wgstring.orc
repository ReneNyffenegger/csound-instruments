; WGSynth by Hans Mikelson 1998
;
; This wave guide synthesis instrument sounds somewhat like a bowed string under
; certain conditions.  It consists of a two delay lines whose outputs are filtered
; , compressed and then fedback into the delay lines.  The filtered output is also
; inverted and cross fedback into the other delay line.
;---------------------------------------------------------------------------

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


instr     10
  idur      =  p3                                 ; DURATION
  iamp      =  p4                                 ; AMPLITUDE
  itim1     =  1000/cpspch(p9)*(1+p12)            ; TIME OF PRIMARY WAVEGUIDE DELAY
  itim2     =  itim1*p10                          ; TIME OF SECONDARY WAVEGUIDE DELAY
  iacct     =  itim1*p6/4                         ; ACCENT PEAK
  ifco1     =  p7/itim1*15000                     ; CUT OFF FREQUENCY IS BASED ON PITCH & MODIFIER
  ifco2     =  ifco1*p8                           ; Fco2 IS BASED ON Fco1 & MODIFIER
  ifdbk     =  (1+p5/sqrt(itim1))/2               ; LOWER NOTES GET MORE FEEDBACK SQRT(FREQUENCY)
  ipan      =  p11                                ; PAN 0=LEFT, .5=CENTER, 1=RIGHT
  idec      =  p13*sqrt(itim1)                    ; DECAY RATE LOWER NOTES GET LONGER DECAY TO START
                                             ; THE WAVEGUIDE OSCILLATING SOONER.
  itabc     =  5                                  ; COMPRESSOR TABLE
  aflt1     init      0                           ; USED FOR FEEDBACK SO THEY NEED TO BE INITED HERE
  aflt2     init      0
  kamp      linseg    0, .005, iamp, idur-.01, iamp, .005, 0 ; DECLICK ENVELOPE
  kfdbk     linseg    ifdbk, .02, iacct*ifdbk, idec+.005, ifdbk, idur-.025-idec, ifdbk ; FEEDBACK ACCENT ENVELOPE
  kampr     oscili    1, cpspch(p9)/2.01, 2       ; PULSES OF NOISE ARE USED TO STIMULATE 

  asig      rand      2000*kampr                  ; THE WAVE GUIDE
  kfco1     linseg    ifco1, .05, ifco1*1.2, .1, ifco1*.8, p3-.15, ifco1*.4 ; A FREQUENCY ACCENT ENVELOPE
  kramp2    linseg    0, .1, 0, .1, 1, idur-.2, 1 ; FADE IN THE VIBRATO
  klfo2     oscili    kramp2, 1.5, 1              ; LFO2 ADDS SOME COMPLEXITY TO THE VIBRATO RATE
  klfo1     oscili    .004*kramp2, 6+klfo2, 1     ; LFO1 IS FOR THE VIBRATO
  ktim1     =  itim1*(1+klfo1)                    ; GENERATE DELAY TIMES
  ktim2     =  itim2*(1+klfo1)
; COMPRESSORS
  karms1    rms       aflt1                       ; FIND RMS LEVEL
  kampn1    =  karms1/60000                       ; NORMALIZE RMS LEVEL 0-1.
  kcomp1    tablei    kampn1,itabc,1,0            ; LOOK UP COMPRESSION VALUE IN TABLE
  karms2    rms       aflt2                       ; FIND RMS LEVEL
  kampn2    =  karms2/60000                       ; NORMALIZE RMS LEVEL 0-1.
  kcomp2    tablei    kampn2,itabc,1,0            ; LOOK UP COMPRESSION VALUE IN TABLE
; VARIABLE DELAY WAVEGUIDES
  adel1     vdelay    asig+kfdbk*aflt1*kcomp1-kfdbk*aflt2*kcomp2, ktim1, itim1*2 ; Loop 1
  adel2     vdelay    asig-kfdbk*aflt1*kcomp1+kfdbk*aflt2*kcomp2, ktim2, itim2*2 ; Loop 2
  aflt1     butterlp  adel1, kfco1                ; FILTER BEFORE FEEDING BACK
  aflt2     butterlp  adel2, ifco2
  aout      butterhp  aflt1/8, 40                 ; TAKE OFF THE DC OFFSET  I HAVE SEEN NOISE RELATED
                                             ; TO THIS OPCODE ON AN SGI
            outs      aout*sqrt(ipan)*kamp, aout*sqrt(1-ipan)*kamp ; PAN, DECLICK AND OUTPUT
endin
