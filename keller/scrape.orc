;************************************** orchestra ; Scrape.orc
; Damian Keller. June 1997.
; Scraping floors. Gaussian noise is shaped by a sine function.

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
                                                                        
instr 1
  kamp      =  p4                                 ; OVERALL AMPLITUDE.
  idur      =  p3                                 ; DURATION
; CONTROL
  kramp     linseg    1, idur, 0                  ; INTENSITY.
  krate     linseg    2, idur, .2                 ; RATE OF SCRAPING
                        
; SOURCE: GAUSSIAN NOISE.
  a1        gauss     kramp                     
                                                
; WINDOWED WITH SINE.
  a2        oscili    1, krate, 1              
  a3        =  a1 * a2 * kamp
            out       a3      
endin
