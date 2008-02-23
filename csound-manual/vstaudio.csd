<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
; Audio out   Audio in    No messages
-odac           -iadc     -d     ;;;RT audio I/O
; For Non-realtime ouput leave only the line below:
; -o vstaudio.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 128
nchnls = 2

; For a PC something like:
;gihandle1 vstinit "c:/vstplugins/cheeze/cheeze machine.dll",1

; On Linux something like: 

;gihandle1 vstinit "/home/andres/src/Transverb.so", 1
gihandle1 vstinit "/home/andres/src/ZR3VST.so", 1
;gihandle1 vstinit "/home/andres/src/soulforce/SoulForceVST.so", 1
;FLpanel "aaa", 1024,800, 130,0
;		vstedit gihandle1
;FLpanelEnd
massign 0,0  ;Send notes on chnl 1 to instrument 10

FLrun

instr 1
ain1 inch 1
;ain1 = 0
ab1 vstaudio gihandle1, ain1 * 0.55

outs ab1, ab1
endin

instr 2
;Uncomment to view the vst editor gui
vstedit gihandle1
vstinfo gihandle1
;vstmidiout gihandle1,192,1,1, 0
turnoff
endin

instr 4
;       instance  kchan  knote  kveloc  kdur
vstnote gihandle1, 1,     p4,    p5,     p3
endin

instr 5
;       instance  kchan  knote  kveloc  kdur
vstparamset gihandle1, p4,    p5
endin

instr 6
;       instance  kchan  knote  kveloc  kdur
vstprogset gihandle1, p4
endin

instr 10
kstatus, kchan, kdata1, kdata2 midiin
printk2 kstatus
printk2 kdata1
ktrig changed kstatus, kchan, kdata1, kdata2

if (ktrig != 0) then
    vstmidiout gihandle1, kstatus, kchan, kdata1, kdata2
endif

endin

</CsInstruments>
<CsScore>
; Real-time performance for 1 hour.
i 1 0 10
;i 10 0 3600 ;Listen to realtime MIDI

i 2 1 1
;           note  veloc
i 4 1 0.5   60     100
i 4 +  .    62     100
i 4 +  .    63     100

i 6 5 1  3



e


</CsScore>
</CsoundSynthesizer>
