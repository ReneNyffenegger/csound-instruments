;sr = 22050
;kr = 22050
  sr        =  44100
  kr        =  44100

  ksmps     =  1

            zakinit   20,20
  nchnls    =  2
            massign   1,1

;modify next 2 lines at your convenience
;turnon 1
            maxalloc  1,1
        
#include "filters.h";load my Moog & TB303 filter models


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 1
; Roland TB-303 bassline emulator /KNOBS (can be automatically activated by the orchestra)
; coded by Josep Mª Comajuncosas , Sept 1997 to August 2000
; gelida@intercom.es
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;it seems necessary to keep the knob controls as a separate instrument to avoid clicks
;this procedure is more expensive but allows new routing possibilities

;knobs are MIDI-controlled. If you use Cakewalk you can get my Studioware pannel
;otherwise use your favourite MIDI controller...

  kfco      ctrl7     1, 1, 0.01, 1
  kres      ctrl7     1, 2, 0.01, 1
  kenvmod   ctrl7     1, 3, 0.01, 1
  kdecay    ctrl7     1, 4, 0.01, 1
  kaccent   ctrl7     1, 5, 0.01, 1
  kdist     ctrl7     1, 6, 0.01, 1
  kpan      ctrl7     1, 7, 0.01, 1


;comment these for faster response
;something wrong with tonek ?
;kfco     tonek kfco,   5
;kres     tonek kres,   5
;kenvmod tonek kenvmod,5
;kdecay  tonek kdecay, 5
;kaccent tonek kaccent,5
;kdist   tonek kdist,  5
;kpan    tonek kpan,   5

            zkw       kfco,   10
            zkw       kres,   11
            zkw       kenvmod,12
            zkw       kdecay, 13
            zkw       kaccent,14
            zkw       kdist,  15
            zkw       kpan,   16

endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 2
; Roland TB-303 bassline emulator /SYNTH
; coded by Josep Mª Comajuncosas , Sept 1997 to August 2000
; gelida@intercom.es
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;My TB303 emulator compared to Rebirth :
;*unlimited polyphony with independent legato & accent for each voice
;*smoother parameter changes (all the controls updated at sample rate)
;*accent,envmod&decay interact in a somewhat different way
;(basically, short notes are more percussive)
;*different accent mechanism (it "remembers" the last state)

;yet to improve : a better interaction between envmod, decay & accent



; initial settings; control the overall character of the sound
  iratio    =  6                                  ; "compression" ratio for the distorter (max. amount of overdrive)
  iportime  =  .06                                ; slide time for legato notes
  iaccw     =  1.25                               ; how much louder are accented notes (>1!)
  imaxamp   =  20000                              ; maximum amplitude. Max 32768 for 16 bit output
  ifade     =  .016                               ; fade-in & fade-out times for the amplitude env.
  iaccdur   =  .3                                 ;.2; duration of the accent sweep envelope
  irt       =  .16                                ; discharge time for the accent envelope
  idectime  =  6                                  ;10   ; max. decay time of the filter envelope
  imindec   =  .16                                ; min. decay time of the filter envelope (>0)


  kfco      zkr       10
  kres      zkr       11
  kenvmod   zkr       12
  kdecay    zkr       13
  kaccent   zkr       14
  kdist     zkr       15
  kpan      zkr       16


; init variables; don´t touch this!
  ipid2     =  .5*3.14159265358979
  inotedur  =  p3
  icps      init      .5*p4                       ;cpspch(p4);adapt this to siut your needs
  iacc      =  p5
  izakacc   =  1
  kacc      zkr       izakacc
  imaxamp   =  imaxamp / iaccw
  itie      tival     
  iacc      =  (itie == 1 ? 0 : iacc)             ; prevent from applying accent to a legato note
  kdist     =  iratio*kdist

; accent routines
;remember previous accent charge
  iremacc   init      i(kacc)
  iremacc   =  (iremacc > 0 ? iremacc : 0.000001)
;accent detector
if iacc == 0 goto noaccent
  kdecay    init      0                           ; accented notes are the shortest ones

  kaccurve  oscil1i   0, 1, iaccdur, 3            ; a fast "woww!" curve to be added to the filter envelope

  kaccurve  =  kaccurve + iremacc                 ;successive accents cause f.cutoff to raise hysterically
;(only in fast sequences, when the accent envelope cannot fully discharge)

            goto      contin

noaccent:
;discharges accent curve
  kaccurve  expon     iremacc, irt, 0.000001

contin:
;store accent charge
            zkw       kaccurve,1


;volume envelope (with legato support)
; Set default amps
  iamp0     init      1
  iamp1     init      (iacc == 0 ? 1 : iaccw)
  iamp2     init      1
  iamp3     init      1

; if not tied, fade in & restart main envelope
if itie == 1 igoto nofadein
  iamp0     init      0.000001
nofadein:

; if not held, fade out
if inotedur < 0 igoto nofadeout
  iamp3     init      0.000001
nofadeout:

; Amplitude envelope
  kamp      expseg    iamp0,ifade,iamp1,abs(inotedur)-2*ifade,iamp2,ifade,iamp3

; Skip rest of initialization on tied note:
            tigoto    tieskip
  
; Init pitch for untied note
  kcps      init      icps
  
; Drift towards target pitch 
  kcps      port      icps, iportime, icps


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;the filter envelope is the most important part of the instrument
;from a perceptual point of view. Also the most difficult to emulate!

;ENVELOPE SETTINGS
; main (filter) envelope - same as expon but hard coded
; decay is only computed at init time for simplicity
  kmeg      expon     1, imindec + (idectime-imindec)*i(kdecay), 0.000001

; filter envelope
;kfco = 50+kfco*((2300-1600*kenvmod)+kmeg*(700+1500*kfco+(1500+kfco*(sr/2-6000))*kenvmod))+iacc*(.3+.7*kfco*kenvmod)*kaccent*kaccurve*2000
  kfco      =  50+kfco*((2300-1600*kenvmod)+kmeg*(700+1500*kfco+(1500+kfco*(44100/2-6000))*kenvmod))+iacc*(.3+.7*kfco*kenvmod)*kaccent*kaccurve*2000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;VCO ; (bandlimited sawtooth/square/pulse wave)
;avco buzz kamp, kcps, sr/(2*kcps), 1 ,0;pulse (great for whistles) 
  avco      vco       kamp,kcps,1,0,1,1           ;saw
;avco vco kamp,kcps,2,.5,1,1;square

; resonant 3-pole LPF w. overdrive
  ifcoft    =  21
  iresft    =  20
$lpf3(avco'aout'kfco'kres'kdist'ifcoft'iresft)

tieskip:
  aout      =  aout*kamp*imaxamp
            outs      sin(ipid2*kpan)*aout, cos(ipid2*kpan)*aout
endin