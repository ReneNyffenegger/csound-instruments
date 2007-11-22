
; RISSET'S INSTRUMENT DESIGN FO A BELL-LIKE SOUND

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1,2,3,4

; p3      =         duration
; p4      =         freq in Hz
; p5      =         amplitude

; PEAK AMPS OF THE PARTIALS ARE A FUNCTION OF THE AMP OF THE LOWEST PARTIAL

  i1        =  p5
  i2        =  p5*0.67
  i3        =  p5*1.35
  i4        =  p5*1.80
  i5        =  p5*2.67
  i6        =  p5*1.67
  i7        =  p5*1.46
  i8        =  p5*1.33
  i9        =  p5*1.33
  i10       =  p5*0.75
  i11       =  p5*1.33

; DURATIONS OF THE PARTIALS ARE A FUNCTION OF THE DURATION OF THE LOWEST PARTIAL
                    
  i12       =  p3
  i13       =  p3*.9
  i14       =  p3*.65
  i15       =  p3*.55
  i16       =  p3*.325
  i17       =  p3*.35
  i18       =  p3*.25
  i19       =  p3*.2
  i20       =  p3*.15
  i21       =  p3*.1
  i22       =  p3*.075

; FREQUENCIES OF THE PARTIALS ARE A FUNCTION OF THE FREQUENCY OF THE FUNDAMENTAL

  i23       =  p4*.56
  i24       =  (p4*.56)+1
  i25       =  p4*.92
  i26       =  (p4*.92)+1.7
  i27       =  p4*1.19
  i28       =  p4*1.7
  i29       =  p4*2
  i30       =  p4*2.74
  i31       =  p4*3
  i32       =  p4*3.75
  i33       =  p4*4.07

; THE INSTRUMENT CONSISTS OF PAIRS Of oscil1/oscili
; WHERE OSCIL1 PROVIDES THE ENVELOPE OF THE PARTIAL
; AND OSCILI THE PARTIAL ITSELF

  k1        oscil1    0,i1,i12,1
  a1        oscili    k1,i23,2

  k2        oscil1    0,i2,i13,1
  a2        oscili    k1,i24,2

  k3        oscil1    0,i3,i14,1
  a3        oscili    k1,i25,2

  k4        oscil1    0,i4,i15,1
  a4        oscili    k1,i26,2

  k5        oscil1    0,i5,i16,1
  a5        oscili    k1,i27,2

  k6        oscil1    0,i6,i17,1
  a6        oscili    k1,i28,2

  k7        oscil1    0,i7,i18,1
  a7        oscili    k1,i29,2

  k8        oscil1    0,i8,i19,1
  a8        oscili    k1,i30,2

  k9        oscil1    0,i9,i20,1
  a9        oscili    k1,i31,2

  k10       oscil1    0,i10,i21,1
  a10       oscili    k1,i32,2

  k11       oscil1    0,i11,i22,1
  a11       oscili    k1,i33,2

            out       a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11

endin
