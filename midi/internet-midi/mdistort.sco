; A TEST OF THE MODULATING DISTORTION INSTRUMENT


; FUNCTION DEFINITIONS
;----------------------------------------------------------------
f1  0 1024  10    1                     ;PURE SINE FOR INSTR 2

f2  0 1025  7     0     250   -1    524   1     250   0 ;TRANSFER FUNCTION: RAMP WITH TRIANGS
; FROM -1 TO + 1

f3  0 33    7     .01   16    1     17    1 ;VOLUME ADJUSTMENT FOR ABOVE XFER
; ACCORDING TO TOTAL DISTORTION INDEX

f4  0 17    7     0     17    1         ;RAMP FOR ENVELOPE ATTACK

f5  0 65    10    1                     ;COARSE SINE FOR CONTROL SIGNALS

f6  0 1024  10    1                     ;IN THIS CASE, SINCE WE COMPARING,
;WE'LL USE A PURE SINE FOR INSTR 1 TOO

f0  30
