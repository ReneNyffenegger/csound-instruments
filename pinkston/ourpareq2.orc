;===============================================
; Simple mono 4-band parametric EQ instrument
; Uses 4 pareq units in series
; Designed in class 10/10/06
; Modified by RP 10/11/06
;===============================================
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   1       ;a 4-band parametric EQ
;---Initialization Section
  igain     =  p4                                 ;overall gain control
  isound    =  p5                                 ;name of input sound file
  ilowC     =  p6                                 ;low shelf corner freq
  ilowV     =  ampdb(p7)                          ;boost/cut in dB
  ilowQ     =  p8                                 ;low shelf Q
  ilowBP    =  p9                                 ;low shelf bypass switch
  imid1C    =  p10                                ;midband1 Center Freq
  imid1V    =  ampdb(p11)                         ;boost/cut in dB
  imid1Q    =  p12                                ;midband1 Q
  imid1BP   =  p13                                ;midband1 bypass switch
  imid2C    =  p14                                ;midband2 Center Freq
  imid2V    =  ampdb(p15)                         ;boost/cut in dB
  imid2Q    =  p16                                ;midband2 Q
  imid2BP   =  p17                                ;midband2 bypass switch
  ihighC    =  p18                                ;high shelf corner freq
  ihighV    =  ampdb(p19)                         ;boost/cut in dB
  ihighQ    =  p20                                ;high shelf Q
  ihighBP   =  p21                                ;high shelf bypass switch
  ibalBP    =  p22                                ;balance bypass switch
;---Performance Section
  ainput    soundin   isound
  ainput    linen     ainput,.01,p3,.49
  ainput    =  ainput*igain                       ;scale the input
  asound    =  ainput                             ;copy for the filters
;low section
if      (ilowBP > 0) goto mid1                    ;skip if low shelf bypassed
  asound    pareq     asound,ilowC,ilowV,ilowQ,1  ;low shelving
mid1:
if      (imid1BP > 0) goto mid2                   ;skip if mid1 bypassed
  asound    pareq     asound,imid1C,imid1V,imid1Q,0 ;peaking
mid2:
if      (imid2BP > 0) goto high                   ;skip if mid2 bypassed
  asound    pareq     asound,imid2C,imid2V,imid2Q,0 ;peaking 2
high:
if      (ihighBP > 0) goto bal                    ;skip if high shelf bypassed
  asound    pareq     asound,ihighC,ihighV,ihighQ,2 ;high shelving
bal:
if      (ibalBP > 0) goto end                     ;skip if not balancing
  asound    balance   asound,ainput               ;balance with input
end:
            out       asound
endin