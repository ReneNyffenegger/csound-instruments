  sr        =  44100
  kr        =  100
  ksmps     =  441

instr 2
  ibase     =  110                                ; lowest pitch
  iseed1    =  p5                                 ; choose different seed (-1 <= p5 <= 1)
                        ; for different sequences
  idelta    =  p6                                 ; time density
  iplimit   =  10.5                               ; want rawpch in [0,21] (3 7note octaves)
  itlimit   =  .5                                 ; want rawdur in [0,1] inverse transformed
                        ; to fit in exponential distribution
  kx        rand      .5, iseed1                  ; seed
  iseed1    =  p5                                 ; don't reinit rand during this p time
        
reset:
  kpch      rand      1, iseed1
  kdur      rand      1, iseed1
  iseed1    =  p5
  irawp     =  i(kpch)*iplimit + iplimit          ; 0 <= rawpch <= 1
  irawd     =  i(kdur)*itlimit + itlimit          ; 0 <= rawdur <= 1
  ioct      =  int(irawp/7)                       ; which octave
  ipc       =  irawp - ioct*7                     ; which note class
  ipch      table     ipc,1                       ; get ratio of note class
  ipch      =  ipch*ibase*exp(ioct*log(2))        ; compute pitch freq
  idur      =  -log(irawd)/idelta                 ; inverse exp distribution
  id        =  (idur < .2 ? .2 : idur)            ; min note duration
            print     ipch, idur, id
  kamp      expon     p4, id, .01                 ; simple env
  a1        oscil     kamp, ipch, 2               ; simple osc
            out       a1
            timout    0, idur, contin             ; timeout = random dur
            reinit    reset                       ; reinitialize note after timeout
            rireturn  
contin:
endin

