  sr        =  22050
  kr        =  2205
  ksmps     =  10
  nchnls    =  1

instr   7       ;pitch shifter instr
  igain     =  p4                                 ;overall gain
  idelay    =  p5                                 ;n seconds delay
  insemis   =  p6                                 ;n semitones to shift
  ifract    =  insemis/12                         ;fraction of an octave
  ibasehz   =  cpsoct(8)                          ;use middle c as basis
  inewhz    =  cpsoct(8+ifract)                   ;rel freq of new pitch
  iratio    =  inewhz/ibasehz                     ;ratio new hz to old
  irate     =  (iratio-1)/idelay                  ;subtract 1/1 speed
  kenv      linen     igain,.01,p3,.05            ;overall env control
  ainput    soundin   p7                          ;p7 is soundin.nnn
  actl1     phasor    -irate                      ;moving phase 1-0
  agate1    tablei    actl1,1,1,0,1               ;window func =triangle
  actl2     phasor    -irate,.5                   ;phase offset of .5
  agate2    tablei    actl2,1,1,0,1               ;triangle window func
  ajunk     delayr    idelay                      ;alloc delay line
  asig1     deltapi   actl1*idelay                ;2 variable taps
  asig2     deltapi   actl2*idelay                ;offset 1/2 buffer len
            delayw    ainput  
  asig1     =  asig1*agate1                       ;gate tap outputs
  asig2     =  asig2*agate2                       ;separately
  asum      =  asig1+asig2                        ;and sum
            out       asum*kenv                   ;overall envelope
endin           
