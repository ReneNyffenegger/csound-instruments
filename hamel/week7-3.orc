

; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0


instr 1
  kran      randi     50, 2205                    ; produce values between -50 and 50
  kran      =  kran + 200                         ; shift values to centre freq of 200
  asig      oscil     p4, kran, 1                 ; generate a band of noise
            out       asig
endin

