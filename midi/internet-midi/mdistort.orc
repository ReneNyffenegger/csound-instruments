; COMPUTER MUSIC -- FIRST PROJECT
  nchnls    =  2
  gimaxamp  =  32000

            massign   1,1

;*******************************************************************
instr     1
; A MODULATING DISTORTION INSTRUMENT USING TRANSFER FUNCTIONS
;
;P3 = DURATION
;P4 = AMPLITUDE (1 = FULL VOLUME)
;P5 = FUNDAMENTAL PITCH IN OCT.INT FORMAT
;P6 = TIMBRE CONTROL (1 = FULL TIMBRE AT START)
;P7 = TIMBRE MODULATION FREQUENCY (CPS)
;P8 = TIMBRE MODULATION DEPTH (0 TO 1)

;F2 = XFER FUNCTION
;F3 = VOLUME ADJUSTMENT FOR XFER FUNCTION
;F4 = ENVELOPE RISE FUNCTION
;F5 = COARSE SINE FUNCTION FOR MODULATOR
;F6 = FUNCTION FOR FUNDAMENTAL

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc, 0, .2, .01

;kamp          envlpx    p4, 0.2*p3, p3, 0.7*p3, 4, -.2, .01 
  kamp      envlpx    .5, 0.2*3, 3, .7*3, 4, -.2, .01    
                         ; A NICE SHARP RISE (F4),
                         ; SLOW DECAY ENVELOPE
                         ; WHICH SCALES FINAL OUTPUT


;ktmod         oscil     p8, p7, 5                ;TIMBRE MODULATOR, SINE (COARSE)
  ktmod     oscil     .9, 5, 5

;kfamp         =         p6 * (1 - ktmod) * .5
  kfamp     =  .5 * (1- ktmod) * .5

;aindx         oscil     kfamp, cpspch(p5), 6     ;FUNDAMENTAL (F6), MODULATED,
 ;aindx        oscil     kfamp, cpspch(7.05), 6
  aindx     oscil     kfamp, knote, 6
                                                  ; IS INDEX FOR XFER FUNCTION

  axfer     tablei    aindx, 2, 1, .5, 1          ;TRANSFER FUNCTION (F2)
                         ;  INDEX HAS MAX OF -.5 TO +.5
                         ;  OFFSET = .5, WITH WRAPAROUND
                         ;  OUTPUT HAS MAX OF -1 TO +1


if kfamp  >= .5     kgoto wrap
  ksind     =  kfamp / .5 * ftlen(3)
  kscal     tablei    ksind, 3                    ;FIND SCALING VALUE THAT WILL BRING
            kgoto     putout                      ;  OUTPUT OF XFER ALWAYS -1 TO +1

wrap:
                                             ;IF INDEX IS WRAPPING AROUND,
  kscal     =  1                                  ; IT'S HITTING MAX XFER, SO USE
                                                  ; SCALE OF 1.

putout:
            display   kfamp, 3
            display   kscal, 3
  axnorm    =  axfer / kscal
  asig      =  axnorm * gimaxamp * kamp           ;SCALE FINAL OUTPUT SIGNAL BY ENVELOPE
               ;out      asig
            outs      asig*kgate, asig*kgate
endin



