
  sr        =  44100
  kr        =  4100
;sr = 22050
;kr = 2205
  ksmps     =  10

instr 1 ; imp
  aimp      =  32767.0
            out       aimp
endin

instr 2
  iop       =  1/p3
  iamp      =  p4*32767
  aenv      oscili    iamp, iop, 1
  anoi      randi     aenv,sr/2, .666
            out       anoi
endin

;f1 0 8192 1 50 0
;i2 0 dur
;line fill
;i3 0 dur atk gain
instr 3
  iatk      =  p4
  idk       =  p3-iatk
  igain     =  p5 * 32767
  aenv      linseg    0,iatk,igain,idk,0
  anoi      randi     aenv,sr/2, .1666
            out       anoi
endin
