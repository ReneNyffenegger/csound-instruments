sr       = 44100
kr       = 44100
ksmps    = 1
nchnls   = 2

instr    1 ; Stereo Frequency Shifter with delays

ilevl    = p4                              ; Output level
ishftl   = p5                              ; L shift (Hz)
ishftr   = p6                              ; R shift (Hz)
idepth   = p7/2                            ; LFO depth (Hz)
irate1   = p8                              ; L LFO rate (Hz)
irate2   = p9                              ; R LFO rate (Hz)
iphse    = p10                             ; R LFO phase
iwave    = p11                             ; LFO waveform
ifdbk    = p12                             ; Feedback
idell    = p13/1000                        ; L delay time (ms)
idelr    = p14/1000                        ; R delay time (ms)
ifdel    = p15                             ; Delay feedback
ixfdel   = p16                             ; Delay cross-feedback
imix     = p17                             ; Mix: 0=Input 1=Output
afeedl   init 0                            ; L feedback initialize
afeedr   init 0                            ; R feedback initialize
afdell   init 0                            ; L delay initialize
afdelr   init 0                            ; R delay initialize

;al, ar   soundin  "StereoSample"
al       soundin  "sample1.wav"
ar       = al

klfol    oscili  idepth, irate1, iwave     ; L LFO
klfol    = klfol + idepth                  ; Make unipolar
klfor    oscili  idepth, irate2, iwave     ; R LFO
klfor    = klfor + idepth                  ; Make unipolar
a1l, a2l hilbert  al + afeedl + afdell     ; L hilbert transform
a1r, a2r hilbert  ar + afeedr + afdelr     ; R hilbert transform
asinl    oscili  1, ishftl + klfol, 1      ; L sine
acosl    oscili  1, ishftl + klfol, 1, .25 ; L cosine
asinr    oscili  1, ishftr + klfor, 1      ; R sine
acosr    oscili  1, ishftr + klfor, 1, .25 ; R cosine
ashiftl  = (a1l*acosl + a2l*asinl)*.8      ; L shift
ashiftr  = (a1r*acosr + a2r*asinr)*.8      ; R shift
afeedl   = ashiftl*ifdbk                   ; L shift feedback
afeedr   = ashiftr*ifdbk                   ; R shift feedback
adelayl  delay  ashiftl, idell             ; L Delay
adelayr  delay  ashiftr, idelr             ; R delay
afdell   = adelayl*ifdel + adelayl*ixfdel  ; L Delay feedback
afdelr   = adelayr*ifdel + adelayr*ixfdel  ; R Delay feedback
aoutl    = ashiftl*imix + al*(1 - imix)    ; L mix
aoutr    = ashiftr*imix + ar*(1 - imix)    ; R mix
outs1    aoutl*ilevl                       ; L output
outs2    aoutr*ilevl                       ; R output

endin