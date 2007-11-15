  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr    1 ; Virtual Mutronics Mutatorª. (sans VCAs)

  igain     =  p4                                 ; Gain: >1=Overdrive
  ifreq     =  p5                                 ; Manual cutoff frequency (0 to 1)
  idepth    =  p6/2                               ; LFO depth
  irate1    =  p7                                 ; L LFO rate
  irate2    =  p8                                 ; R LFO rate
  iphase    =  p9/360                             ; R LFO phase
  iwave     =  p10                                ; LFO waveform
  irez      =  p11                                ; Resonance

  ain       soundin   "sample1.wav"

  ain       =  ain*igain                          ; Gain/Overdrive
  klfo1     oscili    idepth, irate1, iwave       ; L LFO
  klfo2     oscili    idepth, irate2, iwave, iphase ; R LFO
  klfo1     =  klfo1 + idepth                     ; Make unipolar
  klfo2     =  klfo2 + idepth                     ; Make unipolar
  kfreq1    table     klfo1 + ifreq, 1, 1         ; L lin/exp convertor
  kfreq2    table     klfo2 + ifreq, 1, 1         ; R lin/exp convertor
  avcfl     moogvcf   ain, kfreq1, irez, 32768    ; L VCF
  avcfr     moogvcf   ain, kfreq2, irez, 32768    ; R VCF
            outs1     avcfl                       ; L Output
            outs2     avcfr                       ; R Output

endin