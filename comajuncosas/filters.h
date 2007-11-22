;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;"analog" filter library
;3 filters designed by Josep M Comajuncosas
;june / 2000
;18dB LPF TB303, 24dB LPF Moog, 24dB LPF modified Moog
;3 pole, 4 pole, 4 pole (modified)-from an idea by Hans Mikelson
;comments to gelida@intercom.es
;yet to be done : find an elegant approximation to the measured tables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;I tried with a 12dB filter but it didn´t work at all with this structure...
;anyway svfilter and rezzy *are* 12dB filters...so you have the whole collection at last!

#define lpf3(input'output'fco'res'fcoft'resft);18dB/oct resonant 3 pole LPF with tanh() compression
; + resonance driven tanh()distortion
;resonance 0-1 recalibrated to 0-.85 (don´t reach well sustained oscil., but ring a lot)
;of course you can force the filter with resonance >>1 (that will cause strong oscillation and overdrive)
;(just trying to get that TB303 nasal sound guys...not tired enough of that machine?)

#
kfconlpf3         =         $fco./(sr/2)              ; USE FREQ NORMALIZED DC TO NYQUIST
kfcoefflpf3   tablei    kfconlpf3, $fcoft., 1             ; (APPROXIMATED) TUNING TABLE
kscalelpf3    tablei    (kfcoefflpf3+1)/2, $resft., 1          ; ADJUST FEEDBACK (APPROXIMATION)
;kreslpf3      =         .85*($res.)*kscalelpf3
kreslpf3      =         1.2*($res.)*kscalelpf3


ay1lpf3       init      0
ay2lpf3       init      0
aoutputlpf3  init      0


; INVERTED FEEDBACK FOR CORNER PEAKING
$input.        =         $input. - kreslpf3*aoutputlpf3

; 4 CASCADED ONEPOLE FILTERS (BILINEAR TRANSFORM)
ax1lpf3       delay1    $input.,1;hopefully to allow legato...
ay1lpf3       =         $input. * (kfcoefflpf3+1)/2 + ax1lpf3 * (kfcoefflpf3+1)/2 - kfcoefflpf3*ay1lpf3

ay11lpf3      delay1    ay1lpf3,1
ay2lpf3       =         ay1lpf3 * (kfcoefflpf3+1)/2 + ay11lpf3 * (kfcoefflpf3+1)/2 - kfcoefflpf3*ay2lpf3

ay31lpf3      delay1    ay2lpf3,1
aoutputlpf3  =         ay2lpf3 * (kfcoefflpf3+1)/2 + ay31lpf3 * (kfcoefflpf3+1)/2 - kfcoefflpf3*aoutputlpf3
aoutputlpf3  =         tanh(aoutputlpf3)
;it sounds quite similar to the 4 pole version
;BUT things change once you add tanh() distortion :)
;$output.=aoutputlpf3;unmodified filter output (clean)
$output.=tanh(aoutputlpf3*(1.5+2*kreslpf3*(1-kfconlpf3)))
;some compression/distortion + amplitude compensation for high resonance values at low freq.cutoff

#

#define lpf4(input'output'fco'res'fcoft'resft);24dB/oct resonant 4 pole LPF with tanh() compression
#

kfconlpf4         =         $fco./(sr/2)              ; USE FREQ NORMALIZED DC TO NYQUIST
kfcoefflpf4   tablei    kfconlpf4, $fcoft., 1             ; (APPROXIMATED) TUNING TABLE
kscalelpf4    tablei    (kfcoefflpf4+1)/2, $resft., 1          ; ADJUST FEEDBACK (APPROXIMATION)
kreslpf4      =         $res.*kscalelpf4


ay1lpf4       init      0
ay2lpf4       init      0
ay3lpf4       init      0
$output.      init      0


; INVERTED FEEDBACK FOR CORNER PEAKING
$input.        =         $input. - kreslpf4*$output.

; 4 CASCADED ONEPOLE FILTERS (BILINEAR TRANSFORM)
ax1lpf4       delay1    $input.,1
ay1lpf4       =         $input. * (kfcoefflpf4+1)/2 + ax1lpf4 * ( kfcoefflpf4 +1)/2 - kfcoefflpf4*ay1lpf4

ay11lpf4      delay1    ay1lpf4,1
ay2lpf4       =         ay1lpf4 * ( kfcoefflpf4+1)/2 + ay11lpf4 * ( kfcoefflpf4 +1)/2 - kfcoefflpf4*ay2lpf4

ay21lpf4      delay1    ay2lpf4,1
ay3lpf4       =         ay2lpf4 * ( kfcoefflpf4+1)/2 + ay21lpf4 * ( kfcoefflpf4+1)/2 -  kfcoefflpf4*ay3lpf4

ay31lpf4      delay1    ay3lpf4,1
$output.      =         ay3lpf4 * ( kfcoefflpf4+1)/2 + ay31lpf4 * ( kfcoefflpf4+1)/2 - kfcoefflpf4*$output.
$output.  =         tanh($output.)
#

#define lpf42(input'output'fco'res'fcoft'resft);24dB/oct resonant 4 pole LPF
; with tanh() compression at the feedback (*only positive feedback*)
#

kfconlpf4         =         $fco./(sr/2)              ; USE FREQ NORMALIZED DC TO NYQUIST
kfcoefflpf4   tablei    kfconlpf4, $fcoft., 1             ; (APPROXIMATED) TUNING TABLE
kscalelpf4    tablei    (kfcoefflpf4+1)/2, $resft., 1          ; ADJUST FEEDBACK (APPROXIMATION)
kreslpf4      =         $res.*kscalelpf4


ay1lpf4       init      0
ay2lpf4       init      0
ay3lpf4       init      0
$output.      init      0


; INVERTED FEEDBACK FOR CORNER PEAKING
;this is the modification tho the current Moog filter
$input.        =         $input. - kreslpf4* (tanh($output.))/(1+exp(-25*($output.+.125))); smoother than a simple clipper
;you can see the feedbacked signal drawing y=tanh(x)/(1+e(-25(.125+x)))
;notice that at very low amplitudes the signal is unmodified (y~tanh(x))

; 4 CASCADED ONEPOLE FILTERS (BILINEAR TRANSFORM)
ax1lpf4       delay1    $input.,1
ay1lpf4       =         $input. * (kfcoefflpf4+1)/2 + ax1lpf4 * ( kfcoefflpf4 +1)/2 - kfcoefflpf4*ay1lpf4

ay11lpf4      delay1    ay1lpf4,1
ay2lpf4       =         ay1lpf4 * ( kfcoefflpf4+1)/2 + ay11lpf4 * ( kfcoefflpf4 +1)/2 - kfcoefflpf4*ay2lpf4

ay21lpf4      delay1    ay2lpf4,1
ay3lpf4       =         ay2lpf4 * ( kfcoefflpf4+1)/2 + ay21lpf4 * ( kfcoefflpf4+1)/2 -  kfcoefflpf4*ay3lpf4

ay31lpf4      delay1    ay3lpf4,1
$output.      =         ay3lpf4 * ( kfcoefflpf4+1)/2 + ay31lpf4 * ( kfcoefflpf4+1)/2 - kfcoefflpf4*$output.
;$output.  =         tanh($output.);removed the former moogvcf setting
#