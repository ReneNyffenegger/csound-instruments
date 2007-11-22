;============================================;
; RP's answer to 10/11/2001 in-class problem ;
;============================================;

instr   1
  iamp      =  p4
  ioct      =  octpch(p5)
  irate     =  p6
if      (p7 == 0) igoto continue
  iprev     =  octpch(p7)                         ;optionally, specify previous pitch
continue:
  idur      =  abs(ioct-iprev)/irate              ;compute duration of portamento
  koct      init      iprev                       ;koct starts on previous note
if      (ioct == iprev) goto audio                ;if no change, skip over...
  koct      linseg    iprev,idur,ioct,1,ioct
audio:
  asig      oscili    iamp,cpsoct(koct),1         ;function 1 has the waveshape
  asig      linen     asig,.05,p3,.1
            out       asig
  iprev     =  ioct                               ;remember previous pitch
endin