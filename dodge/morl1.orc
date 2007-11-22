; DEXTER MORRILL'S TRUMPET

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
instr          1
  i1        =  p5                                 ; AMP FOR CAR1
  i2        =  p5*.2                              ; AMP FOR CAR2
  i3        =  cpspch(p4)                         ; CAR 1
  i4        =  int(1500/i3+.5)*i3                 ; CAR 2
                                                  ; MOD1 = I3
                                                  ; MOD2 = I3
  i5        =  i3*2.66                            ; INDEX MOD 1
  i6        =  i3*1.8                             ; INDEX MOD 2
  i7        =  (p3<.33 ? .02 : .03)
  i8        =  (p3<.33 ? .1   : .3)               ; A2S
  i10       =  p3-(i7+i8)
  a1        randi     .007,125
if             p3 < .8   goto novib               ; NO VIBRATO IF THE NOTE IS SHORTER THAN .8 SEC
  a2        linseg    0,.6,.007,p3-.8,.007,.2,0
  a3        oscili    a2,7,1
            goto      vib
novib:
  a3        =  0
vib:
  a4        linseg    -.03,.06,.003,.01,0,p3-.07,0 ; CFDEV
  a5        =  (1+a1)*(1+a3)*(1+a4)               ; AA
                                                            ;
                                                            ; CARRIER 1 CODE
                                                            ;
  a6        linseg    0,.03,1,p3-.04,.9,.01,0
  a7        =  a6*i5                              ; INV1
  a8        oscili    a7,i3*a5,1
  a9        linseg    0,.03,1,p3-.18,.9,.15,0
  a10       =  a9*i1                              ; AENV 1
  a11       =  (i3*a5)+a8
  a12       oscili    a10,a11,1                   ; CAR1 OSC
                                                            ;
                                                            ; CARRIER 2 CODE
                                                            ;
  a13       linseg    0,.03,1,p3-.04,.9,.01,0
  a14       =  a13*i6
  a15       oscili    a14,i3*a5,1
  a16       linseg    0,i7,1,i8,.9,i10,0
  a17       =  a16*i2
  a18       =  (i4*a5)+a15
  a19       oscili    a17,a18,1                   ; CAR 2 OSC
  ga1       =  a12+a19
endin

instr          2
  a1        reverb    ga1*.04,2,0
  a2        =  ga1+a1
            out       a2
  ga1       init      0
  ga1       =  0
endin

