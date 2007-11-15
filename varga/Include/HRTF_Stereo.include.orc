
/********************************/
/* macros to spatialize a mono  */
/* signal using HRTF responses  */
/*                              */
/* Effects.Header.orc,          */
/* Delays.include.orc           */
/* include files are required   */
/********************************/

/********************************************************/
/* HRTFStereo : macro to position a mono signal using   */
/*              HRTF responses                          */
/*                                                      */
/* input parameters:    i_az_ : azimuth                 */
/*                      i_el_ : elevation               */
/*                      i_d_  : distance                */
/*                      a_    : input signal            */
/* output:              a_L_  : LEFT channel            */
/*                      a_R_  : RIGHT channel           */
/* variables i_, i__, i_1_ .. i_7_, k_1_ .. k_7_,       */
/* a_1_ .. a_5_ are used                                */
/*                                                      */
/* HRTFStereoDyn: similar to HRTFStereo, but uses       */
/*              k-rate input and allows movement of     */
/*              sound source                            */
/*              only one can be used in an instrument   */
/* (note: all k-rate input must be valid at i-time)     */
/*                                                      */
/* HRTFStereoDynHQ: better quality (and slower) version */
/*              of HRTFStereoDyn                        */
/*              HQ delay table must be set up with      */
/*              InitHQDelay                             */
/********************************************************/

/* ------------------------------------------------------------------------------------------ */

/* base macro to convert azimuth and elevation values   */
/* and convolve a mono input signal                     */
/* it is used only by the other macros                  */

#define HRTFbase #

  i_7_      wrap      i_5_,-180,180                              /* limit azimuth and elevation */
  i_6_      wrap      i_4_+(abs(i_7_)>90 ? 180:0),-180,180       /* i_4_ = i_6_ = azimuth, i_5_ = i_7_ = elevation */
  i_7_      mirror    i_7_,-90,90
  i__       =  (i_6_<0 ? 1:0)                               /* swap channels if azimuth < 0 */
  i_        table     4,$HRTFtable                              /* elev. resolution */
  i_7_      =  int(((i_7_+90)/i_)+0.5)                      /* elevation track number */
  i_        table     int(i_7_+8.5),$HRTFtable                  /* azimuth locations at specified elevation value */
  i_6_      =  int(abs(i_6_)*(i_/360)+0.5)                  /* azimuth -> file number */
  i_        =  int(i_*0.5+0.25)                             /* check maximum file number */
  i_6_      =  (i_6_>i_ ? i_:i_6_)
  i_        table     6,$HRTFtable                              /* file number step / elevation */
  i_7_      =  i_7_*i_
  i_        table     5,$HRTFtable                              /* file number offset */

  a_L_,a_R_ convolve  a_,int(i_+i_6_+i_7_+0.5)       /* convolve input */

  k_7_      samphold  i__,-1,i__,0
  a_        =  a_L_                                         /* swap channels if azimuth < 0 */
  a_L_      =  a_L_*(1-k_7_)+a_R_*k_7_
  a_R_      =  a_R_*(1-k_7_)+a_*k_7_

#

#define HRTFStereo #

  i_4_      =  i_az_
  i_5_      =  i_el_

  i_2_      limit     i_d_,0,$SOUNDSPEED*0.95                   /* limit distance */

  i_        table     0,$HRTFtable                              /* compensate delay of HRTF data */
  i__       table     1,$HRTFtable

  i_3_      =  $Dist2Amp(i_2_)                                              /* output level */

  k_3_      samphold  i_3_,-1,i_3_,0                                         /* lock init. variables */

  a_1_      delay     a_,(int($Dist2Delay(i_2_)*sr-(i_+i__)+0.5)+0.01)/sr       /* delay input signal */

  a_2_      =  a_
  a_        =  a_1_*k_3_                                    /* apply volume and convolve input with HRTF */
$HRTFbase
  a_        =  a_2_                                         /* restore original input stored in a_2_ */

#

/* base macro for dynamic input parameters */

#define HRTFStereoDynBase(TMPDELAYMACRO) #

  k_2_      limit     k_d_,0,$SOUNDSPEED*0.95                   /* limit distance */
  a_4_      interp    $Dist2Amp(k_2_)
  k_2_      =  $Dist2Delay(k_2_)

  a_1_      upsamp    k_az_-i(k_az_)                           /* delay controllers to compensate distance */
  a_2_      delayr    1.0
  a_2_      deltap    k_2_
            delayw    a_1_
  k_1_      downsamp  a_2_
  k_1_      =  k_1_+i(k_az_)
  k_1_      init      i(k_az_)

  a_1_      upsamp    k_el_-i(k_el_)
  a_2_      delayr    1.0
  a_2_      deltap    k_2_
            delayw    a_1_
  k_3_      downsamp  a_2_
  k_3_      =  k_3_+i(k_el_)                                /* k_1_ = azimuth , k_3_ = elevation */
  k_3_      init      i(k_el_)

  k_4_      table     0,$HRTFtable                              /* compensate delay of HRTF data */
  k_5_      table     1,$HRTFtable

  a_3_      =  a_                                           /* save original input */

  a_1_      delayr    1.0                                      /* distance control */
  a_1_      interp    ((k_2_*sr-(k_4_+k_5_))/sr)-$DELAYOFFS1
  a_1_      =  a_1_+$DELAYOFFS1
$TMPDELAYMACRO
            delayw    a_3_
  a_5_      =  a_*a_4_                                      /* save input signal for convolution */

  k_4_      table     2,$HRTFtable                              /* window size */
  k_5_      table     3,$HRTFtable                              /* window overlap */
  k_4_      =  int((k_4_+ksmps-0.5)/ksmps)                  /* convert to k-cycles */
  k_5_      =  int((k_5_+ksmps-0.5)/ksmps)

  k_6_      timeinstk   
  k_6_      =  (k_6_+0.5) % (k_4_*2)                                /* counter, 0.5 -> (window size)*2-0.5 */
  k_2_      =  (k_6_>k_4_ ? 1:0)                                    /* 0: window A is active, 1: window B */
  k_6_      =  int(k_6_ % k_4_)                                     /* 0 -> (window size)-1 */
  k_7_      =  (k_5_-(k_4_-(k_6_+1)))/k_5_
  a_1_      interp    abs(k_2_-(k_7_>0 ? k_7_:0))                      /* window signal / B */

HRTFDyn_TMP_A:
                                                        /* A */

  i_4_      =  i(k_1_)
  i_5_      =  i(k_3_)

  a_        =  a_5_
$HRTFbase

  a_2_      =  (1-a_1_)*a_L_
  a_4_      =  (1-a_1_)*a_R_

if ((k_6_>0.5) || (k_2_<0.5)) goto HRTFDyn_TMP_B
            reinit    HRTFDyn_TMP_A
            rireturn  

HRTFDyn_TMP_B:
                                                        /* B */

  i_4_      =  i(k_1_)
  i_5_      =  i(k_3_)

  a_        =  a_5_
$HRTFbase

  a_L_      =  a_1_*a_L_+a_2_
  a_R_      =  a_1_*a_R_+a_4_

if ((k_6_>0.5) || (k_2_>0.5)) goto HRTFDyn_TMP_X
            reinit    HRTFDyn_TMP_B
            rireturn  

HRTFDyn_TMP_X:

  a_        =  a_3_                                                 /* restore original input */

#

#define HRTFStereoDyn #

$HRTFStereoDynBase($Deltap3A)

#

#define HRTFStereoDynHQ #

$HRTFStereoDynBase($DeltapiHQ)

#


