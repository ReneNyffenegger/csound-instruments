;               I think that's page 231.
;               Note how neat the orcestra is.
;               Maybe you won't learn to do feedback.
;               But learn to make tidy orc files!
;               ftable 1 is the original sound
;               Use a speech segment it sounds best!
;               (Don't use a sine wave, you won't the allpass!)


  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   1
  idelay    =  .05
  igain     =  .7
  a2        init      0       
                                                                
  a1        oscil     10000, 1000, 1              ;THIS IS THE INPUT
  a1        =  a1      +       a2 * igain         ;THIS IS THE (+) AFTER THE INPUT AND THE (*<-g) BEFORE THAT
  a2        delay     a1, idelay                  ;THIS IS THE DELAY
            out       a1 * ( - igain) + a2        ;THIS IS THE (*<-(-g)) AND (+) BEFORE OUTPUT
endin
