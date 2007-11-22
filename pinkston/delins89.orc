  sr        =  22050
  kr        =  2205
  ksmps     =  10
  nchnls    =  1

instr   8       ;soundin instrument
  gasend    init      0                           ;init the global var
  idry      =  p4                                 ;amt of signal to out
  iwet      =  p5                                 ;amt of signal to effect
  ainput    soundin   p6      
            out       ainput*idry     
  gasend    =  gasend+ainput*iwet      
endin           
;=========================================================                      
instr   9       ;harmonizer instr
  igain     =  p4                                 ;overall gain
  idelay    =  p5                                 ;n seconds delay
  insemis   =  p6                                 ;n semitones to shift
  ifeed     =  p7                                 ;feedback factor
  ilfohz    =  p8                                 ;LFO freq
  ifract    =  insemis/12                         ;fraction of an oct
  ibasehz   =  cpsoct(8)                          ;middle c as basis
  inewhz    =  cpsoct(8+ifract)                   ;desired rel pitch
  iratio    =  inewhz/ibasehz                     ;ratio new hz to old
  irate     =  (iratio-1)/idelay                  ;subtract 1/1 speed
  krate     init      irate                       ;copy to kvar
if      (ilfohz==0)     goto continue
  krate     oscili    irate,ilfohz,2              ;LFO sine fn
continue:                       
  kenv      linen     igain,.01,p3,.05            ;overall env control
  actl1     phasor    -irate                      ;moving phase 1-0
  agate1    tablei    actl1,1,1,0,1               ;triangle window func
  actl2     phasor    -irate,.5                   ;phase offset of .5
  agate2    tablei    actl2,1,1,0,1               ;triangle window func
  ajunk     delayr    idelay                      ;alloc delay line
  asig1     deltapi   actl1*idelay                ;2 variable taps
  asig2     deltapi   actl2*idelay                ;offset 1/2 buff len
  asig1     =  asig1*agate1                       ;gate tap outputs
  asig2     =  asig2*agate2                       ;separately
  asum      =  asig1+asig2                        ;and sum
  ainput    =  gasend+asum*ifeed       
            delayw    ainput  
            out       asum*kenv                   ;overall envelope
  gasend    =  0                                  ;zero global variable
endin           
