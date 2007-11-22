  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2
            zakinit   20,20


#include "filters.h"

;revisiting Spiral (Vangelis) - sort of...
;Josep M Comajuncosas / July 2000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Roland TB-303 bassline emulator
; coded by Josep Mª Comajuncosas , Sept 1997 to July 2000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;
instr 1;KNOB TWISTER
;;;;;;;;;;;;;;;;;;;;;;;;;

  itempo    =  p5
;how to compute synced. LFO speeds (set 1 cycle every m n-step patterns):
;freq=1/period where period = step duration * n_steps * m_patterns
;and step duration = 60/tempo * step ( = .5 for quavers, .25 for semiquavers...)

;FCO control (exp. sweep .1-.9)
  ilfofreq1 =  1/(.25*(60/itempo) * 16 * 8)
  k0        linen     1,1,p3,8                    ;fadeout
  k1        oscil     .4,ilfofreq1,1,.25
  kfco      =  k0*(k1+.5)^2

;RES control
  kres      linseg    .1,2*p3/5,.1,p3/10,.5,p3/10,.8,2*p3/5,.2

;ENVMOD control (sweep .2-.5)
  ilfofreq3 =  1/(.25*(60/itempo) * 16 * 8)
  k3        oscil     .15,ilfofreq3,1,.25
  kenvmod   =  (k3+.55)^2

;DECAY control (sweep .05-.35)
  ilfofreq4 =  1/(.25*(60/itempo) * 16 * 1)
  kphase    phasor    ilfofreq4
  k4        table     kphase,4,1
  kdecay    =  .15*k4+.2

;PAN control
  ilfofreq5 =  1/(.25*(60/itempo) * 16 * 8)
  k5        oscil     .4,ilfofreq5,1,.25
  kpan      =  (k1+.5)

  izak_offset  =      p4                          ; to allow simultaneous TB´s with independent controls

            zkw       kfco,    5*izak_offset 
            zkw       kres,    5*izak_offset+1
            zkw       kenvmod, 5*izak_offset+2 
            zkw       kdecay,  5*izak_offset+3
            zkw       kpan,    5*izak_offset+4

endin

;;;;;;;;;;;;;;;;;;;;;;;;;
instr 2;SEQUENCER
;;;;;;;;;;;;;;;;;;;;;;;;;


  kfn_times init      p4
  kfn_values   init   p5
  ibpm      =  p6
  itranspose   =      p7
  izak_offset  =      p8

  ktime_unit   init   .25*(60/ibpm)               ; semiquavers
  initndx   =  0
  kstart    init      0
  kloop     =  16                                 ;ftlen(i(kfn_times))-1

  initndx2  =  0
  kstart2   init      0
  kloop2    =  16                                 ;ftlen(i(kfn_values))-1

  ktrig     seqtime   ktime_unit, kstart, kloop, initndx, kfn_times 
  ip1       table     0,i(kfn_values)
  ip2       table     1,i(kfn_values)
  ip3       table     2,i(kfn_values)

  kp1       init      ip1
  kp2       init      ip2
  kp3       init      ip3

;something seriously wrong here! (there is a buggy 1st event)

            trigseq   ktrig,  kstart2,  kloop2, initndx2,  kfn_values, kp1, kp2, kp3 

            schedkwhen  ktrig, -1, -1, 4.01, 0, (kp2=0?ktime_unit:-ktime_unit), .01*itranspose+kp1, kp3, izak_offset

endin


;;;;;;;;;;;;;;;;;;;;;;;;;
instr 4;SYNTH
;;;;;;;;;;;;;;;;;;;;;;;;;

; initial settings; control the overall character of the sound
  iratio    =  3                                  ; "compression" ratio for the distorter. Must be > 0
  iportime  =  .06                                ; slide time for legato notes

; init variables; don´t touch this!
  inotedur  =  p3
  icps      init      cpspch(p4)
  iacc      =  p5
  izak_offset  =      p6
  imaxamp   =  12000                              ; maximum amplitude. Max 32768 for 16 bit output monophonic

  kfco      zkr       5*izak_offset
  kres      zkr       5*izak_offset+1
  kenvmod   zkr       5*izak_offset+2
  kdecay    zkr       5*izak_offset+3
  kpan      zkr       5*izak_offset+4

;volume envelope (with legato support)
; Set default amps
  iamp0     init      1
  iamp1     init      1
  iamp2     init      1

; Check if this note is tied, if not fade in
  itie      tival     
if itie == 1 igoto nofadein
  iamp0     init      0.000001
nofadein:

; Check if this note is held, if not fade out
if inotedur < 0 igoto nofadeout
  iamp2     init      0.000001
nofadeout:
; Now generate envelope from the set values
  kamp      expseg    iamp0,.004,iamp1,abs(inotedur)-0.02,iamp1,.016,iamp2

; Skip rest of initialization on tied note:
            tigoto    tieskip
  
; Init pitch for untied note
  kcps      init      icps
  
; Drift towards target pitch 
  kcps      port      icps, iportime, icps

;kcps   line i(kcps), iportime, icps

; main (filter) envelope
  kmeg      expon     0.000001+i(kenvmod), .16 + 4.5*i(kdecay), 0.000001

; filter envelope
  kfco      =  50+kfco*1850 + kmeg*(6000+kfco*10000*kenvmod)

; generate bandlimited sawtooth wave
;asaw vco kamp,kcps,1,0,1,1
  abuzz     buzz      kamp, kcps, sr/(4*kcps), 1 ,0 ;bandlimited pulse
  asawdc    filter2   abuzz, 1, 1, 1, -.99        ; leaky integrator
  asaw      =  asawdc                             ; a leaky integrator "forgets" DC transients

; resonant 3-pole LPF
  ifcoft    =  21
  iresft    =  20
$lpf3(asaw'ay4'kfco'kres'ifcoft'iresft)

;final output
tieskip:
  aout1     =  imaxamp*kamp*ay4*kpan
  aout2     =  imaxamp*kamp*ay4*(1-kpan^2)

        ;outs aout1,aout2
            zaw       aout1,0
            zaw       aout2,1
endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 5;stereo delay with damped cross feedback rotation matrix
;(a weird name for a rather ordinary effect)
;josep m comajuncosas / july 21 / 2000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  idlt      =  p4                                 ; delay time (in sec.)
  idamp     =  p5                                 ; damping factor (0 to 1,1 gives no damping and 0 gives total attenuation/no delay))
  ispread   =  p6                                 ; rotation angle (-1 to 1,0 gives no cross feedback, 1/-1 gives crossed delay w. L/R phase inversion)
  ifco      =  p7                                 ; freq.cutoff attenuation (in Hz)

  i2pi      =  6.283185307179

  ain1      zar       0
  ain2      zar       1

  adel1     delayr    idlt
  adel2     delayr    idlt

  acos      =  cos(ispread*i2pi)
  asin      =  sin(ispread*i2pi)

  across1   =  acos*adel1 + asin*adel2
  across2   =  -asin*adel1 + acos*adel2

  afdbk1    tone      across1+ain1,ifco
  afdbk2    tone      across2+ain2,ifco

            delayw    idamp*afdbk1
            delayw    idamp*afdbk2

            zawm      adel1,0
            zawm      adel2,1
;outs adel1,adel2
endin


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 6;simple reverberator
;reverb2 is a crap...but a very convenient one!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  irvbt     =  p4                                 ;reverb time
  ihfdif    =  p5                                 ;difussion amount
  idwmix    =  p6                                 ;wet/dry mix (0: only dry, 1: only wet)

  kdeclick  linen     1,.05,p3,.05
  ain1      zar       0
  ain2      zar       1

  awet1     reverb2   ain1, p4*1.005, p5*.99
  awet2     reverb2   ain2, p4*.995, p5*1.01
            outs      kdeclick*(ain1*(1-idwmix)+awet1*idwmix), kdeclick*(ain2*(1-idwmix)+awet2*idwmix)
            zacl      0,1
endin