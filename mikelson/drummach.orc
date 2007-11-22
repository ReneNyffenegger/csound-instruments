  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

; Drum Machine
instr 1

  kstep     init      0

; Sequencer Section
;-------------------------------------------------------------------------
loop1:
;     Read all of the table values.
  kdur      table     kstep, p5
  kdrnum    table     kstep, p6
  kleft     table     kstep, p7
  kright    table     kstep, p8

  kdur1     =  kdur/8                             ; Make the step smaller.

; All of the envelopes want to be outside of the if for some reason.
  kampenv1  linseg    0, .01, p4/2, .04, 0, .01, 0
  kampenv2  expseg    .0001, .01, p4, .04, .01
  kfreqenv  expseg    50,    .01, 200, .08, 50
  kampenv3  expseg    .0001, .01, p4*2,  .08, .01
  kampenv4  linseg    0, .001, 1,  i(kdur1)-.021, 1, .02, 0
  kfreqenv51   expseg   50,    .01, 200, .08, 50
  kfreqenv52   linseg   150,    .01, 1000, .08, 250, .01, 250
  kampenv5  linseg    0, .01, p4,  .08, 0, .01, 0
  kptchenv  linseg    100, .01, 300, .2, 200, .01, 200

  kampenv61 expseg    .01, .01, p4, .2, p4/100, .1, .001
  kampenv62 linseg    1, .1, 10,  .1, .5, .01, 1

; Some of the signal generators must be outside of the if's
  asig4     pluck     p4/2, kptchenv, 50, 2, 4, .8, 3
  asig5     foscil    kampenv61, 30, 1, 6.726, kampenv62, 1

; Switch between the different drums
if (kdrnum != 0) goto next1
        ; HiHat
  aout      rand      kampenv1
            goto      endswitch

next1:
if (kdrnum != 1) goto next2
        ; Dumb Drum
  asig      rand      kampenv2
  afilt     reson     asig, 1000, 100
  aout      balance   afilt, asig
            goto      endswitch

next2:
if (kdrnum != 2) goto next3
        ; Dumb Bass Drum
  asig      rand      kampenv3
  afilt     reson     asig, kfreqenv, kfreqenv/8
  aout      balance   afilt, asig
            goto      endswitch

next3:
if (kdrnum != 3) goto next4
        ; KS Snare
  aout      =  kampenv4*asig4
            goto      endswitch

next4:
if (kdrnum != 4) goto next5
        ; Sorta Cool Knock Sweep Drum
  asig      rand      kampenv5
  afilt1    reson     asig, kfreqenv51, kfreqenv51/8
  afilt2    reson     asig, kfreqenv52, kfreqenv52/4
  aout1     balance   afilt1, asig
  aout2     balance   afilt2, asig
  aout      =  (aout1+aout2)/2
            goto      endswitch

next5:
if (kdrnum != 5) goto endswitch
        ; FM Metal Boink Drum
  aout      =  asig5


endswitch:
;     When the time runs out go to the next step of the sequence and reinitialize the envelopes.
            timout    0, i(kdur1), cont1
  kstep     =  frac((kstep + 1)/8)*8
            reinit    loop1

cont1:

            outs      aout*kleft, aout*kright

endin

; Figure out your drums down here.  Then move envelopes into the envelope
; section and the rest into the switch section of the drum machine.
instr 2

; Dumb Drum 1
  kampenv   expseg    .0001, .01, p4, .04, .01
  asig      rand      kampenv
  afilt     reson     asig, 1000, 100
  aout      balance   afilt, asig
            outs      aout, aout

endin

instr 3

; Dumb Bass Drum
  kfreqenv  expseg    50,    .01, 200, .08, 50
  kampenv   expseg    .0001, .01, p4,  .08, .01
  asig      rand      kampenv
  afilt     reson     asig, kfreqenv, kfreqenv/8
  aout      balance   afilt, asig
            outs      aout, aout

endin

instr 4

; KS Snare Drum
  kampenv4  linseg    0, .001, 1,  p3-.021, 1, .02, 0
  kptchenv  linseg    100, .01, 300, .2, 200, .01, 200
  asig      pluck     p4, kptchenv, 50, 2, 4, .8, 3
  aout      =  kampenv4*asig
            outs      aout, aout

endin

instr 5

; Sorta Cool Knock Sweep Drum
  kfreqenv41   expseg   50,    .01, 200, .08, 50
  kfreqenv42   linseg   150,    .01, 1000, .08, 250
  kampenv4  linseg    0, .01, p4,  .08, 0, .01, 0
  asig      rand      kampenv4
  afilt1    reson     asig, kfreqenv41, kfreqenv41/8
  afilt2    reson     asig, kfreqenv42, kfreqenv42/4
  aout1     balance   afilt1, asig
  aout2     balance   afilt2, asig
            outs      (aout1+aout2)/2, (aout1+aout2)/2

endin

instr 6

; FM Metal Boink Drum
  kampenv61 expseg    .01, .01, p4, .2, p4/100, .1, .001
  kampenv62 linseg    1, .1, 10,  .1, .5, .01, 1

  asig      foscil    kampenv61, 30, 1, 6.726, kampenv62, 1
            outs      asig, asig

endin
