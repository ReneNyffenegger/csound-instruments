  sr        =  44100
  kr        =  44100
  ksmps     =  1

#include "lpf18.h"

instr 1

;VCO controls
  kamp      init      1
  kcps      init      105

;VCF controls
  kfco      randi     15000, 1.03, .34
  kfco      =  abs(kfco)
  kres      randi     1, .98, .63
  kres      =  abs(kres)
  kdist     randi     3, 1.24,.65
  kdist     =  abs(kdist)

;VCO -> VCF
  avco      vco       kamp,kcps,1,0,1,1           ;saw
$lpf303(avco'aout'kfco'kres'kdist)

;OUTPUT
            out       aout*10000

endin