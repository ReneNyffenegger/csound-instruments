;------------------------------------;
; Pinkston Complex Instruments 2-4   ;
;------------------------------------;

  sr        =  22050
  kr        =  2205
  ksmps     =  10
  nchnls    =  1       

instr   2               ;this instrument beeps 4 times/second
start:
            timout    0,.25,continue              ;branch to continue for .25 seconds, then...
            reinit    start                       ;reinit all, beginning with the timout
continue:                       
  kgate     linen     p4,.02,.25,.1               ;make a .25-second linear envelope; amp=p4
  asig      oscili    kgate,1000,1                ;make a 1 KHz beep tone, using function 1
            out       asig    
endin                   ;reinit will end here, if no rireturn
;------------------------------------------------------------------------;
instr   3               ;this instrument also beeps 4 times/second
  kgate     oscil     p4,4,2                      ;ifn 2 has linear envelope shape; amp=p4
  asig      oscili    kgate,1000,1                ;make a 1 KHz beep tone, using function 1
            out       asig    
endin           
;------------------------------------------------------------------------;
instr   4              ;variable beep rate and phrase envelope
  kphrase   linen     1,p3/2,p3,p3/2              ;gradual rise and fall in amp over p3
  kdur      line      .1,p3,1                     ;kdur changes from .1 to 1 over p3 secs
start:
            timout    0,i(kdur),continue          ;branch to continue for kdur secs, then
            reinit    start                       ;reinit all, beginning with the timout
continue:                       
  kgate     oscil1    0,p4,.1,2                   ;ifn 2 has env shape; dur fixed at .1 
  asig      oscili    kgate,1000,1                ;make a 1 KHz beep tone, using func 1
            out       asig*kphrase                ;apply the overall phrase dynamic
endin                   ;reinitialization stops here
