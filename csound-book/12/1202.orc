  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   1202    ; A BETTER SIMPLE FM INSTRUMENT
  isine     =  1                                  ; f1 HAS A SINE WAVE - BEST FOR SIMPLE FM
  iamp      =  p4                                 ; PEAK AMP OF CARRIER
  ihz0      =  cpspch(p5)+p18                     ; BASIC PITCH +DETUNE
  icfac     =  p6                                 ; CARRIER FACTOR
  imfac     =  p7                                 ; MODULATOR FACTOR
  index     =  p8                                 ; MAXIMUM INDEX VALUE
  ieva      =  p9                                 ; ATTACK TIME OF MAIN ENVELOPE
  ievd      =  p10                                ; DECAY TIME OF MAIN ENVELOPE
  iamp2     =  p11*iamp                           ; MAIN AMP SUSTAIN LEVEL
  ievr      =  p12                                ; RELEASE TIME OF MAIN ENVELOPE
  ievss     =  p3-ieva-ievd-ievr                  ; ENV STEADY STATE
  indx1     =  p13*index                          ; INITIAL/FINAL INDEX
  idxa      =  p14                                ; ATTACK TIME OF INDEX
  idxd      =  p15                                ; DECAY TIME OF INDEX
  indx2     =  p16*index                          ; SUSTAINED INDEX
  idxr      =  p17                                ; RELEASE TIME OF INDEX
  idxss     =  p3-idxa-idxd-idxr                  ; INDEX STEADY STATE
  kndx      linseg    indx1, idxa, index, idxd, indx2, idxss, indx2, idxr, indx1      
  kamp      linseg    0, ieva, iamp, ievd, iamp2, ievss, iamp2, ievr, 0       
  asig      foscili   kamp, ihz0, icfac, imfac, kndx, isine   
            out       asig    
endin           
