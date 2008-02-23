<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o loscil3.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 1

; Instrument #1.
instr 1
   kamp = 30000
   ; If you don't know the frequency of your audio file,
   ; set both the kcps and ibas parameters equal to 1.
   kcps = 1
   ifn = 1
   ibas = 1

   a1 loscil3 kamp, kcps, ifn, ibas
   out a1
endin


</CsInstruments>
<CsScore>

; Table #1: an audio file.
; Its table size is deferred,
; and format taken from the soundfile header.
f 1 0 0 1 "beats.aiff" 0 0 0

; Play Instrument #1 for 6 seconds.
; This will loop the drum pattern several times.
i 1 0 6
e


</CsScore>
</CsoundSynthesizer>
