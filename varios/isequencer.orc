;FROM: E.G.NEWTON@ITI.SALFORD.AC.UK
;HERE IS A CSOUND EXAMPLE I WROTE A FE DAYS AGO TO ALLOW NOTE PATTERNS TO BE
;GENERATED FROM WITHIN CSOUND. IT USES F2 TO STORE PARAMETER LISTS WHICH ARE
;THEN TRANSFERED INTO SETTINGS FOR PITCH, DURATION VOLUME AND GATING SPEED.
;IT IS A STRIPPED DOWN VERSION OF A COMPOSITION I PRODUCED USING SAMPLED
;SOUNDS AS WELL, SO PLEASE STICK WITH IT IF IT SOUNDS TO EMPTY! I APOLOGISE
;FOR LACK OF ANY MUSICAL KNOWLEDGE, IT IS THE SEQUENCING IT IS
;DEMONSTRATING. FEEL FREE TO CHANGE THE CODE, AND IF YOU HAVE ANY EXAMPLES
;ALONG SIMILAR LINES PLEASE SEND. ANYWAY HERE IT IS, I HOPE IT WORKS...




; *****************  ORCHESTRA  *****************

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

  gimult    init      3
; I ALWAYS SET VOLUMES TOO LOW SO THIS BOOSTS EVERYTHING



instr          8
  kfade     line      p17, p3, p18
            kgoto     reset                       ; TRANSFER PAST COUNTER INIT ON PASSES
  kc1       =  0                                  ; INIT COUNTERS
  kc2       =  0                                  ; INIT COUNTERS
  kc3       =  0                                  ; INIT COUNTERS
  kc4       =  0                                  ; INIT COUNTERS
reset:
  krfr      table     kc1, p5                     ; READ FREQ COUNTER POSITION
  krvol     table     kc2, p7                     ; USE GEN02
  kdur      table     kc3, p9
  kmisc     table     kc4, p11
  kphs      phasor    1/kdur                      ; KPHS GOES FROM 0>1 OVER NOTE
if (kphs < 0.998)      goto process               ; GOTO PROCESS IF IN NOTE, ELSE..
  kc1       =  kc1 + 1                            ; ADD ONE TO COUNTER
  kc1       =  ( kc1 < p6 ? kc1 : 0 )             ; IF COUNTER PAST LAST, RESET
  kc2       =  kc2 + 1
  kc2       =  ( kc2 < p8 ? kc2 : 0 )
  kc3       =  kc3 + 1
  kc3       =  ( kc3 < p10 ? kc3 : 0 )
  kc4       =  kc4 + 1
  kc4       =  ( kc4 < p12 ? kc4 : 0 )
            reinit    reset                       ; REINIT ALL OSCILS ETC
process:
; NORMAL INSTRUMENT. p3 ref > kdur

  agatea    oscil     1, kmisc, p16
  asig      buzz      1, 100, 150, 1
  kfreq     oscil     1, 1/kdur, p6
  kcf       =  krfr + (kfreq*krfr)
  afilt     reson     asig, kcf, 35
  asig      balance   afilt, asig
  krvol     =  ampdb(krvol)
  asig      =  asig * agatea * krvol * kfade * p4
            out       asig * gimult
endin
