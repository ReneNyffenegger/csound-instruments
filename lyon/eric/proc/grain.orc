;;; simple orc to "granulate" a soundfile
;;; could be more elaborate... left as "an excercise for the reader"

  sr        =  44100
  kr        =  22050        
  ksmps     =  2
                

instr   1
next:
            timout    0,p6,go1                    ;;; p6 = grain duration time... I could allow
                          ;;; for an envelope on this
            reinit    go1
            timout    0,p5,go2                    ;;; p5 = inter-grain time... I could allow
                          ;;; for an envelope on this
            reinit    next
go1:
  k1        oscil1i   0,1,p6,3
  a1        soundin   p7,p4,4                     ;;; p7 is which soundin file to use...
  a2        =  a1 * k1
            rireturn  
go2:
  k2        oscil1i   0,1,p3,4                    ;;; envelope output sound.
            out       a2*k2
endin

;; sample .sco file
;;f 3 0 8193 9 1 -.5 90 0 .5 90 ;; grain envelope
;;f 4 0 8193 9 1 -.5 90 0 .5 90 ;; Note amplitude env. 
;;ins st   dur  amp inter-grain-time  grainduration  soundinfile# 
;i 1 0.000 2.750 1      0.000        0.020               1
;i 1 2.750 2.612 1 0.010 0.020 1
;i 1 5.362 2.482 1 0.020 0.020 1
;i 1 7.844 2.358 1 0.030 0.020 1
;i 1 10.202 2.240 1 0.04 0.020 1
;i 1 12.442 2.128 1 0.05 0.020 1
;i 1 14.570 2.022 1 0.06 0.020 1
;i 1 16.591 1.920 1 0.07 0.020 1
;i 1 18.512 1.824 1 0.08 0.020 1
;e
;;Copyright 1992 by Charles Baker---
;;*_________________________________________________________* 
;;Charlie Baker
;;Center for Computer Music Research and Composition
;;University of California at Santa Barbara
;;baker@waltz.ccmrc.ucsb.edu 
;;*_________________________________________________________* 
