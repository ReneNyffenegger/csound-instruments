  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


; This instrument is an effect which is sort of a combination of Sheppard 
; tones and flanging. My original thought was to create a flanger that 
; sounds like it is always going in the same direction, instead of 
; oscillating back and forth. It comes out sounding sort of like a chorus 
; effect in most cases. Extreme values generate a weird pitch shifting 
; effect.


; There are 10 delayed versions of a sound which are varied by a sawtooth 
; function. There's a gaussian-like curve that emphasizes each one while it 
; is near the middle, cutting off the transition at the end of the sweep. 
; The rate of the sweeps of the even and odd ones can be set independently 
; so they can be going in different directions or at different rates. 

; Eventually I want to beef this up so you can control the width of the sweep, 
; the speed they move, and their spacing relative to each other. 


instr     1

  isweepe   =  0.1                                ; rate of change of the even delays 
  isweepo   =  -0.1                               ; rate of change of the odd delays 

  iktime    =  1/kr

  asound    soundin   "speech1.aif"


  adel1     oscili    0.05, isweepo, 100
  adel2     oscili    0.05, isweepe, 100, 0.1
  adel3     oscili    0.05, isweepo, 100, 0.2
  adel4     oscili    0.05, isweepe, 100, 0.3
  adel5     oscili    0.05, isweepo, 100, 0.4
  adel6     oscili    0.05, isweepe, 100, 0.5
  adel7     oscili    0.05, isweepo, 100, 0.6
  adel8     oscili    0.05, isweepe, 100, 0.7
  adel9     oscili    0.05, isweepo, 100, 0.8
  adel10    oscili    0.05, isweepe, 100, 0.9

  aspam     delayr    0.05 + iktime
  adelay1   deltapi   adel1 + iktime
  adelay2   deltapi   adel2 +iktime
  adelay3   deltapi   adel3 +iktime
  adelay4   deltapi   adel4 +iktime
  adelay5   deltapi   adel5 +iktime
  adelay    deltap    0.025 +iktime
  adelay6   deltapi   adel6 +iktime
  adelay7   deltapi   adel7 +iktime
  adelay8   deltapi   adel8 +iktime
  adelay9   deltapi   adel9 +iktime
  adelay10  deltapi   adel10 +iktime
            delayw    asound

                    
  aamp1     oscili    adelay1, isweepo, 101
  aamp2     oscili    adelay2, isweepe, 101, 0.1
  aamp3     oscili    adelay3, isweepo, 101, 0.2
  aamp4     oscili    adelay4, isweepe, 101, 0.3
  aamp5     oscili    adelay5, isweepo, 101, 0.4
  aamp6     oscili    adelay6, isweepe, 101, 0.5
  aamp7     oscili    adelay7, isweepo, 101, 0.6
  aamp8     oscili    adelay8, isweepe, 101, 0.7
  aamp9     oscili    adelay9, isweepo, 101, 0.8
  aamp10    oscili    adelay10, isweepe, 101, 0.9 


  atot      =  (adelay + aamp1 + aamp2 + aamp3 + aamp4 + aamp5 + aamp6 + aamp7 + aamp8 + aamp9 + aamp10) 


            out       atot


endin



