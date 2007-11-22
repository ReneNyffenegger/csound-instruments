; INTRO.O - A SIMPLE ORCHESTRA WITH ONE INSTRUMENT.  THIS INSTRUMENT 
; CONSISTS OF ONE OSCILLATOR WITH AMPLITUDE DEFINED BY A LINEN STATEMENT

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

; p3           =         DURATION OF A NOTE
; p4           =         MAN AMPLITUDE FOR LINEN STATEMENT
; p5           =         FREQUENCY IN HZ
; p6           =         ATTACK TIME IN SECONDS
; p7           =         DECAY TIME IN SECONDS

instr     1
  k1        linen     p4,p6,p3,p7
  a1        oscili    k1,p5,1
            out       a1
endin
