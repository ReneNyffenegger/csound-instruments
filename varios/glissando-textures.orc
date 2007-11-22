;CSTIL12.ORC DEFINED PITCH-SPACE FILLED WITH GLISSANDO TEXTURES (cdp)
;USES 13 SCORE PARAMETERS AS FOLLOWS:
;P3 - DURATION
;P4 - AMPIITUDE
;P5 - 1ST PCH, UPPER PITCH TRACE
;P6 - 2ND PCH, UPPER PITCH TRACE
;P7 - 1ST PCH, LOWER PITCH TRACE
;P8 - 2ND PCH, LOWER PITCH TRACE
;P9 - NUMBER OF SWEEPS PER SECOND
;P10 - ENVELOPE RISE TIME
;P11 - ENVELOPE DECAY TIME
;P12 - POINTS TO HATCH TYPE 1 2 OR 3
;P13 - SWITCH FOR 1 (SINGLE) OR 2 (DOUBLE) SWEEP

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     1
  k1        line      cpspch(p5), p3, cpspch(p6)  ;UPPER GHOST LINE
  k2        line      cpspch(p7), p3, cpspch(p8)  ;LOWER GHOST LINE
  k3        oscili    k1-32, p9, p13,-1           ;P13: 1. IF SINGLESWEEP IS REQ'D
                                                  ;     2. IF DOUBLESWEEP IS REQ'D: 2 IF DOUBLE SWEEP IS REQ'D
  k4        =  (k1-k2)-k3                         ;INVERSE (DOWN LINE)
  k5        linen     p4, p10, p3, p11            ;ENVELOPE

if p12    = 1       goto uphatch
if p12    = 2       goto downhatch
if p12    = 3       goto mixhatch

uphatch:
  a1        oscili    k5, k2+k3, 3, -1
            goto      out

downhatch:
  a1        oscili    k5, k2+k4, 3, -1
            goto      out

mixhatch:
  a1        oscili    k5/2, k2+k3, 3, -1
  a2        oscili    k5/2, k2+k4, 3, -1
  a1        =  a1+a2

out:
            out       a1
endin
