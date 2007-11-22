;basic5.orc
; safe version of linseg for aamp.
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  idur      =  abs(p3)
  kpch      =  p5
  ipramp    =  0.01
  i1        =  -1                                 ; PHASE FOR TIED NOTE
  iamp      =  p4                                 ; TIED NOTE STARTS AT SCORE AMP
  iendamp   =  p7                                 ; SLUR TO AMP OF NEXT NOTE
; ENVELOPE CONTROL
  istartlen =  0.05
  iendlen   =  0.05

  ir        tival     
            tigoto    start
  i1        =  0                                  ; FIRST NOTE, RESET PHASE
  iamp      =  0                                  ; SET START AMP
;tighten attack if first note
  istartlen =  0.01
if              p3 < 0 igoto start                ; HELD NOTE, MUST BE A SECOND ONE TO SLUR TO 
  iendamp   =  0                                  ; AND END AMP TO ZERO
start:
  iadjust   =  istartlen + iendlen
if              idur >= iadjust igoto doamp       ; LONG NOTE, WE'RE SAFE ; ADJUST FOR SHORT NOTES:
  istartlen =  idur/2 - 0.0005                    ; DON'T WANT ZERO TIMESPAN 
  iendlen   =  istartlen
  iadjust   =  idur - 0.001                       ; ENSURE ilen != 0 for linseg
doamp:
  ilen      =  idur - iadjust
  amp       linseg    iamp,istartlen,p4,ilen,p4,iendlen,iendamp

; SKIP PITCH RAMP GENERATION IF NOT NEEDED 
if              ir==0 || p6==p5 kgoto slur1
  kpchramp  linseg    p6,ipramp,p5,idur-ipramp,p5 
  kpch      =  kpchramp

slur1:
; p9 SETS PEAK OF EXPRESSION POINT
  aslur     linseg    0,idur/2,p9,idur/2,0        ; EXPRESSION ENVELOPE 
  aamp      =  amp + aslur
  asig      oscili    aamp,kpch,1,i1
            out       asig
endin
