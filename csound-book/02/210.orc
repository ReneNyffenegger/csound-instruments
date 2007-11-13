  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

; p4    =               amp 
; p5-6  =               xtrans: init-final 
; p7-8  =               xoscil amp:     init-final 
; p9-10 =               xoscil freq: init-final
; p11   =               x index fn
; p12-13 =              ytrans: init-final
; p14-15 =              yoscil amp:     init-final 
; p16-17 =              yoscilfreq:     init-final 
; p18   =               y index fn
; p19   =               x plane fn table   
; p20   =               y plane fn table

instr   210
  kenv      linen     p4,.02,p3,.02               ; AMP ENVELOPE
                                                                        ; X INDEX VALUES FOLLOW
  kxtrans   line      p5,p3,p6                    ; TRANSVERSE MOVEMENT IN X PLANE
  kxamp     line      p7,p3,p8                    ; INDEX OSCILLATOR AMPLITUDE
  kxamp     =  kxamp*.5                           ; NORMALIZES OSCIL AMP TO INDEX TABLE
  kxfreq    line      p9,p3,p10                   ; X PLANE INDEX OSCIL FREQUENCY
  kxndx     oscili    kxamp,kxfreq,p11            ; p11=X INDEX FUNCTION
                                                                        ; TRY SINES, TRAINGLES, OR ASCENDING LINES FROM -1 TO +1 
                                                                        ; (PHASOR) ETC FOR INDEX FUNCTION
; kroger
; kxndx =               frac(kxndx+1000.5+kxtrans)      ; NEED FRACTIONAL VALUES
  axndx     =  frac(kxndx+1000.5+kxtrans)         ; NEED FRACTIONAL VALUES
                                                                        ; TO GO FROM ONE TERRAIN BOUNDARY TO THE OTHER
                                                                        ; 1000.5 AVOIDS NEGATIVE VALUES AND SETS START POINT
                                                                        ; AT TABLE MIDPOINT
                                                                        ; Y INDEX VALUES FOLLOW
  kytrans   line      p12,p3,p13                  ; TRANSVERSE MOVEMENT IN X PLANE
  kyamp     line      p14,p3,p15                  ; INDEX OSCILLATOR AMPLITUDE
  kyamp     =  kyamp*.5                           ; NORMALIZES OSCIL AMP TO INDEX TABLE
  kyfreq    line      p16,p3,p17                  ; X PLANE INDEX OSCIL FREQUENCY
  kyndx     oscili    kyamp,kyfreq,p18            ; p11=X INDEX FUNCTION
                                                                        ; TRY SINES, TRAINGLES, OR ASCENDING LINES FROM -1 TO +1 
                                                                        ; (PHASOR) ETC FOR INDEX FUNCTION
; kroger
; kyndx =               frac(kyndx+1000.5+kytrans)      ; NEED FRACTIONAL VALUES
  ayndx     =  frac(kyndx+1000.5+kytrans)         ; NEED FRACTIONAL VALUES
                                                                        ; TO GO FROM ONE TERRAIN BOUNDARY TO THE OTHER
                                                                        ; 1000.5 AVOIDS NEGATIVE VALUES AND SETS START POINT
                                                                        ; AT TABLE MIDPOINT
  ax        tablei    axndx,p19,1,0,0             ; NORMALIZED (-1 TO +1) AUDIO FOR X PLANE
  ay        tablei    ayndx,p20,1,0,0             ; NORMALIZED (-1 TO +1) AUDIO FOR Y PLANE
  az        =  (ax*ay)*kenv                       ; TRACKS Z PLANE TO GENERATE TERRAIN WAVEFORM
            out       az
endin           

