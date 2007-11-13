sr=44100
kr=4410
ksmps=10
nchnls=2

instr 1 ;Global initialization

  gi2fqc init cpspch(p4)
  gi3fqc init cpspch(p5)

endin

instr 2 ; Epicycloid or Spirograph curve
        ; This set of parametric equations defines the path traced by
        ; a point on a circle of radius B rotating outside a circle of
        ; radius A.

ifqc   init cpspch(p5)
ifqci  init gi2fqc
gi2fqc init ifqc
ia     init p6
ib     init p7
ihole  init p8
iscale init 1/(ia+2*ib)

kampenv linseg 0, .02, p4*iscale, p3-.04, p4*iscale, .02, 0
kptchenv linseg ifqci, .2*p3, ifqc, .8*p3, ifqc
kvibenv  linseg 0, .5, 0, .2, 1, .2, 1
kvibr oscil 20, 8, 1
kfqc = kptchenv+kvibr*kvibenv

; Sine and Cosine
acos1 oscil ia+ib, kfqc, 1, .25
acos2 oscil ib*ihole, (ia-ib)/ib*kfqc, 1, .25
ax = acos1 + acos2

asin1 oscil ia+ib, kfqc, 1
asin2 oscil ib, (ia-ib)/ib*kfqc, 1
ay = asin1 - asin2

outs kampenv*ax, kampenv*ay

endin

instr 3 ; Hypocycloid or Spirograph curve
        ; This set of parametric equations defines the path traced by
        ; a point on a circle of radius B rotating inside a circle of
        ; radius A.

ifqc = cpspch(p5)
ifqci  init gi3fqc
gi3fqc init ifqc
ia   = p6
ib   = p7
ihole = p8
iscale = (ia<ib ? 1/ib:1/ia)

kampenv linseg 0, .1, p4*iscale, p3-.2, p4*iscale, .1, 0
kptchenv linseg ifqci, .2*p3, ifqc, .8*p3, ifqc
kvibenv  linseg 0, .5, 0, .2, 1, .2, 1
kvibr oscil 20, 8, 1
kfqc = kptchenv+kvibr*kvibenv

; Sine and Cosine
acos1 oscil ia-ib, kfqc, 1, .25
acos2 oscil ib*ihole, (ia-ib)/ib*kfqc, 1, .25
ax = acos1 + acos2

asin1 oscil ia-ib, kfqc, 1
asin2 oscil ib, (ia-ib)/ib*kfqc, 1
ay = asin1 - asin2

outs kampenv*ax, kampenv*ay

endin

instr 4 ; Banchoff Klein Bottle

ifqc init cpspch(p5)
iu   init p6
iv   init p7
irt2 init sqrt(2)

kampenv linseg 0, .02, p4, p3-.04, p4, .02, 0

; Cosines
acosu  oscil 1, iu*ifqc,   1, .25
acosu2 oscil 1, iu*ifqc/2, 1, .25
acosv  oscil 1, iv*ifqc,   1, .25

; Sines
asinu  oscil 1, iu*ifqc,   1
asinu2 oscil 1, iu*ifqc/2, 1
asinv  oscil 1, iv*ifqc,   1

; Compute X and Y
ax = acosu*(acosu2*(irt2+acosv)+asinu2*asinv*acosv)
ay = asinu*(acosu2*(irt2+acosv)+asinu2*asinv*acosv)

; Low frequency rotation in spherical coordinates z, phi, theta.
  klfsinth oscil 1,4,1
  klfsinph oscil 1,1,1
  klfcosth oscil 1,4,1,.25
  klfcosph oscil 1,1,1,.25

  aox=-ax*klfsinth+ay*klfcosth
  aoy=-ax*klfsinth*klfcosph-ay*klfsinth*klfcosph+klfsinph


outs kampenv*aox, kampenv*aoy

endin
