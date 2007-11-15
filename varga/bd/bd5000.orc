  sr        =  48000
  ksmps     =  2
  nchnls    =  1

#include "base_macros.h.orc"

instr 1

  ivol      =  2.7                                ; volume
  ibpm      =  140.00                             ; tempo
  irel      =  0.1667                             ; release time
  ifrq0     =  5.3333                             ; start freq. / note frq.
  ifrqe     =  14.000                             ; freq. env. speed

  i001      =  1/65536                            ;
  ivel      =  0.0039+p5*p5/16192                 ; velocity
  ibtime    =  60/ibpm                            ; beat time
  ivol      =  ivel*ivol                          ;
  icps0     =  440.0*exp(log(2.0)*(p4-69.0)/12.0) ; note frequency
  p3        =  p3 + irel + 0.1

start01:

  kcps      expseg    ifrq0-1,ibtime/ifrqe,(ifrq0-1)*0.5
  kcps      =  (kcps+1)*icps0
  knumh     =  sr/(2*kcps)
  a_        buzz      sr/(20*3.14159265), kcps, knumh, 256, 0.25
  a__       buzz      sr/(20*3.14159265), kcps, knumh, 256, 0.75
  aosc0     tone      a_-a__, 20
  aosc1     =  aosc0*1.0
  aoscn     unirand   2
  aoscn     =  (aoscn-1)*1.0

  kffrq     port      icps0, ibtime/8, icps0*ifrq0       /* OSC. 1 */
  aosc1     butterlp  aosc1, kffrq
  ax1       =  aosc1

  aoscn     butterbp  aoscn, 8372, 8372      /* noise */
  kffrq     port      65.4, ibtime/16, 2093
  aoscn     butterlp  aoscn, kffrq
  axn       =  aoscn

  kenv1l    linseg    -0.25, 0.00275, -0.25, 0.00001, 1.0, 0.005, 1, 1, 1
  kenv1e    expseg    1, 1, 0.001, 1, 0.001, 1, 0.001, 1, 0.001
  kenvx     expseg    1, p3-(irel+0.1), 1, irel, 1/1024
  aenv1     interp    kenv1l*kenv1e
  aenvx     interp    kenvx*ivol

  ax0       =  ax1*aenv1

  ax0       pareq     ax0, 65.4, 2.25, 1.5, 0   /* OUTPUT EQ */
  ax0       butterlp  ax0, 4186

  a0x       =  (ax0+axn)*aenvx

            out       -7000*a0x

endin

