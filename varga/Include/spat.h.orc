
/* spat.h.orc - spatial stereo macros   */
/* Written by Istvan Varga, Aug 2001    */

#include "spat_def.h.orc"
#include "Delays.include.orc"
#include "Plain_Stereo.include.orc"
#include "Spatial_Stereo.include.orc"
#include "HRTF_Stereo.include.orc"

/* MonoStereo, MonoStereoDyn, and MonoStereoDynHQ - mono output */

#define MonoStereo #

$SPAT_H__base_i_(0.001'0)
$DECODE_MONO

#

#define MonoStereoDyn #

$SPAT_H__base_k_(0.001'0'1)
$DECODE_MONO

#

#define MonoStereoDynHQ #

$SPAT_H__base_k_(0.001'0'3)
$DECODE_MONO

#

/* UHJ_Stereo, UHJ_StereoDyn, and UHJ_StereoDynHQ */

#define UHJ_Stereo #

$SPAT_H__base_i_($UNITDIST'2)
$DECODE_UHJ

#

#define UHJ_StereoDyn #

$SPAT_H__base_k_($UNITDIST'2'1)
$DECODE_UHJ

#

#define UHJ_StereoDynHQ #

$SPAT_H__base_k_($UNITDIST'2'3)
$DECODE_UHJ

#

/* PhseStereo, PhseStereoDyn, and PhseStereoDynHQ - stereo with phase shift */

#define PhseStereo #

$SPAT_H__base_i_(0.001'2)
$DECODE_STEREO3

#

#define PhseStereoDyn #

$SPAT_H__base_k_(0.001'2'1)
$DECODE_STEREO3

#

#define PhseStereoDynHQ #

$SPAT_H__base_k_(0.001'2'3)
$DECODE_STEREO3

#

