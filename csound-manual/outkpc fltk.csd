<CsoundSynthesizer> 
<CsOptions> 
; Select audio/midi flags here according to platform
; No messages Midi in  Midi out  
-m0 -M0 -Q1 -b4096

</CsOptions>
<CsInstruments>

; Initialize the global variables.
sr = 44100
kr = 4410
ksmps = 10
nchnls = 2

; Example by Giorgio Zucco 2007



FLpanel "outkpc",200,100,90,90;start of container
 
gkpg, gihandle FLcount "Midi-Program change",0,127,1,127,1,152,40,16,23,0

FLpanelEnd

FLrun
 
ipg init 0  ;init program change number

; Instrument #1.
instr 1


ifund   notnum 	 
ivel 	   veloc 
idur = 1


outkpc     1,gkpg,0,127

noteondur 	1,ifund,  ivel,idur


endin


</CsInstruments>
<CsScore>
; Play Instrument #1 for 60 seconds.

f0  60


</CsScore>
</CsoundSynthesizer>






