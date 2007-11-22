;==================================================
;                  STEREO ENHANCER          
;                       
;                 Luca Pavan - 2001
;
;==================================================

  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2

#define IN # "thewind.wav" #

instr 1

  iamp      =  p4  
  ipan      =  p5   

  kv1       =  .0012
  kv2       =  .00055
  kv3       =  .00012
  kv4       =  .00045
  kv5       =  .00035

  kran_A    gauss     kv1
  kran_B    gauss     kv2
  kran_C    gauss     kv3
  kran_D    gauss     kv4
  kran_E    gauss     kv5

  kran1_A   weibull   kv1, 2
  kran1_B   weibull   kv2, 2
  kran1_C   weibull   kv3, 2
  kran1_D   weibull   kv4, 2
  kran1_E   weibull   kv5, 2

  kamp      linen     iamp, .005, p3, .005
  asig0, asdum1       diskin  $IN, 1 + kran_A, 0
  afl1      butterbp  asig0, 540, 1080
  asig1, asdum2       diskin  $IN, 1 + kran_B, 0
  afl2      butterbp  asig1, 2740, 3320
  asig2, asdum3       diskin  $IN, 1 + kran_C, 0
  afl3      butterbp  asig2, 8200, 7600
  asig3, asdum4       diskin  $IN, 1 + kran_D, 0
  afl4      butterbp  asig3, 13750, 3500
  asig4, asdum5       diskin  $IN, 1 + kran_E, 0
  afl5      butterbp  asig4, 18775, 6550
  asdr1, asig2_a      diskin  $IN, 1 + kran1_A, 0
  afr1      butterbp  asig2_a, 540, 1080
  asdr2, asig2_b      diskin  $IN, 1 + kran1_B, 0
  afr2      butterbp  asig2_b, 2740, 3320
  asdr3, asig2_c      diskin  $IN, 1 + kran1_C, 0
  afr3      butterbp  asig2_c, 8200, 7600
  asdr4, asig2_d      diskin  $IN, 1 + kran1_D, 0
  afr4      butterbp  asig2_d, 13750, 3500
  asdr5, asig2_e      diskin  $IN, 1 + kran1_E, 0
  afr5      butterbp  asig2_e, 18775, 6550

  as1, as2  diskin    $IN, 1, 0
  asumch    =  (as1 + as2)*.8                     ; BASS REINFORCEMENT
  asmfil    butterlp  asumch, 200
  afl       sum       afl1, afl2, afl3, afl4, afl5
  afl       balance   afl + asmfil, as1
  afr       sum       afr1, afr2, afr3, afr4, afr5
  afr       balance   afr + asmfil, as2
            outs      afl * sqrt(1 - ipan) * kamp, afr * sqrt(ipan) * kamp
endin