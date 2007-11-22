;-------------------------------------------------------------------
; Tone Wheel Organ with Rotating Speaker rev. 4
; by Hans Mikelson
;-------------------------------------------------------------------
; GEN functions
;-------------------------------------------------------------------
f0  50                                  ; Continue running for midi data input.

; Sine
f1  0 16384 10    1     .02   .01
f2  0 16384 10    1     0     .2    0     .1    0     .05   0     .02 

; Rotating Speaker Filter Envelopes
; Deflectors Removed
f13 0 1024  8     .2    440   .4    72    1     72    .4    440   .2
f14 0 1024  8     .4    320   .6    64    1     256   1     64    .6    320   .4
; With Deflectors
f3  0 1024  8     .95   24    .85   24    1     24    .85   24    1     24    .85   248   .9    72    .8    72    1 72 .8 72 .9 248 .85 24 1 24 .85 24 1 24 .85 24 .95
f4  0 1024  8     .95   48    .85   96    .75   240   .8    64    1     128   1     64    .8    240   .75   96    .85 48 .95

; Distortion Tables
; Slight Distortion
f5  0 8192  8     -.8   336   -.78  800   -.7   5920  .7    800   .78   336   .8
; Heavy Distortion
;f5 4 8192   8 -.8 336 -.76 3000 -.7 1520 .7 3000 .76 336 .8

; Central Shaft Table
f7  0 256   7     0     256   1 

; Score
;-------------------------------------------------------------------
;  Tone Wheel Organ
; Initializes global variables and drawbars.
;       Speed SubFund Sub3rd Fund 2nd 3rd 4th 5th 6th 8th  KeyClick(0-70)  2ndPerc  3rdPerc
i1  0  1      1      8      8      8      0      0      0      0      0      0      0      0      0    
i1  18 1      1      6      8      8      6      0      0      0      0      0      1      1      0    
i1  32 1      1      8      8      5      3      2      4      5      8      8      10     0      0    

; Rotating Speaker start/stop
;ins  sta  dur  speed
i2  0  2      1    
i2  +  2      10   
i2  .  4      1    
i2  .  2      10   
i2  .  2      1    
i2  .  4      10   
i2  .  2      1    
i2  .  2      10   
i2  .  2      1    
i2  .  4      10   
i2  .  2      1    
i2  .  2      10   
i2  .  2      1    
i2  .  4      10   
i2  .  2      1    
i2  .  2      10   
i2  .  2      1    
i2  .  4      10   
i2  .  2      1    
i2  .  2      10   
i2  .  2      1    
i2  .  4      10   

; Rotor Organ Instrument 3 is controlled by MIDI

;   3 Different Rotating Speakers (i6 must be used or it won't reset the organ)
;   Start  Dur   Offset  Sep
i4  0  50.2   .5     .1  
i5  0  50.2   .2     .12 
i6  0  50.2   .6     .095


;Popular Settings (from the Hammond Leslie FAQ)
;      Gospel:               88 8000 008
;      Blues:                88 5324 588
;      Rod Argent (Argent)   88 0000 000
;      Brian Auger:          88 8110 000 2nd Percussion, C3 Vibrato
;      Tom Coster (Santana)  88 8800 000
;      Jesse Crawford        80 0800 000      Setting (theatre organ sound)
;      ELP (Keith Emerson)   88 8000 000
;                            88 8400 080
;      Joey De Francesco     83 8000 000 C3 Vibrato
;      Booker T Jones:       88 8800 000 (1st chorus)
;      (Green Onions)        80 8800 008 (2nd chorus) 2nd Percussion
;      Jon Lord:             88 8000 000 2nd Percussion
;      Matthew Fisher        68 8600 000 2nd Percussion, soft Percussion, short decay (A Whiter Shade of Pale)
;      Jimmy Smith:          88 8000 000 3rd Percussion, C3 Vibrato
;                            84 8848 448
;      Steve Winwood:        88 8888 888
;                            80 0008 888 J.Smith can be heard playing this Errol Garner style registration on Crazy Baby, "Mack the Knife", "Makin' Whoppee".

;------------------------------------------------------
;Hammond Presets ( I messed some of these up a bit so if you have corrections let me know.)
;                                 Standard Voices
;                 Upper Manual                       Lower Manual
;       Key Registration       Name        Key  Registration      
;Name
;       C   -- ---- ---    Cancel          C    -- ---- ---  Cancel
;       C#  00 5320 000    Stopped Flute   C#   00 4545 440  Cello
;       D   00 4432 000    Dulciana        D    00 4432 220  Flute & String
;       D#  00 8740 000    French Horn     D#   00 7373 430  Clarinet
;       E   00 4544 222    Salicional      E    00 4544 222  Salicional
;       F   00 5403 000    Flutes 8' &  Great, no 4' F    00 6644 322 reeds
;       F#  00 4675 300    Oboe Horn       F#   00 5642 200  Open Diaposon
;       G   00 5644 320    Swell           G    00 6845 433  Full Great Diapason
;       G#  00 6876 540    Trumpet         G#   00 8030 000  Tibia Clausa
;       A   32 7645 222    Full Swell      A    42 7866 244  Full Great with 16'
;       A#  1st Group Drawbars Upper       A#   1st Group Drawbars Lower
;       B   2nd Group Drawbars Upper       B    2nd Group Drawbars Lower
;
;                                Theatrical Voices
;               Upper Manual                        Lower Manual
;       Key Registration       Name        Key  Registration      Name
;       C   -- ---- ---    Cancel          C    -- ---- ---  Cancel
;       C#  00 8740 000    French Horn 8'  C#  00 4545 440  Cello 8'
;       D   00 4432 000  Dulciana 8'       D   00 8408 004  Tibias 8' & 2'
;       D#  00 4800 000  Vibraharp 8'      D#  00 8080 840    Clarinet 8'
;       E   00 3800 460                    E   08 8800 880    Novel Solo 8'
;       F   60 8088 000    Theatre Solo 8' F   00 6554 322 Accomp. 16'
;       F#  00 4685 300    Oboe Horn 8'    F#  00 5642 200 Openm Diaposon 8'
;       G   60 8807 006    Full Tibias 16' G   43 5434 334 Full Accomp. 16'                                                                          16'
;       G#  00 6888 654    Trumpet 8'      G#  00 8030 000 Tibia 8'
;       A   76 8878 667    Full Theatre    A   84 7767 666  Bombarde 16' Brass 16'
;       A#  1st Group Drawbars Upper       A#  1st Group Drawbars Lower
;       B   2nd Group Drawbars Upper       B   2nd Group Drawbars Lower


