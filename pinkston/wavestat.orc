  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;================================================
; Korg Wavestation Simulation
;
; This implements a kind of vector synthesis,
; similar to that used in the Korg Wavestation,
; which mixes 4 sounds based on the position of
; a joystick, located on the front panel of the
; synth. In this simulation, the four sounds
; are simply 4 oscils containing 4 different
; wave functions. The 4 sounds are "located"
; in the 4 "corners of a room". Since we have
; no joystick, we generate a random x/y 
; position in the "room" and create a mix
; of the 4 sounds, based on that position. 
; The random x and y values are produced using 
; two csound randi units, both running at 5Hz. 
; This results in an x/y position that meanders 
; around the room, causing a constantly shifting
; mix of the 4 sounds. This orchestra code was
; generated using Patchwork, which is why there
; are no line-by-line comments. (Sorry.)
; RP
;================================================

instr     1
  iseed     =  p9
  ifna      =  p12
  irise     =  p6
  ihz       =  cpspch(p4)
  idecay    =  p7
  ifnb      =  p13
  irndhz    =  p10
  ievfn     =  p8
  ifnc      =  p14
  ipanhz    =  p11
  ifnd      =  p15
  kenv      envlpx    p5,irise,p3,idecay,ievfn,1,.01
  kpan      randi     .5,ipanhz,iseed
  kx        randi     .5,irndhz,iseed
  ky        randi     .5,irndhz,1-iseed
  kx        =  (kx) + (.5)
  ky        =  (ky) + (.5)
  kpan      =  (kpan) + (.5)
  k1minx    =  (1) - (kx)
  k1miny    =  (1) - (ky)
  ka        =  (k1minx) * (k1miny)
  kb        =  (k1minx) * (ky)
  kd        =  (kx) * (k1miny)
  kc        =  (kx) * (ky)
  aw2       oscili    kb,ihz,ifnb
  aw1       oscili    ka,ihz,ifna
  aw4       oscili    kd,ihz,ifnd
  aw3       oscili    kc,ihz,ifnc
  aw5       =  (aw1) + (aw2)
  aw6       =  (aw3) + (aw4)
  aw10      =  (aw5) + (aw6)
  aw7       =  (aw10) * (kenv)
  aw8       =  (sqrt(kpan)) * (aw7)
  aw9       =  (aw7) * (sqrt(1-kpan))
            outs      aw8,aw9
endin
