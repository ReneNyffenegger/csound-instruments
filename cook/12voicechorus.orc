sr       =        44100
kr       =        4410
ksmps    =        10
nchnls   =        2

seed     0

instr    1 ; 12 Voice Chorus with random LFO rates and spread pan

ilevl    =        p4*.3                               ; Output level
idelay   =        p5/1000                             ; Delay in ms
idpth    =        p6/1000                             ; Depth in ms
imax     =        p7 - p8                             ; Maximum LFO rate
imin     =        p8                                  ; Minimum LFO rate
iwave    =        p9                                  ; LFO waveform

ain      soundin  "speech1.wav"

ain      =        ain*ilevl                           ; Scale level
i01      unirand  imax                                ; Random rate 1
i02      unirand  imax                                ; Random rate 2
i03      unirand  imax                                ; Random rate 3
i04      unirand  imax                                ; Random rate 4
i05      unirand  imax                                ; Random rate 5
i06      unirand  imax                                ; Random rate 6
i07      unirand  imax                                ; Random rate 7
i08      unirand  imax                                ; Random rate 8
i09      unirand  imax                                ; Random rate 9
i10      unirand  imax                                ; Random rate 10
i11      unirand  imax                                ; Random rate 11
i12      unirand  imax                                ; Random rate 12
alfo01   oscili   idpth, i01 + imin, iwave            ; LFO 1
alfo02   oscili   idpth, i02 + imin, iwave, .08       ; LFO 2
alfo03   oscili   idpth, i03 + imin, iwave, .17       ; LFO 3
alfo04   oscili   idpth, i04 + imin, iwave, .25       ; LFO 4
alfo05   oscili   idpth, i05 + imin, iwave, .33       ; LFO 5
alfo06   oscili   idpth, i06 + imin, iwave, .42       ; LFO 6
alfo07   oscili   idpth, i07 + imin, iwave, .50       ; LFO 7
alfo08   oscili   idpth, i08 + imin, iwave, .58       ; LFO 8
alfo09   oscili   idpth, i09 + imin, iwave, .67       ; LFO 9
alfo10   oscili   idpth, i10 + imin, iwave, .75       ; LFO 10
alfo11   oscili   idpth, i11 + imin, iwave, .83       ; LFO 11
alfo12   oscili   idpth, i12 + imin, iwave, .92       ; LFO 12
atemp    delayr   idelay + idpth +.1                  ; Create delay line
a01      deltapi  idelay + alfo01                     ; Variable tap 1
a02      deltapi  idelay + alfo02                     ; Variable tap 2
a03      deltapi  idelay + alfo03                     ; Variable tap 3
a04      deltapi  idelay + alfo04                     ; Variable tap 4
a05      deltapi  idelay + alfo05                     ; Variable tap 5
a06      deltapi  idelay + alfo06                     ; Variable tap 6
a07      deltapi  idelay + alfo07                     ; Variable tap 7
a08      deltapi  idelay + alfo08                     ; Variable tap 8
a09      deltapi  idelay + alfo09                     ; Variable tap 9
a10      deltapi  idelay + alfo10                     ; Variable tap 10
a11      deltapi  idelay + alfo11                     ; Variable tap 11
a12      deltapi  idelay + alfo12                     ; Variable tap 12
         delayw   ain                                 ; Signal input to delay
         outs1    a01+a02*.95+a03*.9+a04*.85+a05*.79+a06*.74+a07*.67+a08*.6+a09*.52+a10*.42+a11*.3
         outs2    a02*.3+a03*.42+a04*.52+a05*.6+a06*.67+a07*.74+a08*.79+a09*.85+a10*.9+a11*.95+a12

endin
