
; FLUTE INSTRUMENT BASED ON PERRY COOK'S SLIDE FLUTE

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1


          instr     1902

aflute1   init      0
ifqc      =         cpspch(p5)
ipress    =         p6
ibreath   =         p7
ifeedbk1  =         p8
ifeedbk2  =         p9

; FLOW SETUP
kenv1     linseg    0, .06, 1.1*ipress, .2, ipress, p3-.16, ipress, .02, 0 
kenv2     linseg    0, .01, 1, p3-.02, 1, .01, 0
kenvibr   linseg    0, .5, 0, .5, 1, p3-1, 1 ; VIBRATO ENVELOPE

; THE VALUES MUST BE APPROXIMATELY -1 TO 1 OR THE CUBIC WILL BLOW UP
aflow1    rand      kenv1
kvibr     oscil     .1*kenvibr, 5, 3

; ibreath CAN BE USED TO ADJUST THE NOISE LEVEL
asum1     =         ibreath*aflow1 + kenv1 + kvibr
asum2     =         asum1 + aflute1*ifeedbk1

afqc      =         1/ifqc - asum1/20000 -9/sr + ifqc/12000000

; EMBOUCHURE DELAY SHOULD BE 1/2 THE BORE DELAY
; ax      delay     asum2, (1/ifqc-10/sr)/2
atemp1    delayr    1/ifqc/2
ax        deltapi   afqc/2                   ; - asum1/ifqc/10 + 1/1000
          delayw    asum2
                              
apoly     =         ax - ax*ax*ax
asum3     =         apoly + aflute1*ifeedbk2

avalue    tone      asum3, 2000

; BORE, THE BORE LENGTH DETERMINES PITCH.  SHORTER IS HIGHER PITCH
atemp2    delayr    1/ifqc
aflute1   deltapi   afqc
          delayw    avalue

          out       avalue*p4*kenv2

          endin

