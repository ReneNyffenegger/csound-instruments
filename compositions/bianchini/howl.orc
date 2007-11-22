; howl.orc
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
;---------------------------------------------------------
;         HOWL.ORC
;-------------- INSTRUMENTS -------------------------------
; 1 = SPOKEN VOICE 81=ITS REVERB
; 2 = FLOU
; 3 = WAWA
; 4 = BASSDRUM
; 5 = CYMBALS
; 9 = WHISTLES
; 10= KLANG         90=ITS REVERB
; 11= PERCUSSION    91=ITS REVERB
; 12= TUNED VOICE   81=ITS REVERB
; 18= TABLA
;=========================================================
  ga1       init      0
  ga10      init      0
  ga11      init      0
;---------------------------------------------------------
;      INSTRUMENT 1 VOICE 
;---------------------------------------------------------
instr     1
;p4       =         skiptime
;p5       =         amplitude in dB
;p6       =         function number
;p7       =         stereo position
  iamp      =  ampdb(p5)
  itab      =  p6+10
;AMPLITUDE ENVELOPE FOR LOSCIL
  kenv      linseg    0,.01,0,.01,iamp,p3-.03,0,.01,0
  ifrq      =  p4/.01
;FREQUENCY ENVEOPE FOR LOSCIL
  kfrq      linseg    ifrq, .01, ifrq, .001, 1, p3-.011, 1
  a1        loscil    1,kfrq,itab,1
;modulation generator
  aosc      oscili    1,100+p6*2,1
;RING MODULATION & AMPLITUDE ENVELOPE
  a1        =  a1*aosc*kenv
  ga1       =  ga1+a1
            outs      a1*(1-p7),a1*p7
endin
;---------------------------------------------------------
;         INSTRUMENT 2 FLOU
;---------------------------------------------------------
instr     2
;p4       =         amplitude in dB
;p5       =         pitch (oppc)
;p6       =         stereo position
  ifrq      =  cpspch(p5)
  iamp      =  ampdb(p4)/10
;AMPLITUDE ENVELOPE
  kenv      linseg    0,p3/6,iamp*.3,p3/6,iamp,p3/3,iamp,p3/6,iamp*.3,p3/6,0
;RANDOM VARIATION FOR AMPLITUDESOF OSCILLATORS
  kosc1     randi     .5,2.00,-1
  kosc1     =  kosc1+.5
  kosc2     randi     .5,2.78,-1
  kosc2     =  kosc2+.5
  kosc3     randi     .5,2.54,-1
  kosc3     =  kosc3+.5
  kosc4     randi     .5,2.43,-1
  kosc4     =  kosc4+.5
  kosc5     randi     .5,2.38,-1
  kosc5     =  kosc5+.5
  kosc6     randi     .5,2.27,-1
  kosc6     =  kosc6+.5
  kosc7     randi     .5,2.16,-1
  kosc7     =  kosc7+.5
  kosc8     randi     .5,1.91,-1
  kosc8     =  kosc8+.5
  kosc9     randi     .5,1.87,-1
  kosc9     =  kosc9+.5
  kosc10    randi     .5,1.78,-1
  kosc10    =  kosc10+.5
;SOUND GENERATION
  a1        oscili    kenv*kosc1+.5,ifrq*1,1
  a2        oscili    kenv*kosc2*.9+.5,ifrq*2,1
  a3        oscili    kenv*kosc3*.8+.5,ifrq*3,1
  a4        oscili    kenv*kosc4*.75+.5,ifrq*4,1
  a5        oscili    kenv*kosc5*.7+.5,ifrq*5,1
  a6        oscili    kenv*kosc6*.65+.5,ifrq*6,1
  a7        oscili    kenv*kosc7*.6+.5,ifrq*7,1
  a8        oscili    kenv*kosc8*.55+.5,ifrq*8,1
  a9        oscili    kenv*kosc9*.5+.5,ifrq*9,1
  a10       oscili    kenv*kosc10*.45+.5,ifrq*10,1
;SUM OF GENERATED SOUNDS
  atot      =  a1+a2+a3+a4+a5+a6+a7+a8+a9+a10
            outs      atot*(1-p6),atot*p6
endin
;---------------------------------------------------------
;      INSTRUMENT 3  WAWA 
;---------------------------------------------------------
instr     3
;p6       =         starting stereo position
;p7       =         ending stereo position
;p8       =         starting frequency
;p9       =         ending frequency
;----------- CONVERSIONS oppc/cps & db/amp
  ifrq      =  cpspch(p5)
  iamp      =  ampdb(p4)
  a1        rand      1,-1
  kctramp   line      p8,p3,p9
  kamp      oscil     .3,kctramp,2
  kenv      linseg    0,.01,iamp,p3-.01,0
  a1        =  a1*(kamp+.5)*kenv
  kfrq      line      ifrq,p3,ifrq/2
  a2        reson     a1,kfrq,kfrq/48,2
  kstereo   line      p6,p3,p7
            outs      a2*(1-kstereo),a2*kstereo
endin
;---------------------------------------------------------
;       INSTRUMENT 4 BASSDRUM 
;---------------------------------------------------------
instr     4       
;p4       =         amplitude in dB
;p5       =         pitch (oppc)
;p6       =         stereo position
  ifrq      =  cpspch(p5)
  iamp      =  ampdb(p4)
;RANDOM GENERATOR
  a1        rand      iamp,-1
;FILTER CENTER FREQUENCY CONTROL (FROM ifrq*4 TO ifrq TO 30 CPS)
  kfilt     linseg    ifrq*4,.01,ifrq,p3-.011,30
;AMPLITUDE ENVELOPE
  kenv      linseg    1,p3/3,.3,p3/3,.1,p3/3,0
;BAND PASS FILTERING
  a2        reson     a1,kfilt,kfilt/32,2
  a2        =  a2*kenv
            outs      a2*(1-p6),a2*p6
endin
;---------------------------------------------------------
;      INSTRUMENT 5 CYMBALS 
;---------------------------------------------------------
instr     5
;p4       =         amplitude in dB
;p5       =         pitch (oppc)
;p6       =         stereo position
  ifrq      =  cpspch(p5)
  iamp      =  ampdb(p4)
  kenv      linseg    0,.001,iamp,p3*.1,iamp*.5,p3*.9-.001,0
;FOUR CONTROL SIGNALS, FOR OSCIL AMPS
  krnd1     randi     .001,5,-1
  krnd2     randi     .001,5,-1
  krnd3     randi     .001,5,-1
  krnd4     randi     .001,5,-1
;FOUR OSCILS, SLIGHTLY DETUNED
  a1        oscili    kenv,ifrq*(1+krnd1),1
  a2        oscili    kenv,ifrq*1.005*(1+krnd2),1
  a3        oscili    kenv,ifrq*1.01*(1+krnd3),1
  a4        oscili    kenv,ifrq*1.015*(1+krnd4),1
;SUM OF THE GENERATED SIGNALS
  atot      =  (a1+a2+a3+a4)/4
            outs      atot*(1-p6),atot*p6
endin
;---------------------------------------------------------
;      INSTRUMENT 9  WHISTLES
;---------------------------------------------------------
instr     9    
;p4       =         amplitude in dB
;p5       =         pitch (oppc)
;p6       =         stereo position
  ifrq      =  cpspch(p5)
  iamp      =  ampdb(p4-10)
  kenv      linseg    0,p3/4,iamp,p3/2,iamp,p3/4,0
  krn       randi     1.1,p3/10,-1
  kenv      =  kenv+krn-.55
  a1        oscili    kenv,ifrq,1
  a2        oscili    kenv,ifrq*.98,1
  a3        oscili    kenv,ifrq*1.03,1
  a4        oscili    kenv,ifrq*1.074,1
  aout      =  (a1+a2+a3+a4)/4
            outs      aout*(1-p6),aout*p6
endin
;---------------------------------------------------------
;     INSTRUMENT 10 KLANG
;---------------------------------------------------------
instr     10
;p4       =         amplitude in dB
;p5       =         pitch (oppc)
;p6       =         stereo position
  ifrq      =  cpspch(p5)
  iamp      =  ampdb(p4-10)
  kenv      linseg    0,.005,1,p3/2-.006,.3,p3/2,0,.001,0
;THREE ÒMODULATORSÓ...
  a01       oscili    1,ifrq*.56,1
  a02       oscili    1,ifrq*1.47,1
  a03       oscili    1,ifrq*2.17,1
  k01       linseg    20,.01,10,p3-.01,2
;... CONTROL FREQUENCY OF THIS OSCILLATOR
  a1        oscili    iamp,ifrq*(a01*a02*a03)*k01,1
  ga10      =  ga10 + a1*kenv
            outs      a1*kenv*(1-p6),a1*kenv*p6
endin
;---------------------------------------------------------
;      INSTRUMENT 11 PERCUSSION
;---------------------------------------------------------
instr     11
;p4       =         amplitude in dB
;p5       =         picth (oppc)
;p6       =         stereo position
;p7       =         function number
;p8       =         reverb send
  ifrq      =  cpspch(p5)
  iamp      =  ampdb(p4)
  itab      =  p7
  kenv      linseg    iamp,p3-.1,iamp,.1,0
  a1        loscil    kenv,ifrq,itab,cpspch(8)
if        itab!=21 goto avanti                    ;special case: apply
; REVERB ONLY TO BASSDRUM SOUNDFILE
;A SIMPLE REVERB (BUILT INTO INSTRUMENT; NORMALLY DONÕT DO THAT!)
  arev      reson     a1,300,400,1
  arv1      alpass    arev,6,.112
  arv2      alpass    arev,6,.087
  arv3      alpass    arev,6,.131
  atot      =  arv1+arv2+arv3
  a1        =  a1+atot
avanti:
ok11:
  ga11      =  ga11 + a1*p8
            outs      a1*(1-p6),a1*p6
endin
;---------------------------------------------------------
;      INSTR 12 TUNED VOICE
;---------------------------------------------------------
instr     12
;p4       =         skiptime 
;p5       =         amplitude in dB
;p6       =         table number
;p7       =         stereo position
;p8       =         starting frequency
;p9       =         ending frequency
;p10      =         attack time
;p11      =         release time
  iamp      =  ampdb(p5)
  itab      =  p6+10
            print     itab
  kenv      linseg    0,.01,0,p10,iamp,p3-p10-p11-.01,iamp,p11,0
  ifrq      =  p4/.01
  kfrq      linseg    ifrq, .01, ifrq, .001, p8, p3-.011, p9
  a1        loscil    1,kfrq,itab,1
  aosc      oscili    1,100+p6*2,1
  a1        =  a1*aosc*kenv
  ga1       =  ga1+a1
;         outs      a1*(1-p7),a1*p7
endin
;---------------------------------------------------------
;      INSTRUMENT 13 TUNED PERCUSSION
;---------------------------------------------------------
instr     13
;p4       =         skiptime 
;p5       =         amplitude in dB
;p6       =         stereo position
;p7       =         table number
;p8       =         starting frequency
;p9       =         ending frequency
;p10      =         attack time
;p11      =         release time
  ifrq      =  cpspch(p5)
  iamp      =  ampdb(p4)
  itab      =  p7
  kenv      linseg    0,p10,iamp,p3-p10-p11,iamp,p11,0
  kfrq      linseg    cpspch(p8),p3,cpspch(p9)
  a1        loscil    kenv,kfrq,itab,cpspch(8)
            outs      a1*(1-p6),a1*p6
endin
;---------------------------------------------------------
;         INSTRUMENT 18 TABLA
;---------------------------------------------------------
instr     18
;p6       =         starting modulation index  
;p7       =         ending modulation index  
;p8       =         carrier/modulator frequency ratio
;p9       =         stereo position (if <0, random position)
  ifrq      =  cpspch(p5)
  ioct      =  4.5-octpch(p5)/2
  iamp      =  ampdb(p4)
  ix        =  p6
if        p9 >= 0 goto stereo
  kst       randh     .5,1/p3,-1
  kst       =  kst + .5
            kgoto     donest
stereo:
  kst       =  p9
donest:
  kindx     linseg    0,.001,ix,.001,0,.001,ix,.001,0,.001,ix,.001,0,.001,ix,.001,0,.001,ix,.001,0,.001,ix,.001,0,.001,ix,.001,0,.001,ix,p3-.015,p7
  kenv      linseg    0,.01,iamp,p3/2-.011,iamp/5,p3/2-.001,0,.001,0
  a1        foscili   kenv,ifrq,1,p8,kindx,1
            outs      a1*(1-kst),a1*kst
endin
;---------------------------------------------------------
;         INSTR 81 = REVERB FOR VOICE
;---------------------------------------------------------
instr     81
  imix      =  p4
  krvtim    =  p5
  ga1       tone      ga1,1000
  a1        alpass    ga1*imix,krvtim,.04996
  a2        alpass    a1*.72,krvtim,.05465
  a3        alpass    a2*.961,krvtim,.02418
  al        alpass    a3*.649,krvtim,.01785
  ar        alpass    a3*.646,krvtim,.01795
            outs      al,ar
  ga1       =  0
endin
;---------------------------------------------------------
;      INSTRUENT 90 REVERB FOR KLANG
;---------------------------------------------------------
instr     90
  imix      =  p4
  krvtim    =  p5
  a1        alpass    ga10*imix,krvtim,.04996
  a2        alpass    a1*.72,krvtim,.05465
  a3        alpass    a2*.961,krvtim,.02418
  al        alpass    a3*.649,krvtim,.01785
  ar        alpass    a3*.646,krvtim,.01795
            outs      al,ar
  ga10      =  0
endin
;---------------------------------------------------------
;      INSTRUMENT 91 REVERB FOR PERCUSSION
;---------------------------------------------------------
instr     91
;p4       =         starting rev.time
;p5       =         ending reverb.time
  krvtim    line      p4,p3,p5
  a1        alpass    ga11, krvtim, .04996
  a2        alpass    a1*.72,  krvtim, .05465
  a3        alpass    a2*.961, krvtim, .02418
  al        alpass    a3*.649, krvtim, .01785
  ar        alpass    a3*.646, krvtim, .01795
            outs      al,ar
  ga11      =  0
endin
