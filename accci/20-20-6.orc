; ************************************************************************
; ACCCI:     20-20-6.ORC
; synthesis: FM(20),
;            double-carrier FM, dynamic spectral evolution (20)
;            FM-soprano (5)
; source:    Chowning(1980)
; coded:     jpg 10/93, adapted rp's sopink.orc: MIT(1993)

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iampfac   =  .5                                 ; range 0 < AMPFAC < 1
  ifenv     =  49                                 ; amp rise function
  ifport    =  31                                 ; port function
  ifffq     =  32                                 ; formant frequency lookup
  iffamp    =  33                                 ; formant amp lookup
  iffimax   =  42                                 ; formant imax lookup
  ifcimax   =  41                                 ; carrier imax lookup
  irange    =  3                                  ; max range of 3 octaves
  ibase     =  octpch(7.07)                       ; lowest note = g3
  icaroct   =  octpch(p5)                         ; p5 in true decimal
  icarhz    =  cpspch(p5)                         ; p5 in Hz

        ; ipoint points at p5-dependent location of a table with 512 locs
  ipoint    =  (icaroct-ibase)/irange*511.999

  ifmthz    table     ipoint,ifffq                ; relative pos. of formant
  ifmthz    =  ifmthz*3000                        ; map onto frequency range
  ifmthz    =  int(ifmthz/icarhz+.5)*icarhz       ; as nearest harmonic

  ifmtfac   table     ipoint,iffamp               ; relative amp. of formant
  ifmtfac   =  ifmtfac*.1                         ; max value = .1
  ifndfac   =  1-ifmtfac                          ; relative amp. of fund

  ifmtndx   table     ipoint,iffimax              ; relative index of formant
  ifmtndx   =  ifmtndx*5                          ; max value = 5

  ifndndx   table     ipoint,ifcimax              ; relative index of fund
  ifndndx   =  ifndndx*.25                        ; max value = .25

  ifndamp   =  ifndfac * sqrt(iampfac)            ; AMPFAC**.5
  ifmtamp   =  ifmtfac * iampfac * sqrt(iampfac)  ; AMPFAC**1.5

  imodhz    =  icarhz                             ; calculate modulator and
  ipkdev1   =  ifndndx*imodhz                     ; peak deviation

; compute vibrato parameters:
        ; change base of log:   log 2(hz) = log e(hz)/log e(2)
  ilog2pch  =  log(icarhz)/log(2)
  ivibwth   =  .002*ilog2pch                      ; relate width to fund pch
  ivibhz    =  5                                  ; from 5 to 6.5 hz average
  irandhz   =  125                                ; same as Morril-trumpet
  iportdev  =  .05                                ; "     "       "      "
;************************* performance
; vibrato generator
  krand     randi     ivibwth,irandhz             ; random contribution
  kvibwth   linen     ivibwth,.6,p3,.1            ; gate vibrato width
  kvib      oscili    kvibwth,ivibhz,1            ;
  kport     oscil1    0,iportdev,.2,ifport        ; initial portamento
  kv        =  1+kvib+kport+krand                 ; vibrato factor ca. 1

; modulating signal
  kdyn      linseg    0,.03,1,idur-.03-.01,.9,.01,0 ; dynamic index
  adev1     oscili    ipkdev1,imodhz*kv,1         ; modulator
  adev2     =  adev1*ifmtndx/ifndndx              ; rescale for formant

; carrier signals
  afundhz   =  (icarhz+adev1)*kv                  ; vib the modulated fund...
  aformhz   =  (ifmthz+adev2)*kv                  ; ...and modulated formant

  afund     linen     ifndamp,.1,p3,.08
  afund     oscili    afund,afundhz,1
  aform     envlpx    ifmtamp,.1,p3,.08,ifenv,1,.01
  aform     oscili    aform,aformhz,1

  asig      =  (afund+aform)*p4                   ; scale to peak amp here
            out       asig
endin
