; basic4.orc
; here p7 is the amp of the NEXT note, for us to ramp towards 
; and p8 is amp of previous note, to ramp from. 
; NB how CSound processes these: the final npX, and first ppX vals will be zero 
; p9 is the peak amp (expression)

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
  iendamp   =  p7                                 ; AND RAMPS TO NEXT NOTE
  ir        tival     
            tigoto    start
  i1        =  0                                  ; FIRST NOTE, RESET PHASE
  iamp      =  0                                  ; SET START AMP
  iendamp   =  0                                  ; AND END AMP TO ZERO
start:
; BASE AMPLITUDE RAMP FROM PREVIOUS NOTE TO NEXT NOTE 
  kamp      linseg    iamp,0.02,p4,idur-0.1,p4,0.08,iendamp

; SKIP PITCH RAMP GENERATION IF NOT NEEDED 
if              ir==0 || p6==p5 kgoto slur1
  kpchramp  linseg    p6,ipramp,p5,idur-ipramp,p5 
  kpch      =  kpchramp

slur1:
; p9 SETS PEAK OF EXPRESSION POINT
  kslur     linseg    0,idur/2,p9,idur/2,0        ; EXPRESSION ENVELOPE 
  kamp      =  kamp + kslur
;aamp   =               amp + aslur                     ; CLEAN THIS WAY, NO ZIPPER NOISE
tone:
  asig      oscili    kamp,kpch,1,i1
;asig   oscili  aamp,kpch,1,i1
            out       asig
endin
