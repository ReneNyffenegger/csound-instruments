  sr        =  44100
  kr        =  2205
  ksmps     =  20
  nchnls    =  1

instr 1
  kenv      linen     p5,p6,p3,p7                 ; amplitude envelope

 ; Glissando control signal :
  ipitch1   =  cpspch(p4)                         ; 1st pitch
  ipitch2   =  cpspch(p10)                        ; 2nd pitch
  p12       =  (p12 < .001 ? .001 : p12)          ; for notes with no gliss
                                      ; p12 cannot be 0 in expseg below
  kgliss    expseg    ipitch1,p11,ipitch1,p12,ipitch2,p3-(p11+p12),ipitch2 ; gliss. envelope
            display   kgliss,p3                   ; let's see how it looks

 ; Scale the FM index : the lower the pitch, the higher the index
  k3        =  octcps(kgliss)                     ; convert cps to oct for scalar
  kscale    =  (18-k3) * .1                       ; index scalar ; c4 = 1., c3=1.1, c5 = .9 etc
  kscale    =  kscale * kscale                    ; now c4 =1., c3 = 1.21, c5 = .81 etc

 ; F.M.
  amod      oscili    p9*p8*kgliss, p8*kgliss, 100 ; modulating oscillator
  amod      =  kscale*amod                        ; now scale the fm index
  acar      oscili    kenv,  kgliss + amod , 100  ; carrier oscillator
            out       acar
endin
