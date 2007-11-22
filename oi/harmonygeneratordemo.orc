  sr        =  44100
  kr        =  4410
  ksmps     =  10
                
;macro includes
#include"PITCHC~1.TXT"  ;pitch converters
#include"SHUTOF~1.TXT"  ;automatic shutoff macros


;other includes go here
#include"ZAKINI~1.TXT"  ;the zak initializer
#include"TUNING~1.TXT"  ;the tuning proclaimer
#include"MODEPR~1.TXT"  ;the mode proclaimer
#include"CHORDP~1.TXT"  ;the chord proclaimer
#include"MELODY~2.TXT"  ;the melody proclaimer
#include"HARMON~1.TXT"  ;the harmony generator




instr 60                ;this instrument simply looks at the chord
                        ;channel given in p4 and plays the chord it 
                        ;finds there on a French horn (without much
                        ;concern for voicing!). The octave is given in p5.
  idur      =  p3
  p3        =  .02
  ich       =  (p4-1)*13                          ;p4=chord channel to listen to
  ichpop    tablei    ich,4                       ;get the number of components in the chord
  isd1      tablei    ich+1,4                     ;get the 1st pitch in SD form.
  isd2      tablei    ich+2,4                     ;get the 2nd pitch in SD form.
  isd3      tablei    ich+3,4                     ;get the 3rd pitch in SD form.
  isd4      tablei    ich+4,4                     ;get the 4th pitch in SD form.

  isd1      =  -(p5)-(isd1/100)                   ;convert the scalar degrees into 
  isd2      =  -(p5)-(isd2/100)                   ;my generalized notation form.
  isd3      =  -(p5)-(isd3/100)
  isd4      =  -(p5+1)-(isd4/100)

                                        ;now, shedule the events. Note: because of
                                        ;a peculiarity of "schedule", they must be 
                                        ;given in reverse order.  Apparently,
                                        ;schedule also adds extra time to a section
                                        ;---I don't know why---f0 solves the problem.
            schedule  70, 0.015,idur,0,   isd4
            schedule  70, 0.01, idur,0,   isd3
            schedule  70, 0.05, idur,0,   isd2
            schedule  70, 0,    idur,0,   isd1
;for some reason, events which have been scheduled must be shutoff.
$forcedShutoff
endin

instr 70                ;a simple plucked sound

$getPitch(p5)

  axcite    linseg    0,.1,1,.1,0,p3-.2,0
  astring   wgpluck   icps, 7000, 1/5, 1/7, 10, 1000,axcite
  kdclk     linseg    0,.005,0,.006,1,p3-.022,1,.01,0,.001,0

            out       astring*kdclk
;for some reason, events which have been scheduled must be shutoff.
$forcedShutoff
endin

instr 71
$getPitch(p5)

            print     p3
  k1        linseg    0,.05,8000,.05,6400,p3-.2,5600,.1,0
  ar        fmb3      k1, icps, .6, 1.2, .2,8, 1,1,1,1,1
            out       ar


;for some reason, events which have been scheduled must be shutoff.
$forcedShutoff
endin