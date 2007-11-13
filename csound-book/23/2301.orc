sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

gadrysig  init      0                        ; INITIALIZE GLOBAL VARIABLE

          instr     2301
kenv      linseg    9000, .1, 1000, p3-.1, 0    ; ENVELOPE
anoise    randi     kenv, sr/2, .5           ; CREATE NOISE BURST
gadrysig  =         gadrysig+anoise          ; ADD BURST TO GLOBAL VAR
          endin

          instr     2302
irevtime  =         p4
areverb   reverb    gadrysig, irevtime       ; REVERBERATE SIGNAL
          out       areverb                  ; OUTPUT SIGNAL
gadrysig  =         0                        ; ZERO OUT GLOBAL VARIABLE
          endin
