  sr        =  22050
  kr        =  2205
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
instr   1                       ; roll your own pluck instrument
  iamp      =  p4      
  icps      =  cpspch(p5)                         ;desired pitch in PCH
  asig      init      0                           ;initialize asig variable
  kcount    init      1/icps*kr                   ;and loop counter (see below)

;---------------------- use a delay line of length 1/cps:

  adel      delayr    1/icps                      ;delay of 1/cps seconds
  asig      tone      adel,sr/2                   ;filter the output

;---------------------- but at the first k, fill the delay line with noise:

if (kcount < 0) kgoto continue                    ;skip over after line filled
kloop:
                                  ;loop to fill delay
  asig      rand      iamp,-1                     ;with white noise
  kcount    =  kcount - 1                         ;decrement loop counter
;-----------------------------------------------------------------------------

continue:
            delayw    asig                        ;delay line input (always get here)

if      (kcount >= 0) kgoto kloop                 ;loop only kcount times at start 

            out       asig
endin

;==================================================================
; Instrument 2 is also a straightforward implementation of K/S. 
; But instead of pre-filling the delay line before the first output, 
; we just inject noise during the first period (1/icps), then let 
; the delay line ring. Sounds almost exactly the same. RP.
;==================================================================

instr   2
  iamp      =  p4
  icps      =  cpspch(p5)                         ;desired pitch in PCH

            timout    1/icps,p3,skipover          ;skip noise generation after 1 cycle
  anoise    rand      iamp
            kgoto     continue
skipover:
  anoise    =  0                                  ;zero noise variable after 1 cycle
continue:

;---------------------- use a delay line of length 1/cps:

  adel      delayr    1/icps                      ;delay of 1/cps seconds
  asig      tone      adel,sr/2                   ;filter the output

            delayw    asig+anoise                 ;feed back asig into delay line

            out       asig
endin

;=================================================================
; This is a more interesting instrument, with additional features.
; It's a variant of instr 2 which excites the line with a noise 
; pulse with variable rise and decay times. This is no longer the 
; genuine "Karplus/Strong Plucked String Algorithm," so purists will 
; probably not wish to use it. ;) But it makes some cool sounds, 
; ranging from quasi-bowed attacks, to a buzzy "jews harp" effects.
; It's also possible to generate sustained sounds, by continuing to
; feed some noise into the system, and to lowpass filter the noise,
; with alters the color of the sound. RP
;=================================================================

instr   3       
  iamp1     =  p4
  icps      =  cpspch(p5)                         ;desired pitch in PCH
  irise     =  p6
  idecay    =  p7
  iamp2     =  (p8 == 0 ? 1 : p8)                 ;amp of sustained noise
  isust     =  (p8 == 0 ? 0 : p3)                 ;dur for sustained noise
  ifc       =  p9                                 ;lowpass cutoff freq
  ifindec   =  (p10 == 0 ? .2 : p10)              ;final decay of overall env

;---------------------- generate the gated noise excitation signal
  agate     expseg    1,irise,iamp1,idecay,iamp2,isust,iamp2
  anoise    rand      agate                       ;gated noise excitation
if      (ifc == 0) goto skip                      ;skip if no filtering wanted
  anoise    butterlp  anoise,ifc                  ;filter the noise
skip:

;---------------------- use a delay line of length 1/cps:

  adel      delayr    1/icps                      ;delay of 1/cps seconds
  asig      tone      adel,sr/2                   ;filter the output

            delayw    asig+anoise                 ;feed back asig into delay line
  asig      linen     asig,.001,p3,ifindec
            out       asig
endin