  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;===================================================================
; Example Convolution Instrument. Uses the impulse file convolve.p6,
; which will be convolved with the soundin file soundin.p5. The dry
; (original) sound can be mixed with the wet (convolved) sound and
; should have a delay time equal to the exact length of the original
; impulse file. A mechanism is implemented to discard the initial 
; zeros before the output of convolve begins to appear.
; RP
;===================================================================

instr   1
  iampscl   =  p4                                 ;amplitude scaling factor
  isound    =  p5
  impfile   =  p6
  idelay    =  p7
  idryfac   =  p8
  kcount    init      idelay*kr                   ;set counter for initial delay
loop:
  asound    soundin   isound                      ;use soundin.p5
  awet      convolve  asound*iampscl,impfile      ;use convolve.p6
  adry      delay     asound,idelay               ;delayed dry signal
  kcount    =  kcount-1                           ;decrement delay counter
if      (kcount > 0) kgoto loop                   ;discard initial output
            out       adry*idryfac+awet*(1-idryfac)
endin

