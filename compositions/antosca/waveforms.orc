; WAVEFORMS.ORC                                                                                 


; WAVEFORM SWELLS

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2 

  garvbsig  init      0                           ; global audio reverb signal initialization

instr   1
  ishift    =  p4                                 ; pitch shift
  ipch      =  cpspch(p5)                         ; converts p5 to cps
  ioct      =  octpch(p5)                         ; converts p5 to oct
  kadsr     linseg    0, p3/3, 1.0, p3/3, 1.0, p3/3,0 ; ADSR envelope 
  kmodi     linseg    0, p3/3, 5, p3/3, 3, p3/3, 0 ; ADSR envelope for I
  kmodr     linseg    p6, p3, p7                  ; lineseg from p6 to p7 in p3 seconds
  a1        =  kmodi * (kmodr - 1/kmodr)/2
  a1ndx     =  abs(a1 * 2/20)                     ; normalized from 0-1
  a2        =  kmodi * (kmodr + 1/kmodr)/2     
  a3        tablei    a1ndx, 3, 1                 ; interpolated table lookup
                                                                                                                ; index, ifn, ixmode (normalized =1)
  ao1       oscil     a1, ipch, 2                 ; cosine table
  a4        =  exp(-0.5*a3+ao1)                   ; exp increase for oscil amp
  ao2       oscil     a2 * ipch, ipch, 2          ; cosine table
  aoutl     oscil     500 * kadsr * a4, ao2+cpsoct(ioct+ishift), 1 ; left output
  aoutr     oscil     500 * kadsr * a4, ao2+cpsoct(ioct-ishift), 1 ; right output
            outs      aoutl, aoutr
endin


instr 7                                                                                 ; pluck string reversed polarity
  ishift    =  p4                                 ; pitch shift
  ipch      =  cpspch(p5)                         ; converts p5 to cps
  ioct      =  octpch(p5)                         ; converts p5 to oct
  kvib      oscil     1/30, ipch/25, 1            ; vibrato
  ag        pluck     p6, cpsoct(ioct+kvib), 500, 2, 3, 1 ; amp, kcps, icps, ifn, imeth (1 - 6) of decay
  aglt      pluck     p6, cpsoct(ioct+ishift), 500, 2, 3, 1
  agrt      pluck     p6, cpsoct(ioct-ishift), 500, 2, 3, 1
  adump     delayr    0.25                        ; delay time of 250 msec, 4n*sr = mem alloc
            delayw    ag                          ; put source signal into delay line
  ad1       deltap    0.25                        ; delay 250 msec
  ad2       deltap    0.2                         ; delay 200 msec
            outs      aglt+ad1, agrt+ad2          ; left & right outputs combined with tap delay
endin


