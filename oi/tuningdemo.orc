  sr        =  44100
  kr        =  4410
  ksmps     =  10
                
;macro includes
#include"PITCHC~1.TXT"  ;pitch converters

;other includes go here
#include"TUNING~1.TXT"  ;the tuning proclaimer
#include"MODEPR~1.TXT"  ;the mode proclaimer
#include"CHORDP~1.TXT"  ;the chord proclaimer


;instrument macros


instr 70                ;a simple plucked string sound, our monochord
$getPitch(p5)

  axcite    linseg    0,.1,1,.1,0,p3,0
  astring   wgpluck   icps, ampdb(p4), 1/5, 1/7, 10, 1000, axcite
  kdclk     linseg    0,.005,0,.01,1,p3-.026,1,.01,0,.001,0
            out       astring*kdclk

endin

