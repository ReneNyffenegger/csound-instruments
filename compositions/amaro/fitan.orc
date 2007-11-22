  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2

  ga1       init      0
  ga2       init      0


instr 3
  ishift    =  .00666667                          ;altera em 8/1200.
  ipch      =  cpspch(p5)                         ;converte o parâmetro 5 em cps.
  ioct      =  octpch(p5)                         ;converte o parâmeter 5 em oct.

  kadsr     linseg    0,p3/3,1.0,p3*(3/6),1.0,p3*(1/6),0 ;envelope ADSR (*)
  kmodi     linseg    0,p3/3,5,p3/3,3,p3/3,0      ;envelope ADSR para I
  kmodr     linseg    p6,p3,p7                    ;r move de p6 para p7 em p3 segs.
  a1        =  kmodi*(kmodr - 1/kmodr)/2
  a1ndx     =  abs(a1*2/20)                       ;a1*2 é argumento normalizado de 0-1.
  a2        =  kmodi*(kmodr + 1/kmodr)/2  
  a3        tablei    a1ndx,33,1                  ;tabela está em f33, índice normalizado.
  ao1       oscil     a1,ipch,32                  ;cossseno
  a4        =  exp(-0.5*a3+ao1)
  ao2       oscil     a2*ipch,ipch,32             ;cosseno
  aoutl     oscil     1000*kadsr*a4,ao2+cpsoct(ioct+ishift),31 ;saída canal esq.
  aoutr     oscil     1000*kadsr*a4,ao2+cpsoct(ioct-ishift),31 ;saída canal dir.
            outs      aoutl,aoutr
endin

instr 33 ; i3 com alteração para o decrescendo
  ishift    =  .00666667
  ipch      =  cpspch(p5)
  ioct      =  octpch(p5)

  kadsr     linseg    0,.1,1.0,p3-.1,0            ;envelope com alteração(*)
  kmodi     linseg    0,p3/3,5,p3/3,3,p3/3,0
  kmodr     linseg    p6,p3,p7
  a1        =  kmodi*(kmodr - 1/kmodr)/2
  a1ndx     =  abs(a1*2/20)
  a2        =  kmodi*(kmodr + 1/kmodr)/2  
  a3        tablei    a1ndx,33,1
  ao1       oscil     a1,ipch,32
  a4        =  exp(-0.5*a3+ao1)
  ao2       oscil     a2*ipch,ipch,32
  aoutl     oscil     1000*kadsr*a4,ao2+cpsoct(ioct+ishift),31
  aoutr     oscil     1000*kadsr*a4,ao2+cpsoct(ioct-ishift),31
            outs      aoutl,aoutr
endin

instr 34 ; i3 com alteração para o crescendo
  ishift    =  .00666667
  ipch      =  cpspch(p5)
  ioct      =  octpch(p5)

  kadsr     expseg    .1,p3,1.0                   ;envelope com alteração (*)
  kmodi     linseg    0,p3/3,5,p3/3,3,p3/3,0
  kmodr     linseg    p6,p3,p7
  a1        =  kmodi*(kmodr - 1/kmodr)/2
  a1ndx     =  abs(a1*2/20)
  a2        =  kmodi*(kmodr + 1/kmodr)/2  
  a3        tablei    a1ndx,33,1
  ao1       oscil     a1,ipch,32
  a4        =  exp(-0.5*a3+ao1)
  ao2       oscil     a2*ipch,ipch,32
  aoutl     oscil     1000*kadsr*a4,ao2+cpsoct(ioct+ishift),31
  aoutr     oscil     1000*kadsr*a4,ao2+cpsoct(ioct-ishift),31
            outs      aoutl,aoutr
endin

instr 5
  ga1       init      0

  k1        oscili    .5,p4,11                    ;p4=cps do pan
  k2        =  .5+k1
  k3        =  1-k2
  a1        reverb    ga1,2.1
            outs      k2*a1,(k3*a1)*(-1)
  ga1       =  0
endin

instr 6
  p4        =  cpspch(p4)                         ;p4 = frequência em Hz(*)
  i1        =  p5                                 ;p5 = amplitude
  i12       =  p3
  i23       =  p4*.56
  i24       =  (p4*.56)+1
  i25       =  p4*.92                             ;frequencias dos parciais são função da
  i26       =  (p4*.92)+1.7                       ;frequência da fundamental
  i27       =  p4*1.19
  i28       =  p4*1.7
  i29       =  p4*2
  i30       =  p4*2.74
  i31       =  p4*3
  i32       =  p4*3.75
  i33       =  p4*4.07
  
  k1        oscil1    0,i1,i12,5
  a1        oscili    k1,i23,1
  a2        oscili    k1,i24,1
  a3        oscili    k1,i25,1
  a4        oscili    k1,i26,1
  a5        oscili    k1,i27,1
  a6        oscili    k1,i28,1
  a7        oscili    k1,i29,1
  a8        oscili    k1,i30,1
  a9        oscili    k1,i31,1
  a10       oscili    k1,i32,1
  a11       oscili    k1,i33,1
  asig      =  a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11
            outs      asig,asig
endin

instr 7
  i1        =  p5*.3
  i2        =  cpspch(p4)*.1
  i3        =  1/p3
  i4        =  p5*.8
  i5        =  cpspch(p4)

  a1        randi     p5,4000
  a1        oscil     a1,i3,2
  a1        oscil     a1,3000,1
  a2        oscil     i1,i3,2
  a2        oscil     a2,i2,3
  a3        oscil     i4,i3,4
  a3        oscil     a3,i5,1
            outs      a1+a2+a3,a1+a2+a3
endin

instr 9
  i1        =  cpspch(p5)

  k1        linen     p6,p3*.1,p3,p3*.8           ;p4=atenuação do delay
  k2        randh     p8,p9,.1                    ;p6=amplitude
  k3        randh     p8*.98,p9*.91,.2            ;p7=atenuação da reverberação
  k4        randh     p8*1.2,p9*.96,.3            ;p8=amplitude do randh
  k5        randh     p8*.9,p9*1.3                ;p9=frequência do rand
  a1        oscili    k1,i1+k2,11,.2              ;p10=1 para espaço
  a3        oscili    k1*.91,(i1+.004)+k3,92,.3
  a5        oscili    k1*.85,(i1+.006)+k4,93,.5
  a7        oscili    k1*.95,(i1+.009)+k5,94,.8
  a8        =  a1+a3+a5+a7
  ga1       =  ga1+(p7*a8)
  ga2       =  ga2+(p4*a8)
            outs      a1+a5,a3+a7
endin

instr 91 ;glissando e crescendo
  i1        =  cpspch(p5)                         ;p5=nota de saída do gliss(*)
  i2        =  cpspch(p10)                        ;p10=nota de chegada do gliss(*)

  kgliss    linseg    i1,p3*(5/6),i2,p3*(1/6),i2  ;(*)
  k1        linen     p6,p3*(5/6),p3,0            ;crescendo(*)
  k2        randh     p8,p9,.1
  k3        randh     p8*.98,p9*.91,.2
  k4        randh     p8*1.2,p9*.96,.3
  k5        randh     p8*.9,p9*1.3
  a1        oscili    k1,kgliss+k2,11,.2
  a3        oscili    k1*.91,(kgliss+.004)+k3,92,.3 ;(*)
  a5        oscili    k1*.85,(kgliss+.006)+k4,93,.5 ;(*)
  a7        oscili    k1*.95,(kgliss+.009)+k5,94,.8 ;(*)
  a8        =  a1+a3+a5+a7
  ga1       =  ga1+(p7*a8)
  ga2       =  ga2+(p4*a8)
            outs      a1+a5,a3+a7
endin

instr 92 ; novo envelope
  i1        =  cpspch(p5)

  kenv      line      0, p3, 256                  ;novo envelope(*)
  k1        table     kenv,91                     ;(*)
  k1        =  p6*k1                              ;(*)
  k2        randh     p8,p9,.1
  k3        randh     p8*.98,p9*.91,.2
  k4        randh     p8*1.2,p9*.96,.3
  k5        randh     p8*.9,p9*1.3
  a1        oscili    k1,i1+k2,11,.2
  a3        oscili    k1*.91,(i1+.004)+k3,92,.3
  a5        oscili    k1*.85,(i1+.006)+k4,93,.5
  a7        oscili    k1*.95,(i1+.009)+k5,94,.8
  a8        =  a1+a3+a5+a7
  ga1       =  ga1+(p7*a8)
  ga2       =  ga2+(p4*a8)
            outs      a1+a5,a3+a7
endin

instr 93 ; glissando e decrescendo; glissando e crescendo menores
  i1        =  cpspch(p5)                         ;p5=nota de saída do gliss(*)             
  i2        =  cpspch(p10)                        ;p10=nota de chegada do gliss no grave(*)
  i3        =  cpspch(p11)                        ;p11=nota de chegada do último glissando no     
      ;registro médio(*)

  kgliss    linseg    i1,p3*(30/57),i2,p3*(17/57),i2,p3*(1/57),i3,p3*(9/57),i3 ;(*)

  k1        expseg    p6,p3*(36/57),p6*.2,p3*(11/57),p6*.2,p3*(1/57),p6*.4,p3*(9/57), p6*.4  
      ;decrescendo, pianíssimo e cresc. até piano(*)        
   
  k2        randh     p8,p9,.1
  k3        randh     p8*.98,p9*.91,.2
  k4        randh     p8*1.2,p9*.96,.3
  k5        randh     p8*.9,p9*1.3
  a1        oscili    k1,kgliss+k2,11,.2          ;(*)
  a3        oscili    k1*.91,(kgliss+.004)+k3,92,.3 ;(*)
  a5        oscili    k1*.85,(kgliss+.006)+k4,93,.5 ;(*)
  a7        oscili    k1*.95,(kgliss+.009)+k5,94,.8 ;(*)
  a8        =  a1+a3+a5+a7
  ga1       =  ga1+(p7*a8)
  ga2       =  ga2+(p4*a8)
            outs      a1+a5,a3+a7
endin

instr 94    ;ascelerando
  i1        =  cpspch(p5)
  itamanho  =  4                                  ;(*)

  kascel    linseg    .1, p3*2/3, 1, p3*1/3, 1    ;(*)
  k6        phasor    kascel                      ;(*)
  k7        table     k6*itamanho,5               ;(*)
  knota     =  cpspch(k7)                         ;(*)
  k1        linen     p6,p3*.1,p3,p3*.8
  k2        randh     p8,p9,.1
  k3        randh     p8*.98,p9*.91,.2
  k4        randh     p8*1.2,p9*.96,.3
  k5        randh     p8*.9,p9*1.3
  a1        oscili    k1,knota+k2,11,.2           ;(*)
  a3        oscili    k1*.91,(knota+.004)+k3,92,.3 ;(*)
  a5        oscili    k1*.85,(knota+.006)+k4,93,.5 ;(*)
  a7        oscili    k1*.95,(knota+.009)+k5,94,.8 ;(*)
  a8        =  a1+a3+a5+a7
  ga1       =  ga1+(p7*a8)
  ga2       =  ga2+(p4*a8)
            outs      a1+a5,a3+a7
endin

instr 11
  ga2       init      0
  a1        delay     ga2,.05
            outs      a1,a1
  ga2       =  0
endin

instr 13
  i1        =  octpch(p5)

  k1        linseg    0,p3*.8,9,p3*.2,1           ;p6=amplitude
  k2        phasor    k1                          ;p7=início da varredura do filtro
  k3        table     k2*8,22                     ;p8=pico da varredura
  k4        expseg    p7,p3*.7,p8,p3*.3,p7*.9     ;p9=“bandwdth” do filtro
  a1        rand      10000                       ;p10=atenuação da reverberação
  a2        reson     a1,k4,k4/p9,1
  k5        expseg    .1,p3*.1,p6,p3*.1,p6*.5,p3*.3,p6*.8,p3*.5,.01
  a3        oscili    k5,cpsoct(i1+k3)+a2*.8,11
  ga1       =  ga1+(p10*a1)
            outs      a3,(.98*a3)+(.3*a2)
endin
