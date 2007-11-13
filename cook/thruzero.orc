sr       = 44100
kr       = 44100
ksmps    = 1
nchnls   = 2

instr    1 ; Stereo 'Through Zero' Flanger

ilevl    = p4                         ; Output level
idepth   = p5/1000                    ; LFO depth in ms
idelay   = p6/1000                    ; Delay before sweep in ms
isweep   = p7/1000 - p6               ; Sweep length in ms
imin     = 1/kr                       ; Minimum delay

a1, a2   soundin  "Stereo Sample"

kfade    oscil1  idelay, 1, isweep, 1 ; Generate sweep after delay
afade    upsamp  kfade                ; Convert to sr
alfo1    = (1 - afade)*idepth         ; Invert and scale sweep
atemp    delayr  2*idepth + .002
adel1    deltapi imin                 ; Delay L input 1 sample
adel2    deltapi alfo1 + imin         ; Create moving delay tap
         delayw  a1                   ; Write L input to delay
atemp    delayr  2*idepth + .002
adel3    deltapi imin                 ; Delay R input 1 sample
adel4    deltapi alfo1 + imin         ; Create moving delay tap
         delayw  a2                   ; Write L input to delay
outs1    (adel1 + adel2*afade)*ilevl  ; Level, sum L signals and output
outs2    (adel3 + adel4*afade)*ilevl  ; Level, sum R signals and output

endin
