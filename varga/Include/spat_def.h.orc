
/* header file for spatializer macros */

#define EARDIST         # 0.2 #         /* distance between ears (in meters) */
#define UNITDIST        # 1.0 #         /* B format unit circle distance     */
#define DELAYOFFS1      # 0.02 #        /* delay when distance = 0           */
#define ROOM_TABLE      # 225 #         /* room parameters are stored in     */
                                        /* this table                        */
  i_        ftgen     $ROOM_TABLE, 0, 64, -2,   0, -1, -1, -1, -1, 0, 0, 1.0, 0, 0, 1000.0, 1.0, 0.7, 0, 0, 1.0, 0, 0, 1000.0, 1.0, 0.7, 0, 0, 1.0, 0, 0, 1000.0, 1.0, 0.7, 0, 0, 1.0, 0, 0, 1000.0, 1.0, 0.7, 0, 0, 1.0, 0, 0, 1000.0, 1.0, 0.7, 0, 0, 1.0, 0, 0, 1000.0, 1.0, 0.7, 0

/* HRTFStereo parameters */

#define HRTFtable       # 240 #         /* table storing HRTF parameters     */
#define AMPDIST0        # 10.0 #        /* amplitude when distance = 0       */
#define SOUNDSPEED      # 340.0 #       /* sound speed (in m/s)              */

/* structure of HRTFtable:                              */
/*      0 :     impulse response length in samples      */
/*      1 :     delay of HRTF responses (in samples)    */
/*      2 :     window size for dynamic spat. (samples) */
/*      3 :     window overlap (samples)                */
/*      4 :     elevation resolution (degrees)          */
/*      5 :     number of first (-90,0) convolve file   */
/*      6 :     file number step between elev. tracks   */
/*      7 :     not used                                */

/*      8 - :   number of azimuth locations at each elevation value     */

  i_        ftgen     $HRTFtable, 0, 32, -2,    256, 64, 576, 64, 10, 1050, 50, 0, 56, 56, 56, 56, 56, 56, 60, 72, 72, 72, 72, 72, 60, 56, 45, 36, 24, 12, 1

/* convert distance to delay time */

#define Dist2Delay(xdst)        # ((($xdst)/$SOUNDSPEED)+$DELAYOFFS1) #

/* convert distance to amplitude */

#define Dist2Amp(xdst)          # (1/(($xdst)+1/$AMPDIST0)) #

/* azimuth to LEFT channel amp. */

#define Azim2AmpL(xazim)        # abs(1.4142135*cos((($xazim)+1.570796)/2)) #

/* azimuth to RIGHT channel amp. */

#define Azim2AmpR(xazim)        # abs(1.4142135*sin((($xazim)+1.570796)/2)) #

/* base spatializer macro with i-rate control    */
/* input variables:                              */
/*   i_az_: azimuth                              */
/*   i_el_: elevation                            */
/*   i_d_:  distance                             */
/*   a_:    input signal                         */
/* output variables:                             */
/*   a_1_:  W output                             */
/*   a_2_:  X output                             */
/*   a_3_:  Y output                             */
/*   a_4_:  Z output                             */
/* temp variables:                               */
/*   i_1_, i_2_, i_3_, i_4_                      */
/* macro parameters:                             */
/*   SPAT_H__idist_: spat3d unit circle distance */
/*   SPAT_H__imode_: spat3d mode                 */

#define SPAT_H__base_i_(SPAT_H__idist_'SPAT_H__imode_) #

  i_1_      =  sin(0.01745329 * i_az_)              /* convert azimuth,     */
  i_2_      =  cos(0.01745329 * i_az_)              /* elevation and        */
  i_3_      =  sin(0.01745329 * i_el_)              /* distance to X, Y, Z  */
  i_4_      =  cos(0.01745329 * i_el_)              /* coordinates          */
  i_1_      =  i_1_ * i_4_ * i_d_                   /* X */
  i_2_      =  i_2_ * i_4_ * i_d_                   /* Y */
  i_3_      =  i_3_ * i_d_                          /* Z */

  a_1_, a_2_, a_3_, a_4_  spat3di                 a_ + (1.0 / 1.0e24), i_1_, i_2_, i_3_, $SPAT_H__idist_, $ROOM_TABLE, $SPAT_H__imode_

#

/* base spatializer macro with k-rate control    */
/* input variables:                              */
/*   k_az_: azimuth                              */
/*   k_el_: elevation                            */
/*   k_d_:  distance                             */
/*   a_:    input signal                         */
/* output variables:                             */
/*   a_1_:  W output                             */
/*   a_2_:  X output                             */
/*   a_3_:  Y output                             */
/*   a_4_:  Z output                             */
/* temp variables:                               */
/*   k_1_, k_2_, k_3_, k_4_                      */
/* macro parameters:                             */
/*   SPAT_H__idist_: spat3d unit circle distance */
/*   SPAT_H__imode_: spat3d mode                 */
/*   SPAT_H__iover_: oversample ratio            */

#define SPAT_H__base_k_(SPAT_H__idist_'SPAT_H__imode_'SPAT_H__iover_) #

  k_1_      =  sin(0.01745329 * k_az_)              /* convert azimuth,     */
  k_2_      =  cos(0.01745329 * k_az_)              /* elevation and        */
  k_3_      =  sin(0.01745329 * k_el_)              /* distance to X, Y, Z  */
  k_4_      =  cos(0.01745329 * k_el_)              /* coordinates          */
  k_1_      =  k_1_ * k_4_ * k_d_                   /* X */
  k_2_      =  k_2_ * k_4_ * k_d_                   /* Y */
  k_3_      =  k_3_ * k_d_                          /* Z */

  a_1_, a_2_, a_3_, a_4_  spat3d                  a_ + (1.0 / 1.0e24), k_1_, k_2_, k_3_, $SPAT_H__idist_, $ROOM_TABLE, $SPAT_H__imode_, 2.0, $SPAT_H__iover_

#

/* decoder modules              */
/* input variables:             */
/*   a_1_: W input              */
/*   a_2_: X input              */
/*   a_3_: Y input              */
/*   a_4_: Z input              */
/* output variables:            */
/*   a_L_: left channel         */
/*   a_R_: right channel        */
/* temp variables:              */
/*   a_5_, a_6_                 */

/* mono */

#define DECODE_MONO #

  a_L_      delay     a_1_, $DELAYOFFS1
  a_R_      delay     a_1_, $DELAYOFFS1

#

/* intensity stereo */

#define DECODE_STEREO1 #

  a_L_      delay     a_1_ + 0.7071 * a_3_, $DELAYOFFS1
  a_R_      delay     a_1_ - 0.7071 * a_3_, $DELAYOFFS1

#

/* pair of microphones */

#define DECODE_STEREO2 #

  a_5_      butterlp  0.333 * a_1_,   500.0          /* left channel */
  a_6_      butterlp  0.533 * a_1_,  4000.0
  a_5_      =  a_5_ + a_6_
  a_6_      butterlp  0.134 * a_1_, 12000.0
  a_L_      delay     a_2_ + a_5_ + a_6_, $DELAYOFFS1
  a_5_      butterlp  0.333 * a_3_,   500.0          /* right channel */
  a_6_      butterlp  0.533 * a_3_,  4000.0
  a_5_      =  a_5_ + a_6_
  a_6_      butterlp  0.134 * a_3_, 12000.0
  a_R_      delay     a_4_ + a_5_ + a_6_, $DELAYOFFS1

#

/* stereo with +/- 90 degrees phase shift */

#define DECODE_STEREO3 #

  a_L_, a_R_   hilbert  a_1_            /* W */
  a_5_      =  1.4142 * a_L_
  a_6_      =  -1.4142 * a_R_
  a_L_, a_R_   hilbert  a_2_            /* X */
  a_5_      =  a_5_ + a_L_
  a_6_      =  a_6_ + a_R_
  a_L_, a_R_   hilbert  a_3_            /* Y */
  a_5_      =  a_5_ - a_R_
  a_6_      =  a_6_ + a_L_
  a_L_      delay     0.5 * (a_5_ + a_6_), $DELAYOFFS1
  a_R_      delay     0.5 * (a_5_ - a_6_), $DELAYOFFS1

#

/* UHJ */

#define DECODE_UHJ #

  a_L_, a_R_   hilbert  a_1_            /* W */
  a_5_      =  0.4699 * a_L_
  a_6_      =  -0.1710 * a_R_
  a_L_, a_R_   hilbert  a_2_            /* X */
  a_5_      =  a_5_ + 0.0928 * a_L_
  a_6_      =  a_6_ + 0.2550 * a_R_
  a_L_, a_R_   hilbert  a_3_            /* Y */
  a_6_      =  a_6_ + 0.3277 * a_L_
  a_L_      delay     2.16 * (a_5_ + a_6_), $DELAYOFFS1
  a_R_      delay     2.16 * (a_5_ - a_6_), $DELAYOFFS1

#

/* end of spat_def.h.orc */

