  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;*** Warning! This example is not intended to be heard, but only to visualize the generated signals 
;*** with a wave editor. Don't attempt to hear it, because very low frequencies could damage the speakers

instr   1
  k0        line      0,p3,1                      ;modifies the envelope dinamically
  kfreq     line      .5,p3,15                    ;modifies envelope repeat frequency
  ktrig     metro     .5                          ;forces the envelope to restart from the beginning

;ksig   loopseg kfreq, ktrig, ktime0, kvalue0  [, ktime1, kvalue1, ... , ktimeN, kvalueN] 
  k1        loopseg   1,  0,  0,0, 10+k0*200,30000, 110-k0*100,10000, 10,3000, 10,10000, 10,0
;negative frequency produces backward envelope 
  k2        loopseg   -1, 0,  0,0, 10+k0*200,30000, 110-k0*100,10000, 10,3000, 10,10000, 10,0
  a1        upsamp    k1
  a2        upsamp    k2
            outs      a1,a2

endin




