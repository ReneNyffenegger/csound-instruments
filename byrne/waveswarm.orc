; CREATED  BY PER BYRNE VILLEZ  1997  hbyrne@pavilion.co.uk

  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2

instr 1
      
; FAST JITTER1 SIGNALS
  k50       randi     .01,20, .8135
  k60       randi     .01,9,  .5111
  k70       randi     .01,8,  .6711
                    
; SUM THE JITTERS AND MODULATE THE FUNDAMENTAL
  kjitter   =  (k50 + k60 + k70) * p4

; SWAY SECONDARY FUNDS TO CREATE THICKNER FOR a1 AND a2
  kfund1    linseg    50,p3*.5, 49,p3*.5, 50
  kfund2    linseg    51,p3*.5, 53,p3*.5, 51

; GRAIN AMPLITUDE ENVELOPES
  kdur      linseg    1,p3*.02,1,p3*.02,.5,p3*.96,1
  kdec      linseg    1,p3*.02,1,p3*.02,.5,p3*.96,1

; OVERALL AMPLITUDE ENVELOPE
  kenv      linseg    9000,p3*.02,9000,p3*.02,10000,p3*.96,15000
                                             
  kf1       =  kfund1+kjitter                     ; SUM a1 FUND WITH kjitter
  kf2       =  kfund2+(kjitter*1.1)               ; DITTO FOR a2

  ktwist    expseg    36,p3*.8,1, p3*.2, 1        ; DEVIATE FORMANT FREQS 
  ktwist2   expseg    36.3,p3*.8, 1.03, p3*.2, 1.03
                                                               
  a1        fof       kenv, kf1, ktwist, 1, 0, .003, kdur, kdec, 75, 1, 19, p3,0,1
  a2        fof       kenv, kf2, ktwist2, 1, 0, .003, kdur, kdec, 75, 2, 19, p3,0,1

            outs      a1,a2 
endin
