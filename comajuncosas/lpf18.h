;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;"analog" filter library
;filters designed by Josep M Comajuncosas
;dec / 2000
;18dB/oct resonant 3 pole LPF with tanh() dist.
;orchestra-only version (no tables)
;comments to gelida@intercom.es
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


#define lpf303(input'output'fco'res'dist)#
kfcn = $fco./(sr/2)
kp   = ((-2.7528*kfcn + 3.0429)*kfcn + 1.718)*kfcn - 0.9984 
ap upsamp kp
kp1=kp+1
kscl = ((-2.7079*kp1 + 10.963)*kp1 - 14.934)*kp1 + 8.4974
;kscl = -1.6519*log(kp+1) + 2.2173
kres = $res.*kscl

ay1      init      0
ay2      init      0
aoutput  init      0

$input.  =         $input. - kres*tanh(aoutput)

ax1      delay1    $input.,1
ay1      =         ($input.+ ax1) * (ap+1)/2 - ap*ay1

ay11     delay1    ay1,1
ay2      =         (ay1 + ay11) * (ap+1)/2 - ap*ay2

ay31     delay1    ay2,1
aoutput  =         (ay2 + ay31) * (ap+1)/2 - ap*aoutput
$output.=aoutput
;$output.=tanh(aoutput*(1+($dist.*(1.5+2*kres*(1-kfcn)))))
#
