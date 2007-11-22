;=================================================================
; Pulser Orc - Developed in class on 10-17-2000
; This implements an alternative method of repetitively triggering
; an envelope, which allows the trigger (pulse) rate to vary while
; keeping the envelope duration constant. The idea is to use a 
; phasor to access a table containing an envelope (gating) function.
; The table unit is set for a normalized index, and the phasor's
; output scaled in such a way that when the phasor is running at 
; a preset maximum speed, its range is 0-1. Consequently, the
; entire table is read through from beginning to end in exactly 
; 1/phasorhz seconds. At anything slower than the maximum speed, 
; the amplitude of the phasor is made to vary in inverse proportion
; to the phasor's frequency. I.e., 
; phasor amplitude = max phasor freq / current phasor freq
; Since the table unit is set for a normalized index (0-1), and
; the optional wrap flag is not enabled, an index value that is
; greater than 1 will simply return the last value in the table.
; And since the phasor amplitude (table index) range will begin to
; exceed 1 as soon as the phasor frequency goes below its preset 
; maximum, and will vary inversely in proportion to the phasor's
; frequency, the entire table will always be read from beginning to 
; end at exactly the same rate, regardless of the phasor frequency.

  sr        =  22050
  kr        =  2205
  ksmps     =  10
  nchnls    =  1

instr   1       ;basic pulser instrument w/random pitches
  isinefn   =  1                                  ;audio wave shape func
  igatefn   =  2                                  ;envelope (gating) func
  imaxamp   =  20                                 ;highest value table index will have
  imaxhz    =  20                                 ;fastest rate of pulsing
  iminhz    =  2                                  ;slowest rate of pulsing
  icent     =  octpch(p5)
  imaxrnd   =  2
  kplshz    linseg    imaxhz,p3/2,iminhz,p3/2,imaxhz ;pulse freq control
  aphase    phasor    kplshz                      ;changing pulse freq
  aindex    =  aphase*imaxamp/kplshz              ;change phase amp inv of freq
  agate     tablei    aindex,igatefn,1            ;the gate
  kpitch    randh     imaxrnd,kplshz              ;get random pitch offset
  asig      oscili    agate,cpsoct(icent+kpitch),isinefn ;the sound
            out       asig*p4
endin

instr   2       ;pulser with contstrained random pitches
  isinefn   =  1                                  ;audio wave shape func
  igatefn   =  2                                  ;envelope (gating) func
  imaxamp   =  20                                 ;highest value table index will have
  imaxhz    =  20                                 ;fastest rate of pulsing
  iminhz    =  2                                  ;slowest rate of pulsing
  imaxrnd   =  7.999                              ;almost 8, but not quite
  ipitfn    =  3                                  ;table of acceptable intervals
  klast     init      0                           ;variable to remember our last pitch with
  kplshz    linseg    imaxhz,p3/2,iminhz,p3/2,imaxhz ;pulse freq control
  aphase    phasor    kplshz                      ;changing pulse freq
  aindex    =  aphase*imaxamp/kplshz              ;change phase amp inv of freq
  agate     tablei    aindex,igatefn,1            ;the gate
  kpitno    randh     imaxrnd,kplshz
  kpitch    table     kpitno,ipitfn,0,0,1
;A problem to solve: how can we avoid repeating the same pitch
; with this instrument? The following doesn't work, we learned,
; because we need to check on each new random number, not every k.
;
;kpitch =       (kpitch == klast ? kpitch - 1 : kpitch)
;klast  =       kpitch
  asig      oscili    agate,cpspch(p5+kpitch),isinefn ;the sound
            out       asig*p4
endin
