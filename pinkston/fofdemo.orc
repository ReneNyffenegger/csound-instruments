  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
;========================================================
;               Example FOF instrument 
;
;This uses 5 fof units to simulate vowel formants. The
;formant data is taken from the Dodge book, pp. 230-231
;RP
;========================================================

instr   1               ;basic vowel formant generation instrument
  idur      =  p3
  igain     =  p4                                 ;gain factor, usually between 0 - 1
  ibasedb   =  dbamp(32767)                       ;max amp for 16-bit - use as 0dB reference
  ifund     =  cpspch(p5)
  ivibdel   =  p6
  ivibwth   =  p7
  ivibrte   =  p8
  iform1    =  p9                                 ;fof1 formant freq
  iamp1     =  ampdb(ibasedb+p10)                 ;amp relative to 0dB
  ibw1      =  p11
  iform2    =  p12                                ;fof2 formant freq
  iamp2     =  ampdb(ibasedb+p13)                 ;amp relative to 0dB
  ibw2      =  p14
  iform3    =  p15                                ;fof3 formant freq
  iamp3     =  ampdb(ibasedb+p16)                 ;amp relative to 0dB
  ibw3      =  p17
  iform4    =  p18                                ;fof4 formant freq
  iamp4     =  ampdb(ibasedb+p19)                 ;amp relative to 0dB
  ibw4      =  p20
  iform5    =  p21                                ;fof5 formant freq
  iamp5     =  ampdb(ibasedb+p22)                 ;amp relative to 0dB
  ibw5      =  p23
  ilrise    =  p24                                ;local envelope settings
  ildur     =  p25
  ildec     =  p26
  irise     =  p27                                ;global envelope settings
  idecay    =  p28
  iolaps    =  (p29 == 0 ? ifund*ildur+1 : p29)   ;compute overlaps
  ioct      =  p30                                ;octaviation

  kenv      linen     igain,irise,idur,idecay
  kvibctl   oscil1i   ivibdel,1,.25,3             ;fn3 is vib control function
  kvib      oscili    kvibctl*ivibwth,kvibctl*ivibrte,1
  kfund     =  ifund*(1+kvib)
  ar1       fof       iamp1, kfund, iform1, ioct, ibw1, ilrise, ildur, ildec, iolaps, 1, 2, idur
  ar2       fof       iamp2, kfund, iform2, ioct, ibw2, ilrise, ildur, ildec, iolaps, 1, 2, idur
  ar3       fof       iamp3, kfund, iform3, ioct, ibw3, ilrise, ildur, ildec, iolaps, 1, 2, idur
  ar4       fof       iamp4, kfund, iform4, ioct, ibw4, ilrise, ildur, ildec, iolaps, 1, 2, idur
  ar5       fof       iamp5, kfund, iform5, ioct, ibw5, ilrise, ildur, ildec, iolaps, 1, 2, idur
            out       (ar1+ar2+ar3+ar4+ar5)*kenv
endin