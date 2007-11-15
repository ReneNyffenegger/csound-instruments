
/* some constants */

#define LN2 # 0.69314718 #
#define LN10 # 2.30258509 #
#define PI # 3.14159265 #
#define TWOPI # 6.28318531 #
#define PIDIV2 # 1.57079633 #
#define SEMITONE # 1.05946309 #

/* conversion macros */

/* -------------------------- note <-> frequency --------------------------- */

/* convert MIDI note number to frequency */

#define MIDI2CPS(MIDI2CPSnot) # (exp(0.057762265*($MIDI2CPSnot)+2.10117844)) #

/* convert frequency to MIDI note number */

#define CPS2MIDI(CPS2MIDIcps) # ((log($CPS2MIDIcps)-2.10117844)*17.31234049) #

/* semitone -> frequency ratio */

#define NOTE2FRQ(NOTE2FRQnot) # (exp(0.057762265*($NOTE2FRQnot))) #

/* frequency ratio -> semitone */

#define FRQ2NOTE(FRQ2NOTEfrq) # (log($FRQ2NOTEfrq)*17.31234049) #

/* ------------------------ velocity <-> amplitude ------------------------- */

/* convert velocity to amplitude */

#define VELOC2AMP(VELOC2AMPv) # (0.0039+($VELOC2AMPv)*($VELOC2AMPv)/16192.0) #

/* convert amplitude to velocity */

#define AMP2VELOC(AMP2VELOCamp) # (sqrt((($AMP2VELOCamp)-0.0039)*16192.0)) #

/* --------------------------- dB <-> amplitude ---------------------------- */

/* dB -> amplitude */

#define DB2AMP(DB2AMPdB) # (exp(($DB2AMPdB)*0.11512925)) #

/* amplitude -> dB */

#define AMP2DB(AMP2DBamp) # (log($AMP2DBamp)*8.68588964) #

/* ---------------------- orchestra header statements ---------------------- */

#define ORCHDR(ORCHDRsr'ORCHDRksmps'ORCHDRnchnls) #

  sr        =  $ORCHDRsr
  ksmps     =  $ORCHDRksmps
  nchnls    =  $ORCHDRnchnls

#

/* ----------------------- frequency -> table number ----------------------- */

/* ft: table number (output)            */
/* cps: frequency in Hz (input)         */
/* tabl: min. table number (input)      */

#define CPS2FNUM(CPS2FNUMft'CPS2FNUMcps'CPS2FNUMtabl) #

$CPS2FNUMft     limit $CPS2MIDI($CPS2FNUMcps), 0, 127
$CPS2FNUMft     =  int($CPS2FNUMft + ($CPS2FNUMtabl) + 0.5)

#

/* -------- set note parameters (length, frequency, and amplitude) --------- */

/* xtime: extra time (in seconds)       */

/* ilnth: original note length (p3)     */
/* icps: note frequency in Hz           */
/* iamp: note amplitude                 */

#define NOTEPARAMS(NOTEPARAMSxtime) #

  ilnth     =  p3
  p3        =  p3 + ($NOTEPARAMSxtime)
  icps      =  $MIDI2CPS(p4)
  iamp      =  $VELOC2AMP(p5)

#

/* Set parameters of MIDI note, expand duration, and generate release   */
/* envelope                                                             */
/* ---------------------------- input args ---------------------------- */
/* M_NOTEPARM_rel:      release time in seconds (> 0)                   */
/* M_NOTEPARM_xtim:     extra time in seconds (after release)           */
/* ------------------------- output variables ------------------------- */
/* ilnth:               note length (-1 as it is unknown)               */
/* inote:               note number (0 - 127)                           */
/* ivel:                velocity (0 - 127)                              */
/* icps:                note frequency in Hz                            */
/* iamp:                amplitude (0 - 1)                               */
/* aenv:                release envelope (linear)                       */

#define M_NOTEPARM(M_NOTEPARM_rel'M_NOTEPARM_xtim) #

  ilnth     =  -1                                 ; length is not known
  inote     notnum                                ; note number
  ivel      veloc                                 ; velocity
  icps      =  $MIDI2CPS(inote)                   ; frequency
  iamp      =  $VELOC2AMP(ivel)                   ; amplitude

; release envelope

            xtratim   ($M_NOTEPARM_rel) + ($M_NOTEPARM_xtim)
  k_        release   
  a_        =  (k_ < 0.5 ? 0 : (1 / (sr * ($M_NOTEPARM_rel))))
  aenv      integ     a_
  aenv      limit     1 - aenv, 0, 1

#

/* Set parameters of score note, expand duration, and generate release  */
/* envelope                                                             */
/* ---------------------------- input args ---------------------------- */
/* S_NOTEPARM_rel:      release time in seconds (> 0)                   */
/* S_NOTEPARM_xtim:     extra time in seconds (after release)           */
/* ------------------------- output variables ------------------------- */
/* ilnth:               note length in seconds                          */
/* inote:               note number (0 - 127)                           */
/* ivel:                velocity (0 - 127)                              */
/* icps:                note frequency in Hz                            */
/* iamp:                amplitude (0 - 1)                               */
/* aenv:                release envelope (linear)                       */

#define S_NOTEPARM(S_NOTEPARM_rel'S_NOTEPARM_xtim) #

  ilnth     =  p3                                 ; length
  inote     =  p4                                 ; note number
  ivel      =  p5                                 ; velocity
  icps      =  $MIDI2CPS(inote)                   ; frequency
  iamp      =  $VELOC2AMP(ivel)                   ; amplitude

; release envelope

  p3        =  (p3 <= 0 ? p3 : (p3 + ($S_NOTEPARM_rel) + ($S_NOTEPARM_xtim)))
  aenv      linseg    1, (ilnth <= 0 ? 3600 : ilnth), 1, ($S_NOTEPARM_rel), 0, 1, 0

#

