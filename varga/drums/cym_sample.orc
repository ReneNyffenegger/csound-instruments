  sr        =  48000
  ksmps     =  64
  nchnls    =  1

; this orc generates sample files for cymbal instruments

instr 1

  itmp      rnd31     1, 0, p4                    ; set seed

#define OSC #

  iamp      rnd31     1, p5, 0                    ; amplitude
  ifrq      rnd31     24000, 0, 0                 ; frequency
  iphs      rnd31     1, 0, 0                     ; phase

  a_        oscils    iamp, ifrq, abs(iphs), 2

            vincr     a0, a_

#

; 600 oscillators

#define OSC10 #

$OSC
$OSC
$OSC
$OSC
$OSC
$OSC
$OSC
$OSC
$OSC
$OSC

#

#define OSC100 #

$OSC10
$OSC10
$OSC10
$OSC10
$OSC10
$OSC10
$OSC10
$OSC10
$OSC10
$OSC10

#

  a0        =  0

$OSC100
$OSC100
$OSC100
$OSC100
$OSC100
$OSC100

            out       a0

endin

