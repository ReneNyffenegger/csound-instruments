                                        ; tt6d.orc
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 6

  ifunc     =  p11                                ; SELECT THE BASIC WAVEFORM
  irel      =  .01                                ; SET VIBRATO RELEASE TIME
  idel1     =  p3-(p10*p3)                        ; CALCULATE INITIAL DELAY (% OF DUR)
  isus      =  p3-(idel1-irel)                    ; CALCULATE REMAINING DURATION
             
  iamp      =  ampdb(p4)
  iscale    =  iamp*.333                          ; p4=AMP
  inote     =  cpspch(p5)                         ; p5=FREQ
             
  k3        linseg    0,idel1,p9,isus,p9,irel,0   ; p6=ATTACK TIME
  k2        oscil     k3,p8,1                     ; p7=RELEASE TIME
  k1        linen     iscale,p6,p3,p7             ; p8=VIB RATE
  a3        oscil     k1,inote*.999+k2,ifunc      ; p9=VIB DEPTH
  a2        oscil     k1,inote*1.001+k2,ifunc     ; p10=VIB DELAY (0-1)
  a1        oscil     k1,inote+k2,ifunc
            out       a1+a2+a3
endin

