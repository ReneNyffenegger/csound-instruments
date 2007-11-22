  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;================================================================;
; Example Granular Synthesis Instrument Using Granule            ;
;                                                                ;
; This is a modification of the example instrument given in the  ;
; Csound manual, which uses two granule opcodes - one for the    ;
; left output and one for the right. The only difference between ;
; the two is that they have different seed values. I have added  ;
; varying gap and size parameters, controlled by oscil1i units.  ;
; Russell Pinkston, 2/18/99                                      ;
;================================================================;

instr   2
;
  iamp      =  p4                                 ;peak grain amplitude
  ivoice    =  p5                                 ;n voices (up to 128)
  iratio    =  p6                                 ;1 is normal, < 1 for time stretch, > 1 for compress
  imode     =  p7                                 ;+ is forward, - is backward, 0 is random
  ithd      =  p8                                 ;skip if signal amp is less than ithd
  ifn       =  p9                                 ;sound source function
  iflen     =  p10                                ;length of source function in seconds
  ipshift   =  p11                                ;Number of pitch shift values
  igskip    =  p12                                ;initial skip time
  igskoff   =  p13                                ;random offset from igskip
  igapmin   =  p14                                ;minimum gap between successive grains
  igapoff   =  p15                                ;random gap offset %
  igapmax   =  p25                                ;maximum gap between successive grains
  igapfn    =  p26                                ;gap variation control function
  igapvar   =  igapmax-igapmin
  isizmin   =  p16                                ;minimum grain size
  isizoff   =  p17                                ;random size offset %
  isizmax   =  p27                                ;maximum grain size
  isizefn   =  p28                                ;grain size control function
  isizvar   =  isizmax-isizmin
  iatt      =  p18                                ;grain attack time (% of grain size)
  idec      =  p19                                ;grain decay time (% of grain size)
  iseed     =  p20                                ;random number generator seed
  ipitch1   =  p21                                ;pitch shift factors (1 = no shift)
  ipitch2   =  p22
  ipitch3   =  p23
  ipitch4   =  p24

  kenv      linen     iamp,.5,p3,.5               ;overall amplitude envelope
  kgapctl   oscil1i   0,1,p3,igapfn               ;gap control function
  ksizctl   oscil1i   0,1,p3,isizefn              ;grain size control function
  kgap      =  igapmin+igapvar*kgapctl            ;vary gap between min and max
  ksize     =  isizmin+isizvar*ksizctl            ;vary size between min and max
  a1        granule   kenv,ivoice,iratio,imode,ithd,ifn,ipshift,igskip,igskoff,iflen,kgap, igapoff,ksize,isizoff,iatt,idec,iseed,ipitch1,ipitch2,ipitch3,ipitch4
  a2        granule   kenv,ivoice,iratio,imode,ithd,ifn,ipshift,igskip,igskoff,iflen,kgap, igapoff,ksize,isizoff,iatt,idec,iseed+.017,ipitch1,ipitch2,ipitch3,ipitch4
            outs      a1,a2
endin
