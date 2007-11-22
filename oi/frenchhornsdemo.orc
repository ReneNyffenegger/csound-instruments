  sr        =  44100
  kr        =  44100
  ksmps     =  1
                
;macro includes
#include"PITCHC~1.TXT"  ;pitch converters
#include"WSFREN~1.TXT"  ;waveshaping French horn 
#include"SUBFRE~1.TXT"  ;sbutractive French horn (pitched source)
#include"SUBFRE~2.TXT"  ;subtractive French horn (noise source)
#include"FOFFRE~1.TXT"  ;fof French horn 
#include"MONOOUT.TXT"   ;monophonic output
#include"CHCLEAR.TXT"   ;channel clearer


;gloabal variables here
;ftgen macros---i don't like putting them here---they could be 
;automatic if ftgens were allowed to appear between instruments
$wsFhornFT

;other includes go here
#include"ZAKINI~1.TXT"  ;the zak initializer
#include"TUNING~1.TXT"  ;the tuning proclaimer
#include"MODEPR~1.TXT"  ;the mode proclaimer




;instrument macros here
$wsFhorn(70)
$subFhorn(71)
$subFhorn2(72)
$fofFhorn(73)
$monoOut(198'0)
$chClear(199)

