  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1

  asig      oscili    16384,440,1 

  ahm       tablei    asig,2 
 

            out       ahm*32768

endin
