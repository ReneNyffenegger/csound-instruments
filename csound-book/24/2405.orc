
;----------------------------------------------------------------------------------
; CSOUND SYSTEM FOR IMPLEMENTING REVERBS BASED ON NESTED ALL-PASS FILTERS
; SIMILAR TO THOSE USED BY WILLIAM GARDNER (MIT)
; CODED BY HANS MIKELSON 12/2/97-3/8/98
;----------------------------------------------------------------------------------
;
; 1. NOISE CLICK
; 2. DISK INPUT MONO
; 3. DISK INPUT STEREO
; 5. BAND LIMITED IMPULSE
; 8. SIMPLE SUM
; 9. FEEDBACK FILTER
;10. DELAY
;11. SIMPLE ALL-PASS FILTER
;12. NESTED ALL-PASS FILTER
;13. DOUBLE NESTED ALL-PASS FILTER
;15. OUTPUT
;21. SMALL ROOM REVERB
;22. MEDIUM ROOM REVERB
;23. LARGE ROOM REVERB
;25. SMALL  ROOM REVERB WITH INPUT CONTROL
;26. MEDIUM ROOM REVERB WITH INPUT CONTROL
;27. LARGE  ROOM REVERB WITH INPUT CONTROL


  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

            zakinit   30,30


;----------------------------------------------------------------------------------
; NOISE CLICK FOR TESTING THE DECAY CURVE OF THE REVERB.
instr     1

  idur      =  p3
  iamp      =  p4
  ioutch    =  p5
  ifco      =  p6

  kamp      linseg    0, .002, iamp, .002, 0, idur-.004, 0
  aout      rand      kamp

  afilt     butterlp  aout, ifco
            zaw       afilt, ioutch
;         outs      aout, aout

endin
;----------------------------------------------------------------------------------
; DISK INPUT MONO
instr     2

  iamp      =  p4
  irate     =  p5
  isndin    =  p6
  ioutch    =  p7

  ain       diskin    isndin, irate
            zaw       ain, ioutch
            outs      ain*iamp, ain*iamp

endin
;----------------------------------------------------------------------------------
; DISK INPUT STEREO
instr     3

  iamp      =  p4
  irate     =  p5
  isndin    =  p6
  ioutch1   =  p7
  ioutch2   =  p8

  ain1, ain2   diskin   isndin, irate

            zaw       ain1, ioutch2
            zaw       ain2, ioutch2
            outs      ain1*iamp, ain2*iamp

endin

;----------------------------------------------------------------------------------
; BAND-LIMITED IMPULSE
instr     5

  iamp      =  p4
  ifqc      =  cpspch(p5)
  ioutch    =  p6

  apulse    buzz      1,ifqc, sr/2/ifqc, 1        ; Avoid aliasing
     
            zaw       apulse*iamp, ioutch
            outs      apulse*iamp, apulse*iamp

endin

       
;----------------------------------------------------------------------------------
; SIMPLE SUM--ADD 2 CHANNELS TOGETHER AND OUTPUT TO A THIRD CHANNEL.
instr     8

  idur      =  p3
  iinch1    =  p4
  iinch2    =  p5
  ioutch    =  p6

  ain1      zar       iinch1
  ain2      zar       iinch2
            zaw       ain1+ain2, ioutch

endin

;----------------------------------------------------------------------------------
; FEEDBACK FILTER
instr     9

  idur      =  p3
  ifco      =  p4
  igain     =  p5
  iinch1    =  p6
  iinch2    =  p7
  ioutch    =  p8

  ain1      zar       iinch1
  ain2      zar       iinch2                      ; READ IN TWO CHANNELS
     
  afilt     butterbp  ain2, ifco, ifco/2          ; BANDPASS FILTER ONE CHANNEL
            zaw       ain1+igain*afilt, ioutch    ; ADJUST FILTER LEVEL ADD & OUTPUT

endin

;----------------------------------------------------------------------------------
; DELAY  -- SIMPLE DELAY
instr     10

  idur      =  p3
  idtime    =  p4/1000
  igain     =  p5
  iinch     =  p6
  ioutch    =  p7

  ain       zar       iinch                       ; READ THE CHANNEL
  aout      delay     ain, idtime                 ; DELAY FOR TIME
            zaw       aout, ioutch                ; OUTPUT THE CHANNEL

endin

;----------------------------------------------------------------------------------
; SIMPLE ALL-PASS FILTER
instr     11

  idur      =  p3
  itime     =  p4/1000
  igain     =  p5
  iinch     =  p6
  ioutch    =  p7
  adel1     init      0

  ain       zar       iinch

  aout      =  adel1-igain*ain                    ; FEED FORWARD
  adel1     delay     ain+igain*aout, itime       ; DELAY AND FEEDBACK

            zaw       aout, ioutch
     
endin

;----------------------------------------------------------------------------------
; SINGLE NESTED ALL-PASS FILTER
instr     12

  idur      =  p3
  itime1    =  p4/1000-p6/1000
  igain1    =  p5
  itime2    =  p6/1000
  igain2    =  p7
  iinch     =  p8
  ioutch    =  p9
  adel1     init      0
  adel2     init      0

  ain       zar       iinch
     
  asum      =  adel2 - igain2*adel1               ; FEED FORWARD (INNER ALL-PASS)
  aout      =  asum - igain1*ain                  ; FEED FORWARD (OUTER ALL-PASS)

  adel1     delay     ain  + igain1*aout, itime1  ; FEEDBACK (OUTER ALL-PASS)
  adel2     delay     adel1 + igain2*asum, itime2 ; FEEDBACK (INNER ALL-PASS)
     
            zaw       aout, ioutch

endin

;----------------------------------------------------------------------------------
; DOUBLE NESTED ALL-PASS FILTER (1 OUTER WITH 2 INNER IN SERIES)
instr     13

  idur      =  p3
  itime1    =  p4/1000-p6/1000-p8/1000
  igain1    =  p5
  itime2    =  p6/1000
  igain2    =  p7
  itime3    =  p8/1000
  igain3    =  p9
  iinch     =  p10
  ioutch    =  p11
  adel1     init      0
  adel2     init      0
  adel3     init      0

  ain       zar       iinch
     
  asum1     =  adel2 - igain2*adel1               ; FIRST  INNER FEED FORWARD
  asum2     =  adel3 - igain3*asum1               ; SECOND INNER FEED FORWARD
  aout      =  asum2 - igain1*ain                 ; OUTER  FEED FORWARD

  adel1     delay     ain  + igain1*aout, itime1  ; OUTER FEEDBACK
  adel2     delay     adel1 + igain2*asum1, itime2 ; FIRST INNER FEEDBACK
  adel3     delay     asum1 + igain3*asum2, itime3 ; SECOND INNER FEEDBACK

            zaw       aout, ioutch

endin

;----------------------------------------------------------------------------------
; 2D ECHOS
;----------------------------------------------------------------------------------
instr     17

  idur      =  p3
  iamp      =  p4
  iex       =  p5
  iey       =  p6
  isx       =  p7
  isy       =  p8
  iwx       =  p9
  iwy       =  p10
  iinch     =  p11
  ioutch1   =  p12
  ioutch2   =  p13

  kamp      linseg    0, .002, iamp, idur-.004, iamp, .002, 0

  ain       zar       iinch

  iang0     =  taninv((iex-isx)/(iey-isy))
  idist0    =  sqrt((iex-isx)*(iex-isx)+(iey-isy)*(iey-isy))
  iang1     =  taninv((iex-isx)/(iey+isy))
  idist1    =  sqrt((iex-isx)*(iex-isx)+(iey+isy)*(iey+isy))
  iang2     =  taninv((iey-isy)/(iex+isx))
  idist2    =  sqrt((iey-isy)*(iey-isy)+(iex+isx)*(iex+isx))
  iang3     =  taninv((iex-isx)/(2*iwy-iey-isy))
  idist3    =  sqrt((iex-isx)*(iex-isx)+(2*iwy-iey-isy)*(2*iwy-iey-isy))
  iang4     =  taninv((iey-isy)/(2*iwx-iex-isx))
  idist4    =  sqrt((iey-isy)*(iey-isy)+(2*iwx-iex-isx)*(2*iwx-iex-isx))

  adel0     delay     ain/(1+idist0/2), idist0/333
  adel1     delay     ain/(1+idist1/4), idist1/333
  adel2     delay     ain/(1+idist2/4), idist2/333
  adel3     delay     ain/(1+idist3/4), idist3/333
  adel4     delay     ain/(1+idist4/4), idist4/333

;al1, ar1 hrtfer   adel1, iang1, 0, "hrtfcomp"
;al2, ar2 hrtfer   adel2, iang2, 0, "hrtfcomp"
;al3, ar3 hrtfer   adel3, iang3, 0, "hrtfcomp"
;al4, ar4 hrtfer   adel4, iang4, 0, "hrtfcomp"

  al0       =  adel0*sqrt(     (iang0+3.141592)/4/3.141592)
  ar0       =  adel0*sqrt(1-(iang0+3.141592)/4/3.141592)
  al1       =  adel1*sqrt(     (iang1+3.141592)/4/3.141592)
  ar1       =  adel1*sqrt(1-(iang1+3.141592)/4/3.141592)
  al2       =  adel2*sqrt(     (iang2+3.141592)/4/3.141592)
  ar2       =  adel2*sqrt(1-(iang2+3.141592)/4/3.141592)
  al3       =  adel3*sqrt(     (iang3+3.141592)/4/3.141592)
  ar3       =  adel3*sqrt(1-(iang3+3.141592)/4/3.141592)
  al4       =  adel4*sqrt(     (iang4+3.141592)/4/3.141592)
  ar4       =  adel4*sqrt(1-(iang4+3.141592)/4/3.141592)

  aoutl     =  (al0+al1+al2+al3+al4)*kamp
  aoutr     =  (ar0+ar1+ar2+ar3+ar4)*kamp
     
            outs      aoutl, aoutr 
            zaw       aoutl, ioutch1
            zaw       aoutr, ioutch2

endin

;----------------------------------------------------------------------------------
; SMALL ROOM REVERB
;----------------------------------------------------------------------------------
instr     21

  idur      =  p3
  iamp      =  p4
  iinch     =  p5

  aout41    init      0
  adel01    init      0
  adel11    init      0
  adel21    init      0
  adel22    init      0
  adel23    init      0
  adel41    init      0
  adel42    init      0

  kdclick   linseg    0, .002, iamp, idur-.004, iamp, .002, 0

; INITIALIZE
  asig0     zar       iinch
  aflt01    butterlp  asig0, 6000                 ; PRE-FILTER
  aflt02    butterbp  .5*aout41, 1600, 800        ; FEED-BACK FILTER
  asum01    =  aflt01+.5*aflt02                   ; INITIAL MIX

; DELAY 1
  adel11    delay     asum01, .024

; DOUBLE NESTED ALL-PASS
  asum21    =  adel22-.25*adel21                  ; FIRST INNER FEEDFORWARD
  asum22    =  adel23-.30*asum21                  ; SECOND INNER FEEDFORWARD
  aout21    =  asum22-.15*adel11                  ; OUTER FEEDFORWARD
  adel21    delay     adel11+.15*aout21, .0047    ; OUTER FEEDBACK
  adel22    delay     adel21+.25*asum21, .022     ; FIRST INNER FEEDBACK
  adel23    delay     asum21+.30*asum22, .0083    ; SECOND INNER FEEDBACK
     
; SINGLE NESTED ALL-PASS
  asum41    =  adel42-.3*adel41                   ; INNER FEEDFORWARD
  aout41    =  asum41-.08*aout21                  ; OUTER FEEDFORWARD
  adel41    delay     aout21+.08*aout41, .036     ; OUTER FEEDBACK
  adel42    delay     adel41+.3*asum41,   .030    ; INNER FEEDBACK

; OUTPUT
  aout      =  .6*aout41+.5*aout21

            outs      aout*kdclick, -aout*kdclick

endin

;----------------------------------------------------------------------------------
; MEDIUM ROOM REVERB
;----------------------------------------------------------------------------------
instr     22

  idur      =  p3
  iamp      =  p4
  iinch     =  p5

  adel71    init      0
  adel11    init      0
  adel12    init      0
  adel13    init      0
  adel31    init      0
  adel61    init      0
  adel62    init      0

  kdclick   linseg    0, .002, iamp, idur-.004, iamp, .002, 0

; INITIALIZE
  asig0     zar       iinch
  aflt01    butterlp  asig0, 6000                 ; PRE-FILTER
  aflt02    butterbp  .4*adel71, 1000, 500        ; FEED-BACK FILTER
  asum01    =  aflt01+.5*aflt02                   ; INITIAL MIX

; DOUBLE NESTED ALL-PASS
  asum11    =  adel12-.35*adel11                  ; FIRST  INNER FEEDFORWARD
  asum12    =  adel13-.45*asum11                  ; SECOND INNER FEEDFORWARD
  aout11    =  asum12-.25*asum01                  ; OUTER FEEDFORWARD
  adel11    delay     asum01+.25*aout11, .0047    ; OUTER FEEDBACK
  adel12    delay     adel11+.35*asum11, .0083    ; FIRST   INNER FEEDBACK
  adel13    delay     asum11+.45*asum12, .022     ; SECOND INNER FEEDBACK
     
  adel21    delay     aout11, .005                ; DELAY 1

; ALL-PASS 1
  asub31    =  adel31-.45*adel21                  ; FEEDFORWARD
  adel31    delay     adel21+.45*asub31,.030      ; FEEDBACK

  adel41    delay     asub31, .067                ; DELAY 2
  adel51    delay     .4*adel41, .015             ; DELAY 3
  aout51    =  aflt01+adel41

; SINGLE NESTED ALL-PASS
  asum61    =  adel62-.35*adel61                  ; INNER FEEDFORWARD
  aout61    =  asum61-.25*aout51                  ; OUTER FEEDFORWARD
  adel61    delay     aout51+.25*aout61, .0292    ; Outer Feedback
  adel62    delay     adel61+.35*asum61, .0098    ; Inner Feedback

  aout      =  .5*aout11+.5*adel41+.5*aout61      ; COMBINE OUTPUTS

  adel71    delay     aout61, .108                ; DELAY 4

            outs      aout*kdclick, -aout*kdclick ; FINAL OUTPUT

endin

;----------------------------------------------------------------------------------
; LARGE ROOM REVERB
;----------------------------------------------------------------------------------
instr     23

  idur      =  p3
  iamp      =  p4
  iinch     =  p5

  aout91    init      0
  adel01    init      0
  adel11    init      0
  adel51    init      0
  adel52    init      0
  adel91    init      0
  adel92    init      0
  adel93    init      0

  kdclick   linseg    0, .002, iamp, idur-.004, iamp, .002, 0

; INITIALIZE
  asig0     zar       iinch
  aflt01    butterlp  asig0, 4000                 ; PRE-FILTER
  aflt02    butterbp  .5*aout91, 1000, 500        ; FEED-BACK FILTER
  asum01    =  aflt01+.5*aflt02                   ; INITIAL MIX

; ALL-PASS 1
  asub01    =  adel01-.3*asum01                   ; FEEDFORWARD
  adel01    delay     asum01+.3*asub01,.008       ; FEEDBACK

; ALL-PASS 2
  asub11    =  adel11-.3*asub01                   ; FEEDFORWARD
  adel11    delay     asub01+.3*asub11,.012       ; FEEDBACK

  adel21    delay     asub11, .004                ; DELAY 1
  adel41    delay     adel21, .017                ; DELAY 2

; SINGLE NESTED ALL-PASS
  asum51    =  adel52-.25*adel51                  ; INNER FEEDFORWARD
  aout51    =  asum51-.5*adel41                   ; OUTER FEEDFORWARD
  adel51    delay     adel41+.5*aout51,   .025    ; OUTER FEEDBACK
  adel52    delay     adel51+.25*asum51, .062     ; INNER FEEDBACK

  adel61    delay     aout51, .031                ; DELAY 3
  adel81    delay     adel61, .003                ; DELAY 4
     
; DOUBLE NESTED ALL-PASS
  asum91    =  adel92-.25*adel91                  ; FIRST  INNER FEEDFORWARD
  asum92    =  adel93-.25*asum91                  ; SECOND INNER FEEDFORWARD
  aout91    =  asum92-.5*adel81                   ; OUTER FEEDFORWARD
  adel91    delay     adel81+.5*aout91, .120      ; OUTER FEEDBACK
  adel92    delay     adel91+.25*asum91, .076     ; FIRST  INNER FEEDBACK
  adel93    delay     asum91+.25*asum92, .030     ; SECOND INNER FEEDBACK

  aout      =  .8*aout91+.8*adel61+1.5*adel21     ; COMBINE OUTPUTS

            outs      aout*kdclick, -aout*kdclick ; FINAL OUTPUT

endin

;----------------------------------------------------------------------------------
; SMALL ROOM REVERB WITH CONTROLS
;----------------------------------------------------------------------------------
instr     25

  idur      =  p3
  iamp      =  p4
  iinch     =  p5
  idecay    =  p6
  idense    =  p7
  idense2   =  p8
  ipreflt   =  p9
  ihpfqc    =  p10
  ilpfqc    =  p11
  ioutch    =  p12

  aout41    init      0
  adel01    init      0
  adel11    init      0
  adel21    init      0
  adel22    init      0
  adel23    init      0
  adel41    init      0
  adel42    init      0

  kdclick   linseg    0, .002, iamp, idur-.004, iamp, .002, 0

; INITIALIZE
  asig0     zar       iinch
  aflt01    butterlp  asig0, ipreflt              ; PRE-FILTER
  aflt02    butterhp  .5*aout41*idense2, ihpfqc   ; FEED-BACK FILTER
  aflt03    butterlp  .5*aflt02, ilpfqc           ; FEED-BACK FILTER
  asum01    =  aflt01+.5*aflt03                   ; INITIAL MIX

; DELAY 1
  adel11    delay     asum01, .024*idecay

; DOUBLE NESTED ALL-PASS
  asum21    =  adel22-.25*adel21*idense           ; FIRST INNER FEEDFORWARD
  asum22    =  adel23-.30*asum21*idense           ; SECOND INNER FEEDFORWARD
  aout21    =  asum22-.15*adel11*idense           ; OUTER FEEDFORWARD
  adel21    delay     adel11+.15*aout21*idense, .0047*idecay ; OUTER FEEDBACK
  adel22    delay     adel21+.25*asum21*idense, .0220*idecay ; FIRST INNER FEEDBACK
  adel23    delay     asum21+.30*asum22*idense, .0083*idecay ; SECOND INNER FEEDBACK

; SINGLE NESTED ALL-PASS
  asum41    =  adel42-.30*adel41*idense           ; INNER FEEDFORWARD
  aout41    =  asum41-.08*aout21*idense           ; OUTER FEEDFORWARD
  adel41    delay     aout21+.08*aout41*idense, .036*idecay ; OUTER FEEDBACK
  adel42    delay     adel41+.30*asum41*idense, .030*idecay ; INNER FEEDBACK

; OUTPUT
  aout      =  .6*aout41+.5*aout21
            zaw       aout*kdclick, ioutch


endin

;----------------------------------------------------------------------------------
; MEDIUM ROOM REVERB WITH CONTROLS
;----------------------------------------------------------------------------------
instr     26

  idur      =  p3
  iamp      =  p4
  iinch     =  p5
  idecay    =  p6
  idense    =  p7
  idense2   =  p8
  ipreflt   =  p9
  ihpfqc    =  p10
  ilpfqc    =  p11
  ioutch    =  p12

  adel71    init      0
  adel11    init      0
  adel12    init      0
  adel13    init      0
  adel31    init      0
  adel61    init      0
  adel62    init      0

  kdclick   linseg    0, .002, iamp, idur-.004, iamp, .002, 0

; INITIALIZE
  asig0     zar       iinch
  aflt01    butterlp  asig0, ipreflt              ; PRE-FILTER
  aflt02    butterhp  .4*adel71*idense2, ihpfqc   ; FEED-BACK FILTER
  aflt03    butterlp  .4*aflt02, ilpfqc           ; FEED-BACK FILTER
  asum01    =  aflt01+.5*aflt03                   ; INITIAL MIX

; DOUBLE NESTED ALL-PASS
  asum11    =  adel12-.35*adel11*idense           ; FIRST  INNER FEEDFORWARD
  asum12    =  adel13-.45*asum11*idense           ; SECOND INNER FEEDFORWARD
  aout11    =  asum12-.25*asum01*idense           ; OUTER FEEDFORWARD
  adel11    delay     asum01+.25*aout11*idense, .0047*idecay ; OUTER FEEDBACK
  adel12    delay     adel11+.35*asum11*idense, .0083*idecay ; FIRST  INNER FEEDBACK
  adel13    delay     asum11+.45*asum12*idense, .0220*idecay ; SECOND INNER FEEDBACK

  adel21    delay     aout11, .005*idecay         ; DELAY 1

; ALL-PASS 1
  asub31    =  adel31-.45*adel21*idense           ; FEEDFORWARD
  adel31    delay     adel21+.45*asub31*idense, .030*idecay ; FEEDBACK

  adel41    delay     asub31, .067*idecay         ; DELAY 2
  adel51    delay     .4*adel41, .015*idecay      ; DELAY 3
  aout51    =  aflt01+adel41

; SINGLE NESTED ALL-PASS
  asum61    =  adel62-.35*adel61*idense           ; INNER FEEDFORWARD
  aout61    =  asum61-.25*aout51*idense           ; OUTER FEEDFORWARD
  adel61    delay     aout51+.25*aout61*idense, .0292*idecay ; OUTER FEEDBACK
  adel62    delay     adel61+.35*asum61*idense, .0098*idecay ; INNER FEEDBACK

  aout      =  .5*aout11+.5*adel41+.5*aout61      ; Combine Outputs

  adel71    delay     aout61, .108*idecay         ; DELAY 4

            zaw       aout*kdclick, ioutch

endin

;----------------------------------------------------------------------------------
; LARGE ROOM REVERB
;----------------------------------------------------------------------------------
instr     27

  idur      =  p3
  iamp      =  p4
  iinch     =  p5
  idecay    =  p6
  idense    =  p7
  idense2   =  p8
  ipreflt   =  p9
  ihpfqc    =  p10
  ilpfqc    =  p11
  ioutch    =  p12

  aout91    init      0
  adel01    init      0
  adel11    init      0
  adel51    init      0
  adel52    init      0
  adel91    init      0
  adel92    init      0
  adel93    init      0

  kdclick   linseg    0, .002, iamp, idur-.004, iamp, .002, 0

; INITIALIZE
  asig0     zar       iinch
  aflt01    butterlp  asig0, ipreflt              ; PRE-FILTER
  aflt02    butterhp  .5*aout91, ihpfqc           ; FEED-BACK FILTER
  aflt03    butterlp  aflt02, ilpfqc              ; FEED-BACK FILTER
  asum01    =  aflt01+.5*idense2*aflt03           ; INITIAL MIX

; ALL-PASS 1
  asub01    =  adel01-.3*idense*asum01            ; FEEDFORWARD
  adel01    delay     asum01+.3*idense*asub01,.008*idecay ; FEEDBACK

; ALL-PASS 2
  asub11    =  adel11-.3*idense*asub01            ; FEEDFORWARD
  adel11    delay     asub01+.3*idense*asub11,.012*idecay ; FEEDBACK

  adel21    delay     asub11, .004*idecay         ; DELAY 1
  adel41    delay     adel21, .017*idecay         ; DELAY 2

; SINGLE NESTED ALL-PASS
  asum51    =  adel52-.25*adel51*idense           ; INNER FEEDFORWARD
  aout51    =  asum51-.50*adel41*idense           ; OUTER FEEDFORWARD
  adel51    delay     adel41+.50*aout51*idense, .025*idecay ; OUTER FEEDBACK
  adel52    delay     adel51+.25*asum51*idense, .062*idecay ; INNER FEEDBACK

  adel61    delay     aout51, .031*idecay         ; DELAY 3
  adel81    delay     adel61, .003*idecay         ; DELAY 4

; DOUBLE NESTED ALL-PASS
  asum91    =  adel92-.25*adel91*idense           ; FIRST  INNER FEEDFORWARD
  asum92    =  adel93-.25*asum91*idense           ; SECOND INNER FEEDFORWARD
  aout91    =  asum92-.50*adel81*idense           ; OUTER FEEDFORWARD
  adel91    delay     adel81+.50*aout91*idense, .120*idecay ; OUTER FEEDBACK
  adel92    delay     adel91+.25*asum91*idense, .076*idecay ; FIRST  INNER FEEDBACK
  adel93    delay     asum91+.25*asum92*idense, .030*idecay ; SECOND INNER FEEDBACK

  aout      =  .8*aout91+.8*adel61+1.5*adel21     ; COMBINE OUTPUTS

            zaw       aout*kdclick, ioutch

endin

;----------------------------------------------------------------------------------
; OUTPUT FOR REVERB
instr     90

  idur      =  p3
  igain     =  p4
  iinch     =  p5

  kdclik    linseg    0, .002, igain, idur-.004, igain, .002, 0

  ain       zar       iinch
            outs      ain*kdclik, -ain*kdclik     ; INVERTING ONE SIDE MAKES THE SOUND
endin                             ; SEEM TO COME FROM ALL AROUND YOU.
                                       ; THIS MAY CAUSE SOME PROBLEMS WITH CERTAIN
                                       ; SURROUND SOUND SYSTEMS

;----------------------------------------------------------------------------------
; OUTPUT FOR REVERB
instr     91

  idur      =  p3
  igain     =  p4
  iinch1    =  p5
  iinch2    =  p6

  kdclik    linseg    0, .002, igain, idur-.004, igain, .002, 0

  ain1      zar       iinch1
  ain2      zar       iinch2
            outs      ain1*kdclik, ain2*kdclik

endin

instr     99
            zacl      0,30
endin
