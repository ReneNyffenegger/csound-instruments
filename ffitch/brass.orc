
  sr        =  44100                              ; SAMPLERATE
  kr        =  441                                ; CONTROL SAMPLERATE
  ksmps     =  100                                ; SR / KR
  nchnls    =  1                                  ; 1=MONO, 2=STEREO

  gareverb  init      0

          
instr 1

;         wgbrass        KAMP,KFREQ,LIPTENS,DEATTACK,VIBFREQ,VIBAMT,TABLE[,LOWFREQ],
; asignal wgbrass        10000, 440,   0.4,    0.4,    1.1,   0.05,   1,    

endin


instr 2
  kbalance  init      p5

  kv        linseg    0, 0.5, 0, 1, 1, p3-0.5, 1

;ar       wgbow          KAMP,    KFREQ,  KPRES,  KRAT, KVIBF,    KVAMP,  IFN[, IMINFREQ]
  a1        wgbow     kbalance,   p4,    0.9,   0.1,     1,  kv*0.01,  1
            out       a1
endin


instr 3
;ar       vibes          KAMP,     KFREQ, IHRD, IPOS,  IMP, KVIBF, KVAMP, IVIBFN, IDEC
  a2        vibes     31129.60, 440,    0.5, 0.561,  2,   4.0,   0.2,    1,     0.1
            out       a2
endin


          ; NATURAL ROOM REVERB
          
instr 99
  a1        reverb2   gareverb,p4,0
  a2        butterlp  a1,11000                    ; CUTOFF HIGH FREQS
            out       a2                          ; TO AVOID "RAMP GLITCHES"
  gareverb  =  0
endin


          ; COMB FILTER REVERB

instr 100
  a1        comb      gareverb,p4,p5              ; P4=REVTIME  P5=LOOPTIME
  a2        butterlp  a1,13000                    ; CUTOFF HIGH FREQS
            out       a2                          ; TO AVOID "RAMP GLITCHES"
  gareverb  =  0
endin


