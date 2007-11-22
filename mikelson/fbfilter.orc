  sr        =  44100
  kr        =  22050
  ksmps     =  2
  nchnls    =  2
            zakinit   30,30

; Feedback Filter 1
instr 1

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  itab      =  p6
  itabc     =  p7
  ifeedbk   =  p8

  kdclick   linseg    0, .002, 1, idur-.004, 1, .002, 0
  kfco      linseg    500, .1*idur, 5000, .4*idur, 1000, .4*idur, 500, .1*idur, 500

  asig      oscil     kdclick, ifqc, itab
  afilt     tone      asig, kfco

  afdbk     =  afilt/10                           ; Reduce original signal
  adeli     delayr    .2                          ; Feed back delay
  adel1     deltapi   1/kfco
  afilt2    butterbp  adel1, kfco, kfco/4         ; Filter the delayed signal
  kamprms   rms       afilt2                      ; Find rms level
  kampn     =  kamprms/6                          ; Normalize rms level 0-1.
  kcomp     tablei    kampn,itabc,1,0             ; Look up compression value in table
            delayw    afdbk+kcomp*ifeedbk*afilt2  ; Add limited feedback
  aout      =  adel1*10*kdclick*iamp

            outs      aout, aout

endin

; Feedback Filter 2
instr 2

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  itab      =  p6
  itabc     =  p7
  ifeedbk   =  p8/2

  kdclick   linseg    0, .002, iamp, idur-.004, iamp, .002, 0
  kfco      linseg    500, .1*idur, 5000, .4*idur, 1000, .4*idur, 500, .1*idur, 500

  asig      oscil     1, ifqc, itab
  afilt     tone      asig, kfco

  afdbk     =  afilt/10                           ; Reduce original signal
  adeli     delayr    .2                          ; Feed back delay
  adel1     deltapi   1/kfco
  afilt3    reson     adel1, kfco, kfco/4         ; Filter the delayed signal
  afilt2    balance   afilt3, adel1               ;
  kamprms   rms       afilt2                      ; Find rms level
  kampn     =  kamprms/6                          ; Normalize rms level 0-1.
  kcomp     tablei    kampn,itabc,1,0             ; Look up compression value in table
            delayw    afdbk+kcomp*ifeedbk*afilt2  ; Add limited feedback
  aout      =  adel1*10*kdclick

            outs      aout, aout

endin

; Standard tone/butterbp Combo Filter
instr 3

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  itab      =  p6
  itabc     =  p7
  ifeedbk   =  p8

  kdclick   linseg    0, .002, 1, idur-.004, 1, .002, 0
  kfco      linseg    500, .1*idur, 5000, .4*idur, 1000, .4*idur, 500, .1*idur, 500

  asig      oscil     kdclick, ifqc, itab
  afilt     tone      asig, kfco
  afilt2    butterbp  afilt, kfco, kfco/8/ifeedbk ; Filter the delayed signal
  aout      =  (afilt/2+afilt2*ifeedbk*6)*kdclick*iamp

            outs      aout, aout

endin

; Oscillator Module
instr 10

  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  itab      =  p6
  ioutch    =  p7

  kdclick   linseg    0, .002, iamp, idur-.004, iamp, .002, 0
  asig      oscil     kdclick, ifqc, itab
            zaw       asig, ioutch

endin


; Feedback Filter Module
instr    20

  idur      =  p3
  ifco      =  p4
  imodtab   =  p5
  ifeedbk   =  p6
  icmptab   =  p7
  iinch     =  p8
  ioutch    =  p9

  kfco      oscil     ifco, 1/idur, imodtab

  asig      zar       iinch
  afilt     tone      asig, kfco

  afdbk     =  afilt/10                           ; Reduce original signal
  adeli     delayr    .2                          ; Feed back delay
  adel1     deltapi   1/kfco
  afilt2    butterbp  adel1, kfco, kfco/4         ; Filter the delayed signal
  kamprms   rms       afilt2                      ; Find rms level
  kampn     =  kamprms/6                          ; Normalize rms level 0-1.
  kcomp     tablei    kampn,icmptab,1,0           ; Look up compression value in table
            delayw    afdbk+kcomp*ifeedbk*afilt2  ; Add limited feedback
            zaw       adel1*10, ioutch

endin

; Output Amplifier Module
instr 99

  idur      =  p3
  iamp      =  p4
  iamptab   =  p5
  ipantab   =  p6
  iinch     =  p7

  kamp      oscil     iamp, 1/idur, iamptab
  kpan      oscil     1, 1/idur, ipantab

  asig      zar       iinch 
            outs      asig*kamp*sqrt(kpan), asig*kamp*sqrt(1-kpan)

endin

; Clear the Zaks
instr 100
            zacl      0,30
endin

