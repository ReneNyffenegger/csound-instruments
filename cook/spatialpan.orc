  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr    1 ; Red Sound "Federation BPM FX Pro" Spatial Panning emulator+

  ilevl     =  p4                                 ; Output level
  icut1     =  p5                                 ; Low/Mid crossover frequency
  icut2     =  p6                                 ; Mid/High crossover frequency
  irate1    =  p7                                 ; Low rate
  irate2    =  p8                                 ; Mid rate
  irate3    =  p9                                 ; High rate
  iphse1    =  p10/360                            ; Low phase
  iphse2    =  p11/360                            ; Mid phase
  iphse3    =  p12/360                            ; High phase
  imode     =  p13                                ; Mode: 1=Normal 2=Mid/High inverted

  ain       soundin   "sample1.wav"

  apan1     oscili    1, irate1, 1, iphse1        ; LFO1
  apan2     oscili    1, irate2, 1, iphse2        ; LFO2
  apan3     oscili    1, irate3, 1, iphse3        ; LFO3
  apan1     =  sqrt(apan1)                        ; L pan1
  apan2     =  sqrt(apan2)                        ; L pan2
  apan3     =  sqrt(apan3)                        ; L pan3
  apan4     =  sqrt(1 - apan1)                    ; R pan1
  apan5     =  sqrt(1 - apan2)                    ; R pan2
  apan6     =  sqrt(1 - apan3)                    ; R pan3
  alo       tone      ain, icut1                  ; Low frequency signal
  atm       tone      ain, icut2                  ; Not used (low + mid)
  amd       atone     atm, icut1                  ; Mid frequency signal
  ahi       atone     ain, icut2                  ; High frequency signal
if       imode == 2 goto invert                   ; Select normal or inverse phase
  amix1     =  alo*apan1 + amd*apan2 + ahi*apan3  ; L panning - normal
            goto      normal
invert:
  amix1     =  alo*apan1 - amd*apan2 - ahi*apan3  ; L panning - inverted
normal:
  amix2     =  alo*apan4 + amd*apan5 + ahi*apan6  ; R panning
            outs1     amix1*ilevl                 ; L level and output
            outs2     amix2*ilevl                 ; R level and output

endin