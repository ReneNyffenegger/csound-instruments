; Sound rotation in stereophonic environment
; -- Luca Pavan, pavan@panservice.it  1997 --  orchestra

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 1

  idur      =  p3                                 ; SOUNDFILE DURATION
  iamp      =  p4                                 ; AMPLITUDE (1 = ORIGINAL AMPLITUDE)
  iskiptime =  p5                                 ; iskiptime
  iattack   =  p6                                 ; ATTACK
  irelease  =  p7                                 ; DECAY
  ifcmin    =  p8                                 ; MINIMUM CENTRAL FREQUENCY OF PASS-BAND FILTER
  ifcmax    =  p9                                 ; MAXIMUM CENTRAL FREQUENCY OF PASS-BAND FILTER
  kband     =  p10                                ; BANDWIDTH
  kpan1     =  p11                                ; LEFT CHANNEL
  kpan2     =  p12                                ; RIGHT CHANNEL
  icircles  =  p13                                ; NUMBER OF SOUND ROTATIONS
                                      
  kamp      linen     iamp, iattack, idur, irelease
  kpan1     oscili    kpan1, (1/p3)*icircles, 6
  kpan2     oscili    kpan2, (1/p3)*icircles, 5
  asig      soundin   "just_friends.aif", iskiptime
  arampsig  =  kamp * asig

  kcentro   oscili    ifcmax, (1/p3)*icircles, 7
  autfilt1  butterbp  arampsig*kpan1,ifcmin+kcentro,kband
  autfilt2  butterbp  arampsig*kpan2,ifcmin+kcentro,kband
     
            outs      autfilt1, autfilt2
endin
