
/* SpatStereo, SpatStereoDyn, and SpatStereoDynHQ - macros simulating   */
/* a pair of microphones                                                */

#define SpatStereo #

$SPAT_H__base_i_($EARDIST'4)
$DECODE_STEREO2

#

#define SpatStereoDyn #

$SPAT_H__base_k_($EARDIST'4'1)
$DECODE_STEREO2

#

#define SpatStereoDynHQ #

$SPAT_H__base_k_($EARDIST'4'3)
$DECODE_STEREO2

#

