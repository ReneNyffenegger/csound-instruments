  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2

instr    1 ; AND/NAND gate - Complementary outputs

  ilevl     =  p4                                 ; Output level

  ain1      soundin   "sample1.wav"
  ain2      soundin   "sample2.wav"

  kin1      downsamp  ain1                        ; Convert to kr
  kin2      downsamp  ain2                        ; Convert to kr
  k1        =  ( kin1 > 0 ? 1 : 0 )               ; See if above zero crossing line
  k2        =  ( kin2 > 0 ? 1 : 0 )               ; See if above zero crossing line
if       k1 + k2 = 2 goto 1                       ; If both above, goto 1
  aand      =  0                                  ; Set AND gate to 0...
            goto      out                         ; ...then goto out
1:
  aand      =  1                                  ; Set AND gate to 1
out:
  ain       =  ain1 + ain2                        ; Sum inputs
            outs1     aand*ain                    ; AND gate signals and output L
            outs2     (1 - aand)*ain              ; NAND gate signals and output R
  
endin

instr    2 ; Exclusive OR gate - Complementary outputs

  ilevl     =  p4                                 ; Output level

  ain1      soundin   "sample1.wav"
  ain2      soundin   "sample2.wav"

  kin1      downsamp  ain1                        ; Convert to kr
  kin2      downsamp  ain2                        ; Convert to kr
  k1        =  ( kin1 > 0 ? 1 : 0 )               ; See if above zero crossing line
  k2        =  ( kin2 > 0 ? 1 : 0 )               ; See if above zero crossing line
if       k1 + k2 = 0 goto 1                       ; If both below, goto 1
if       k1 + k2 = 1 goto 2                       ; If 1 below goto 2
1:
                                     ; If neither below, also go to 1
  aexor     =  0                                  ; Set Exclusive OR gate to 0...
            goto      out                         ; ...then goto out
2:
  aexor     =  1                                  ; Set Exclusive OR gate to 1
out:
            outs1     aexor*ain1 + (1 - aexor)*ain2 ; Gate signals and output L
            outs2     (1 - aexor)*ain1 + aexor*ain2 ; Gate signals and output R
  
endin
