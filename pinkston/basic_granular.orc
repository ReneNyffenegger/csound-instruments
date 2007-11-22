

/***************************************************
Simple Granular Synthesis Instruments

Uses a sine wave as the grain to demonstrate various principles

Created by Gregory Cornelius 
October 2006
***************************************************/

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


; synchronous granular instrument without time varying parameters

instr 1

;initialization
  iamp      =  p4
  igfn      =  1                                  ;first table has a sine wave
  iwfn      =  p8
  ipitch    =  cpspch(p5)
  idensity  =  p6
  idur      =  p7
  iampoff   =  p9
  ipitchoff =  p10

;syntax for grain 
;ares grain xamp, xpitch, xdens, kampoff, kpitchoff, kgdur, igfn, iwfn, imgdur [, igrnd]

  ares      grain     iamp, ipitch, idensity, iampoff, ipitchoff, idur, igfn, iwfn, .5, 1 ; synchronous granular synthesis
  aenv      linen     1, .01, p3, .01             ; basic declicking envelope
            outs      ares*aenv, ares*aenv
endin

