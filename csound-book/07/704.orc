  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   704             
  idur      =  abs(p3)                            ; MAIN INIT BLOCK
  idovib    =  1       
  i2        =  -1                                 ; VIBRATO PHASE
  irise     =  idur*p9                            ; p9 PROPORTIONAL, 0 < p9 < 1
  ifall     =  idur-irise      
  ipch1     =  cpspch(p6)      
  ipch2     =  cpspch(p5)      
  kpch      =  ipch2   
  iport     =  0.1                                ; 100msec PORTAMENTO
  iatt      =  0.05                               ; DEFAULT DURS FOR AMPLITUDE RAMPS
  idec      =  0.05                               ; ASSUME THIS IS A TIED NOTE:
  iamp      =  p4                                 ; SO START AT p4 LEVEL...
  i1        =  -1                                 ; ... AND KEEP PHASE CONTINUITY
  ir        tival                                 ;  CONDITIONAL INIT BLOCK:TIED NOTE?
            tigoto    start    
  i1        =  0                                  ; FIRST NOTE: RESET PHASE
  i2        =  0.25                               ; VIB STARTS WITH COSINE PHASE
  iamp      =  0                                  ; AND ZERO iamp
start:                  
  iadjust   =  iatt+idec       
if              idur >= iadjust igoto doamp       ; ADJUST RAMP DURATIONS FOR SHORT...
  iatt      =  idur/2-0.005                       ; ... NOTES, 10msecs LIMIT
  idec      =  iatt                               ; ENSURE NO ZERO-DUR SEGMENTS
  iadjust   =  idur-0.01        
  iport     =  0.005                              ; MAKE AMPLITUDE RAMP...
  idovib    =  0       
doamp:
                                                                ; ... (arate FOR CLEANNESS) AND...
  ilen      =  idur-iadjust                       ; ... SKIP PITCH RAMP GENERATION...
  amp       linseg    iamp, iatt, p4, ilen, p4, idec, p7
if              ir == 0 || p6 == p5 kgoto slur    ; ...IF FIRST NOTE OR TIE.
; MAKE PITCH RAMP, PORTAMENTO AT START OF NOTE
  kpramp    linseg    ipch1, iport, ipch2, idur-iport, ipch2
  kpch      =  kpramp  
slur:
                                                                ; MAKE THE NOTE
  aslur     linseg    0, irise, p8, ifall, 0      ; p8 = AMPLITUDE OF SWELL
if              idovib = 0 goto slur1             ; SKIP VIBRATO IF SHORT NOTE
  avib      oscili    0.5, 4.5, 2, i2             ; MED SPEED, ASSUME SINE FOR f2
  avib      =  avib+0.5                           ; OFFSET SO RANGE = 0...1
  aslur     =  aslur*avib                         ; APPLY VIBRATO TO SWELL
slur1:                  
  aamp      =  amp+aslur       
  asig      oscili    aamp, kpch, 1, i1       
            out       asig    
endin
