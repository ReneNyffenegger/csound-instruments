sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 2

instr    1 ; Dual (stereo) 3-Phase BBD Ensemble.

ilevl    = p4/2                              ; Output level
idepth   = p5/1000                           ; Depth factor
irate1   = p6                                ; LFO 1 rate
irate2   = p7                                ; LFO 2 rate
irate3   = p8                                ; LFO 3 rate
irate4   = p9                                ; LFO 4 rate
imin     = 1/kr                              ; Minimum delay

ain      soundin  "sample1.wav"

idepth1  = idepth*(1/irate1)                 ; Scale depth 1
idepth2  = idepth*(1/irate2)                 ; Scale depth 2
idepth3  = idepth*(1/irate3)                 ; Scale depth 3
idepth4  = idepth*(1/irate4)                 ; Scale depth 4
alfo1a   oscil  idepth1, irate1, 1           ; LFO 1   0 degrees
alfo1b   oscil  idepth1, irate1, 1, .333     ; LFO 1 120 degrees
alfo1c   oscil  idepth1, irate1, 1, .667     ; LFO 1 240 degrees
alfo2a   oscil  idepth2, irate2, 1           ; LFO 2   0 degrees
alfo2b   oscil  idepth2, irate2, 1, .333     ; LFO 2 120 degrees
alfo2c   oscil  idepth2, irate2, 1, .667     ; LFO 2 240 degrees
alfo3a   oscil  idepth3, irate3, 1           ; LFO 3   0 degrees
alfo3b   oscil  idepth3, irate3, 1, .333     ; LFO 3 120 degrees
alfo3c   oscil  idepth3, irate3, 1, .667     ; LFO 3 240 degrees
alfo4a   oscil  idepth4, irate4, 1           ; LFO 4   0 degrees
alfo4b   oscil  idepth4, irate4, 1, .333     ; LFO 4 120 degrees
alfo4c   oscil  idepth4, irate4, 1, .667     ; LFO 4 240 degrees
ax       delayr  1                           ; Create 1s delay line
abbd1	   deltapi  alfo1a + alfo2a + imin     ; Tap 1
abbd2	   deltapi  alfo1b + alfo2b + imin     ; Tap 2
abbd3    deltapi  alfo1c + alfo2c + imin     ; Tap 3
abbd4    deltapi  alfo3a + alfo4a + imin     ; Tap 4
abbd5    deltapi  alfo3b + alfo4b + imin     ; Tap 5
abbd6    deltapi  alfo3c + alfo4c + imin     ; Tap 6
         delayw  ain                         ; Input signal into delay
outs1    (abbd1 + abbd2 + abbd3)*ilevl       ; Level, sum and output
outs2    (abbd4 + abbd5 + abbd6)*ilevl       ; Level, sum and output

endin
