sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2
        
          instr     2202            ; DRY PLUCK
gasend    init      0                    ; INIT GLOBAL "SEND"
kgate     linseg    p4, .1, 0, 1, 0      ; .1 SECOND RAMP
icps      =         cpspch(p5)           ; P5 IN PCH
asig      pluck     kgate, icps, icps, 0, 1, 0, 0   ; SIMPLE PLUCK
          outs      asig, asig           ; STRAIGHT OUT
gasend    =         gasend+asig          ; ADD TO GLOBAL VAR
          endin

          instr     2203            ; GLOBAL EFFECT INSTRUMENT
atap1     delay     gasend*p4, p6        ; USE GLOBAL VAR FOR INPUTS
atap2     delay     gasend*p5, p7    
          outs      atap1, atap2         ; STEREO ECHOES
gasend    =         0                    ; CLEAR GLOBAL VAR
          endin
