  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
        
;
; A GUITAR SUB OCTAVE GENERATOR BASED ON TYPICAL ANALOG DESIGNS.  BEST USED
; WITH MONOPHONIC INPUTS, AND MIXED WITH ORIGINAL SIGNAL.  (DIRECT SIGNAL
; SOUNDS GOOD ABOUT 2 OR 3 TIMES LOUDER THAN SUB OCTAVE.)
;


instr 1


                                             ; MIGHT WANT TO CHANGE THESE,
                                             ; DEPENDING ON DESIRED MIX
  idlev     =  1.0                                ; LEVEL OF DIRECT GUITAR SIGNAL
  isublev   =  0.3                                ; LEVEL OF SUB OCTAVE SIGNAL

; PROBABLY DON'T NEED TO CHANGE THESE UNLESS SOMETHING SOUNDS WRONG
  istl      =  0.4                                ; SCHMIDTT TRIGGER LEVEL FOR SQUARE WAVE
  iincr     =  sr/8                               ; USED FOR INCREMENTING DIVIDE BY 2 COUNTER





  ain       soundin   "suboct.aif"                ; THE SOUND FILE TO BE PROCESSED


; 700 Hz LPF
  alpf      butterlp  ain,700


  kpwr      rms       alpf


; GENERATE SQUARE WAVE WITH HARD LIMITER FUNCTION WITH AN ADAPTIVE SCHMIDTT
; TRIGGER TO PREVENT TOO MUCH NOISE FROM GLITCHES

  ahigh     table     (alpf-istl*kpwr)/5000+16,2
  alow      table     (-alpf-istl*kpwr)/5000+16,2
  asqr1     samphold  ahigh-alow, ahigh+alow



; A QUICK AND DIRTY DIFFERENTIATOR TO GENERATE AN EDGE TRIGGERED GATE
; FOR THE DIVIDE BY 2 COUNTER

  adela     delay1    asqr1
  agate     =  -asqr1+adela


; USING A DIVIDE BY 2 COUNTER TO GET ONE OCTAVE LOWER (SQUARE WAVE)
; -adel IS LIKE USING Q' ON A D FLIP-FLOP

  aphs      phasor    abs(agate*iincr)
  asub1     table     aphs,1,1
  asub2     tone      asub1,3000
        
; INVERT EVERY OTHER CYCLE OF THE DIRECT SIGNAL TO GET SUB OCTAVE
  asub      =  asub2*ain

  aout      butterlp  asub,600


            out       0.5*(isublev*aout+idlev*ain)

endin
