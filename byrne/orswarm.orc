; ORSWARM.ORC
; CREATED  BY PER BYRNE VILLEZ   1997  hbyrne@pavilion.co.uk

  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2

instr 1
                                        
; FAST JITTER1 SIGNALS
  k50       randi     .01,20, .8135               ; FAST JITTER FOR  FOF a1 OSC
  k60       randi     .01,9, .5111
  k70       randi     .01,.8, .6711

; SUM THE JITTERS AND MODULATE THE FUNDAMENTAL
  kjitter   =  (k50 + k60 + k70) * p4

; SWAY SECONDARY FUNDS  TO CREATE THICKNER FOR a1

  kfund1    linseg    50, p3*.5, 49,p3*.5, 50
  kfund2    linseg    51, p3*.5, 53,p3*.5, 51     ; DITTO FOR a2

; amplitude  envelopes
  kdur      linseg    1, p3*.02, 1, p3*.02, .5, p3*.96, 1 ; CHANGES SIZE OF kdur
  kdec      linseg    1, p3*.02, 1, p3*.02, .5, p3*.96, 1 ; CHANGES SIZES OF kdec

  kenv      linseg    3500, p3*.02, 3500, p3*.02, 3500, p3*.96, 3500 ; AMPLITUDE ENVELOPE

                                             
  kf1       =  kfund1+kjitter                     ; SUM a1 FUND WITH kjitter
  kf2       =  kfund2+(kjitter*1.1)               ; DITTO FOR a2

  ktwist    linseg    1, p3*.4, 1.1,  p3*.6, 1    ; CHANGES FORMANT FREQUENCY
  ktwist2   linseg    1.05, p3*.4, 1.14,  p3*.6, 1.05 ; CHANGES FORMANT FREQUENCY

  koct      linseg    0, p3*.9, 0, p3*.01, 2, p3*.09, 3 ; OCTIVIATION ENVELOPE

  a1        fof       kenv, kf1, ktwist, koct, 0, .003, kdur, kdec, 75, 1, 19, p3,0, 1
  a2        fof       kenv, kf2, ktwist2, koct, 0, .003, kdur, kdec, 75, 2, 19, p3,0, 1

            outs      a1, a2 

endin
