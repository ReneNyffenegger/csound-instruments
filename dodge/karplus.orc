  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;=============================================================================
;               Karplus Strong Algorithm Demonstration                       
;                                                                            
;This is a crude implementation of the Karplus-Strong Plucked String Algorithm
;It simply fills a delay line with noise, then feeds the output through a tone
;filter and back into the delay line.  The pitch produced is determined by the
;length of the delay line, and the "pluck" effect caused by the lowpass filter
;in the feedback loop, which gradually removes the high frequencies from the  
;noise, eventually leaving nothing but the fundamental frequency of the line. 
;Study this to see how the basic algorithm works, but use Pluck in real life. 
;RP                                                                           
;=============================================================================
instr     1
; ROLL YOUR OWN PLUCK INSTRUMENT
  icps      =  cpspch(p5)                         ; DESIRED PITCH IN PCH
  asig      init      0                           ; INITIALIZE ASIG VARIABLE
  kcount    init      1/icps*kr                   ; AND LOOP COUNTER (SEE BELOW)

;---------------------- USE A DELAY LINE OF LENGTH 1/cps:

  adel      delayr    1/icps                      ; DELAY OF 1/cps SECONDS
  asig      tone      adel,sr/2                   ; FILTER THE OUTPUT

;---------------------- BUT AT THE FIRST k, FILL THE DELAY LINE WITH NOISE:

if        (kcount < 0) kgoto continue             ; SKIP OVER AFTER LINE FILLED
kloop:
                                       ; LOOP TO FILL DELAY
  asig      rand      p4,-1                       ; WITH WHITE NOISE
  kcount    =  kcount - 1                         ; DECREMENT LOOP COUNTER
;-----------------------------------------------------------------------------

continue:
            delayw    asig                        ; DELAY LINE INPUT (ALWAYS GET HERE)

if        (kcount   >= 0) kgoto kloop             ; LOOP ONLY KCOUNT TIMES AT START 

            out       asig
endin
