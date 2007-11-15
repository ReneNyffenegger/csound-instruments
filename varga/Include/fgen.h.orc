
/* FGEN_128: generate a set of band-limited function tables     */
/* written by Istvan Varga, May 2002                            */
/*                                                              */
/* FG128_lbl:   name (to avoid conflicts with other instances   */
/*              of this macro)                                  */
/* FG128_ft:    first output table number. One table is         */
/*              generated for each MIDI note number (0 - 127),  */
/*              the last table is (TABLE + 127)                 */
/* FG128_size:  length of output ftables (in samples)           */
/* FG128_src:   source table number (may not be equal to        */
/*              FG128_ft)                                       */
/* FG128_minh:  lowest harmonic partial number                  */
/* FG128_bw:    bandwidth (usually sr*0.5)                      */

#define FGEN_128(FG128_lbl'FG128_ft'FG128_size'FG128_src'FG128_minh'FG128_bw) #

; generate first table
  i__       =  ($FG128_bw) / 8.1757989
  i_        ftgen     $FG128_ft, 0, $FG128_size, -30, $FG128_src, $FG128_minh, i__

  i_        =  1                                  ; note number
l_$FG128_lbl:
  i__       =  ($FG128_bw) / (440 * exp(log(2) * (i_ - 69) / 12))
  i___      ftgen     $FG128_ft + i_, 0, $FG128_size, -30, $FG128_ft, $FG128_minh, i__
  i_        =  i_ + 1
if (i_ < 127.5) igoto l_$FG128_lbl

#

