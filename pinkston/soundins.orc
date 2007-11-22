  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;================================================================;
;        Example Sound File Playback Instruments                 ;
;                                                                ;  
; These instruments demonstrate various approaches to sound file ;
; playback from disk in Csound. The sound files are located in   ;
; the zip archive sounds1.zip. Unzip the files into your SSDIR   ;
; before running this orchestra. RP                              ;
;================================================================; 

;simple soundin instrument with rescaling factor
instr     1
  iscale    =  (p5 == 0 ? 1 : p5)                 ;optional rescale fact in p5
  asound    soundin   p4                          ;p4 is nn of soundin.nn
  aoutput   =  asound * iscale                    ;rescale
            outs      aoutput,aoutput
endin
;soundin instrument with skip time & envelope
instr     2
  ifile     =  p4                                 ;p4 is nn of soundin.nn
  iskip     =  p5                                 ;p5 is skiptime in seconds
  irise     =  p6
  idecay    =  p7
  iscale    =  (p8 == 0 ? 1 : p8)                 ;optional rescale fact in p8
  asound    soundin   ifile,iskip
  kgate     linen     iscale,irise,p3,idecay
  aoutput   =  asound * kgate                     ;apply envelope and rescale
            outs      aoutput,aoutput
endin
;soundfile playback with gen01 and tablei
instr     3
;table will be rescaled to +/- 1, so need pk amp
  iamp      =  p4                                 ;peak amplitude
  ifunc     =  p5                                 ;gen01 function number
  istart    =  p6                                 ;start sample for playback
  idur      =  p7                                 ;playback duration
  iend      =  p8                                 ;end sample for playback
  irise     =  p9
  idecay    =  p10
  aindex    line      istart,idur,iend            ;play forwards or backwards
  asound    tablei    aindex,ifunc        
  kgate     linen     iamp,irise,p3,idecay
  aoutput   =  asound * kgate                     ;apply envelope
            outs      aoutput,aoutput
endin
;soundfile playback with gen01 and loscil
instr     4
  iamp      =  p4                                 ;peak amplitude
  icps      =  cpspch(p5)                         ;desired pitch
  ifunc     =  p6                                 ;gen01 function no
  iroot     =  cpspch(p7)                         ;original pitch of sample
  irise     =  p8
  idecay    =  p9
  kamp      linen     iamp,irise,p3,idecay
  asig      loscil    kamp,icps,ifunc,iroot,p10,p11,p12
            outs      asig,asig
endin
;loscil instrument that assumes aiff files and reads all info from file
instr     5
  iamp      =  p4                                 ;peak amplitude
  icps      =  cpspch(p5)                         ;desired pitch
  ifunc     =  p6                                 ;gen01 function no
  irise     =  p7
  idecay    =  p8
  kamp      linen     iamp,irise,p3,idecay
  asig      loscil    kamp,icps,ifunc
            outs      asig,asig
endin