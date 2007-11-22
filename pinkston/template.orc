;======================================;
; Template Orchestra for Final Project ;
;======================================;

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;=============================================
;    Global Control Instruments (1 - 10)
;Use the first block of instrument numbers
;for instruments that contain global variables
;used for effects sends or external parameter
;control (phrase envelopes, etc.) Any schedule
;instruments should be in this block, as well.
;=============================================

instr   1       ;effects sends
  gasend1   =  0                                  ;zero here, at start 
  gasnd2L   =  0                                  ;of each new k-pass
  gasnd2R   =  0
endin

instr   2       ;example control vars
  imax1     =  p4                                 ;max control value 1
  ifunc1    =  p5                                 ;control function 1
  imax2     =  p6                                 ;max control value 2
  ifunc2    =  p7                                 ;control function 2
;use an oscil1 to read control function 1
  gkvar1    oscil1i   0,1,p3,ifunc1               ;a global control
;use a line/table combination for control 2
  kindex    line      0,p3,1
  kvar2     tablei    kindex,ifunc2,1             ;normalized index
  gkvar2    =  kvar2 * imax2                      ;scale as needed
endin

instr   3       ;example event scheduler
  ipkamp    =  p4                                 ;peak amp for all events
  ievthz    =  p5                                 ;frequency of events
  itable    =  p6                                 ;number of parameter table
  iseed     =  p7                                 ;seed for random numbers
  insno     =  p8                                 ;slave instrument number
  idry      =  p9                                 ;dry output factor (0-1)
  isend1    =  p10                                ;send1 factor (0-1)
  isend2    =  p11                                ;send2 factor (0-1)
  krndno    rand      .5,iseed,1,.5
  ievtdur   =  1/ievthz
  kprev     init      1                           ;initialize previous phase 
  kphase    phasor    ievthz                      ;event "clock"
if      (kphase > kprev) kgoto wait
            event     "i",insno,0,ievtdur,ipkamp,krndno,itable,idry,isend1,isend2
wait:   
  kprev     =  kphase                             ;remember last phase value
endin

;==========================================;
;   Sound producing instruments (11-50)    ;
;Put the instruments that generate sound   ;
;here, so that they can use global vars    ;
;being initialized and/or controlled above ;
;==========================================;

instr   11              ;example playback instr
  igain     =  p4                                 ;gain factor
  irndno    =  p5                                 ;random value 
  itable    =  p6                                 ;param table
  idry      =  p7                                 ;dry signal factor
  isend1    =  p8                                 ;amp factor for send1
  isend2    =  p9                                 ;amp factor for send2
  isnds     table     0,itable                    ;get number of sounds
  index     =  2+int(isnds*irndno)*2
            print     irndno,isnds,index
  isound    table     index,itable                ;get the soundin number
  idur      table     index+1,itable              ;get the duration
  p3        =  idur                               ;adjust p3 to actual sound dur
  asig      soundin   isound                      ;play the sound
  asig      =  asig*igain*gkvar1                  ;apply global amp control
  adry      =  asig*idry                          ;signal for direct (dry) outputs
  kleft     =  sqrt(gkvar2)                       ;left pan factor
  kright    =  sqrt(1-gkvar2)                     ;right pan factor
  aleft     =  adry*kleft                         ;apply global pan control
  aright    =  adry*kright     
            outs      aleft,aright
if      (isend1 == 0) kgoto send2
  gasend1   =  gasend1+asig*isend1
send2:
if      (isend2 == 0) kgoto end
  gasnd2L   =  gasnd2L+aleft*isend2
  gasnd2R   =  gasnd2R+aright*isend2
end:
endin

;==========================================;
;   Global effects instruments (51-99)     ;
;Put the instruments that generate sound   ;
;here, so that they can use global vars    ;
;being initialized and/or controlled above ;
;==========================================;

instr   51      ;stereo slapback delay
  idel1     =  p4      
  ilvl1     =  p5
  ipan1     =  p6
  ifeed1    =  p7                                 ;feedback factor1 (0-1)
  idel2     =  p8
  ilvl2     =  p9
  ipan2     =  p10
  ifeed2    =  p11                                ;feedback factor2 (0-1)
  isend2    =  p12                                ;amount to send on to reverb
  atap1     init      0                           ;initialize outputs
  atap2     init      0
  atap1     delay     gasend1+atap1*ifeed1,idel1
  atap2     delay     gasend1+atap2*ifeed2,idel2
  ileft1    =  sqrt(ipan1)
  iright1   =  sqrt(1-ipan1)
  ileft2    =  sqrt(ipan2)
  iright2   =  sqrt(1-ipan2)
  aleft     =  atap1*ileft1 + atap2*ileft2
  aright    =  atap1*iright1 + atap2*iright2
            outs      aleft,aright
if      (isend2 == 0) kgoto end
  gasnd2L   =  gasnd2L+aleft*isend2
  gasnd2R   =  gasnd2R+aright*isend2
end:
endin
        
instr   52      ;stereo reverb
  igain     =  p4                                 ;reverb gain factor
  irvt      =  p5                                 ;reverb time
  idiff     =  p6                                 ;reverb2 diffusion factor
  aleft     reverb2   gasnd2L,irvt,idiff
  aright    reverb2   gasnd2R,irvt,idiff
            outs      aleft,aright
endin   