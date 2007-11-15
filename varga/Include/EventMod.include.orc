
/* this macro randomizes/modulates the parameters of score              */
/* events (start time, duration, velocity)                              */
/*      ftable: function table to set parameters (see EventMod.sco)     */
/*      instr1: instrument number used by the event scheduler           */
/*      instr2: target instrument (instr2 should be > instr1)           */
/*      plist:  list of additional parameters if the target instrument  */
/*              has more than 5 p-fields; example: ", p6, p7"           */
/*              if there are no extra p-fields, set it to an empty      */
/*              string                                                  */
/* the randomization/modulation of start time, note length, and         */
/* velocity is scaled by the global variables gidscale, gilscale, and   */
/* givscale                                                             */

#define EventMod(ftable'instr1'instr2'plist) #

instr $instr1

  ifnum     =  int(($ftable) + 0.5)                 /* ftable number        */

  ibpm      table     0, ifnum                       /* tempo                */
  i_time    times     
  i_time    =  i_time * (ibpm / 60.0)               /* time in beats        */

  idel      table     1, ifnum                       /* delay time in beats  */
  ilnth     =  p3
  ilnth     =  ilnth * (ibpm / 60.0)                /* note length in beats */
  i_note    =  p4                                   /* note number          */
  ivel      =  p5                                   /* velocity             */

/* delay */

  idelrn    table     2, ifnum                       /* delay rand. (beats)  */
  i_        trirand   1.0
  idel      =  idel + gidscale * idelrn * i_
  idt       table     3, ifnum                       /* delay mod. table     */
  ido       table     4, ifnum                       /* table offset         */
  idl       table     5, ifnum                       /* loop time in beats   */
  ids       table     6, ifnum                       /* mod. scale           */
  i_        wrap      ido + (i_time / idl), 0, 1
  i__       tablei    i_, int(idt + 0.5), 1, 0, 0
  idel      =  idel + gidscale * ids * i__
  idel      =  idel * (60.0 / ibpm)
  idel      limit     idel, 0, 3600.0

/* note length */

  ilntrn    table     7, ifnum                       /* note length rand.    */
  i_        trirand   1.0
  ilnth     =  ilnth + gilscale * ilntrn * i_
  ilt       table     8, ifnum                       /* length mod. table    */
  ilo       table     9, ifnum                       /* table offset         */
  ill       table     10, ifnum                       /* loop time in beats   */
  ils       table     11, ifnum                       /* mod. scale           */
  i_        wrap      ilo + (i_time / ill), 0, 1
  i__       tablei    i_, int(ilt + 0.5), 1, 0, 0
  ilnth     =  ilnth + gilscale * ils * i__
  ilnth     =  ilnth * (60.0 / ibpm)
  ilnth     limit     ilnth, 0.01, 3600.0

/* velocity */

  ivelrn    table     12, ifnum                       /* velocity rand.       */
  i_        trirand   1.0
  ivel      =  ivel + givscale * ivelrn * i_
  ivt       table     13, ifnum                       /* velocity mod. table  */
  ivo       table     14, ifnum                       /* table offset         */
  ivl       table     15, ifnum                       /* loop time in beats   */
  ivs       table     16, ifnum                       /* mod. scale           */
  i_        wrap      ivo + (i_time / ivl), 0, 1
  i__       tablei    i_, int(ivt + 0.5), 1, 0, 0
  ivel      =  ivel + givscale * ivs * i__
  ivel      limit     ivel, 0, 127

/* add score event */

            schedule  int(($instr2) + 0.5), idel, ilnth, i_note, ivel $plist

endin

#


