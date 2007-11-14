sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

          instr 6
          
; SHIMMERING INSTR #1
; VARIABLE #PARTIALS, POWER TO PARTIALS, STARTING PARTIAL, ETC
; P4=PCH P5=AMP P6=POWER P7=CHNL1AMP
                                             
i1        =          cpsoct(p4-2)
k1        linseg     0,p3/2,p5,p3/2,0        ; ENV
k2        randi      2,25
k3        oscil      .03,4+k2,1              ; RAND TREM
a1        gbuzz      .33+k3,i1,p6,1,50,4
k4        randi      1.2,15
k5        oscil      .03,4+k2,1              ; RAND TREM
a2        gbuzz      .33+k5,i1+(i1*.02),p6,1,50,4
k6        randi      1.5,20
k7        oscil      .03,4+k2,1              ; RAND TREM
a3        gbuzz      .33+k7,i1-(i1*.021),p6,1,50,4
a4        =          (a1+a2+a3)*k1
ga1       =          a4*p7
ga2       =          a4*(1-p7)
          outs       ga1,ga2
          endin

          instr 7   
; FINGER CYMBALS WHEN HIGH F, LOWER PITCHES INTERESTING TOO
; P4=PCH P5=AMP P6=CHNL1AMP

i1        =          cpsoct(p4)
k1        expseg     .0001,.05,p5,p3-.05,.0001       ; ENV
k2        linseg     1.69,.1,1.75,p3-.1,1.69         ; POWER TO PARTIALS
a1        foscil     k1,i1,1,2.01,k2,1
ga1       =          a1*p6
ga2       =          a1*(1-p6)
          outs       ga1,ga2
          endin

          instr 10,11,12,13,14,15       
          
; SIMPLE MARIMBA
; P4=PCH P5=AMP P6=BIAS

i1        =          cpsoct(p4)
i2        =         log(i1)/10.0 - p6
k1        expseg     .0001,.03,p5,p3-.03,.001      ; ENV
k25       linseg     1,.03,1,p3-.03,3
k1        =          k25*k1
k10       linseg     2.25,.03,3,p3-.03,2           ; POWER TO PARTIALS
a1        gbuzz      k1,i1,k10,0,35,4
a2        reson      a1,500,50,1     ;filt
a3        reson      a2,1500,100,1   ;filt
a4        reson      a3,2500,150,1   ;filt
a5        reson      a4,3500,150,1   ;filt
a6        balance    a5,a1
i6        =          p6
ga7       =         a6*i2
ga8       =         a6*(1-i2)
;;        display   a6, 0.25
          outs      ga7,ga8
;;        out       a6
          endin
