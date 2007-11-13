  ; fm instrument with 2 carriers
  ; COMMENT  NORMALLY THIS WOULD BE A MONO INSTRUMENT. THE TWO CARRIER OUTPUTS
  ; ARE SENT TO THE LEFT AND RIGHT CHANNELS IN THIS EXAMPLE ONLY SO THAT THE
  ; OUTPUT OF EACH CARRIER CAN BE HEARD INDIVIDUALLY, IF DESIRED. TO LISTEN TO
  ; THE OUTPUT OF ONLY ONE CARRIERS, USE THE STUDIO HEADPHONES RATHER THAN
  ; LOUDSPEAKERS, AND ADJUST THE LEFT AND RIGHT STEREO HEADPHONE GAIN POTS
  ; TO MUTE ONE OF THE CHANNELS.
  ; p-fields :
  ; p3 = duration ;  p4 = pitch        ;p5  = amplitude   ;p6 = attack time
  ; p7 = decay time  ; p8 = atss       ;p9 = rise function
  ; FM p-fields :
  ; p10  = 1st carrier freq. (*p4)  ;  p11 = 1st mod. freq. (*p4)
  ; p12  = 2nd carrier freq. (*p4)  ;  p13  2nd mod. freq. (*p4)
  ; Modulation index envelope:
  ;  p14 = opening index; p15  = index after p6; p16 = index before p7
  ; Amplitude % for 2nd carrier : p17 = opening ; p18 = after p6 ; p19 = before p7
  ; p20 = attack hardness (1. ord)

  sr = 44100
  kr = 2205
  ksmps = 20
  nchnls = 2

  instr 1
  ipitch = cpspch(p4)
  amp envlpx p5,  p6,  p3,  p7,  p9,  p8,  .005  ; amplitude envelope

  ; Random frequency deviation ( for attack noise)
   iscale =  octcps(ipitch)
   iscale =  (18-iscale) * .1     ; scalar : c4 = 1.,c5 =.9, c3 = 1.1, etc.
  k1 expseg .5*p20,  p20*p6,  .003,  p3,  .002
  k2 expseg 999,  p20*p6,  15
  krandpitch  randi  k1*ipitch ,  k2
  kpitch = ipitch + krandpitch            ; pitch

  ; Fm index:
  k2 expseg p14,p6,p15,p3-(p6+p7),p16,p7,.5*p7

  acar1 foscili amp, kpitch, p10, p11, k2, 100  ; 1st carrier
  acar2 foscili amp, kpitch, p12, p13, k2, 100  ; 2nd carrier
   ; The  2nd carrier usually produces  (usually higher frequencies)
   ; signal "kmix" is an envelope that determines the mix of the 2 carriers
  kmix expseg  p17, p6, p18, p3-(p6+p7), p19, p7, .5*p19

  ;  COMMENT The next four lines are the normal output of this algorithm :
  ;  COMMENT audio  = (kmix * acar2) + ((1-kmix) * acar1)
  ;  COMMENT afilt  reson audio , p21, p22, 1        ; provide a formant
  ;  COMMENT   ;  restore amplitude lost in filtering :
  ;  COMMENT audio balance (.5 * afilt) +( .5 * audio) , audio ; restore gain
  ;  COMMENT out audio
  ; COMMENT The following lines send the output of carrier 1 to the left channel
  ; COMMENT and the output of carrier two to the right channel, so that these
  ; COMMENT two signals can be auditioned independently
  afilt1 reson acar1, p21, p22, 1        ; formant for carrier 1
  afilt2 reson acar2, p21, p22, 1        ; same formant for carrier 2
  audio1 balance (.5 * acar1) +(.5 * afilt1) , acar1
  ;  restore gain to filtered carrier 1 & carrier 2 signals
  audio2 balance (.5 * acar2) +(.5 * afilt2) , acar2
  outs  (1. - kmix) * audio1 , kmix * audio2
  endin

