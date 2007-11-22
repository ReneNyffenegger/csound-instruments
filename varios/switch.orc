


; Steven Grosmark
; NYU Computer Music Studio
; rand-switch.orc

; p4            =               PITCH
; p5            =               MAX AMP
; p6            =               RAND SEED

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  i1        =  1.5                                ; UPPER LIMIT FOR ON/OFF
  i2        =  1.7/i1                             ; CONSTANT FOR LOG
  i3        =  p4                                 ; PITCH
  i4        =  p6                                 ; RAND # SEED
  i5        =  1/p3                               ; FREQ FOR SINE
  i6        =  i3 * .1                            ; DEVIATION

  k1        randi     10,5,i4                     ; FREQ OF ON/OFF SWITCH
  k2        =  abs(k1)                            ; ONLY POSITIVE #'S ALLOWED
  k3        randh     i1,k2,i4                    ; ON/OFF SWITCH
  k4        =  abs(k3)                            ; ONLY POSITIVE #'S
  k5        =  int(k4)                            ; ON FROM 1 -=> i1
  k6        =  k5*((k4-1)*i2)                     ; ON/OFF NOW FROM 0 TO 1.7
  k7        oscili    1,k2,2                      ; ENVELOPE - f2 = 1/2 SINE
  k8        =  k5*k7*p5*(log(k6+1))

; or k9 linseg  1,p3,i6
; or k11        =               i3

  k9        linseg    .1,p3/2,.4,p3/2,.1

  k11       =  i3-(k9*i3)

  a1        oscili    k8,k11,1
            out       a1
endin
