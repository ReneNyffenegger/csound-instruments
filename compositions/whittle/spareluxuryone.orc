; SL_ONE.ORC   Spare Luxury One
;
; Together with SL_ONE.SCO, this produces a 7 minute 40 sec contemplative
; binarual stereo sound massage. It sounds fine over speakers or headphones.
;
; For a text only description of the binaural model used in this piece,
; see the doco which is at the end of the SL_ONE.SCO file.
; Unfortunately Csound spits the dummy if I include doco of that length in 
; the .ORC file. 
; 
; The code is reasonably self explanatory when this overview is understood.
;
; Based on Spare Luxury 19    20 April 1995
;
; On the IBM, I use the following command line to execute these files.
;
; cs -W -R -d -m7 -oSL_ONE.wav -H e:\cs\SL_ONE.orc e:\cs\SL_ONE.sco
;
; It should display a line for each second of sound it produces.
; Each second could take 90 seconds or so on a 486DX33.  This takes around
; 11 hours to complete, generating an 83 Megabyte 44.1 KHz stereo 
; SL_ONE.WAV file.
;
; If I want to stop it, I hold Ctrl and press Pause (Break).  The next time it
; puts out a one second report line, it terminates.
;
; Then I use the Windows 3.1 Media player (In the Accessories group) to 
; play it.  Alternatively I use the DOS play program which came with the 
; 16 bit stereo sound card. Under DOS or Windows, sound card volume controls 
; are a pain, so I took direct feeds from the 16 Bit DAC chip (via capacitors) 
; and now I don't need to worry about setting the pesky analog mixer or about
; the noise and distortion it generates.  
; 
;-----------------------------------------------------------------------------
                    ;
                    ; Initialisation of orchestra
  sr        =  44100                              ;
  kr        =  4410                               ; Make K rate finer so the doppler works nicely.
  ksmps     =  10                                 ; 
                    ; Tests show that with a single instrument of
                    ; 1, 50, 90 95 and 100, a 486DX33 (running 
                    ; CS.EXE 386 635,390 bytes 13-11-94)
                    ; takes 11.0 seconds to make a second of 
                    ; audio in the A cycles, and 60.3 seconds
                    ; for the K cycles if ksmps = 1.
                    ;
                    ; This is a 5.5:1 K to A CPU load ratio.
                    ;
                    ; ksmps = 7 seems to be a good compromise - 
                    ; this keeps the K rate high for fine spacing 
                    ; and doppler without grain or whilstles.
                    ; The CPU time is 1 + (5.5/7) compared to a 
                    ; very low CPU rate.
                    ;
                    ; Use low sample rate first to determine 
                    ; output scaling requirements.
;    sr = 44100
;    kr =  4410
;    ksmps = 10

  nchnls    =  2
                    ; - - - - - - -
                    ;
                    ; Initalise global variables:

  gidelmax  init      0.3                         ; Maximum delay time for all delays.


  gal       init      0                           ; Left and right head mix accumulators.
  gar       init      0                           ;

  gkhx      init      0                           ; X location of head.
  gkhy      init      0                           ; Y location of head.
  gkha      init      0                           ; Angle of rotation of head 0 - 2pi ACW.

  gkhxl     init      0                           ; X position of left ear.
  gkhyl     init      0                           ; Y position of left ear.
  gkhxr     init      0                           ; X position of right ear.
  gkhyr     init      0                           ; Y position of right ear.
  gkhxf     init      0                           ; X position of front reference point.
  gkhyf     init      0                           ; Y position of front reference point.
  gkhxb     init      0                           ; X position of rear reference point.
  gkhyb     init      0                           ; Y position of rear reference point.

                    ;
                    ; Initialise 16 global audio mixing global 
                    ; variables - gvars.
                    ;    
                    ; Outputs of Major 7th chords
  ga0       init      0         
  ga1       init      0    
  ga2       init      0    
  ga3       init      0    
                    ; Outputs of flangers
  ga4       init      0    
  ga5       init      0    
  ga6       init      0    
  ga7       init      0    

  ga8       init      0    
  ga9       init      0    
  ga10      init      0    
  ga11      init      0    
  ga12      init      0    
  ga13      init      0    
  ga14      init      0    
  ga15      init      0    

;----------------------------------------------------------------------------
;
;                     Details of tables provided by score.
;                     All waveform tables are -1 to +1
;
; Table  1 = 2048 sine
; Table  2 = 16 step "Casio" waveform A Broad spectrum
; Table  3 = 16 step "Casio" waveform B Sine like
; Table  4 = 16 step "Casio" waveform C Narrow pulse
;
; Table 50 = 1024 step linear for rise of envlpx EG




;-----------------------------------------------------------------------------
;
; Instrument 1  Can't get linenr to hold on - tried 0.00001, .01 and .1.
;         Now trying envlpx
;
; An interpolated table waveform instrument.
; Output to one of four gvars ga0 - ga4.
;
; Parm     3   Duration
;     4   Frequency cps
;     5   Volume 
;     6   Table number
;     7   Output channel 0 to 7
;     8   Rise time - linear
;     9   Decay time after note off
;    10   Tremelo period seconds = 1/frequency
;    11   Tremelo depth eg. 0.2 gives .8 to 1.2 volume
;
;-----------------------------------------------------------------------------
                    ;
instr     1         ;
                    ;
  a1        oscili    p5, p4, p6                  ; Basic oscillator.
                    ;
                    ; EG with exponential decay.
                    ;
                    
  kenv      envlpx    1, p8, p3, p9, 50, 1, 0.006   
                    
  klfo      oscil     p11, 1/p10, 1               ; Tremolo depth and frequency, sine table.
                    ;
                    ; Now to decide where the output will go to.
if   p7 == 0 goto out0                            ;
if   p7 == 1 goto out1                            ;
if   p7 == 2 goto out2                            ;
if   p7 == 3 goto out3                            ;
if   p7 == 4 goto out4                            ;
if   p7 == 5 goto out5                            ;
if   p7 == 6 goto out6                            ;
if   p7 == 7 goto out7                            ;

out0:
  ga0       =  ga0 + (a1 * (kenv * (1 + klfo) ) )
            goto      done

out1:
  ga1       =  ga1 + (a1 * (kenv * (1 + klfo) ) )
            goto      done

out2:
  ga2       =  ga2 + (a1 * (kenv * (1 + klfo) ) )
            goto      done

out3:
  ga3       =  ga3 + (a1 * (kenv * (1 + klfo) ) )
            goto      done

out4:
  ga4       =  ga4 + (a1 * (kenv * (1 + klfo) ) )
            goto      done

out5:
  ga5       =  ga5 + (a1 * (kenv * (1 + klfo) ) )
            goto      done

out6:
  ga6       =  ga6 + (a1 * (kenv * (1 + klfo) ) )
            goto      done

out7:
  ga7       =  ga7 + (a1 * (kenv * (1 + klfo) ) )

done:
  k1        =  0                                  ; Dummy - compiler crashes if the label has no
                    ; code to keep it company.


endin



;-----------------------------------------------------------------------------
;
; Instrument 50 Flanger for inputs ga0-3 output = ga4-7
; Modified to get rid of minimum delay stuff.
;
; Parm     4   Delay time Max = 0.1 sec
;     5   Mix level 1 = purely delayed
;     6   Feedback ratio > 1 = feedback
;     7   Period of sine LFO cps
;     8   Deviation from delay time eg. 0.2 => 0.8 to 1.2
;     9   Input channel ga0 to ga3
;    10   Output channel ga4 to ga7
;
;
;-----------------------------------------------------------------------------

instr     50

  adum      delayr    0.1                         ; Maximum delay - don't use output.

                    ; Make an LFO table 1 = sine
                    ; With the range of the parameter 8.
  klfo      oscili    p8, 1/p7, 1

                    ; Get input sound.
if   p9 == 3 goto in3                             ;
if   p9 == 2 goto in2                             ;
if   p9 == 1 goto in1                             ;
                    ;

in0:
  a1        =  ga0 
            goto      done1

in1:
  a1        =  ga1 
            goto      done1

in2:
  a1        =  ga2 
            goto      done1

in3:
  a1        =  ga3 

                    ; Get variable delay sound

done1:
  a2        deltapi   p4 * (1 + klfo)

                    ; Mix output into specified ga4 to ga7.
                    ;
if   p10 == 7 goto out7                           ;
if   p10 == 6 goto out6                           ;
if   p10 == 5 goto out5                           ;
                    ;

out4:
  ga4       =  ga4 + (a1 * (1 - p5) ) + (a2 * p5) 
            goto      done2

out5:
  ga5       =  ga5 + (a1 * (1 - p5) ) + (a2 * p5) 
            goto      done2

out6:
  ga6       =  ga6 + (a1 * (1 - p5) ) + (a2 * p5) 
            goto      done2

out7:
  ga7       =  ga7 + (a1 * (1 - p5) ) + (a2 * p5) 

                    ; Get input from specifed source ga0 to ga3

done2:    
                    ; Write the input signal plus feedback
                    ; value into the delay line.
            delayw    a1 + (a2 * p6)
                    ; End of delay section   
endin





;-----------------------------------------------------------------------------
;
; Instrument 90  Provide X, Y and R for head.
;          Also calculate global variables for position of ears and 
;          reference points.
;
; parm    3    Duration
;    4    Initial X
;    5    Initial Y
;    6    Initial R 0 to 1 anticlockwise
;    7    Final     X
;    8    Final     Y
;    9    Final     R
;
;-----------------------------------------------------------------------------
                    ;
                    ; Since this sets global variables, it can be
                    ; used for one period of time to move the head
                    ; to a particular location, and then the values
                    ; will remain until another instance changes 
                    ; them.  
instr     90
                    ; Create a 0 to 1 ramp for the duration of the
                    ; instrument's time.
                    ;
  kpath     phasor    1/p3
                    ; Use this to interpolate between starting
                    ; and ending values for X, Y and R.
                    ;
                    ; kprem = remainder of what is left of path 
                    ; towards 1.
  kprem     =  1-kpath

  gkhx      =  p4 * kprem + p7 * kpath
  gkhy      =  p5 * kprem + p8 * kpath
  gkhr      =  (p6 * kprem + p9 * kpath) * 6.28318   


                    ; - - - - - 
                    ; 
                    ; Now calculate the X and Y positions of the
                    ; ears and the front and back reference points.
                    ;
                    ; First calculate the X deviation of the right
                    ; ear from the centre of the head. The
                    ; left deviation will be minus this.
                    ; When the head is pointing straight, this 
                    ; will be 0.25.
                    ;
                    ; We need both sin and cos of the head angle
                    ; twice, but it takes the FPU a long time to 
                    ; calculate it, so just do them once and 
                    ; assign them to a variable.
  kksin     =  sin(gkha)
  kkcos     =  cos(gkha)

  kdevxr    =  kkcos * 0.25                          
                    ; Calculate the X location of the left and 
                    ; right ears.
  gkhxl     =  gkhx - kdevxr          
  gkhxr     =  gkhx + kdevxr          
                    ; Now do likewise for Y.

                    ; Right ear goes plus as angle goes ACW, this
                    ; means that the Y deviation increases.
  kdevyr    =  kksin * 0.25                          

  gkhyl     =  gkhy - kdevyr          
  gkhyr     =  gkhy + kdevyr          
                    ; Now do similar for the F and B reference
                    ; points which are 0.209 forward and back of 
                    ; central point between the ears.
                    ;
                    ; 40 degrees from ears. Tan 40 = 0.84
                    ; 0.84 of 0.25 msec is 0.209
                    ;
                    ; This would result in a maximum delay difference
                    ; between the ears and the F or B points of
                    ; 0.325.

  kdevxf    =  kksin * -0.209                        
                    ; kdevxf goes negative (to the left) as the
                    ; head is rotated ACW.
  gkhxf     =  gkhx + kdevxf          
  gkhxb     =  gkhx - kdevxf          
                    ;
  kdevyf    =  kkcos * 0.209 

  gkhyf     =  gkhy + kdevyf          
  gkhyb     =  gkhy - kdevyf          


endin



;-----------------------------------------------------------------------------
;
; Instrument 95 Binaural mix system - Robin Whittle 20 April 1995
;         See also instrument 90 which locates the head.
;         
;         Binaural mix system, uses a gax variable for sound input.
;         Does all other location and mix stuff itself.
;         
;         Super version with differing axes for extra time delay and
;         volume & high frequency gain.
;
;         In addition to the basic binaural time delays, there are 
;         three sets of directionality cues:
;
;         1/ The extra time sound takes to go around the head to the
;            far ear.
;
;         2/ Reduced volume when sound is more than 50 degrees of axis
;            from the forward pointing 40 degree from left/right axis
;            which the ear is assumed to be pointing along.
;            (This is not really required for binarual, or not to a 
;             great degree, it is mainly to enhance the placement when
;             listened to on speakers.) 
;
;         3/ Lowered high frequency response for far ear on the same 
;            axis.
;
;         In the original version of the binaural model, I did these
;         using the axis between the ears - there was no forward to 
;         backwards difference.  Now for each ear, the axis for volume 
;         and frequency response is 40 degrees forward, and the axis for 
;         extra time delay is 40 degrees backwards.
;
;         This is because the outer ear points forwards, but is rear of 
;         the centre of the head.
;
;         In each case the angle is more than would be true of a real
;         head, but I am trying to accentuate the naturally weak 
;         forward to backward cues. 
;
;         This involves calculating distances to two extra points, 
;         tan 40 = 0.84 of an ear distance in front of and 
;         behind the centre of the head (between the ears).
;         The ears are assumed to be 0.25 msec from the centre, so
;         we need points 0.209 in front of and behind the centre.
;         When the sound is on one of these axes, the maximum delay 
;         difference could be .3258 msec. 
;
;         The X,Y postitions of the two ears and the two reference 
;         points are already calculated and available as golbal 
;         variables.
;
;         I don't claim that this approach is unique or optimal, or
;         that it does not infringe any software patents.  If you
;         have fun with it I would really appreciate a copy of your
;         .SCO and .ORC files - to: firstpr@ozemail.com.au or to
;         rwhittle@ozonline.com.au.
;
; parm    3    Duration
;    4    Source - 4, 5, 6 or 7 for ga4 - ga7
;    5    not used
;    6    not used
;    7    not used
;    
;    8    Initial X
;    9    Cyclic    X range
;    10   Cyclic    X time for cosine cycle ACW starting at East
;    11   Cyclic  X - where to start in cycle 0 - 1
;
;    12   Initial Y
;    13   Cyclic    Y range
;    14   Cyclic    Y time for sine cycle ACW starting at East
;    15   Cyclic  Y - where to start in cycle 0 - 1
;
;    16   Initial Z
;    17   Cyclic    Z range
;    18   Cyclic    Z time for sine cycle going up from centre point
;    19   Cyclic  Z - where to start in cycle 0 - 1
;
;-----------------------------------------------------------------------------
                    ;---------------------------------------------
instr     95        ;
                    ;
                    ; Get sound source.
                    ; Select from input ga4 to ga7.
if   p4 == 7 goto in7                             ;
if   p4 == 6 goto in6                             ;
if   p4 == 5 goto in5                             ;
                    ;
in4:
  as        =  ga4 
            goto      done1

in5:
  as        =  ga5
            goto      done1

in6:
  as        =  ga6
            goto      done1

in7:
  as        =  ga7
                    

                    ; Code above here generates an audio source
                    ; in local variable as.
                    ;
                    ;- - - - - - 
                    ;
                    ; Now we need to generate local variables
                    ; kx, ky and kz for the location of this 
                    ; sound source.
                    ;
                    ; Make an LFO table 1 = sine
                    ;
                    ; Adjust starting phases so that an input 
                    ; parameter of 0 will start both X and Y 
                    ; oscillators ready for an anticlockwise
                    ; rotation starting at East (3 o'clock)
                    
done1:
  kx        oscili    p9, 1/p10, 1, (p11 + 0.25)
  kx        =  kx + p8

  ky        oscili    p13, 1/p14, 1, p15
  ky        =  ky + p12

  kz        oscili    p17, 1/p18, 1, p19
  kz        =  kz + p16          
                    ;
                    ; So now we have signal as, at locations
                    ; kx, ky and kz.
                    ;
                    ; The head is at ghx and ghy, but we use the
                    ; X and Y locations of the ears and the 
                    ; reference points which are global 
                    ; variables.
                    ;  
                    ; The head's Z location is 0. 
                    ;
                    ; It is pointing at a direction gha, 0 to 2pi,
                    ; but we don't need that here since the 
                    ; instrument which placed the head also 
                    ; calculated the ear and reference point 
                    ; locations.
                    ;
                    ; X difference in postions between source and
                    ; left ear.  Likewise for other ear and 
                    ; reference points, and for Y as well.
  kdifxl    =  kx - gkhxl
  kdifxr    =  kx - gkhxr        

  kdifxf    =  kx - gkhxf
  kdifxb    =  kx - gkhxb

  kdifyl    =  ky - gkhyl        
  kdifyr    =  ky - gkhyr        

  kdifyf    =  ky - gkhyf
  kdifyb    =  ky - gkhyb
                    ; - - - - - -
                    ;
                    ; Now we want to determine the delay times 
                    ; from the source to the left and right ears, 
                    ; and to the two reference points F and B.
                    ;
                    ; These are in milliseconds, which is the unit 
                    ; of measurement of X, Y and Z.
                    ;
                    ; The head is at Z = 0.
                    ;
                    ; Calculate delay times to left and right
                    ; ears. 
                    ;
                    ; We need the Z difference squared for the 
                    ; following Pythagoras stuff
  kzsq      =  kz * kz

  kdell     =  sqrt ( kdifxl * kdifxl + kdifyl * kdifyl + kzsq)     
  kdelr     =  sqrt ( kdifxr * kdifxr + kdifyr * kdifyr + kzsq)     

                    ; Now do likewise for the front point and the
                    ; back.

  kdelf     =  sqrt ( kdifxf * kdifxf + kdifyf * kdifyf + kzsq)     
  kdelb     =  sqrt ( kdifxb * kdifxb + kdifyb * kdifyb + kzsq)     
                    ;
                    ; All these delays are positive values.
                    ;
                    ; Calculate the delay difference between 
                    ; the left ear and the "F" point, for
                    ; the left's extra delay.
                    ; Positive means left is behind the "F" point
                    ; and therefore the sound is coming from 
                    ; behind the head = from the right, and must 
                    ; have an extra delay added for the left ear
                    ; because of the path around the head.

  kdeldiffl =  kdell - kdelf
                    ; Likewise for right ear.
  kdeldiffr =  kdelr - kdelf

                    ; Calculate the delay difference between 
                    ; the left ear and the "B" point, for
                    ; the left's high frequency gain lobe.
                    ; Positive means left is behind the "B" point
                    ; and therefore the sound is coming from 
                    ; behind the head, and must have its high 
                    ; frequencies attenuated.
  kdeldifbl =  kdell - kdelb
                    ; Likewise for right ear.
  kdeldifbr =  kdelr - kdelb

                    ; - - - - - - 
                    ;    
                    ; Establish a delay line with the maximum 
                    ; length.  Use a dummy variable to keep 
                    ; compiler happy.
  adum      delayr    gidelmax                    ;
                    ; We write the stuff into it later, and
                    ; get stuff out of it with deltapi.
                    ; 
                    ;
                    ; Get the delayed sounds.
                    ;
                    ; Delay time and X, Y, Z coordinates are in 
                    ; milliseconds = feet. Deltap is in seconds.
                    ;
                    ; Simple version:
                    ; aleft    deltapi kdell/1000      
                    ; aright deltapi kdelr/1000   
                    ;
                    ; However we want more subtlety.
                    ;
                    ; Add an additional delay to the furthest 
                    ; ear to simulate the longer path around the 
                    ; head.  At the most, this is the extra
                    ; travel distance around a quarter of a circle
                    ; compared to its radius  = 1 - pi/2 = .57.
                    ; Since the radius is .25 msec, this is .14
                    ; msec.
                    ;
                    ; However I will try for a .25 msec extra
                    ; delay to give a stronger effect.
                    ;
                    ; This only becomes an issue for higher angles
                    ; where the kdeldiffx is above about half
                    ; its maximum.  We want to introduce the
                    ; extra delay smoothly beyond this.
                    ;
                    ; However, we do not want a sudden increase at
                    ; this point - square the difference beyond
                    ; 0.15 and scale to a .25 max.
                    ; This means that the extra delay starts when
                    ; the source is about 63 degrees from the 
                    ; ear -> F axis on the far side of the head,
                    ; and grows rapidly as the angle gets smaller.
                    ;
                    ; Make the CPU costly calculation of 
                    ; delay time happen at the control rate - not 
                    ; audio rate.
  kdeldifftl   =      kdeldiffl - 0.15
  kdeldifftr   =      kdeldiffr - 0.15
                    ; With a 0.325 range in the difference in 
                    ; delay times between ear and F reference 
                    ; point, these values could go to +0.14 when 
                    ; the ear is behind the head from the sound 
                    ; source.
                    ;
                    ; With .325 range, try for a .25 msec
                    ; extra delay  
                    ; .175 * .175 * 8 = .245 msec
               
                    ;       True: False

  aleft     deltapi   (kdell + (kdeldifftl < 0 ? 0: (kdeldifftl * kdeldifftl * 8) ) )/ 1000
  aright    deltapi   (kdelr + (kdeldifftr < 0 ? 0: (kdeldifftr * kdeldifftr * 8) ) )/ 1000

                    ; Note - starting at a delay difference of
                    ; 0.15 implies an angle of 63.5 degrees from 
                    ; the axis, but with little effect at first.
                    ; 
                    ;
                    ; Write the source into the delay line.
                    ; See the Csound manual on how the deltapi
                    ; lines must be sandwiched between the 
                    ; delayr and delayw lines.
            delayw    as             
                    ;
                    ; - - - - - - -
                    ;
                    ; Originally I assumed a 1/(distance squared)
                    ; volume curve, where a 10 foot (10 msec)
                    ; delay gives an equal volume in the ear
                    ; to the source.
                    ;
                    ; The following code does this, and adds a
                    ; minimum distance to each ear (for the 
                    ; purposes of calculating level only)
                    ; of 0.1 feet.  This also avoids a divide by 0
                    ; when the sound source is exactly at the ear.
                    
;aleft    = aleft  * (100 / (kdell * kdell) + 0.01)
;aright   = aright * (100 / (kdelr * kdelr) + 0.01)

                    ; However, I found that the 1/ distance squared
                    ; is severe - like a sound source in 
                    ; empty space with no reverb or floor 
                    ; reflection.
                    ;
                    ; Try to power of 1.5 instead.

  aleft     =  aleft  * (100 / (sqrt (kdell * kdell * kdell) ) + 0.01)
  aright    =  aright * (100 / (sqrt (kdelr * kdelr * kdelr) ) + 0.01)

                    ; Now to process these delayed sounds for 
                    ; the volume and frequency responses of the
                    ; ears.
                    ;
                    ; First the sound will be subject to a gain
                    ; control based on direction. This will be
                    ; stronger than a real binaural mic would
                    ; pick up, but helps create space when listened
                    ; to on loudspeakers.
                    ;
                    ; Then a separate volume function will be 
                    ; performed on the higher frequencies.
                    ;
                    ; We assume a 40 degree from L-R axis for these
                    ; effects, based on a B reference point which
                    ; gives a maximum .325 msec difference in
                    ; delay times from each ear to the B point.
                    ;
                    ; The idea for volume is that +/- 50 degrees
                    ; from this axis, the volume will be normal.
                    ; after that it decreases - down to 0.5 of
                    ; normal when the ear is on the opposite side
                    ; of the head from the sound source.
                    ;
                    ; The latter case will be with kdeldifbx being
                    ; + .325 msec.
                    ;
                    ; At the 50 degree from axis point (one of 
                    ; which co-incides with straight ahead), the
                    ; delay difference will be sin 40 of this.
                    ; 0.643 of -0.325 = -0.209.
                    ; So only delays above this will reduce the
                    ; volume from 1.0 to 0.5.
                    ;
                    ; Save a multiplication and make the range
                    ; beyond this (0.54) equal to change in gain.
                    ;
                    ; True :  False     

  aleft     =  aleft  * (kdeldifbl < -0.209 ? 1 : 0.791 - kdeldifbl )
  aright    =  aright * (kdeldifbr < -0.209 ? 1 : 0.791 - kdeldifbr )

                    ; (For max speed, this could be added to the
                    ; pair of equations above.)
                    ;
                    ; Make the filters get lower when the 
                    ; ear is on the opposite side of the head 
                    ; to the sound.
                    ;
                    ; This lowers the frequency to 60% of the 
                    ; usual.
                    ; Scaled for 0.325 difference.

                    ;True: False

  kfiltl    =  1 - (kdeldifbl < 0.1 ? 0: ((kdeldifbl - 0.1) * 1.78) )
  kfiltr    =  1 - (kdeldifbr < 0.1 ? 0: ((kdeldifbr - 0.1) * 1.78) )


  aleftlow  tone      aleft,     3000 * kfiltl
  aleftlow  tone      aleftlow,  4500 * kfiltl
     
  arightlow tone      aright,    3000 * kfiltr
  arightlow tone      arightlow, 4500 * kfiltr

                    ; Add low frequencies, plus gain adjusted                   ; high freqencies, and accumulate the final 
                    ; sound to the global binaural mix variables.
                    ; 
                    ; Make the gain drop off only when the
                    ; kdeldifx is > 0 and also make it come in 
                    ; rather slowly by squaring it and scaling it
                    ; appropriately.  Go for gain reduction to 
                    ; 0.3, so we want a 0.7 loss when the 
                    ; kdeldifbx is 0.325
                    ;
                    ;                              True : False       
  gal       =  gal + aleftlow  +  (aleft  - aleftlow)  * (kdeldifbl < 0 ? 1 : 1 - kdeldifbl * kdeldifbl * 6.6)   
  gar       =  gar + arightlow +  (aright - arightlow) * (kdeldifbr < 0 ? 1 : 1 - kdeldifbr * kdeldifbr * 6.6)  


endin



;-----------------------------------------------------------------------------
; Instrument 98  Debugging replacement for Binaural mix system, 
;          mixes directly to left and right ears - no binaural stuff - 
;          to speed up debugging of sound sources.
;
; parm    3    Duration
;    4    Source - 4, 5, 6 or 7 for ga4 - ga7
;-----------------------------------------------------------------------------

                    ;---------------------------------------------
instr     98        ;
                    ;
                    ; Get sound source.
                    ; Select from input ga4 to ga7.
if   p4 == 7 goto in7                             ;
if   p4 == 6 goto in6                             ;
if   p4 == 5 goto in5                             ;
                    ;
in4:
  as        =  ga4 
            goto      done1

in5:
  as        =  ga5
            goto      done1

in6:
  as        =  ga6
            goto      done1

in7:
  as        =  ga7

                    ; Code above here generates an audio source
                    ; in local variable as.
                    ;
                    ;- - - - - - 
                    ; Add to the global binaural mix variables.

done1:
  gal       =  gal + as
  gar       =  gar + as


endin

;-----------------------------------------------------------------------------
;
; Instrument 100
;
; Output instrument to mix gal and gar into a stereo mix.
;
; Parm     4   Scale factor
;
;-----------------------------------------------------------------------------
                    ; Must be high instrument number so it is 
                    ; executed last.
instr     100       

                    ; Do the output mixing with 1 LSB of dither and
                    ; a scaling factor for each channel.

  adith     rand      0.5

            outs      gal * p4 + adith, gar * p4 - adith

                    ; Clear global mix variables for next cycle.
  gal       =  0    
  gar       =  0    
                    ; Clear gax for next cycle.
  ga0       =  0    
  ga1       =  0    
  ga2       =  0    
  ga3       =  0    
  ga4       =  0    
  ga5       =  0    
  ga6       =  0    
  ga7       =  0    
;ga8 =    0    
;ga9 =    0    
;ga10     =    0    
;ga11     =    0    
;ga12     =    0    
;ga13     =    0    
;ga14     =    0    
;ga15     =    0    

endin
