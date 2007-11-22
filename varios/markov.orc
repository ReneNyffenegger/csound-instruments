
;THIS ORCHESTRA IS AN ATTEMPT AT REALISING PITCH AND ONSET-TIME
;USING MARKOV PROCESSES.  THE CURRENT PROBLEM HAS TO DO
;WITH CLICKING OF ENVELOPES    A.D. HANNA
;MODIFIED ENVELOPES TO REDUCE POPPING M VIGORITO


  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  ga1       init      0

instr     1
  itablesize   =      32                          ;PITCH TABLES 2 AND 3 ARE INDEXED FROM 0 TO 31
  iratchoose   =      p9                          ;DETERMINES WHICH OF TWO TEMPOS ARE USED

  kdclick   linseg    0,.04,1,p3-.08,1,.04,0

;A NEAT WAY TO REPRESENT MARKOV CHAINS.
;CHOOSE BETWEEN TWO SUBSETS OF THE SET "FURNITURE"
if (iratchoose == 0) igoto furniture_to_sit_on
if (iratchoose == 1) igoto furniture_to_put_stuff_in

;----------------------------------------------------------------------
furniture_to_sit_on:
        ;BEING HERE DEPENDS ON OUTCOME OF p9

  kindex    phasor    p5*p6 
plantatulip:
  kenv      linen     1,.04,1/p5,1/p5*.5

  inotechoose  =      p8
        ;CHOOSE BETWEEN TWO PITCH TABLES
        ;THE SECOND OF WHICH IS A TRANSPOSITION
        ;OF THE FIRST IN THE ORDER OF 1 SEMITONE.
if (inotechoose == 1) igoto chair
if (inotechoose == 0) igoto sofa
        
        ;--------------------------------------------------
chair:
  ;BEING HERE DEPENDS ON THE OUTCOME OF p9 AND p8
  iipitch   table     i(kindex)*itablesize,2
            igoto     resume
        
        ;--------------------------------------------------
sofa:
   ;BEING HERE DEPENDS ON THE OUTCOME OF p9 AND p8
  iipitch   table     i(kindex)*itablesize,3
            igoto     resume

resume:
            timout    0,1/p5,pluckatulip
            reinit    plantatulip

;----------------------------------------------------------------------
furniture_to_put_stuff_in:
        ;BEING HERE DEPENDS ON OUTCOME OF p9
  kindex    phasor    (p5*p6)*1.125               ;varies phase of lfo vs beat 
        ;THUS CREATING MELODIC PATTERNS
plantadaisy:
  kenv      linen     1,.04,1/p5,1/p5*.5

  inotechoose  =      p8
if (inotechoose == 1) igoto bookcase
if (inotechoose == 0) igoto wardrobe

        ;-----------------------------------------------
bookcase:
       ;BEING HERE DEPENDS ON THE OUTCOME OF p9 AND p8
  iipitch   table     i(kindex)*itablesize,2
            igoto     continue

        ;--------------------------------------------------
wardrobe:
       ;BEING HERE DEPENDS ON THE OUTCOME OF p9 AND p8
  iipitch   table     i(kindex)*itablesize,3
            igoto     continue

continue:
            timout    0,1/p5,pluckatulip
            reinit    plantadaisy

pluckatulip:

  a2        oscili    ampdb(p4)*kenv*kdclick,cpspch(iipitch+p7),1 ;p7 = OCTAVE TRANSPOSITION     
  ga1       =  a2+ga1
            outs      a2,a2

endin

instr     50                    

  kfreq     expseg    0.01,p3*.2,.4,p3*.2,1,p3*.2,1.5,p3*.2,.1,p3*.2,.05
  k1        oscili    .5,kfreq*p4,1               ;kfreq*p4=cps of pan
  k2        =  .5+k1
  k3        =  1-k2
  a1        reverb2   ga1,2.1,.5
            outs      k2*a1,a1*k3*(-1)
  ga1       =  0
endin
