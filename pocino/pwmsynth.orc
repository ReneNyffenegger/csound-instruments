  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


; A SIMULATION OF AN ANALOG SYNTHESIZER WITH A PULSE WAVE OSCILLATOR
; AND A SAWTOOTH OSCILLATOR



instr 1
                                        
  ilforate  =  2.3                                ; LFO SPEED IN Hz
  isawlvl   =  0.5                                ; LEVEL OF SAWTOOTH WAVEFORM
  ipwmlvl   =  0.5                                ; LEVEL OF PULSE WAVEFORM
  ipwm      =  0.2                                ; DC OFFSET OF PULSE width
  ipwmlfo   =  0.1                                ; DEPTH OF PULSE WIDTH MODULATION
  ivcffrq   =  800                                ; CUTOFF OF GLOBAL LOW PASS FILTER
  ienvflt   =  200                                ; MAX CHANGE IN LPF CUTOFF BY ENVELOPE
  ikbdflt   =  0.1                                ; RELATIVE CHANGE IN LPF CUTOFF TO PITCH
  iatt      =  0.2                                ; ATTACK LENGTH COMPARED TO NOTE DURATION
  idec      =  0.1                                ; DECAY LENGTH COMPARED TO NOTE DURATION
  isus      =  0.8                                ; SUSTAIN LEVEL (1 IS FULL STRENGTH)
  irel      =  0.2                                ; RELEASE LENGTH COMPARED TO NOTE DURATION
  isteady   =  1-(iatt+idec+irel)                 ; LENGTH OF SUSTAIN LEVEL
;
; The Oscillators
;


  klfo      oscil     1, ilforate, 1              ; GENERATE LFO

  asaw      oscili    1, p5, 3                    ; GENERATE SAWTOOTH


  apwm      table     asaw/2+(klfo*ipwmlfo+ipwm),4,1,0.5 



  awaves    =  isawlvl*asaw+ipwmlvl*apwm          ; MIX THE WAVEFORMS


;
; THE ENVELOPE
;

  kenv      linseg    0,iatt*p3,1,idec*p3,isus,isteady*p3,isus,irel*p3,0


;
; THE FILTERS
;


  klpfcut   =  ivcffrq+p5*ikbdflt+ienvflt*kenv

  alpf      butterlp  awaves, klpfcut



  aout      =  p4*kenv*alpf 

            out       aout

endin
