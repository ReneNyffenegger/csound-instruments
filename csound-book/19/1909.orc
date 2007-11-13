sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

          instr     1909 
ax        init      0                    ; ROSSLER'S ATTRACTOR
ay        init      0
az        init      0
ih        init      p5
aa        init      .375
ib        init      p6
ic        init      p7
ipanl     init      p8
ipanr     init      1-ipanl
; AMPLITUDE ENVELOPE
kampenv   linseg    0,.01,p4,p3-.02,p4,.01,0
aa        oscil     1/7,.5,1
aa        =         .3+aa
axnew     =         ax+ih*(-ay-az)
aynew     =         ay+ih*(ax+aa*ay)
aznew     =         az+ih*(ib+ax*az-ic*az)
ax        =         axnew
ay        =         aynew
az        =         aznew
          outs      kampenv*ax*ipanl,kampenv*ay*ipanr
          endin
