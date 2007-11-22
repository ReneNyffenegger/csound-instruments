;/////////////////////////////////////////////////////////////////////////// 
;// STEPHEN BARRASS
;//  BATHTUB.ORC
;//  june 1997
;//
;//
  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  1

;/////////////////////////////////////////////////////////////////////////// 
; BUBBLES
;

instr 1

; INITIALISE   ------------

  iamp      =  ampdb(p4)
  ihz       =  p5
  ihzlo     =  0.8*ihz
  ibw       =  p6
  ibwlo     =  0.8*ibw

; CONTROL RATE ------------
  kamp      linseg    0, 0.003, 0, 0.007, iamp, p3-0.02, iamp, 0.01, 0
; DECLICK 
  khz       linseg    ihzlo, p3, ihz
  kbw       linseg    ibwlo, p3, ibw

; AUDIO RATE   ------------
  ao0       randi     khz, kbw, 0                 ; NOISE SOURCE
  ao1       oscil     kamp, ao0, 1

; SEND IT OUT
            out       ao1

endin

;/////////////////////////////////////////////////////////////////////////// 
; PING
;

instr 2
  iamp      =  ampdb(p4)
  ihz       =  p5
  ihzlo     =  0.8*ihz
  ibw       =  p6
  ibwlo     =  0.5*ibw

; CONTROL RATE ------------
  kamp      linseg    0, 0.01, iamp, 0.9, 0       ; DECLICK 
  khz       linseg    ihzlo, p3, ihz
  kbw       linseg    ibw, p3, ibwlo

; AUDIO RATE   ------------
  ao0       randi     80, kbw, 0                  ; NOISE SOURCE
  ao1       oscil     kamp, khz+ao0, 1

; SEND IT OUT
            out       ao1

endin

;/////////////////////////////////////////////////////////////////////////// 
; CALLING
;

instr 3
  iamp      =  ampdb(p4)
  ihz       =  p5
  ihzlo     =  0.5*ihz
  ibw       =  p6
  ibwlo     =  0.5*ibw

; CONTROL RATE ------------
  kamp      expseg    1, 0.01, iamp, p3-0.01, 1   ; DECLICK 
  khz       expseg    100, 0.1, ihz, p3-0.1, ihzlo
  kbw       linseg    ibwlo, p3, ibw

; AUDIO RATE   ------------
  ao0       rand      kbw                         ; NOISE SOURCE
  ao1       oscili    kamp, khz+ao0, 1
  ao2       reverb    ao1, 0.3, 1
  ao3       delay     ao2*0.9, 0.05, 0    
  ao4       delay     ao3*0.6, 0.9, 0     
  ao5       delay     ao3*0.4, 1.8, 0     
; SEND IT OUT
            out       ao2+ao3+ao4+ao5

endin
