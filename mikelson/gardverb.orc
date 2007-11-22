;----------------------------------------------------------------------------------
; Csound system for implementing reverbs based on nested all-pass filters
; similar to those used by William Gardner (MIT)
; Coded by Hans Mikelson 12/2/97-3/8/98
;----------------------------------------------------------------------------------
;
; 1. Noise Click
; 2. Disk Input Mono
; 3. Disk Input Stereo
; 5. Band Limited Impulse
; 8. Simple Sum
; 9. Feedback Filter
;10. Delay
;11. Simple All-Pass Filter
;12. Nested All-Pass Filter
;13. Double Nested All-Pass Filter
;15. Output
;21. Small Room Reverb
;22. Medium Room Reverb
;23. Large Room Reverb
;25. Small  Room Reverb with input control
;26. Medium Room Reverb with input control
;27. Large  Room Reverb with input control

  sr        =  44100
  kr        =  22050
  ksmps     =  2
  nchnls    =  2
            zakinit   30,30

;----------------------------------------------------------------------------------
; Noise Click for testing the decay curve of the reverb.
instr  1

  idur      =  p3
  iamp      =  p4
  ioutch    =  p5
  ifco      =  p6

  kamp      linseg    0, .002, iamp, .002, 0, idur-.004, 0
  aout      rand      kamp

  afilt     butterlp  aout, ifco
            zaw       afilt, ioutch
;       outs   aout, aout

endin

;----------------------------------------------------------------------------------
; Disk Input Mono
instr  2

  iamp      =  p4
  irate     =  p5
  isndin    =  p6
  ioutch    =  p7

  ain       diskin    isndin, irate
            zaw       ain, ioutch
            outs      ain*iamp, ain*iamp

endin
;----------------------------------------------------------------------------------
; Disk Input Stereo
instr  3

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
; Band-Limited Impulse
instr  5

  iamp      =  p4
  ifqc      =  cpspch(p5)
  ioutch    =  p6

  apulse    buzz      1,ifqc, sr/2/ifqc, 1        ; Avoid aliasing

            zaw       apulse*iamp, ioutch
            outs      apulse*iamp, apulse*iamp

endin

       
;----------------------------------------------------------------------------------
; Simple Sum--Add 2 channels together and output to a third channel.
instr  8

  idur      =  p3
  iinch1    =  p4
  iinch2    =  p5
  ioutch    =  p6

  ain1      zar       iinch1
  ain2      zar       iinch2
            zaw       ain1+ain2, ioutch

endin

;----------------------------------------------------------------------------------
; Feedback Filter
instr  9

  idur      =  p3
  ifco      =  p4
  igain     =  p5
  iinch1    =  p6
  iinch2    =  p7
  ioutch    =  p8

  ain1      zar       iinch1
  ain2      zar       iinch2                      ; Read in two channels

  afilt     butterbp  ain2, ifco, ifco/2          ; Bandpass filter one channel
            zaw       ain1+igain*afilt, ioutch    ; Adjust filter level add & output

endin

;----------------------------------------------------------------------------------
; Delay  -- Simple Delay
instr  10

  idur      =  p3
  idtime    =  p4/1000
  igain     =  p5
  iinch     =  p6
  ioutch    =  p7

  ain       zar       iinch                       ; Read the channel
  aout      delay     ain, idtime                 ; Delay for time
            zaw       aout, ioutch                ; Output the channel

endin


;----------------------------------------------------------------------------------
; Simple All-Pass Filter
instr  11

  idur      =  p3
  itime     =  p4/1000
  igain     =  p5
  iinch     =  p6
  ioutch    =  p7
  adel1     init      0

  ain       zar       iinch

  aout      =  adel1-igain*ain                    ; Feed Forward
  adel1     delay     ain+igain*aout, itime       ; Delay and Feedback

            zaw       aout, ioutch

endin

;----------------------------------------------------------------------------------
; Single Nested All-Pass Filter
instr  12

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

  asum      =  adel2 - igain2*adel1               ; Feed Forward (Inner all-pass)
  aout      =  asum  - igain1*ain                 ; Feed Forward (Outer all-pass)

  adel1     delay     ain   + igain1*aout, itime1 ; Feedback (Outer all-pass)
  adel2     delay     adel1 + igain2*asum, itime2 ; Feedback (Inner all-pass)

            zaw       aout, ioutch

endin

;----------------------------------------------------------------------------------
; Double Nested All-Pass Filter (1 outer with 2 inner in series)
instr  13

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

  asum1     =  adel2 - igain2*adel1               ; First  Inner Feed Forward
  asum2     =  adel3 - igain3*asum1               ; Second Inner Feed Forward
  aout      =  asum2 - igain1*ain                 ; Outer  Feed Forward

  adel1     delay     ain   + igain1*aout, itime1 ; Outer Feedback
  adel2     delay     adel1 + igain2*asum1, itime2 ; First Inner Feedback
  adel3     delay     asum1 + igain3*asum2, itime3 ; Second Inner Feedback

            zaw       aout, ioutch

endin

;----------------------------------------------------------------------------------
; 2D Echos
;----------------------------------------------------------------------------------
instr    17

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

  iang0     =  atan((iex-isx)/(iey-isy))
  idist0    =  sqrt((iex-isx)*(iex-isx)+(iey-isy)*(iey-isy))
  iang1     =  atan((iex-isx)/(iey+isy))
  idist1    =  sqrt((iex-isx)*(iex-isx)+(iey+isy)*(iey+isy))
  iang2     =  atan((iey-isy)/(iex+isx))
  idist2    =  sqrt((iey-isy)*(iey-isy)+(iex+isx)*(iex+isx))
  iang3     =  atan((iex-isx)/(2*iwy-iey-isy))
  idist3    =  sqrt((iex-isx)*(iex-isx)+(2*iwy-iey-isy)*(2*iwy-iey-isy))
  iang4     =  atan((iey-isy)/(2*iwx-iex-isx))
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

  al0       =  adel0*sqrt(  (iang0+3.141592)/2/3.141592)
  ar0       =  adel0*sqrt(1-(iang0+3.141592)/2/3.141592)
  al1       =  adel1*sqrt(  (iang1+3.141592)/2/3.141592)
  ar1       =  adel1*sqrt(1-(iang1+3.141592)/2/3.141592)
  al2       =  adel2*sqrt(  (iang2+3.141592)/2/3.141592)
  ar2       =  adel2*sqrt(1-(iang2+3.141592)/2/3.141592)
  al3       =  adel3*sqrt(  (iang3+3.141592)/2/3.141592)
  ar3       =  adel3*sqrt(1-(iang3+3.141592)/2/3.141592)
  al4       =  adel4*sqrt(  (iang4+3.141592)/2/3.141592)
  ar4       =  adel4*sqrt(1-(iang4+3.141592)/2/3.141592)

  aoutl     =  (al0+al1+al2+al3+al4)*kamp
  aoutr     =  (ar0+ar1+ar2+ar3+ar4)*kamp

            outs      aoutl, aoutr 
            zaw       aoutl, ioutch1
            zaw       aoutr, ioutch2

endin

;----------------------------------------------------------------------------------
; Small Room Reverb
;----------------------------------------------------------------------------------
instr  21

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

; Initialize
  asig0     zar       iinch
  aflt01    butterlp  asig0, 6000                 ; Pre-Filter
  aflt02    butterbp  .5*aout41, 1600, 800        ; Feed-Back Filter
  asum01    =  aflt01+.5*aflt02                   ; Initial Mix

; Delay 1
  adel11    delay     asum01, .024

; Double Nested All-Pass
  asum21    =  adel22-.25*adel21                  ; First Inner Feedforward
  asum22    =  adel23-.30*asum21                  ; Second Inner Feedforward
  aout21    =  asum22-.15*adel11                  ; Outer Feedforward
  adel21    delay     adel11+.15*aout21, .0047    ; Outer Feedback
  adel22    delay     adel21+.25*asum21, .022     ; First Inner Feedback
  adel23    delay     asum21+.30*asum22, .0083    ; Second Inner Feedback

; Single Nested All-Pass
  asum41    =  adel42-.3*adel41                   ; Inner Feedforward
  aout41    =  asum41-.08*aout21                  ; Outer Feedforward
  adel41    delay     aout21+.08*aout41, .036     ; Outer Feedback
  adel42    delay     adel41+.3*asum41,  .030     ; Inner Feedback

; Output
  aout      =  .6*aout41+.5*aout21

            outs      aout*kdclick, -aout*kdclick

endin

;----------------------------------------------------------------------------------
; Medium Room Reverb
;----------------------------------------------------------------------------------
instr  22

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

; Initialize
  asig0     zar       iinch
  aflt01    butterlp  asig0, 6000                 ; Pre-Filter
  aflt02    butterbp  .4*adel71, 1000, 500        ; Feed-Back Filter
  asum01    =  aflt01+.5*aflt02                   ; Initial Mix

; Double Nested All-Pass
  asum11    =  adel12-.35*adel11                  ; First  Inner Feedforward
  asum12    =  adel13-.45*asum11                  ; Second Inner Feedforward
  aout11    =  asum12-.25*asum01                  ; Outer Feedforward
  adel11    delay     asum01+.25*aout11, .0047    ; Outer Feedback
  adel12    delay     adel11+.35*asum11, .0083    ; First  Inner Feedback
  adel13    delay     asum11+.45*asum12, .022     ; Second Inner Feedback

  adel21    delay     aout11, .005                ; Delay 1

; All-Pass 1
  asub31    =  adel31-.45*adel21                  ; Feedforward
  adel31    delay     adel21+.45*asub31,.030      ; Feedback

  adel41    delay     asub31, .067                ; Delay 2
  adel51    delay     .4*adel41, .015             ; Delay 3
  aout51    =  aflt01+adel41

; Single Nested All-Pass
  asum61    =  adel62-.35*adel61                  ; Inner Feedforward
  aout61    =  asum61-.25*aout51                  ; Outer Feedforward
  adel61    delay     aout51+.25*aout61, .0292    ; Outer Feedback
  adel62    delay     adel61+.35*asum61, .0098    ; Inner Feedback

  aout      =  .5*aout11+.5*adel41+.5*aout61      ; Combine Outputs

  adel71    delay     aout61, .108                ; Delay 4

            outs      aout*kdclick, -aout*kdclick ; Final Output

endin

;----------------------------------------------------------------------------------
; Large Room Reverb
;----------------------------------------------------------------------------------
instr  23

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

; Initialize
  asig0     zar       iinch
  aflt01    butterlp  asig0, 4000                 ; Pre-Filter
  aflt02    butterbp  .5*aout91, 1000, 500        ; Feed-Back Filter
  asum01    =  aflt01+.5*aflt02                   ; Initial Mix

; All-Pass 1
  asub01    =  adel01-.3*asum01                   ; Feedforward
  adel01    delay     asum01+.3*asub01,.008       ; Feedback

; All-Pass 2
  asub11    =  adel11-.3*asub01                   ; Feedforward
  adel11    delay     asub01+.3*asub11,.012       ; Feedback

  adel21    delay     asub11, .004                ; Delay 1
  adel41    delay     adel21, .017                ; Delay 2

; Single Nested All-Pass
  asum51    =  adel52-.25*adel51                  ; Inner Feedforward
  aout51    =  asum51-.5*adel41                   ; Outer Feedforward
  adel51    delay     adel41+.5*aout51,  .025     ; Outer Feedback
  adel52    delay     adel51+.25*asum51, .062     ; Inner Feedback

  adel61    delay     aout51, .031                ; Delay 3
  adel81    delay     adel61, .003                ; Delay 4

; Double Nested All-Pass
  asum91    =  adel92-.25*adel91                  ; First  Inner Feedforward
  asum92    =  adel93-.25*asum91                  ; Second Inner Feedforward
  aout91    =  asum92-.5*adel81                   ; Outer Feedforward
  adel91    delay     adel81+.5*aout91, .120      ; Outer Feedback
  adel92    delay     adel91+.25*asum91, .076     ; First  Inner Feedback
  adel93    delay     asum91+.25*asum92, .030     ; Second Inner Feedback

  aout      =  .8*aout91+.8*adel61+1.5*adel21     ; Combine outputs

            outs      aout*kdclick, -aout*kdclick ; Final Output

endin

;----------------------------------------------------------------------------------
; Small Room Reverb with controls
;----------------------------------------------------------------------------------
instr  25

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

; Initialize
  asig0     zar       iinch
  aflt01    butterlp  asig0, ipreflt              ; Pre-Filter
  aflt02    butterhp  .5*aout41*idense2, ihpfqc   ; Feed-Back Filter
  aflt03    butterlp  .5*aflt02, ilpfqc           ; Feed-Back Filter
  asum01    =  aflt01+.5*aflt03                   ; Initial Mix

; Delay 1
  adel11    delay     asum01, .024*idecay

; Double Nested All-Pass
  asum21    =  adel22-.25*adel21*idense           ; First Inner Feedforward
  asum22    =  adel23-.30*asum21*idense           ; Second Inner Feedforward
  aout21    =  asum22-.15*adel11*idense           ; Outer Feedforward
  adel21    delay     adel11+.15*aout21*idense, .0047*idecay ; Outer Feedback
  adel22    delay     adel21+.25*asum21*idense, .0220*idecay ; First Inner Feedback
  adel23    delay     asum21+.30*asum22*idense, .0083*idecay ; Second Inner Feedback

; Single Nested All-Pass
  asum41    =  adel42-.30*adel41*idense           ; Inner Feedforward
  aout41    =  asum41-.08*aout21*idense           ; Outer Feedforward
  adel41    delay     aout21+.08*aout41*idense, .036*idecay ; Outer Feedback
  adel42    delay     adel41+.30*asum41*idense, .030*idecay ; Inner Feedback

; Output
  aout      =  .6*aout41+.5*aout21
            zaw       aout*kdclick, ioutch


endin

;----------------------------------------------------------------------------------
; Medium Room Reverb with controls
;----------------------------------------------------------------------------------
instr  26

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

; Initialize
  asig0     zar       iinch
  aflt01    butterlp  asig0, ipreflt              ; Pre-Filter
  aflt02    butterhp  .4*adel71*idense2, ihpfqc   ; Feed-Back Filter
  aflt03    butterlp  .4*aflt02, ilpfqc           ; Feed-Back Filter
  asum01    =  aflt01+.5*aflt03                   ; Initial Mix

; Double Nested All-Pass
  asum11    =  adel12-.35*adel11*idense           ; First  Inner Feedforward
  asum12    =  adel13-.45*asum11*idense           ; Second Inner Feedforward
  aout11    =  asum12-.25*asum01*idense           ; Outer Feedforward
  adel11    delay     asum01+.25*aout11*idense, .0047*idecay ; Outer Feedback
  adel12    delay     adel11+.35*asum11*idense, .0083*idecay ; First  Inner Feedback
  adel13    delay     asum11+.45*asum12*idense, .0220*idecay ; Second Inner Feedback

  adel21    delay     aout11, .005*idecay         ; Delay 1

; All-Pass 1
  asub31    =  adel31-.45*adel21*idense           ; Feedforward
  adel31    delay     adel21+.45*asub31*idense, .030*idecay ; Feedback

  adel41    delay     asub31, .067*idecay         ; Delay 2
  adel51    delay     .4*adel41, .015*idecay      ; Delay 3
  aout51    =  aflt01+adel41

; Single Nested All-Pass
  asum61    =  adel62-.35*adel61*idense           ; Inner Feedforward
  aout61    =  asum61-.25*aout51*idense           ; Outer Feedforward
  adel61    delay     aout51+.25*aout61*idense, .0292*idecay ; Outer Feedback
  adel62    delay     adel61+.35*asum61*idense, .0098*idecay ; Inner Feedback

  aout      =  .5*aout11+.5*adel41+.5*aout61      ; Combine Outputs

  adel71    delay     aout61, .108*idecay         ; Delay 4

            zaw       aout*kdclick, ioutch

endin

;----------------------------------------------------------------------------------
; Large Room Reverb
;----------------------------------------------------------------------------------
instr    27

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

; Initialize
  asig0     zar       iinch
  aflt01    butterlp  asig0, ipreflt              ; Pre-Filter
  aflt02    butterhp  .5*aout91, ihpfqc           ; Feed-Back Filter
  aflt03    butterlp  aflt02, ilpfqc              ; Feed-Back Filter
  asum01    =  aflt01+.5*idense2*aflt03           ; Initial Mix

; All-Pass 1
  asub01    =  adel01-.3*idense*asum01            ; Feedforward
  adel01    delay     asum01+.3*idense*asub01,.008*idecay ; Feedback

; All-Pass 2
  asub11    =  adel11-.3*idense*asub01            ; Feedforward
  adel11    delay     asub01+.3*idense*asub11,.012*idecay ; Feedback

  adel21    delay     asub11, .004*idecay         ; Delay 1
  adel41    delay     adel21, .017*idecay         ; Delay 2

; Single Nested All-Pass
  asum51    =  adel52-.25*adel51*idense           ; Inner Feedforward
  aout51    =  asum51-.50*adel41*idense           ; Outer Feedforward
  adel51    delay     adel41+.50*aout51*idense, .025*idecay ; Outer Feedback
  adel52    delay     adel51+.25*asum51*idense, .062*idecay ; Inner Feedback

  adel61    delay     aout51, .031*idecay         ; Delay 3
  adel81    delay     adel61, .003*idecay         ; Delay 4

; Double Nested All-Pass
  asum91    =  adel92-.25*adel91*idense           ; First  Inner Feedforward
  asum92    =  adel93-.25*asum91*idense           ; Second Inner Feedforward
  aout91    =  asum92-.50*adel81*idense           ; Outer Feedforward
  adel91    delay     adel81+.50*aout91*idense, .120*idecay ; Outer Feedback
  adel92    delay     adel91+.25*asum91*idense, .076*idecay ; First  Inner Feedback
  adel93    delay     asum91+.25*asum92*idense, .030*idecay ; Second Inner Feedback

  aout      =  .8*aout91+.8*adel61+1.5*adel21     ; Combine outputs

            zaw       aout*kdclick, ioutch

endin

;----------------------------------------------------------------------------------
; Output For reverb
instr  90

  idur      =  p3
  igain     =  p4
  iinch     =  p5

  kdclik    linseg    0, .002, igain, idur-.004, igain, .002, 0

  ain       zar       iinch
            outs      ain*kdclik, -ain*kdclik     ; Inverting one side makes the sound
endin                           ; seem to come from all around you.
                                       ; This may cause some problems with certain
                                       ; surround sound systems

;----------------------------------------------------------------------------------
; Output For reverb
instr  91

  idur      =  p3
  igain     =  p4
  iinch1    =  p5
  iinch2    =  p6

  kdclik    linseg    0, .002, igain, idur-.004, igain, .002, 0

  ain1      zar       iinch1
  ain2      zar       iinch2
            outs      ain1*kdclik, ain2*kdclik

endin

instr   99
            zacl      0,30
endin
