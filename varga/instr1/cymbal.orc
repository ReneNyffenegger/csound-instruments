  sr        =  48000
  ksmps     =  32
  nchnls    =  2

#include "base_macros.h.orc"
#include "fgen.h.orc"
#include "spat.h.orc"
#include "uhjmacros.h.orc"

  itmp      ftgen     21, 0, 8, -2, 1.0000, 1.4471, 1.6170, 1.9265, 2.5028, 2.6637
  itmp      ftgen     22, 0, 65536, -7, 32768, 1, 32768, 0, 0, 32767, 0, 0, -32768, 1, -32768, 0, 0, 32767, 0

  ifrq      =  440 * exp(log(2) * (73 - 69) / 12)

  icps0     table     0, 21
  icps1     table     1, 21
  icps2     table     2, 21
  icps3     table     3, 21
  icps4     table     4, 21
  icps5     table     5, 21

  itrns0    =  int(0.5 + 131072 / (sr / (ifrq * icps0)))
  itrns1    =  int(0.5 + 131072 / (sr / (ifrq * icps1)))
  itrns2    =  int(0.5 + 131072 / (sr / (ifrq * icps2)))
  itrns3    =  int(0.5 + 131072 / (sr / (ifrq * icps3)))
  itrns4    =  int(0.5 + 131072 / (sr / (ifrq * icps4)))
  itrns5    =  int(0.5 + 131072 / (sr / (ifrq * icps5)))

  itmp      ftgen     23, 0, 524288, -31, 22, itrns0, 1, 0, itrns1, 1, 0, itrns2, 1, 0, itrns3, 1, 0, itrns4, 1, 0, itrns5, 1, 0
  itmp      ftgen     24, 0, 524288, -30, 23, 1, 65536
  itmp      ftgen     25, 0, 16384, 5, 1, 16384, 0.01

instr 1

$S_NOTEPARM(0.1'0.2)
  aenv      =  aenv * aenv * iamp

  a1        grain3    sr / 131072, 0.5, 0, 0.5, 0.2, 200.0, 100, 24, 25, 0, 0, 0, 16
  a2l       grain3    sr / 131072, 0.5, 0, 0.5, 0.04, 500.0, 100, 24, 25, 0, 0, 0, 16
  a2r       grain3    sr / 131072, 0.5, 0, 0.5, 0.04, 500.0, 100, 24, 25, 0, 0, 0, 16

  a1        pareq     a1, 500, 0, 1.5, 1
  a2l       pareq     a2l, 500, 0, 1.5, 1
  a2r       pareq     a2r, 500, 0, 1.5, 1
  a1        butterbp  a1, 11000, 7000
  a1        butterlp  a1, 12000
  a2l       butterlp  a2l, 20000
  a2r       butterlp  a2r, 20000
;aenv1  expseg 0.7, 0.03, 1, 0.25, 0.5
  aenv1     expseg    0.25, 0.1, 1, 0.25, 0.5
  aenv2     expon     1, 0.3, 0.5
  a1        =  500 * a1 * aenv1 * aenv
  a2l       =  500 * a2l * aenv2 * aenv * 0.25
  a2r       =  500 * a2r * aenv2 * aenv * 0.25

$SPAT2(a1'20'1)
$SPAT2(a2l'-40'1)
$SPAT2(a2r'80'1)

endin

$OUT3CH(90'"cymbal.pcm")

