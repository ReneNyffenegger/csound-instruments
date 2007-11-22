; Dynamic Granular instrument

instr 2

  k1        linseg    0,20,1,(p3-80),1,60,0  
  k2        expseg    .20,(p3/8)*2,.2,(p3/8)*6,.002 ;gap varies over time.
  k3        expseg    .30,p3/2,.03,p3/2,.002      ;grain size decreases over time.


  a1        granule   p4*k1,p5,p6,p7,p8,p9,p10,p11,p12,p13,k2,p15,k3,p17,p18,p19,p20,p21,p22,p23,p24
  a2        granule   p4*k1,p5,p6,p7,p8,p9,p10,p11,p12,p13,k2,p15,k3,p17,p18,p19,p20+0.07,p21,p22,p23,p24
            outs      a1,a2

endin

