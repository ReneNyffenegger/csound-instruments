  sr        =  44100
  kr        =  44100
  ksmps     =  1
                
;macro includes
#include"PITCHC~1.TXT"  ;pitch converters
#include"SHUTOF~1.TXT"  ;shutoff macros

;other includes go here
#include"TUNING~1.TXT"  ;the tuning proclaimer
#include"MODEPR~1.TXT"  ;the mode proclaimer
#include"CHORDP~1.TXT"  ;the chord proclaimer



instr 60                ;this instrument simply looks at the chord
                        ;channel given in p4 and plays the chord it 
                        ;finds there on instrument 70 (without much
                        ;concern for voicing!).
  idur      =  p3
  ich       =  (p4-1)*13                          ;p4=chord channel to listen to
  ichpop    tablei    ich,4                       ;get the number of components in the chord
  isd1      tablei    ich+1,4                     ;get the 1st pitch in SD form.
  isd2      tablei    ich+2,4                     ;get the 2nd pitch in SD form.
  isd3      tablei    ich+3,4                     ;get the 3rd pitch in SD form.
  isd4      tablei    ich+4,4                     ;get the 4th pitch in SD form.
  isd1      =  -7-(isd1/100)                      ;convert the scalar degrees into 
  isd2      =  -7-(isd2/100)                      ;my generalized notation form.
  isd3      =  -7-(isd3/100)
  isd4      =  -8-(isd4/100)
                                        ;now, schedule the events. Note: because of
                                        ;a peculiarity of "schedule", they must be 
                                        ;given in reverse order.
            schedule  70, 0.015,idur,   isd4
            schedule  70, 0.01, idur,   isd3
            schedule  70, 0.05, idur,   isd2
            schedule  70, 0,    idur,   isd1
$forcedShutoff
endin

instr 70                ;a simple piano sound
$getPitch(p4)

  axcite    linseg    0,.1,1,.1,0,p3,0
  astring   wgpluck   icps, 7000, 1/5, 1/7, 10, 1000, axcite
  aout      integ     astring
  adclk     linseg    0,.005,0,.006,1,p3-.022,1,.01,0,.001,0
            out       astring*adclk
$forcedShutoff
endin