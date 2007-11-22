  sr        =  48000
  kr        =  375
  ksmps     =  128
  nchnls    =  2


;************ midi slider initialization *************
  gk1       init      0                           ;detune amount
  gk3       init      0                           ;
  gk11      init      .1                          ;11-harmonizer delay offset
  gk12      init      1                           ;12-speed of pitch changes
  gk13      init      5                           ;13-portamento time of pitch changes
  gk15      init      2                           ;15-phasor frequency
  gk16      init      .1                          ;16-main volume

  gaOut1    init      0
  gaOut2    init      0
  gaOffset  init      0
  ga15      init      0

#define main #1#
#define shifter #2#
#define controllers #100#

;//////////////////////////////////////////
instr   $main
;//////////////////////////////////////////
;iCONTROL       init    100     
;iSHIFTER       init    2       

            call      $controllers,0,p3

  abutta    delayr    25
  ain, ai2  ins       

  gk15      tonek     gk15, .5
  ga15      interp    gk15

;*** calculate the fixed pitch 


;-------- voice 1 ------------------
            call      $shifter,0,p3,.1            ;** iarg: pan position
            parmck    powoftwo(gk1*1)
;-------- voice 2 ------------------
            call      $shifter,0,p3,.2
            parmck    powoftwo(gk1*2)
;-------- voice 3 ------------------
            call      $shifter,0,p3,.3
            parmck    powoftwo(gk1*3)
;-------- voice 4 ------------------
            call      $shifter,0,p3,.4
            parmck    powoftwo(gk1*4)
;-------- voice 5 ------------------
;       call    $shifter,0,p3,.5        ;** iarg: pan position
;       parmck  powoftwo(gk1*5)
;-------- voice 6 ------------------
;       call    $shifter,0,p3,.6
;       parmck  powoftwo(gk1*6)
;-------- voice 7 ------------------
            call      $shifter,0,p3,1
            parmck    powoftwo(-gk1*1)
;-------- voice 8 ------------------
            call      $shifter,0,p3,.7
            parmck    powoftwo(-gk1*2)
;-------- voice 9 ------------------
            call      $shifter,0,p3,.8            ;** iarg: pan position
            parmck    powoftwo(-gk1*3)
;-------- voice 10 ------------------
            call      $shifter,0,p3,.9
            parmck    powoftwo(-gk1*4)
;-------- voice 11 ------------------
;       call    $shifter,0,p3,1
;       parmck  powoftwo(-gk1*5)
;-------- voice 12 ------------------
;       call    $shifter,0,p3,.75
;       parmck  powoftwo(-gk1*6)
;-------- voice 13 ------------------
;       call    $shifter,0,p3,.85
;       parmck  powoftwo(-gk1*7)
;-------- voice 14 ------------------
;       call    $shifter,0,p3,.65
;       parmck  powoftwo(-gk1*8)
;-------- voice 15 ------------------
;       call    $shifter,0,p3,.25       ;** iarg: pan position
;       parmck  powoftwo(gk1*7)
;-------- voice 16 ------------------
;       call    $shifter,0,p3,.35
;       parmck  powoftwo(gk1*8)


            delayw    ain
            outs      (gaOut1 + ain * .5)* gk16, (gaOut2 + ain * .5) * gk16
            clear     gaOut1,gaOut2
endin




;** this subroutine outputs the shifted signal to the vars gaOut1 and gaOut2
;//////////////////////////////////////////
instr   $shifter
;//////////////////////////////////////////
            parmtk    krnd1
;printk .2,krnd1

  kphfrq    =  (1-krnd1) / ga15 
  amod1     phasor    kphfrq 
  avol1     tablei    amod1,2,1 
  amod1b    phasor    kphfrq ,.5
  avol1b    tablei    amod1b,2,1

  a1        deltapi   amod1  * ga15               ;+ gaOffset
  a1b       deltapi   amod1b * ga15               ;+ gaOffset
  a1        =  a1  * avol1
  a1b       =  a1b * avol1b
  aout1     =  (a1+a1b) * (1+(1-krnd1)*.35)       ;** reduces high pitches volume
            vincr     gaOut1, aout1 * p4          ;** return values 
            vincr     gaOut2, aout1 * (1-p4)
endin



;** this subroutine listen to the MIDI controllers
;//////////////////////////////////////////
instr   $controllers
;//////////////////////////////////////////

; **** min and max settings for each slider
  i1min     init      -.01                        ;Detune amount
  i1max     init      .2      
  i11min    init      .01                         ;11-harmonizer delay offset
  i11max    init      10
  i15min    init      .02                         ;15-phasor freq
  i15max    init      10
  i16min    init      .1                          ;16-main volume
  i16max    init      2

;******  initialization
;******  ivalue = (initial_value - min) / (max - min)
            initc7    1,1,(i(gk1)-i1min)/(i1max-i1min)
            initc7    1,11,(i(gk11)-i11min)/(i11max-i11min)
            initc7    1,15,(i(gk15)-i15min)/(i15max-i15min)
            initc7    1,16,(i(gk16)-i16min)/(i16max-i16min)

;******  16 sliders midi take control of various parameters
  gk1       ctrl7     1,1,i1min,i1max,3
  gk11      ctrl7     1,11,i11min,i11max      
  gk15      ctrl7     1,15,i15min,i15max,3    
  gk16      ctrl7     1,16,i16min,i16max      
endin

