; Terrain Mapping
; Coded by Hans Mikelson February 13, 1998
;
sr=44100
kr=22050 
ksmps=2
nchnls=2
zakinit 50, 50

;-----------------------------------------------------------
; Orbits Traced on Complex 3D Surfaces
; z=sin^2*(sqrt(x^2+y^2))
;-----------------------------------------------------------
       instr 1

idur   =     p3
iamp   =     p4
ifqc   =     cpspch(p5)

kdclick linseg 0, .02, iamp, idur-.04, iamp, .02, 0

krsize oscil .1, 1, 1                      ; Sweeps both radius size and circle center
krsize =     krsize + 0.11
krad0  oscil krsize, .4, 1
krad1  =     krad0+0.11                       ; Make a positive radius.

ax0    oscil krad1, ifqc, 1, .25  ; Cosine
ax     =     ax0+krsize
ay0    oscil krad1, ifqc, 1       ; Sine
ay     =     ay0-krsize

az1    =     sin(sqrt(ax*ax+ay*ay))     ; Compute the surface
az     =     az1*az1-.5

       outs az*kdclick, az*kdclick

       endin

;-----------------------------------------------------------
; z=ln(x^2+y^2)
;-----------------------------------------------------------
       instr 2

idur   =     p3
iamp   =     p4
ifqc   =     cpspch(p5)

kdclick linseg 0, .002, iamp, idur-.004, iamp, .002, 0

klin1  oscil 5, .21, 1        ; Sweeps both radius size and circle center
krad1  oscil 5, .31, 1
krad1  =     krad1+6

ax0    oscil krad1, ifqc, 1, .25  ; Cosine
ax     =     ax0+klin1
ay0    oscil krad1, ifqc, 1       ; Sine
ay     =     ay0-klin1

az     =     log(ax*ax+ay*ay)-4

       outs az*kdclick, az*kdclick

       endin

;-----------------------------------------------------------
; z=-5*x/(x^2+y^2+1)
;-----------------------------------------------------------
       instr 3

idur   =     p3
iamp   =     p4
ifqc   =     cpspch(p5)

kdclick linseg 0, .002, iamp, idur-.004, iamp, .002, 0

krsize oscil 2.5, .4, 1
krsize =     krsize+3
krad0  oscil krsize, .2, 1
krad1  =     krad0+6

ax0    oscil krad1, ifqc, 1, .25  ; Cosine
ax     =     ax0+krsize
ay0    oscil krad1, ifqc, 1       ; Sine
ay     =     ay0-krsize

az     =     -5*ax/(ax*ax+ay*ay+1)
adcblk butterhp az, 20
abal1  =       1
aout   balance adcblk, abal1

       outs aout*kdclick, aout*kdclick

       endin

;-----------------------------------------------------------
; 4D
; w=sin^2*(sqrt(x^2+y^2+z^2))
;-----------------------------------------------------------
       instr   4

idur   =     p3
iamp   =     p4
ifqc   =     cpspch(p5)

kdclick linseg 0, .002, iamp, idur-.004, iamp, .002, 0
krminor linseg .5, idur/2, 5, idur/2, .5
krmajor =      krminor+1

asin1  oscil krminor, ifqc, 1
acos1  oscil krminor, ifqc, 1, .25
asin2  oscil krmajor, ifqc/4, 1
acos2  oscil krmajor, ifqc/4, 1, .25

ax     =     asin1+acos2
ay     =     acos1
az     =     asin2

az1    =     sin(sqrt(ax*ax+ay*ay+az*az))   ; Compute the surface
az     =     az1*az1-.5

       outs az*kdclick, az*kdclick

       endin

;-----------------------------------------------------------
; 4D
; w=sin^2*(sqrt(x^2+y^2+z^2))
;-----------------------------------------------------------
       instr   5

idur    =    p3
iamp    =    p4
ifqc    =    cpspch(p5)
iwamp   =    p6
ioutch1 =    p7
ioutch2 =    p8
ioutch3 =    p9
ioutch4 =    p10

kdclick linseg 0, .02, iamp, idur-.04, iamp, .02, 0
;krminor linseg .5, idur/2, 5, idur/2, .5
krminor oscil  5, .2, 1
krminor =      krminor+6
krmajor =      krminor+1

asin1  oscil krminor, ifqc, 1
acos1  oscil krminor, ifqc, 1, .25
asin2  oscil krmajor, ifqc/4, 1
acos2  oscil krmajor, ifqc/4, 1, .25

ax     =     asin1+acos2
ay     =     acos1
az     =     asin2

aw1    =     sin(sqrt(ax*ax+ay*ay+az*az))   ; Compute the surface
aw     =     aw1*aw1-.5

       zaw   ax*kdclick, ioutch1
       zaw   ay*kdclick, ioutch2
       zaw   az*kdclick, ioutch3
       zaw   aw*kdclick*iwamp, ioutch4

       endin

;-----------------------------------------------------------
; z=ln(x^2+y^2)
;-----------------------------------------------------------
       instr 6

idur   =     p3
iamp   =     p4
ifqc   =     cpspch(p5)

kdclick linseg 0, .002, iamp, idur-.004, iamp, .002, 0

klin1  oscil 5, .21, 1        ; Sweeps both radius size and circle center
krad1  oscil 5, .31, 1
krad1  =     krad1+6

ax0    oscil krad1, ifqc, 1, .25  ; Cosine
ax     =     ax0+klin1
ay0    oscil krad1, ifqc, 1       ; Sine
ay     =     ay0-klin1

az     =     log(ax*ax+ay*ay)-4

       outs az*kdclick, az*kdclick

       endin

;-----------------------------------------------------------
; 4D
; w=x^4-5*x^2+y^4-5*y^2+z^4-5*z^2+11.8
;-----------------------------------------------------------
       instr   7

idur    =    p3
iamp    =    p4
ifqc    =    cpspch(p5)
imodpth =    p6

kamp     linseg 0, .02, 1, idur-.04, 1, .02, 0
krminor oscil  .5*imodpth, .5, 1
krminor =      krminor+.7*imodpth
krmajor =      krminor+.4*imodpth

asin1  oscil krminor, ifqc*4, 1
acos1  oscil krminor, ifqc*4, 1, .25
asin2  oscil krmajor, ifqc, 1
acos2  oscil krmajor, ifqc, 1, .25

ax     =     asin1+acos2
ay     =     acos1
az     =     asin2

aw     =     ax*ax*ax*ax-5*ax*ax+ay*ay*ay*ay-5*ay*ay+az*az*az*az-5*az*az   ; Compute the surface
aamp1  =        iamp
abal1  balance  aw+5, aamp1
aout   atone    abal1, 10
       outs  aout*kamp, aout*kamp

       endin

;-----------------------------------------------------------
; z=sqrt((1-x^2)*((1-y)+y*cos(1/x)))
;-----------------------------------------------------------
       instr   8

idur    =    p3
iamp    =    p4
ifqc    =    cpspch(p5)
imodpth =    p6

kamp     linseg 0, .1, 20, idur-.2, 20, .1, 0
kradius oscil  .5*imodpth, .05, 1  ; Modulation
kradius =      kradius+.8*imodpth ; Make it positive

asin1  oscil kradius, ifqc, 1
acos1  oscil 1, ifqc, 1, .25  ; Must be between 0 and .5

ax     =     (asin1+1)/2
ay     =     (acos1+1.1)/10     ; Must be between 0 and .5

az     =     sqrt((1-ax*ax)*((1-ay)+ay*cos(1/ax)))   ; Compute the surface

aamp1  =        iamp

abal1  balance  az+5, aamp1        ; Normalize
aout   atone    abal1, 10          ; Remove DC
       outs  aout*kamp, aout*kamp

       endin

;-----------------------------------------------------------
; z=sqrt(x^4+y^4-x^2-y^2-x^2Y^2+1)
;-----------------------------------------------------------
        instr   9

idur    =       p3
iamp    =       p4
aamp1   init    iamp
ifqc    =       cpspch(p5)
imodpth =       p6
imodrt  =       p7
ibndtab =       p8

kamp    linseg  0, .1, 10, idur-.2, 10, .1, 0
krad1   oscil   .5*imodpth, imodrt, 1  ; Modulation
krad1   =       krad1+.8*imodpth ; Make it positive
krad2   oscil   .5*imodpth, imodrt, 1, .25  ; Modulation
krad2   =       krad2+.8*imodpth ; Make it positive
kbend   oscil   1, 1/idur, ibndtab
kfqc    =       kbend*ifqc

asin1   oscil   krad1, kfqc, 1
acos1   oscil   krad1, kfqc, 1, .25  ; 
asin2   oscil   krad2, kfqc, 1, .5
acos2   oscil   krad2, kfqc, 1, .75  ; 

ax1     =       asin1+.35
ay1     =       acos1-.80
ax2     =       asin2+.5
ay2     =       acos2-.20

axsq1   =       ax1*ax1
aysq1   =       ay1*ay1
axsq2   =       ax2*ax2
aysq2   =       ay2*ay2

; Compute the surface
az1     =       sqrt(axsq1*axsq1+aysq1*aysq1-axsq1-aysq1-axsq1*aysq1+1)
az2     =       sqrt(axsq2*axsq2+aysq2*aysq2-axsq2-aysq2-axsq2*aysq2+1)

abal1   balance az1, aamp1
abal2   balance az2, aamp1

aout1   atone   abal1, 10
aout2   atone   abal2, 10

        outs    aout1*kamp/5, aout2*kamp/5

        endin

;-----------------------------------------------------------
; 3 Space Planar Rotations
;-----------------------------------------------------------
        instr 50

ifqc    =    p4
iphase  =    p5
iplane  =    p6
inx     =    p7
iny     =    p8
inz     =    p9
ioutx   =    p10
iouty   =    p11
ioutz   =    p12

kcost  oscil 1, ifqc,   1, .25+iphase
ksint  oscil 1, ifqc,   1, iphase

ax      zar  inx
ay      zar  iny
az      zar  inz

; Rotation in X-Y plane
  if (iplane!=1) goto next1
    axr = ax*kcost + ay*ksint
    ayr =-ax*ksint + ay*kcost
    azr = az
    goto next3

; Rotation in X-Z plane
next1:
  if (iplane!=2) goto next2
    axr = ax*kcost + az*ksint
    ayr = ay
    azr =-ax*ksint + az*kcost
    goto next 3

; Rotation in Y-Z plane
next2:
    axr = ax
    ayr = ay*kcost + az*ksint
    azr =-ay*ksint + az*kcost

next3:
        zaw axr, ioutx
        zaw ayr, iouty
        zaw azr, ioutz

endin

;-----------------------------------------------------------
; 4 Space Planar Rotations
;-----------------------------------------------------------
        instr 51

ifqc    =    p4
iphase  =    p5
iplane  =    p6
inx     =    p7
iny     =    p8
inz     =    p9
inw     =    p10
ioutx   =    p11
iouty   =    p12
ioutz   =    p13
ioutw   =    p14

kcost  oscil 1, ifqc,   1, .25+iphase
ksint  oscil 1, ifqc,   1, iphase

ax      zar  inx
ay      zar  iny
az      zar  inz
aw      zar  inw

; Rotation in X-Y plane
  if (iplane!=1) goto next1
    axr = ax*kcost + ay*ksint
    ayr =-ax*ksint + ay*kcost
    azr = az
    awr = aw
    goto nextend

; Rotation in X-Z plane
next1:
  if (iplane!=2) goto next2
    axr = ax*kcost + az*ksint
    ayr = ay
    azr =-ax*ksint + az*kcost
    awr = aw
    goto nextend

; Rotation in Y-Z plane
next2:
  if (iplane!=3) goto next3
    axr = ax
    ayr = ay*kcost + az*ksint
    azr =-ay*ksint + az*kcost
    awr = aw
    goto nextend

; Rotation in X-W plane
next3:
  if (iplane!=4) goto next4
    axr = ax*kcost + aw*ksint
    ayr = ay
    azr = az
    awr =-ax*ksint + aw*kcost
    goto nextend

; Rotation in Y-W plane
next4:
  if (iplane!=5) goto next5
    axr = ax
    ayr = ay*kcost + aw*ksint
    azr = az
    awr =-ay*ksint + aw*kcost
    goto nextend

; Rotation in Z-W plane
next5:
  if (iplane!=6) goto nextend
    axr = ax
    ayr = ay
    azr = az*kcost + aw*ksint
    awr =-az*ksint + aw*kcost

nextend:
        zaw axr, ioutx
        zaw ayr, iouty
        zaw azr, ioutz
        zaw awr, ioutw

endin

;---------------------------------------------------------------------------
; Mixer Section
;---------------------------------------------------------------------------
          instr 100

idur      =     p3
iamp      =     p4
inch1     =     p5
inch2     =     p6

ain1      zar   inch1
ain2      zar   inch2

          outs  ain1*iamp, ain2*iamp

          endin

;---------------------------------------------------------------------------
; Clear audio & control channels
;---------------------------------------------------------------------------
          instr 110

          zacl  0, 50          ; Clear audio channels 0 to 30
          zkcl  0, 50          ; Clear control channels 0 to 30

          endin

