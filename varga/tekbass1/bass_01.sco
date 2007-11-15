/* bass_01.sco - written by Istvan Varga, 2002 */

t       0       137.00  /*      tempo   */

#define PATTERN1(strt'n1'n2'flt1'flt2) #

;	start time	     duration	note number   veloc	filter freq.

i 1 [  $strt  +      0.000  ]      0.100  [      $n1    -      12     ]      90     $flt1
i 1 [  $strt  +      0.500  ]      0.100  [      $n1    -      12     ]      90     <   
i 1 [  $strt  +      0.500  ]      0.400  $n1    120    <  
i 1 [  $strt  +      1.000  ]      0.100  [      $n1    -      12     ]      90     <   
i 1 [  $strt  +      1.500  ]      0.100  [      $n1    -      12     ]      90     <   
i 1 [  $strt  +      1.500  ]      0.375  $n1    127    <  
i 1 [  $strt  +      2.000  ]      0.100  [      $n2    -      12     ]      90     <   
i 1 [  $strt  +      2.500  ]      0.100  [      $n2    -      12     ]      90     <   
i 1 [  $strt  +      2.500  ]      0.350  $n2    120    <  
i 1 [  $strt  +      3.000  ]      0.100  [      $n2    -      12     ]      90     <   
i 1 [  $strt  +      3.500  ]      0.100  [      $n2    -      12     ]      90     <   
i 1 [  $strt  +      3.500  ]      0.350  $n2    112    $flt2

#

$PATTERN1( 0'36'36'60'64)
$PATTERN1( 4'36'36'64'68)
$PATTERN1( 8'36'36'68'72)
$PATTERN1(12'36'36'72'76)
$PATTERN1(16'36'36'76'80)
$PATTERN1(20'36'36'80'84)
$PATTERN1(24'36'36'84'88)
$PATTERN1(28'36'36'88'92)

/* ---- bass drum parameters ---- */

f 20  0     32    -2    0.50            ; volume
      0.03                              ; release time (sec.)
      31                                ; base frequency (MIDI note number)
      5.3333                            ; oscillator start frequency / base frequency
      0.0714                            ; oscillator freq. envelope half-time in beats
      0.5                               ; bandpass 1 bandwidth / oscillator frequency
      0.0625                            ; highpass 1 freq. / oscillator frequency
      0.5                               ; "allpass" 1 start freq. / oscillator frq.
      0.125                             ; "allpass" 1 envelope half-time in beats
      1.0                               ; "allpass" 1 end frq. / oscillator frequency
      8                                 ; highpass 2 frequency / base frequency
      -2                                ; highpass 2 output gain
      0.5                               ; highpass 3 freq. / base frequency
      -0.4                              ; highpass 3 output gain
      1.5                               ; output highpass frequency / base frequency
      2                                 ; output highpass resonance
      40                                ; output lowpass start freq 1 / oscillator frq.
      0.01                              ; output lowpass frequency 1 half-time in beats
      8                                 ; output lowpass start freq 2 / oscillator frq.
      0.1                               ; output lowpass frequency 2 half-time in beats
      7040                              ; noise bandpass start frequency in Hz
      7040                              ; noise bandpass end frequency in Hz
      2                                 ; noise bandpass bandwidth / frequency
      3520                              ; noise lowpass start frequency (Hz)
      55                                ; noise lowpass end frequency (Hz)
      0.0833                            ; noise filter envelope half-time in beats
      0.01                              ; noise attack time (in seconds)
      0.3333                            ; noise decay half-time (in beats)
      0.4                               ; noise mix

#define BDPAT1(strt'ft) #

i 2 [  $strt  +      0.000  ]      0.400  $ft    127
i 2 [  $strt  +      1.005  ]      0.400  $ft    120
i 2 [  $strt  +      2.000  ]      0.400  $ft    127
i 2 [  $strt  +      3.005  ]      0.400  $ft    120

#

$BDPAT1( 0'20)
$BDPAT1( 4'20)
$BDPAT1( 8'20)
$BDPAT1(12'20)
$BDPAT1(16'20)
$BDPAT1(20'20)
$BDPAT1(24'20)
$BDPAT1(28'20)

e

