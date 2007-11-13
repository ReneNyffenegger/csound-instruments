  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

            zakinit   30,30

;----------------------------------------------------------------------------------
; DISK INPUT MONO
;----------------------------------------------------------------------------------
instr     2401

  iamp      =  p4
  irate     =  p5
  isndin    =  p6
  ioutch    =  p7

  ain       diskin    isndin, irate
            zaw       ain, ioutch
            outs      ain*iamp, ain*iamp

endin
       
;----------------------------------------------------------------------------------
; LARGE ROOM REVERB
;----------------------------------------------------------------------------------
instr     2404

  idur      =  p3
  iamp      =  p4
  iinch     =  p5

  aout91    init      0
  adel01    init      0
  adel11    init      0
  adel51    init      0
  adel52    init      0
  adel91    init      0
  adel92    init      0
  adel93    init      0

  kdclick   linseg    0, .002, iamp, idur-.004, iamp, .002, 0

; INITIALIZE
  asig0     zar       iinch
  aflt01    butterlp  asig0, 4000                 ; PRE-FILTER
  aflt02    butterbp  .5*aout91, 1000, 500        ; FEED-BACK FILTER
  asum01    =  aflt01+.5*aflt02                   ; INITIAL MIX

; ALL-PASS 1
  asub01    =  adel01-.3*asum01                   ; FEEDFORWARD
  adel01    delay     asum01+.3*asub01,.008       ; FEEDBACK

; ALL-PASS 2
  asub11    =  adel11-.3*asub01                   ; FEEDFORWARD
  adel11    delay     asub01+.3*asub11,.012       ; FEEDBACK

  adel21    delay     asub11, .004                ; DELAY 1
  adel41    delay     adel21, .017                ; DELAY 2

; SINGLE NESTED ALL-PASS
  asum51    =  adel52-.25*adel51                  ; INNER FEEDFORWARD
  aout51    =  asum51-.5*adel41                   ; OUTER FEEDFORWARD
  adel51    delay     adel41+.5*aout51,   .025    ; OUTER FEEDBACK
  adel52    delay     adel51+.25*asum51, .062     ; INNER FEEDBACK

  adel61    delay     aout51, .031                ; DELAY 3
  adel81    delay     adel61, .003                ; DELAY 4

; DOUBLE NESTED ALL-PASS
  asum91    =  adel92-.25*adel91                  ; FIRST  INNER FEEDFORWARD
  asum92    =  adel93-.25*asum91                  ; SECOND INNER FEEDFORWARD
  aout91    =  asum92-.5*adel81                   ; OUTER FEEDFORWARD
  adel91    delay     adel81+.5*aout91, .120      ; OUTER FEEDBACK
  adel92    delay     adel91+.25*asum91, .076     ; FIRST  INNER FEEDBACK
  adel93    delay     asum91+.25*asum92, .030     ; SECOND INNER FEEDBACK

  aout      =  .8*aout91+.8*adel61+1.5*adel21     ; COMBINE OUTPUTS

            outs      aout*kdclick, -aout*kdclick ; FINAL OUTPUT

endin


;----------------------------------------------------------------------------------
; CLEAR Zac
instr     2499
            zacl      0,30
endin

