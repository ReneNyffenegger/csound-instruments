  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;===============================================================
;FOF demo instrument for varying vowels. Vowel data is stored in
;a table this time. Linsegs are used to interpolate between the
;successive formant frequencies, amplitudes, and band widths.
;Up to 5 vowel formants can be passed through per note. If less
;than 5 vowel formants will be used, be sure the durations of the
;vowels add to at least p3 seconds. Otherwise, the linsegs will 
;continue to interpolate in whatever direction they were last 
;headed!
;RP
;===============================================================

instr   2               ;variable vowels
  idur      =  p3                                 ;overall duration
  igain     =  p4                                 ;gain factor
  ibasedb   =  dbamp(32767)                       ;max amp for 16-bit - use as 0dB reference
  ifund     =  cpspch(p5)
  ivibdel   =  p6
  ivibwth   =  p7
  ivibrte   =  p8
  ivfn      =  p9                                 ;vowel formant data function
  irise     =  p10                                ;global env settings
  idecay    =  p11
  ivow1     =  p12                                ;number of 1st vowel
  idur1     =  p13                                ;duration until 2nd vowel
  ivow2     =  p14                                ;number of 2nd vowel
  idur2     =  p15                                ;duration until 3rd vowel
  ivow3     =  p16                                ;number of 3rd vowel
  idur3     =  p17                                ;etc.
  ivow4     =  p18
  idur4     =  p19
  ivow5     =  p20
  ioct      =  p21
  iolaps    =  (p22 == 0 ? 20 : p22)              ;default to 20 overlaps
  iolaps    =  20
  index1    =  18*(ivow1-1)
  index2    =  18*(ivow2-1)
  index3    =  18*(ivow3-1)
  index4    =  18*(ivow4-1)
  index5    =  18*(ivow5-1)
  ifmt11    table     index1,ivfn
  iamp11    table     index1+1,ivfn
  ibw11     table     index1+2,ivfn
  ifmt12    table     index1+3,ivfn
  iamp12    table     index1+4,ivfn
  ibw12     table     index1+5,ivfn
  ifmt13    table     index1+6,ivfn
  iamp13    table     index1+7,ivfn
  ibw13     table     index1+8,ivfn
  ifmt14    table     index1+9,ivfn
  iamp14    table     index1+10,ivfn
  ibw14     table     index1+11,ivfn
  ifmt15    table     index1+12,ivfn
  iamp15    table     index1+13,ivfn
  ibw15     table     index1+14,ivfn
  ilrise1   table     index1+15,ivfn
  ildur1    table     index1+16,ivfn
  ildec1    table     index1+17,ivfn
  ifmt21    table     index2,ivfn
  iamp21    table     index2+1,ivfn
  ibw21     table     index2+2,ivfn
  ifmt22    table     index2+3,ivfn
  iamp22    table     index2+4,ivfn
  ibw22     table     index2+5,ivfn
  ifmt23    table     index2+6,ivfn
  iamp23    table     index2+7,ivfn
  ibw23     table     index2+8,ivfn
  ifmt24    table     index2+9,ivfn
  iamp24    table     index2+10,ivfn
  ibw24     table     index2+11,ivfn
  ifmt25    table     index2+12,ivfn
  iamp25    table     index2+13,ivfn
  ibw25     table     index2+14,ivfn
  ilrise2   table     index2+15,ivfn
  ildur2    table     index2+16,ivfn
  ildec2    table     index2+17,ivfn
  ifmt31    table     index3,ivfn
  iamp31    table     index3+1,ivfn
  ibw31     table     index3+2,ivfn
  ifmt32    table     index3+3,ivfn
  iamp32    table     index3+4,ivfn
  ibw32     table     index3+5,ivfn
  ifmt33    table     index3+6,ivfn
  iamp33    table     index3+7,ivfn
  ibw33     table     index3+8,ivfn
  ifmt34    table     index3+9,ivfn
  iamp34    table     index3+10,ivfn
  ibw34     table     index3+11,ivfn
  ifmt35    table     index3+12,ivfn
  iamp35    table     index3+13,ivfn
  ibw35     table     index3+14,ivfn
  ilrise3   table     index3+15,ivfn
  ildur3    table     index3+16,ivfn
  ildec3    table     index3+17,ivfn
  ifmt41    table     index4,ivfn
  iamp41    table     index4+1,ivfn
  ibw41     table     index4+2,ivfn
  ifmt42    table     index4+3,ivfn
  iamp42    table     index4+4,ivfn
  ibw42     table     index4+5,ivfn
  ifmt43    table     index4+6,ivfn
  iamp43    table     index4+7,ivfn
  ibw43     table     index4+8,ivfn
  ifmt44    table     index4+9,ivfn
  iamp44    table     index4+10,ivfn
  ibw44     table     index4+11,ivfn
  ifmt45    table     index4+12,ivfn
  iamp45    table     index4+13,ivfn
  ibw45     table     index4+14,ivfn
  ilrise4   table     index4+15,ivfn
  ildur4    table     index4+16,ivfn
  ildec4    table     index4+17,ivfn
  ifmt51    table     index5,ivfn
  iamp51    table     index5+1,ivfn
  ibw51     table     index5+2,ivfn
  ifmt52    table     index5+3,ivfn
  iamp52    table     index5+4,ivfn
  ibw52     table     index5+5,ivfn
  ifmt53    table     index5+6,ivfn
  iamp53    table     index5+7,ivfn
  ibw53     table     index5+8,ivfn
  ifmt54    table     index5+9,ivfn
  iamp54    table     index5+10,ivfn
  ibw54     table     index5+11,ivfn
  ifmt55    table     index5+12,ivfn
  iamp55    table     index5+13,ivfn
  ibw55     table     index5+14,ivfn
  ilrise5   table     index5+15,ivfn
  ildur5    table     index5+16,ivfn
  ildec5    table     index5+17,ivfn
; interpolate gradually from one vowel to the next
  kform1    linseg    ifmt11,idur1,ifmt21,idur2,ifmt31,idur3,ifmt41,idur4,ifmt51,1,ifmt51
  kamp1     linseg    iamp11,idur1,iamp21,idur2,iamp31,idur3,iamp41,idur4,iamp51,1,iamp51
  kamp1     =  ampdb(ibasedb+kamp1)
  kbw1      linseg    ibw11,idur1,ibw21,idur2,ibw31,idur3,ibw41,idur4,ibw51,1,ibw51
  kform2    linseg    ifmt12,idur1,ifmt22,idur2,ifmt32,idur3,ifmt42,idur4,ifmt52,1,ifmt52
  kamp2     linseg    iamp12,idur1,iamp22,idur2,iamp32,idur3,iamp42,idur4,iamp52,1,iamp52
  kamp2     =  ampdb(ibasedb+kamp2)
  kbw2      linseg    ibw12,idur1,ibw22,idur2,ibw32,idur3,ibw42,idur4,ibw52,1,ibw52
  kform3    linseg    ifmt13,idur1,ifmt23,idur2,ifmt33,idur3,ifmt43,idur4,ifmt53,1,ifmt53
  kamp3     linseg    iamp13,idur1,iamp23,idur2,iamp33,idur3,iamp43,idur4,iamp53,1,iamp53
  kamp3     =  ampdb(ibasedb+kamp3)
  kbw3      linseg    ibw13,idur1,ibw23,idur2,ibw33,idur3,ibw43,idur4,ibw53,1,ibw53
  kform4    linseg    ifmt14,idur1,ifmt24,idur2,ifmt34,idur3,ifmt44,idur4,ifmt54,1,ifmt54
  kamp4     linseg    iamp14,idur1,iamp24,idur2,iamp34,idur3,iamp44,idur4,iamp54,1,iamp54
  kamp4     =  ampdb(ibasedb+kamp4)
  kbw4      linseg    ibw14,idur1,ibw24,idur2,ibw34,idur3,ibw44,idur4,ibw54,1,ibw54
  kform5    linseg    ifmt15,idur1,ifmt25,idur2,ifmt35,idur3,ifmt45,idur4,ifmt55,1,ifmt55
  kamp5     linseg    iamp15,idur1,iamp25,idur2,iamp35,idur3,iamp45,idur4,iamp55,1,iamp55
  kamp5     =  ampdb(ibasedb+kamp5)
  kbw5      linseg    ibw15,idur1,ibw25,idur2,ibw35,idur3,ibw45,idur4,ibw55,1,ibw55
;local envelope settings
  klrise    linseg    ilrise1,idur1,ilrise2,idur2,ilrise3,idur3,ilrise4,idur4,ilrise5,1,ilrise5
  kldur     linseg    ildur1,idur1,ildur2,idur2,ildur3,idur3,ildur4,idur4,ildur5,1,ildur5
  kldec     linseg    ildec1,idur1,ildec2,idur2,ildec3,idur3,ildec4,idur4,ildec5,1,ildec5
;main envelope
  kenv      linen     igain,irise,idur,idecay
  kvibctl   oscil1i   ivibdel,1,.25,3             ;fn3 is vib control function
  kvib      oscili    kvibctl*ivibwth,kvibctl*ivibrte,1
  kfund     =  ifund*(1+kvib)
  ar1       fof       kamp1, kfund, kform1, ioct, kbw1, klrise, kldur, kldec, iolaps, 1, 2, idur,0,1
  ar2       fof       kamp2, kfund, kform2, ioct, kbw2, klrise, kldur, kldec, iolaps, 1, 2, idur,0,1
  ar3       fof       kamp3, kfund, kform3, ioct, kbw3, klrise, kldur, kldec, iolaps, 1, 2, idur,0,1
  ar4       fof       kamp4, kfund, kform4, ioct, kbw4, klrise, kldur, kldec, iolaps, 1, 2, idur,0,1
  ar5       fof       kamp5, kfund, kform5, ioct, kbw5, klrise, kldur, kldec, iolaps, 1, 2, idur,0,1
            out       (ar1+ar2+ar3+ar4+ar5)*kenv
endin