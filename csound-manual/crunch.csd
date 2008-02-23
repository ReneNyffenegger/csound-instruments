<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o crunch.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

;orchestra ---------------

  sr =           44100
  kr =            4410
  ksmps =              10
  nchnls =               1

instr 01                  ;an example of a crunch
a1      crunch p4, 0.01
          out a1
          endin


</CsInstruments>
<CsScore>

;score -------------------

   i1 0 1 26000
   e


</CsScore>
</CsoundSynthesizer>
