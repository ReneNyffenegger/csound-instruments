  sr        =  48000
  kr        =  240
  ksmps     =  200
  nchnls    =  2


;************ midi slider initialization *************
  gk1       init      -.01                        ;1-voice1 transposition offset 
  gk3       init      0                           ;3-voice1 transposition range 
  gk11      init      .1                          ;11-harmonizer delay offset
  gk12      init      1                           ;12-speed of pitch changes
  gk13      init      5                           ;13-portamento time of pitch changes
  gk15      init      2                           ;15-phasor frequency
  gk16      init      .1                          ;16-main volume

  gaOut1    init      0
  gaOut2    init      0
  gaOffset  init      0

#define main #1#
#define shifter #2#
#define pitch #3#
#define controllers #100#


;//////////////////////////////////////////
instr   $main
;//////////////////////////////////////////
            call      $controllers ,0,p3

  abutta    delayr    25
  ain, ai2  ins       
;kenv   oscili  5000,.2,5
;ain    oscili  kenv,100,6

  k15       tonek     gk15, .5

;-------- voice 1 ------------------
            call      $pitch,0,p3,.3, 1           ;** iarg: random seed, speed of changes ratio
            rtrnck    kpitch                      ;** return pitch
            call      $shifter,0,p3,.3            ;** iarg: pan position
            parmck    kpitch,k15
;-------- voice 2 ------------------
            call      $pitch,0,p3,.2, .5
            rtrnck    kpitch  
            call      $shifter,0,p3,0
            parmck    kpitch,k15
;-------- voice 3 ------------------
            call      $pitch,0,p3,.3, .25
            rtrnck    kpitch  
            call      $shifter,0,p3,1
            parmck    kpitch,k15
;-------- voice 4 ------------------
            call      $pitch,0,p3,.4,.125
            rtrnck    kpitch  
            call      $shifter,0,p3,.8
            parmck    kpitch,k15
;-----------------------------------
            delayw    ain
            outs      (gaOut1 + ain * .5)* gk16, (gaOut2 + ain * .5) * gk16
            clear     gaOut1,gaOut2




endin



;** this subroutine outputs the shifted signal
;//////////////////////////////////////////
instr   $shifter
;//////////////////////////////////////////
            parmtk    krnd1,k15
  arnd1     interp    krnd1
  a15       interp    k15     
  aphfrq    =  (1-arnd1) /a15 
  amod1     phasor    aphfrq 
  avol1     tablei    amod1,2,1 
  amod1b    phasor    aphfrq ,.5
  avol1b    tablei    amod1b,2,1

  a1        deltapi   amod1  * a15 + gaOffset
  a1b       deltapi   amod1b * a15 + gaOffset
  a1        =  a1  * avol1
  a1b       =  a1b * avol1b
  aout1     =  (a1+a1b) * (1+(1-arnd1)*.35)       ;** reduces high pitches volume
            vincr     gaOut1, aout1 * p4          ;** return values 
            vincr     gaOut2, aout1 * (1-p4)
endin



;** this subroutine generates pitch ratios
;//////////////////////////////////////////
instr   $pitch
;//////////////////////////////////////////
  krnd1     randh     .5, gk12*p5,p4
  krnd1     =  (krnd1+.5) * gk3 + gk1 
  krnd1     table     krnd1,50,1,.5
  krnd1     tonek     krnd1, gk13
            rtrntk    krnd1
endin


;//////////////////////////////////////////
instr   $controllers
;//////////////////////////////////////////

; **** min and max settings for each slider
  i1min     init      -.5                         ;1-voice1 transposition offset 
  i1max     init      .5      
  i3min     init      0                           ;3-voice1 transposition range 
  i3max     init      .5      
  i11min    init      .01                         ;11-harmonizer delay offset
  i11max    init      2
  i12min    init      .25                         ;12-speed of pitch changes
  i12max    init      12
  i13min    init      .1                          ;13-portamento time
  i13max    init      100
  i15min    init      .02                         ;15-phasor freq
  i15max    init      10
  i16min    init      .1                          ;16-main volume
  i16max    init      2



;************ midi sliders initialization *************
  gk1       init      -.01                        ;1-voice1 transposition offset 
  gk3       init      0                           ;3-voice1 transposition range 
  gk11      init      .1                          ;11-harmonizer delay offset
  gk12      init      1                           ;12-speed of pitch changes
  gk13      init      5                           ;13-portamento time of pitch changes
  gk15      init      2                           ;15-phasor frequency
  gk16      init      .1                          ;16-main volume

;******  initialization
;******  ivalue = (initial_value - min) / (max - min)
            initc7    1,1,(i(gk1)-i1min)/(i1max-i1min)
            initc7    1,3,(i(gk3)-i3min)/(i3max-i3min)
            initc7    1,11,(i(gk11)-i11min)/(i11max-i11min)
            initc7    1,12,(i(gk12)-i12min)/(i12max-i12min)
            initc7    1,13,(i(gk13)-i13min)/(i13max-i13min)
            initc7    1,15,(i(gk15)-i15min)/(i15max-i15min)
            initc7    1,16,(i(gk16)-i16min)/(i16max-i16min)

;******  16 sliders midi take control of various parameters
  gk1       ctrl7     1,1,i1min,i1max             ; all MIDI sliders output channel 0
  gk3       ctrl7     1,3,i3min,i3max
  gk11      ctrl7     1,11,i11min,i11max      
  gk12      ctrl7     1,12,i12min,i12max      
  gk13      ctrl7     1,13,i13min,i13max,3
  gk15      ctrl7     1,15,i15min,i15max,3    
  gk16      ctrl7     1,16,i16min,i16max

  gk11      tonek     gk11, .5
  gaOffset  interp    gk11    
;gaOffset       tone    aoffset, .5
endin

