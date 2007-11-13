sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2


          zakinit 30,30

;----------------------------------------------------------------------------------
; DISK INPUT MONO
;----------------------------------------------------------------------------------
          instr     2401

iamp      =         p4
irate     =         p5
isndin    =         p6
ioutch    =         p7

ain       diskin    isndin, irate
          zaw       ain, ioutch
          outs      ain*iamp, ain*iamp

          endin
       
;----------------------------------------------------------------------------------
; MEDIUM ROOM REVERB
;----------------------------------------------------------------------------------
          instr     2403

idur      =         p3
iamp      =         p4
iinch     =         p5

adel71    init      0
adel11    init      0
adel12    init      0
adel13    init      0
adel31    init      0
adel61    init      0
adel62    init      0

kdclick   linseg    0, .002, iamp, idur-.004, iamp, .002, 0

; INITIALIZE
asig0     zar       iinch
aflt01    butterlp  asig0, 6000               ; PRE-FILTER
aflt02    butterbp  .4*adel71, 1000, 500      ; FEED-BACK FILTER
asum01    =         aflt01+.5*aflt02          ; INITIAL MIX

; DOUBLE NESTED ALL-PASS
asum11    =         adel12-.35*adel11         ; FIRST  INNER FEEDFORWARD
asum12    =         adel13-.45*asum11         ; SECOND INNER FEEDFORWARD
aout11    =         asum12-.25*asum01         ; OUTER FEEDFORWARD
adel11    delay     asum01+.25*aout11, .0047 ; OUTER FEEDBACK
adel12    delay     adel11+.35*asum11, .0083 ; FIRST   INNER FEEDBACK
adel13    delay     asum11+.45*asum12, .022   ; SECOND INNER FEEDBACK

adel21    delay     aout11, .005              ; DELAY 1

; ALL-PASS 1
asub31    =         adel31-.45*adel21         ; FEEDFORWARD
adel31    delay     adel21+.45*asub31,.030    ; FEEDBACK

adel41    delay     asub31, .067              ; DELAY 2
adel51    delay     .4*adel41, .015           ; DELAY 3
aout51    =         aflt01+adel41

; SINGLE NESTED ALL-PASS
asum61    =         adel62-.35*adel61         ; INNER FEEDFORWARD
aout61    =         asum61-.25*aout51         ; OUTER FEEDFORWARD
adel61    delay     aout51+.25*aout61, .0292 ; OUTER FEEDBACK
adel62    delay     adel61+.35*asum61, .0098 ; INNER FEEDBACK

aout      =         .5*aout11+.5*adel41+.5*aout61 ; COMBINE OUTPUTS
     
adel71    delay     aout61, .108                   ; DELAY 4
     
          outs      aout*kdclick, -aout*kdclick    ; FINAL OUTPUT

          endin

;----------------------------------------------------------------------------------
; CLEAR Zac
          instr     2499
          zacl      0,30
          endin

