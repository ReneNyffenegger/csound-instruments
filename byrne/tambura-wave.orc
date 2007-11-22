; TAMBURA WAVE.ORC
; CREATED BY:PER BYRNE VILLEZ    hbyrne@pavilion.co.uk

  sr        =  44100                              ; AUDIO SAMPLING  RATE IN Khz
  kr        =  441                                ; CONTROL SAMPLING RATE IN Khz
  ksmps     =  100
  nchnls    =  1                                  ; NUMBER OF AUDIO CHANNELS

instr 1             ; INSTRUMENT NUMBER
  idur      =  p3                                 ; ASSIGN SCORE  PFIELD 3 TO LABEL idur (NOTE DURATION)
  ifq       =  p4                                 ; ASSIGN SCORE  PFIELD4  TO LABEL ifq  (FUNDAMENTAL)


; SEE THE CSOUND  MANUAL FOR THE ORDER AND MEANING OF THESE ARGUMENTS
  a1        fof       5000,  ifq,    1, 0,  0, .003, .02, .005,  20, 1, 19, idur,0 ,1


            out       a1                          ; OUTPUT SIGNAL a1

endin                              ; END INTRUMENT

