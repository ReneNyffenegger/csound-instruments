<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o stix.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

;orchestra ---------------

  sr =           44100
  kr =            4410
  ksmps =              10
  nchnls =               1

instr 01                  ;an example of stix
  a1      line 20, p3, 20                           ;preset amplitude increase
  a2      stix p4, 0.01   ;stix needs a little amp help at these settings
  a3      product a1, a2                               ;increase amplitude
          out a3
          endin


</CsInstruments>
<CsScore>

;score -------------------

   i1 0 1 26000
   e


</CsScore>
</CsoundSynthesizer>
