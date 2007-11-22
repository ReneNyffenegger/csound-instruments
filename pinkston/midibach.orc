;MIDIFile playback instrument designed in class on 10-15-2002 RP
;Perf with csound -gWo midibach.wav -F bachinv.mid midibach.orc stupid.sco 

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

  gisine    ftgen     1,0,8192,10,1               ;Sine wave table for foscil

instr 1
  ifn       =  1                                  ;sine
  index     =  4                                  ;brassy
  icar      =  1                                  ;all harmonics
  imod      =  1
  ivibwth   =  .1                                 ;max vib width
  ilfohz    =  100                                ;max vib rate
  icps      cpsmidi                               ;cvt this midinote to cps
  iamp      ampmidi   10000                       ;cvt this midi vel to amp
  kmodwh    midictrl  1,0,1                       ;cc#1 (mod wheel) scaled 0-1
; use the mod wheel to control vib width and rate
  klfo      oscili    ivibwth*kmodwh,ilfohz*kmodwh,gisine
  kvib      =  1+klfo                             ;offset by 1 for use as multiplier
  kamp      linenr    iamp,.01,.5,.01
  kindex    linenr    index,.01,.25,.01
  asig      foscil    kamp,icps*kvib,icar,imod,kindex,gisine
            out       asig
endin