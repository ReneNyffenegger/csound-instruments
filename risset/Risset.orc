; Eight Instruments                       
; from                          
; Jean-Claude Risset's 
; Introductory Catalog of Computer Synthesized Sounds

; Translated from MusicV by: 
; David Helm, NYU & Joseph DiMeo, Brooklyn College

; These instruments are diagramed and explained in 
; Charles Dodge's "Computer Music" text. 

; Additional Coding by Curtis Bahn, Brooklyn College

; Additional Coding by Russell Pinkston, University of Texas - Austin

; Selected from the 
; Csound Anthology of Instruments, Orchestras, and Scores
; compiled and edited by Dr. Richard Boulanger
; Associate Professor
; Music Synthesis Department
; Berklee College of Music
; Boston, MA 02215

  sr        =  44100
  kr        =  4410
  ksmps     =  10

; RISSET'S FLUTE-LIKE                         
; #100                
; CODED BY THOMAS DIMEO - BROOKLYN COLLEGE

instr 1
if              p12 = 12 igoto dc1
  i1        =  .6
            goto      start
dc1:
  i1        =  .74
            goto      start
start:
  k1        randi     (p4*.01),p9
  k1        =  k1 + p4
  k2        oscil     k1,1/p11,p12
  k2        =  k2 + i1
  k3        oscil     k2,1/p6,p9
  a1        oscili    k3,p5,p10
            out       a1*10
endin

instr 2
  k1        oscil     p4,1/p6,p7
  k2        oscil     p5,1/p6,p8
  a1        oscili    k1,k2,1
            out       a1*10
endin

; RISSET'S WAVESHAPING CLARINET  
; CODED BY THOMAS DIMEO - BROOKLYN COLLEGE

instr 3
  i1        =  cpspch(p4)
  i2        =  .64
if              p3 >.75 igoto start
  i2        =  p3 - .085
start:
  a1        linen     255,.085,p3,i2
  a1        oscili    a1,i1,1
  a1        tablei    a1+256,2
            out       a1*p5
endin

; ANOTHER OF RISSET'S WAVESHAPING INSTRUMENTS 
; CODED BY THOMAS DIMEO - BROOKLYN COLLEGE

instr 4
  i1        =  1/p3
  i2        =  cpspch(p4)
  a1        oscili    p5,i1,2                     ; SCALING FACTOR CODE
  a2        oscili    a1,i2,1
  a3        linseg    1,.04,0,p3-.04,0
  a4        oscili    a3,i2*.7071,1               ; AUDIO CODE
                                                                        ; INLINE CODE FOR TRANSFER FUNCTION:
; f(x)=1+.841x-.707x**2-.595x**3+.5x**4+.42x**5-.354x**6-.279x**7+.25x**8+.21x**9
  a5        =  a4*a4
  a6        =  a5*a4
  a7        =  a5*a5
  a8        =  a7*a4
  a9        =  a6*a6
  a10       =  a9*a4
  a11       =  a10*a4
  a12       =  a11*a4
  a13       =  1+.841*a4-.707*a5-.595*a6+.5*a7+.42*a8-.354*a9-.297*a10+.25*a11+.21*a12
  a14       =  a13*a2
            out       a14
endin

; RISSET'S RING-MODULATION INSTRUMENT
; CODED BY THOMAS DIMEO - BROOKLYN COLLEGE

instr 5
  a1        expseg    .001,p7,1,p3-p7,.001
  a1        oscili    a1,p4,1
  a2        oscili    p5,p6,2
            out       a1*a2
endin

; RISSET'S ADDITIVE BELL INSTRUMENT
; CODED BY CURTIS BAHN - BROOKLYN COLLEGE

instr 6
  i1        =  p5                                 ; p3 = DURATION
  i2        =  p5*0.67                            ; p4 = FREQ IN Hz
  i3        =  p5*1.35                            ; p5 = AMPLITUDE
  i4        =  p5*1.80
  i5        =  p5*2.67
  i6        =  p5*1.67
  i7        =  p5*1.46
  i8        =  p5*1.33                            ; PEAK AMPS OF THE PARTIALS
  i9        =  p5*1.33                            ; ARE A FUNCTION OF THE AMP
  i10       =  p5*0.75                            ; OF THE LOWEST PARTIAL
  i11       =  p5*1.33
  i12       =  p3
  i13       =  p3*.9
  i14       =  p3*.65
  i15       =  p3*.55                             ; DURATIONS OF THE PARTIALS ARE A FUNCTION OF 
  i16       =  p3*.325                            ; THE DURATION OF THE LOWEST PARTIAL
  i17       =  p3*.35
  i18       =  p3*.25
  i19       =  p3*.2
  i20       =  p3*.15
  i21       =  p3*.1
  i22       =  p3*.075
  i23       =  p4*.56
  i24       =  (p4*.56)+1
  i25       =  p4*.92                             ; FREQUENCIES OF THE PARTIALS ARE A FUNCTION OF 
  i26       =  (p4*.92)+1.7                       ; THE FREQUENCY OF THE FUNDAMENTAL
  i27       =  p4*1.19
  i28       =  p4*1.7
  i29       =  p4*2       
  i30       =  p4*2.74
  i31       =  p4*3
  i32       =  p4*3.75
  i33       =  p4*4.07

  k1        oscil1    0,i1,i12,2
  a1        oscili    k1,i23,1                    ; THE INSTRUMENT CONSISTS OF PAIRS OF oscil1/oscili
  k2        oscil1    0,i2,i13,2                  ; WHERE OSCIL1 PROVIDES THE ENVELOPE OF THE PARTIAL
  a2        oscili    k1,i24,1                    ; AND OSCILI THE PARTIAL ITSELF
  k3        oscil1    0,i3,i14,2
  a3        oscili    k1,i25,1
  k4        oscil1    0,i4,i15,2
  a4        oscili    k1,i26,1
  k5        oscil1    0,i5,i16,2
  a5        oscili    k1,i27,1
  k6        oscil1    0,i6,i17,2
  a6        oscili    k1,i28,1
  k7        oscil1    0,i7,i18,2
  a7        oscili    k1,i29,1
  k8        oscil1    0,i8,i19,2
  a8        oscili    k1,i30,1
  k9        oscil1    0,i9,i20,2
  a9        oscili    k1,i31,1
  k10       oscil1    0,i10,i21,2
  a10       oscili    k1,i32,1
  k11       oscil1    0,i11,i22,2
  a11       oscili    k1,i33,1
            out       a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11
endin

; RISSET'S DRUM INSTRUMENT 
; CODED BY THOMAS DIMEO - BROOKLYN COLLEGE

instr 7
  i1        =  p5*.3
  i2        =  p4*.1
  i3        =  1/p3
  i4        =  p5*.8
  i5        =  p4

  a1        randi     p5,4000
  a1        oscil     a1,i3,2
  a1        oscil     a1,3000,
   
  a2        oscil     i1,i3,2
  a2        oscil     a2,i2,3

  a3        oscil     i4,i3,4
  a3        oscil     a3,i5,1

            out       a1+a2+a3
endin

; RISSET'S ARPEGGIO INSTRUMENT 
; CODED BY CURTIS BAHN - BROOKLYN COLLEGE

instr 8
  i1        =  p6                                 ; INIT VALUES CORRESPOND TO FREQ.
  i2        =  2*p6                               ; OFFSETS FOR OSCILLATORS BASED ON ORIGINAL p6
  i3        =  3*p6
  i4        =  4*p6

  ampenv    linen     p5,.01,p3,.02               ; A SIMPLE ENVELOPE TO PREVENT CLICKING.

  a1        oscili    ampenv,p4,2
  a2        oscili    ampenv,p4+i1,2              ; NINE OSCILLATORS WITH THE SAME AMP ENV
  a3        oscili    ampenv,p4+i2,2              ; AND WAVEFORM, BUT SLIGHTLY DIFFERENT
  a4        oscili    ampenv,p4+i3,2              ; FREQUENCIES TO CREATE THE BEATING EFFECT
  a5        oscili    ampenv,p4+i4,2
  a6        oscili    ampenv,p4-i1,2              ; p4 = FREQ OF FUNDAMENTAL (Hz)
  a7        oscili    ampenv,p4-i2,2              ; p5 = AMP
  a8        oscili    ampenv,p4-i3,2              ; p6 = INITIAL OFFSET OF FREQ - .03 Hz
  a9        oscili    ampenv,p4-i4,2
            out       a1+a2+a3+a4+a5+a6+a7+a8+a9
endin                                   
