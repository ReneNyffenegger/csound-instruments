            ;; resibois
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1

  ic1       init      1
  ic2       init      10000
  kthresh   init      5000
  is1       init      1
  is2       init      1

  apluck    pluck     30000,110,110,0,3
  aout      dam       apluck,kthresh,ic1,ic2,is1,is2
            out       aout

endin

