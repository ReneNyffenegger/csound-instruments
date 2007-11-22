; "It seems to me that this will give you the (2k+1) and the (4k+2), missing
; the (4k)s."

; You are absolutely correct. The lower-freq. oscillator will give you any
; desired odd harmonic. The upper will only give you selected even harmonics,
; the 2, 6, 10, ..., 4k+2 th ones to be exact. I didn't promise all of the
; evens. I honestly don't know what Sinan Boekesoy needs, but adding some
; even harmonics removes the reedy clarinet/bassoon quality from a sound. I
; offered a workaround, not a complete fix. Eli is correct that you need
; oscillators at 2x, 4x, 8x, & 16x, etc. if you really need all of the even
; harmonics. At that point adsyn or a high-pass filter start looking pretty
; appealing.

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
          
  aenv      linseg    0,0.05,1000,p3-.1,1000,0.05,0 ; AMPLITUDE ENVELOPE
  aspc      linseg    0,p3/2,0.5,p3/2,0           ; SPECTRAL ENVELOPE
  aodd      oscil     aspc,p4,1                   ; ODD HARMONICS
  aodh      table     aodd,2,1,0.5                ; ODD HARMONICS
  aevn      oscil     aspc,2*p4,1                 ; EVEN HARMS
  aevh      table     aevn,3,1,0.5                ; EVEN HARMS

            out       aodh+aevh
          
            display   aodh+aevh,0.02
endin
                                             
