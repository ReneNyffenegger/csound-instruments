;HOWARD FREDRICS
;5-30-93
;
;=====================================================================
;
;
  sr        =  44100
  kr        =  2205   
  ksmps     =  20
  nchnls    =  2
;
;=====================================================================
;
;
;=================================================================
;       Pitch Changing Granular Synthesis Instrument                            
;                                                                
;       p4 = Wave Function 1    p5 = Wave Function 2     p6 = desired pitch in midi (converted to freq of wavereading)                       ;
;       p7 = peak amp p8=attack p9=decay p10 = wavemixer freq in hz                               
;       p11=grainfreq    p12 = vibrate    p13 = vibwidth p14=revtime
;       p15=dry/wetmix (percentage 0-100) p16=tblesize p17=delay time (msec)
;                                                                   
;=================================================================
;
instr         1                             ;1 INSTRUMENTS
  iwave1    =  p4                                 ;SOUNDIN FUNCTION NUMBERS (GEN -1) 
  iwave2    =  p5
  iwavemixer   =      p10                         ;WAVE MIXER FREQ IN HZ
  itblesize =  p16                                ;WAVE TABLE SIZE
;
  itak      =  p8                                 ;ATTACK TIME FOR NOTE
  idec      =  p9                                 ;DECAY TIME
  igrainenv =  15                                 ;GRAIN ENV IS FUNCTION 15
  igrainfreq   =      p11
;
  imidinn   =  p6                                 ;STORE MIDI NN IN VARIABLE FOR LATER USE
  ioctmid   =  3+(imidinn/12)                     ;THEORETICAL FUNDAMENTAL (P5) CONVERTED FROM MIDI NN TO OCT 
  icpswave  =  cpsoct(ioctmid)                    ;THEORETICAL FUNDAMENTAL CONVERTED FROM OCT TO CPS
  icpswave  =  (icpswave*(sr/itblesize))/4        ;CONVERT TO ACTUAL FREQ BASED ON SR/TABLESIZE 
;                                                           ;SO THAT ORC SR CAN BE VARIED
;
  ipkamp    =  p7/2                               ;PEAK 16 BIT AMP FOR TWO WAVES
;
;    
  ivibrate  =  p12
  ivibwidth =  p13/(2*3.14159)                    ;INDEX/2PI
;
  irevtime  =  p14                                ;REV TIME IN SEC
  idrywet   =  p15/100                            ;DRY PERCENTAGE
  idelaytime   =      p17/1000                    ;DELAY TIME IN MS
  idelayfn  =  3
  iloopstart   =      0                           ; initialize loop to 0 (reads p18 at startreinit:)
  iloopend  =  p19
  ilooplen  =  iloopend-iloopstart


;
;                       PERFORMANCE BLOCK
;
  kport     init      1                           ;INITIALIZE PORTAMENTO ENV
  kport     oscil1    itak+(p3-irevtime),1,idec,2 ;SLIGHT RAMP DOWN IN PITCH FOR EACH NOTE'S DECAY     
;
  kgrainfreq   init   igrainfreq                  ;INITIALIZE KGRAINFREQ TO ITIME VALUE
  krand     init      0                           ;INIT FIRST RAND FACTOR TO 0
  krand     randh     kgrainfreq/2,(krand +igrainfreq) ;CHOOSE NEW GRAIN SIZE 1X PER GRAINENV
;
  kgraingate   init   0                           ;INITIALIZE GRAINENV TO 0
  kgraingate   oscili   1,igrainfreq+krand,igrainenv ;GRAINENV IS A QUASI-GAUSIAN ENV WITH FREQ SLIGHTLY RANDOMIZED
;
  kmastergate  linseg   0,itak,1,(p3-irevtime-itak-idec),1,idec,0,irevtime,0 ;FINAL OUTPUT ENVELOPE
  kmodphase init      0                           ;INITIALIZE PHASE
  kmodphs   oscili    ivibwidth,ivibrate,1        ;VIBRATO OSCILATOR
;

;RANDOM DISTRIBUTION OF GRAINS WITHIN WAVETABLE
  kdistribute  init   0
  kdistribute  randh  itblesize, (krand+igrainfreq)

            display   kdistribute, igrainfreq


  awave1phs phasor    cpsoct(octcps(icpswave)+kmodphs)*kport ;MOVING PHASE VALUES FOR WAVESHAPE OSCILS
  awave2phs phasor    cpsoct(octcps(icpswave)+kmodphs)*kport
  kmix      oscili    1,iwavemixer+(krand/10),11  ;PYRAMID WITH RANDOM FREQ VARIATION
  kdelayenv oscil1i   0,kmastergate,p3,idelayfn   ; VARIABLE DELAY ENVELOPE FOR SECOND WAVE
;
  kindex1   init      0
  kindex2   init      0
  kprev1    =  kindex1
  kprev2    =  kindex2
  aindex1   =  (awave1phs*ilooplen)+iloopstart+(kdistribute-ilooplen)
  aindex2   =  (awave2phs*ilooplen)+iloopstart+(kdistribute-ilooplen)
  kindex1   downsamp  aindex1
  kindex2   downsamp  aindex2
            display   kindex1, igrainfreq
;asig1         tablei         awave1phs*itblesize,iwave1,0,0,1        ;CREATE WAVE OUTPUT OSCILLATORS
  asig1     tablei    aindex1,iwave1,0,0,1        ;CREATE WAVE OUTPUT  
  asig2     tablei    aindex2,iwave2,0,0,1        ;CREATE WAVE OUTPUT  
;asig2         tablei         awave2phs*itblesize,iwave2,0,0,1 
  ktempscale1  tablei   kindex1, igrainenv,0,0,1  ;LOOP RAMP FADE ENV
  ktempscale2  tablei   kindex2, igrainenv,0,0,1  ;LOOP RAMP FADE ENV
  kscale1   =  (iloopstart>0 ? ktempscale1:1)  
  kscale2   =  (iloopstart>0 ? ktempscale2:1)  
if             iloopstart > 0 goto noreinit
if        kindex1 >=kprev1    goto noreinit
if        kindex2 >=kprev2    goto noreinit
            reinit    startreinit
startreinit:
   
  iloopstart   =      p18
  ilooplen  =  iloopend-iloopstart 
            rireturn  
  aindex1   =  iloopstart + aindex1+kdistribute       
  aindex2   =  iloopstart + aindex2+kdistribute       
noreinit:
  adeltime  upsamp    kdelayenv*idelaytime
  adump     delayr    idelaytime                  ;        CENTER DELAY TIME
  ad2       deltapi   adeltime
            delayw    asig2
  asig2     =  ad2
  asig      =  kmastergate*(asig1*kmix*(kgraingate*ipkamp)*kscale1) ;SPLIT UP OF CODE INTO TWO LINES (FIXES RT ERROR)
  asig      =  (asig+(kmastergate*(asig2*(1-kmix)*(kgraingate*ipkamp))))
;
  adry      =  asig*idrywet
  arev      reverb    asig*(1-idrywet),irevtime   ;REV SIGNAL
;
  krandpan  randi     1,(igrainfreq+krand)/20     ;QUASI RANDOM PANNING BASED ON GRAIN FREQ
  klfac     =  sqrt(abs(krandpan))
  krfac     =  sqrt(1-(abs(krandpan)))
;
            outs      (adry+arev)*klfac,(adry+arev)*krfac ;output the panned/rev. sigs   
endin



          
