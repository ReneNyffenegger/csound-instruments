;DAVID KIRSH


;----- TIES ORCHESTRA WITH DCLIC ----------

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     5
  inote     =  cpspch(p4)                         ; THIS NOTE'S PITCH
  idur      =  abs(p3)
  istied    tival     

            tigoto    tieinit

  ibegpitch =  inote
  iprevpitch   =      inote
            goto      cont

tieinit:
   
  ibegpitch =  iprevpitch
  iprevpitch   =      inote

cont:
 
  kpitchenv linseg    ibegpitch, .9, inote, abs(p3), inote

        ; IF THIS IS A TIED NOTE, THEN DECLICK ENVELOPE AMPLITUDE
        ; STARTS OUT AT '1' (I.E., SAME AS ENDING VALUE OF NOTE
        ; WE'RE TYING ONTO).  OTHERWISE, IT STARTS AT '0'.
  ibegdclic =  (istied == 1 ? 1 : 0)

        ; IF THIS NOTE IS BEING HELD (IN ANTICIPATION OF BEING TIED
        ; ONTO), THEN DECLICK AMPLITUDE ENDS AT '1' (SO IT
        ; MATCHES THE BEGINNING DECLICK AMPLITUDE OF THE TIED-ON NOTE).
        ; OTHERWISE, AMPLITUDE ENDS AT '0'.
  ienddclic =  (p3 < 0 ? 1 : 0)

  kdclic    linseg    ibegdclic, 0.1, 1, abs(p3)-0.2, 1, 0.1, ienddclic
                        
  a1        buzz      10000, kpitchenv, 6, 1, -1
            out       a1 * kdclic
endin
