
/* read formant values from table       */
/* FVALUEtnum:  ftable                  */
/* FVALUEvoice: voice number            */
/*              FVALUEvoice = 5*x + y   */
/*              x: 0: soprano           */
/*                 1: alto              */
/*                 2: countertenor      */
/*                 3: tenor             */
/*                 4: bass              */
/*              y: 0: a                 */
/*                 1: e                 */
/*                 2: i                 */
/*                 3: o                 */
/*                 4: u                 */
/* output variables:                    */
/*              frequency (Hz):         */
/*                k_frq_0_ .. k_frq_4_  */
/*              amplitude (dB):         */
/*                k_amp_0_ .. k_amp_4_  */
/*              bandwidth (Hz):         */
/*                k_bwd_0_ .. k_bwd_4_  */
/* tmp variable:                        */
/*              k_                      */

#define FORMANTVALUE(FVALUEtnum'FVALUEvoice) #

  k_        =  int((int(($FVALUEvoice) + 0.5) * 15) + 0.5)

  k_frq_0_  table     k_ +  0,        $FVALUEtnum
  k_frq_1_  table     k_ +  1,        $FVALUEtnum
  k_frq_2_  table     k_ +  2,        $FVALUEtnum
  k_frq_3_  table     k_ +  3,        $FVALUEtnum
  k_frq_4_  table     k_ +  4,        $FVALUEtnum

  k_amp_0_  table     k_ +  5,        $FVALUEtnum
  k_amp_1_  table     k_ +  6,        $FVALUEtnum
  k_amp_2_  table     k_ +  7,        $FVALUEtnum
  k_amp_3_  table     k_ +  8,        $FVALUEtnum
  k_amp_4_  table     k_ +  9,        $FVALUEtnum

  k_bwd_0_  table     k_ + 10,        $FVALUEtnum
  k_bwd_1_  table     k_ + 11,        $FVALUEtnum
  k_bwd_2_  table     k_ + 12,        $FVALUEtnum
  k_bwd_3_  table     k_ + 13,        $FVALUEtnum
  k_bwd_4_  table     k_ + 14,        $FVALUEtnum

#

/* same as FORMANTVALUE, but allows interpolation between       */
/* FVALUEIvoice1 and FVALUEIvoice2 (if FVALUEIbalance is 0,     */
/* then output is FVALUEIvoice1, if 1, then FVALUEIvoice2);     */
/* this macro also uses the tmp variables k_a0_ .. k_a4_,       */
/* k_b0_ .. k_b4_, k_f0_ .. k_f4_                               */

#define FORMANTVALUEI(FVALUEItnum'FVALUEIvoice1'FVALUEIvoice2'FVALUEIbalance) #

$FORMANTVALUE($FVALUEItnum'$FVALUEIvoice1)

  k_f0_     =  k_frq_0_
  k_f1_     =  k_frq_1_
  k_f2_     =  k_frq_2_
  k_f3_     =  k_frq_3_
  k_f4_     =  k_frq_4_

  k_a0_     =  k_amp_0_
  k_a1_     =  k_amp_1_
  k_a2_     =  k_amp_2_
  k_a3_     =  k_amp_3_
  k_a4_     =  k_amp_4_

  k_b0_     =  k_bwd_0_
  k_b1_     =  k_bwd_1_
  k_b2_     =  k_bwd_2_
  k_b3_     =  k_bwd_3_
  k_b4_     =  k_bwd_4_

$FORMANTVALUE($FVALUEItnum'$FVALUEIvoice2)

  k_frq_0_  =  k_f0_ * exp(log(k_frq_0_ / k_f0_) * ($FVALUEIbalance))
  k_frq_1_  =  k_f1_ * exp(log(k_frq_1_ / k_f1_) * ($FVALUEIbalance))
  k_frq_2_  =  k_f2_ * exp(log(k_frq_2_ / k_f2_) * ($FVALUEIbalance))
  k_frq_3_  =  k_f3_ * exp(log(k_frq_3_ / k_f3_) * ($FVALUEIbalance))
  k_frq_4_  =  k_f4_ * exp(log(k_frq_4_ / k_f4_) * ($FVALUEIbalance))

  k_amp_0_  =  k_a0_ + ((k_amp_0_ - k_a0_) * ($FVALUEIbalance))
  k_amp_1_  =  k_a1_ + ((k_amp_1_ - k_a1_) * ($FVALUEIbalance))
  k_amp_2_  =  k_a2_ + ((k_amp_2_ - k_a2_) * ($FVALUEIbalance))
  k_amp_3_  =  k_a3_ + ((k_amp_3_ - k_a3_) * ($FVALUEIbalance))
  k_amp_4_  =  k_a4_ + ((k_amp_4_ - k_a4_) * ($FVALUEIbalance))

  k_bwd_0_  =  k_b0_ * exp(log(k_bwd_0_ / k_b0_) * ($FVALUEIbalance))
  k_bwd_1_  =  k_b1_ * exp(log(k_bwd_1_ / k_b1_) * ($FVALUEIbalance))
  k_bwd_2_  =  k_b2_ * exp(log(k_bwd_2_ / k_b2_) * ($FVALUEIbalance))
  k_bwd_3_  =  k_b3_ * exp(log(k_bwd_3_ / k_b3_) * ($FVALUEIbalance))
  k_bwd_4_  =  k_b4_ * exp(log(k_bwd_4_ / k_b4_) * ($FVALUEIbalance))

#

/* apply formant filters to a_0_ .. a_4_ using the butterbp opcode      */
/* formant parameters should be set with FORMANTVALUE or FORMANTVALUEI  */
/* bandwidth values are scaled by Fbwd                                  */

#define FORMANTFILTER(Fbwd) #

  a_0_      butterbp  a_0_ * exp(0.1151293 * k_amp_0_), k_frq_0_, k_bwd_0_ * ($Fbwd)
  a_1_      butterbp  a_1_ * exp(0.1151293 * k_amp_1_), k_frq_1_, k_bwd_1_ * ($Fbwd)
  a_2_      butterbp  a_2_ * exp(0.1151293 * k_amp_2_), k_frq_2_, k_bwd_2_ * ($Fbwd)
  a_3_      butterbp  a_3_ * exp(0.1151293 * k_amp_3_), k_frq_3_, k_bwd_3_ * ($Fbwd)
  a_4_      butterbp  a_4_ * exp(0.1151293 * k_amp_4_), k_frq_4_, k_bwd_4_ * ($Fbwd)

#

/* same as FORMANTFILTER, but uses 2 butterbp filters   */
/* bandwidth values are scaled by Fbwd1 and Fbwd2       */

#define FORMANTFILTER2(Fbwd1'Fbwd2) #

  a_0_      butterbp  a_0_ * exp(0.1151293 * k_amp_0_), k_frq_0_, k_bwd_0_ * ($Fbwd1)
  a_1_      butterbp  a_1_ * exp(0.1151293 * k_amp_1_), k_frq_1_, k_bwd_1_ * ($Fbwd1)
  a_2_      butterbp  a_2_ * exp(0.1151293 * k_amp_2_), k_frq_2_, k_bwd_2_ * ($Fbwd1)
  a_3_      butterbp  a_3_ * exp(0.1151293 * k_amp_3_), k_frq_3_, k_bwd_3_ * ($Fbwd1)
  a_4_      butterbp  a_4_ * exp(0.1151293 * k_amp_4_), k_frq_4_, k_bwd_4_ * ($Fbwd1)

  a_0_      butterbp  a_0_, k_frq_0_, k_bwd_0_ * ($Fbwd2)
  a_1_      butterbp  a_1_, k_frq_1_, k_bwd_1_ * ($Fbwd2)
  a_2_      butterbp  a_2_, k_frq_2_, k_bwd_2_ * ($Fbwd2)
  a_3_      butterbp  a_3_, k_frq_3_, k_bwd_3_ * ($Fbwd2)
  a_4_      butterbp  a_4_, k_frq_4_, k_bwd_4_ * ($Fbwd2)

#


