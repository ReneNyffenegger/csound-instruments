  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1

  inote     =  cpspch( p5)
  ipnote    =  cpspch( p4)

  ivoice    =  p6
  ivowel    =  p10

  iform1freq   =      0
  iform2freq   =      0
  iform3freq   =      0
  iform4freq   =      0
  iform5freq   =      0
        
  i1        =  0

            igoto     sel

pv:
if      i1      ==      2 igoto numcrunch
if      i1      ==      1 igoto nv

  ipform1   =  iform1freq
  ipform2   =  iform2freq
  ipform3   =  iform3freq
  ipform4   =  iform4freq
  ipform5   =  iform5freq

  i1        =  1
  ivowel    =  p11
            igoto     sel
nv:

  inform1   =  iform1freq
  inform2   =  iform2freq
  inform3   =  iform3freq
  inform4   =  iform4freq
  inform5   =  iform5freq

  ivowel    =  p7
  i1        =  2
            igoto     sel
        
sel:
if      ivoice == 0 igoto bs
if      ivoice == 1 igoto tn
if      ivoice == 2 igoto ct
if      ivoice == 3 igoto al
if      ivoice == 4 igoto sp
        
;VOWEL FORMANT TABLES

bs:
                                                                        ;BASS
  iolaps    =  4
if      ivowel == 0 igoto ba
if      ivowel == 1 igoto be
if      ivowel == 2 igoto bi
if      ivowel == 3 igoto bo
if      ivowel == 4 igoto bu
        
ba:
  iform1freq   =      600                         ;Bass /a/
  iform2freq   =      1040
  iform3freq   =      2250
  iform4freq   =      2450
  iform5freq   =      2750

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -7)
  iform3amp =  ampdb( 84 +  -9)
  iform4amp =  ampdb( 84 +  -9)
  iform5amp =  ampdb( 84 +  -20)

  iform1band   =      60
  iform2band   =      70
  iform3band   =      110
  iform4band   =      120
  iform5band   =      130
            igoto     pv

be:
  iform1freq   =      400                         ;Bass /e/
  iform2freq   =      1620
  iform3freq   =      2400
  iform4freq   =      2800
  iform5freq   =      3100

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -12)
  iform3amp =  ampdb( 84 +  -9)
  iform4amp =  ampdb( 84 +  -12)
  iform5amp =  ampdb( 84 +  -18)

  iform1band   =      40
  iform2band   =      80
  iform3band   =      100
  iform4band   =      120
  iform5band   =      120
            igoto     pv
        
bi:
  iform1freq   =      250                         ;Bass /i/
  iform2freq   =      1750
  iform3freq   =      2600
  iform4freq   =      3050
  iform5freq   =      3340

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -30)
  iform3amp =  ampdb( 84 +  -16)
  iform4amp =  ampdb( 84 +  -22)
  iform5amp =  ampdb( 84 +  -28)

  iform1band   =      60
  iform2band   =      90
  iform3band   =      100
  iform4band   =      120
  iform5band   =      120
            igoto     pv
        
bo:
  iform1freq   =      400                         ;Bass /o/
  iform2freq   =      750
  iform3freq   =      2400
  iform4freq   =      2600
  iform5freq   =      2900

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -11)
  iform3amp =  ampdb( 84 +  -21)
  iform4amp =  ampdb( 84 +  -20)
  iform5amp =  ampdb( 84 +  -40)

  iform1band   =      40
  iform2band   =      80
  iform3band   =      100
  iform4band   =      120
  iform5band   =      120
            igoto     pv
        
bu:
  iform1freq   =      350                         ;Bass /u/
  iform2freq   =      600
  iform3freq   =      2400
  iform4freq   =      2675
  iform5freq   =      2950

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -20)
  iform3amp =  ampdb( 84 +  -32)
  iform4amp =  ampdb( 84 +  -28)
  iform5amp =  ampdb( 84 +  -36)

  iform1band   =      40
  iform2band   =      80
  iform3band   =      100
  iform4band   =      120
  iform5band   =      120
            igoto     pv


tn:
                                                                                ;TENOR
  iolaps    =  5
if ivowel       ==      0 igoto ta
if ivowel       ==      1 igoto te
if ivowel       ==      2 igoto ti
if ivowel       ==      3 igoto to
if ivowel       ==      4 igoto tu
        
ta:
  iform1freq   =      650                         ;Tenor /a/
  iform2freq   =      1080
  iform3freq   =      2650
  iform4freq   =      2900
  iform5freq   =      3250

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -6)
  iform3amp =  ampdb( 84 +  -7)
  iform4amp =  ampdb( 84 +  -8)
  iform5amp =  ampdb( 84 +  -22)

  iform1band   =      80
  iform2band   =      90
  iform3band   =      120
  iform4band   =      130
  iform5band   =      140
            igoto     pv

te:
  iform1freq   =      400                         ;Tenor /e/
  iform2freq   =      1700
  iform3freq   =      2600
  iform4freq   =      3200
  iform5freq   =      3580

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -14)
  iform3amp =  ampdb( 84 +  -12)
  iform4amp =  ampdb( 84 +  -14)
  iform5amp =  ampdb( 84 +  -20)

  iform1band   =      70
  iform2band   =      80
  iform3band   =      100
  iform4band   =      120
  iform5band   =      120
            igoto     pv

ti:
  iform1freq   =      290                         ;Tenor /i/
  iform2freq   =      1870
  iform3freq   =      2800
  iform4freq   =      3250
  iform5freq   =      3540

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -15)
  iform3amp =  ampdb( 84 +  -18)
  iform4amp =  ampdb( 84 +  -20)
  iform5amp =  ampdb( 84 +  -30)

  iform1band   =      40
  iform2band   =      90
  iform3band   =      100
  iform4band   =      120
  iform5band   =      120
            igoto     pv

to:
  iform1freq   =      400                         ;Tenor /o/
  iform2freq   =      800
  iform3freq   =      2600
  iform4freq   =      2800
  iform5freq   =      3000

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -10)
  iform3amp =  ampdb( 84 +  -12)
  iform4amp =  ampdb( 84 +  -12)
  iform5amp =  ampdb( 84 +  -26)

  iform1band   =      40
  iform2band   =      80
  iform3band   =      100
  iform4band   =      120
  iform5band   =      120
            igoto     pv

tu:
  iform1freq   =      350                         ;Tenor /u/
  iform2freq   =      600
  iform3freq   =      2700
  iform4freq   =      2900
  iform5freq   =      3300

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -20)
  iform3amp =  ampdb( 84 +  -17)
  iform4amp =  ampdb( 84 +  -14)
  iform5amp =  ampdb( 84 +  -26)

  iform1band   =      40
  iform2band   =      60
  iform3band   =      100
  iform4band   =      120
  iform5band   =      120
            igoto     pv


ct:
                                                                                ;COUNTERTENOR
  iolaps    =  6
if ivowel       ==      0 igoto cta
if ivowel       ==      1 igoto cte
if ivowel       ==      2 igoto cti
if ivowel       ==      3 igoto cto
if ivowel       ==      4 igoto ctu
        
cta:
  iform1freq   =      660                         ;Countertenor /a/
  iform2freq   =      1120
  iform3freq   =      2750
  iform4freq   =      3000
  iform5freq   =      3350

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -6)
  iform3amp =  ampdb( 84 +  -23)
  iform4amp =  ampdb( 84 +  -24)
  iform5amp =  ampdb( 84 +  -38)

  iform1band   =      80
  iform2band   =      90
  iform3band   =      120
  iform4band   =      130
  iform5band   =      140
            igoto     pv

cte:
  iform1freq   =      440                         ;Countertenor /e/
  iform2freq   =      1800
  iform3freq   =      2700
  iform4freq   =      3000
  iform5freq   =      3300

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -14)
  iform3amp =  ampdb( 84 +  -18)
  iform4amp =  ampdb( 84 +  -20)
  iform5amp =  ampdb( 84 +  -20)
        
  iform1band   =      70
  iform2band   =      80
  iform3band   =      100
  iform4band   =      120
  iform5band   =      120
            igoto     pv

cti:
  iform1freq   =      270                         ;Countertenor /i/
  iform2freq   =      1850
  iform3freq   =      2900
  iform4freq   =      3350
  iform5freq   =      3590

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -24)
  iform3amp =  ampdb( 84 +  -24)
  iform4amp =  ampdb( 84 +  -36)
  iform5amp =  ampdb( 84 +  -36)
        
  iform1band   =      40
  iform2band   =      90
  iform3band   =      100
  iform4band   =      120
  iform5band   =      120
            igoto     pv

cto:
  iform1freq   =      430                         ;Countertenor /o/
  iform2freq   =      820
  iform3freq   =      2700
  iform4freq   =      3000
  iform5freq   =      3300

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -10)
  iform3amp =  ampdb( 84 +  -26)
  iform4amp =  ampdb( 84 +  -22)
  iform5amp =  ampdb( 84 +  -34)
        
  iform1band   =      40
  iform2band   =      80
  iform3band   =      100
  iform4band   =      120
  iform5band   =      120
            igoto     pv

ctu:
  iform1freq   =      370                         ;Countertenor /u/
  iform2freq   =      630
  iform3freq   =      2750
  iform4freq   =      3000
  iform5freq   =      3400

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -20)
  iform3amp =  ampdb( 84 +  -23)
  iform4amp =  ampdb( 84 +  -30)
  iform5amp =  ampdb( 84 +  -34)
        
  iform1band   =      40
  iform2band   =      60
  iform3band   =      100
  iform4band   =      120
  iform5band   =      120
            igoto     pv

al:
                                                                                ;ALTO
  iolaps    =  7
if ivowel       ==      0 igoto aa
if ivowel       ==      1 igoto ae
if ivowel       ==      2 igoto ai
if ivowel       ==      3 igoto ao
if ivowel       ==      4 igoto au
        
aa:
  iform1freq   =      800                         ;Alto /a/
  iform2freq   =      1150
  iform3freq   =      2800
  iform4freq   =      3500
  iform5freq   =      4950

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -4)
  iform3amp =  ampdb( 84 +  -20)
  iform4amp =  ampdb( 84 +  -36)
  iform5amp =  ampdb( 84 +  -60)
        
  iform1band   =      80
  iform2band   =      90
  iform3band   =      120
  iform4band   =      130
  iform5band   =      140
            igoto     pv

ae:
  iform1freq   =      400                         ;Alto /e/
  iform2freq   =      1600
  iform3freq   =      2700
  iform4freq   =      3300
  iform5freq   =      4950

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -24)
  iform3amp =  ampdb( 84 +  -30)
  iform4amp =  ampdb( 84 +  -35)
  iform5amp =  ampdb( 84 +  -60)
        
  iform1band   =      60
  iform2band   =      80
  iform3band   =      120
  iform4band   =      150
  iform5band   =      200
            igoto     pv

ai:
  iform1freq   =      350                         ;Alto /i/
  iform2freq   =      1700
  iform3freq   =      2700
  iform4freq   =      3700
  iform5freq   =      4950

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -20)
  iform3amp =  ampdb( 84 +  -30)
  iform4amp =  ampdb( 84 +  -36)
  iform5amp =  ampdb( 84 +  -60)
        
  iform1band   =      50
  iform2band   =      100
  iform3band   =      120
  iform4band   =      150
  iform5band   =      200
            igoto     pv

ao:
  iform1freq   =      450                         ;Alto /o/
  iform2freq   =      800
  iform3freq   =      2830
  iform4freq   =      3500
  iform5freq   =      4950

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -9)
  iform3amp =  ampdb( 84 +  -16)
  iform4amp =  ampdb( 84 +  -28)
  iform5amp =  ampdb( 84 +  -55)
        
  iform1band   =      70
  iform2band   =      80
  iform3band   =      100
  iform4band   =      130
  iform5band   =      135
            igoto     pv

au:
  iform1freq   =      325                         ;Alto /u/
  iform2freq   =      700
  iform3freq   =      2530
  iform4freq   =      3500
  iform5freq   =      4950

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -12)
  iform3amp =  ampdb( 84 +  -30)
  iform4amp =  ampdb( 84 +  -40)
  iform5amp =  ampdb( 84 +  -64)
        
  iform1band   =      50
  iform2band   =      60
  iform3band   =      170
  iform4band   =      180
  iform5band   =      200
            igoto     pv

sp:
                                                                                ;SOPRANO
  iolaps    =  8
if ivowel               ==      0 igoto sa
if ivowel       ==      1 igoto se
if ivowel       ==      2 igoto si
if ivowel       ==      3 igoto so
if ivowel       ==      4 igoto su
        
sa:
  iform1freq   =      800                         ;Soprano /a/
  iform2freq   =      1150
  iform3freq   =      2900
  iform4freq   =      3900
  iform5freq   =      4950

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -6)
  iform3amp =  ampdb( 84 +  -32)
  iform4amp =  ampdb( 84 +  -20)
  iform5amp =  ampdb( 84 +  -50)

  iform1band   =      80
  iform2band   =      90
  iform3band   =      120
  iform4band   =      130
  iform5band   =      140
            igoto     pv

se:
  iform1freq   =      350                         ;Soprano /e/
  iform2freq   =      2000
  iform3freq   =      2800
  iform4freq   =      3600
  iform5freq   =      4950

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -20)
  iform3amp =  ampdb( 84 +  -15)
  iform4amp =  ampdb( 84 +  -40)
  iform5amp =  ampdb( 84 +  -56)
        
  iform1band   =      60
  iform2band   =      100
  iform3band   =      120
  iform4band   =      150
  iform5band   =      200
            igoto     pv

si:
  iform1freq   =      270                         ;Soprano /i/
  iform2freq   =      2140
  iform3freq   =      2950
  iform4freq   =      3900
  iform5freq   =      4950

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -12)
  iform3amp =  ampdb( 84 +  -26)
  iform4amp =  ampdb( 84 +  -26)
  iform5amp =  ampdb( 84 +  -44)
        
  iform1band   =      60
  iform2band   =      90
  iform3band   =      100
  iform4band   =      120
  iform5band   =      120
            igoto     pv

so:
  iform1freq   =      450                         ;Soprano /o/
  iform2freq   =      800
  iform3freq   =      2830
  iform4freq   =      3800
  iform5freq   =      4950

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -11)
  iform3amp =  ampdb( 84 +  -22)
  iform4amp =  ampdb( 84 +  -22)
  iform5amp =  ampdb( 84 +  -50)
        
  iform1band   =      70
  iform2band   =      80
  iform3band   =      100
  iform4band   =      130
  iform5band   =      135
            igoto     pv

su:
  iform1freq   =      325                         ;Soprano /u/
  iform2freq   =      700
  iform3freq   =      2700
  iform4freq   =      3800
  iform5freq   =      4950

  iform1amp =  ampdb( 84 +  0)
  iform2amp =  ampdb( 84 +  -16)
  iform3amp =  ampdb( 84 +  -35)
  iform4amp =  ampdb( 84 +  -40)
  iform5amp =  ampdb( 84 +  -60)
        
  iform1band   =      50
  iform2band   =      60
  iform3band   =      170
  iform4band   =      180
  iform5band   =      200
            igoto     pv

numcrunch:

;PITCH, VIBRATO AND AMPLITUDE CONTROLS
        
  kvibdepth linseg    0,      4,      1,      p3 - 4, 0
  kvib      oscil     2 * kvibdepth,  5 ,     1

  krand1    randi     .7,     4
  krand2    randi     .3,     6
  krand     =  krand1 + krand2 
  kfund     =  kvib + krand

  kenv      linseg    p8, .1, 1.3, .1, 1, p3 - .4, 1, .2, p9
  krand3    randi     .2, 4
  kamp      =  kenv + krand3 - .1

  knote     expseg    ipnote, .2,     inote,  p3 - .2, inote
  kpitch    =  knote + kfund
        
;FORMANT FUNCTION GENERATORS

  kform1    linseg    ipform1, p12 / 2, iform1freq, p3 - p12, iform1freq, p12 / 2, inform1
  kform2    linseg    ipform2, p12 / 2, iform2freq, p3 - p12, iform2freq, p12 / 2, inform2
  kform3    linseg    ipform3, p12 / 2, iform3freq, p3 - p12, iform3freq, p12 / 2, inform3
  kform4    linseg    ipform4, p12 / 2, iform4freq, p3 - p12, iform4freq, p12 / 2, inform4
  kform5    linseg    ipform5, p12 / 2, iform5freq, p3 - p12, iform5freq, p12 / 2, inform5

;FORMANTS

  aform1    fof       iform1amp * kamp, kpitch, kform1, 1, iform1band, .003, .01, .007, iolaps, 1, 1, p3 + p3 / inote
  aform2    fof       iform2amp * kamp, kpitch, kform2, 1, iform2band, .003, .01, .007, iolaps, 1, 1, p3 + p3 / inote
  aform3    fof       iform3amp * kamp, kpitch, kform3, 1, iform3band, .003, .01, .007, iolaps, 1, 1, p3 + p3 / inote
  aform4    fof       iform4amp * kamp, kpitch, kform4, 1, iform4band, .003, .01, .007, iolaps, 1, 1, p3 + p3 / inote
  aform5    fof       iform5amp * kamp, kpitch, kform5, 1, iform5band, .003, .01, .007, iolaps, 1, 1, p3 + p3 / inote

;SUMMATION OF FORMANTS AND OUTPUT

  avx       =  (aform1 + aform2 + aform3 + aform4 + aform5) / p13
            out       avx
endin
