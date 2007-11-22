;============================================================
; Granule test instrument with real-time controls.
; Demonstrated in class on 1/22/02. 
; N.B., DirectCS/MS Windows only. Requires DirectX. 
; Command line switches will vary: I use this one:
; -+S1 -b200
; RP
;============================================================
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

  itop      =  20
  ileft     =  50
  indent    =  80
  isep      =  10
  iyinc     =  50
  imid1     =  itop+3*iyinc+isep
  imid2     =  imid1+3*iyinc+15
  iboxw     =  100
  iboxh     =  30
  ifadw     =  230
  ifadh     =  30
  ivalw     =  70
  ibox2w    =  60
  ileft2    =  25
  ileft3    =  55
  ibutw     =  90

            FLpanel   "Granule Test Panel",420,580
;text boxes                             min   max    step  type                 width   height  xpos                    ypos
  gktext1,iht1 FLtext   "pkamp",        1000, 50000, 1000, 2,                   iboxw,  iboxh,  ileft,                  itop
  gktext2,iht2 FLtext   "ivoice",       1,    64,    1,    2,                   iboxw,  iboxh,  ileft+iboxw+isep,       itop
  gktext3,iht3 FLtext   "iratio",       .01,  4,     .1,   2,                   iboxw,  iboxh,  ileft+2*(iboxw+isep),   itop
  gktext4,iht4 FLtext   "imode",        -1,   1,     1,    2,                   iboxw,  iboxh,  ileft,                  itop+iyinc
  gktext5,iht5 FLtext   "ipshift",      0,    4,     1,    2,                   iboxw,  iboxh,  ileft+iboxw+isep,       itop+iyinc
  gktext6,iht6 FLtext   "mingap",       .001, .02,   .001, 2,                   iboxw,  iboxh,  ileft+2*(iboxw+isep),   itop+iyinc
  gktext7,iht7 FLtext   "maxgap",       .01,  .5,    .01,  2,                   iboxw,  iboxh,  ileft,                  itop+2*iyinc
  gktext8,iht8 FLtext   "minsize",      .001, .02,   .001, 2,                   iboxw,  iboxh,  ileft+iboxw+isep,       itop+2*iyinc
  gktext9,iht9 FLtext   "maxsize",      .01,  .5,    .01,  2,                   iboxw,  iboxh,  ileft+2*(iboxw+isep),   itop+2*iyinc
;value boxes                                                                    width   height  xpos                    ypos                    
  ihv1      FLvalue   "kgap",                                                 ivalw,  iboxh,  ileft3+ifadw+isep,      imid1
  ihv2      FLvalue   "kgsize",                                               ivalw,  iboxh,  ileft3+ifadw+isep,      imid1+iyinc+isep
  ihv3      FLvalue   "ampctl",                                               ivalw,  iboxh,  ileft3+ifadw+isep,      imid1+2*iyinc+isep
;faders                                         min  max exp type disp          width   height  xpos                    ypos
  gkfader1,ihf1       FLslider                    "kgap",         0,  1,   0,   5, ihv1,          ifadw,  ifadh,  ileft3,                 imid1
  gkfader2,ihf2       FLslider                    "kgsize",       0,  1,   0,   5, ihv2,          ifadw,  ifadh,  ileft3,                 imid1+iyinc+isep
  gkfader3,ihf3       FLslider                    "ampctl",       0,  1,   0,   5, ihv3,          ifadw,  ifadh,  ileft3,                 imid1+2*iyinc+isep
;env controls
  gkv1a,ih1a   FLtext   "gpoff",  0, 100, 5, 2,                 ibox2w, iboxh,  ileft2,                 imid2
  gkv1b,ih1b   FLtext   "szoff",  0, 100, 5, 2,                 ibox2w, iboxh,  ileft2+ibox2w+2,        imid2
  gkv1c,ih1c   FLtext   "pit1",   .125, 4, .125, 2,             ibox2w, iboxh,  ileft2+2*(ibox2w+2),    imid2
  gkv1d,ih1d   FLtext   "pit2",   .125, 4, .125, 2,             ibox2w, iboxh,  ileft2+3*(ibox2w+2),    imid2
  gkv1e,ih1e   FLtext   "pit3",   .125, 4, .125, 2,             ibox2w, iboxh,  ileft2+4*(ibox2w+2),    imid2
  gkv1f,ih1f   FLtext   "pit4",   .125, 4, .125, 2,             ibox2w, iboxh,  ileft2+5*(ibox2w+2),    imid2
;
  gkdur,ihdur  FLtext   "dur",     0, 50, 1, 2,                 ibox2w, iboxh,  ileft+ibutw+isep*4,     imid2+iyinc+isep
  gknn,ihnn FLtext    "sound #", 1, 20, 1, 2,                 ibox2w, iboxh,  ileft+2*(ibutw+isep*4), imid2+iyinc+isep
;                               "label",      ion, ioff, itype, iwidth, iheight,  ix,                   iy,               op, p1, p2,   p3  
  gk,ih     FLbutton  "Play a note",  3,    0,    11, ibutw,  iboxh,  ileft,                  imid2+iyinc+isep,  0,  1,  0,  gkdur ,gktext1, gktext2, gktext3, gktext4, gktext5, gktext6, gktext7, gktext8, gktext9, gkfader1, gkfader2, gkfader3 ,gkv1a,gkv1b,gkv1c,gkv1d,gkv1e,gkv1f,gknn
  gkload,ihload       FLbutton                    "Load Presets",  3,    0,   11, ibutw,  iboxh,  ileft2,                 imid2+20+2*iyinc,  0,  13, 0,   0 
  gksave,ihsave       FLbutton                    "Save Presets",  3,    0,   11, ibutw,  iboxh,  ileft2+ibutw+isep,      imid2+20+2*iyinc,  0,  12, 0,   0 
  gkstor,ihstor       FLbutton                    "Store Preset",  3,    0,   11, ibutw,  iboxh,  ileft2+2*(ibutw+isep),  imid2+20+2*iyinc,  0,  11, 0,   0 
  gknum,ihnum  FLtext   "Preset",       0, 7, 1, 2,     ibox2w, iboxh,  ileft2+3*(ibutw+isep),  imid2+20+2*iyinc
;                               type, nx, ny,   width,  height, ix,     iy,                     op, p1, p2, p3
  gkGet,ihget  FLbutBank  12,   8,  1,    360,    25,     ileft2, imid2+25+3*iyinc,       0,  14,  0,  3
  ihx       FLbox     "Recall snapshots",1,1,14,      360,    20,     ileft2, imid2+5+4*iyinc
            FLsetFont   4,ihx
            FLsetTextType   5,ihx
            FLsetTextColor  180,180,180,ihx
FLpanel_end
            FLrun     
;set up some default values for the widgets
            FLsetVal_i  10000,iht1                ;amp
            FLsetVal_i  4,iht2                    ;voices
            FLsetVal_i  .5,iht3                   ;ratio
            FLsetVal_i  1,iht4                    ;mode
            FLsetVal_i  4,iht5                    ;pshift
            FLsetVal_i  .01,iht6                  ;mingap
            FLsetVal_i  .2,iht7                   ;maxgap
            FLsetVal_i  .02,iht8                  ;minsize
            FLsetVal_i  .5,iht9                   ;maxsize
            FLsetVal_i  20,ihdur                  ;p3
            FLsetVal_i  2,ihnn                    ;soundfile number
            FLsetVal_i  0,ih1a                    ;gap offset pct
            FLsetVal_i  0,ih1b                    ;size offset pct
            FLsetVal_i  1,ih1c                    ;pitch factor 1
            FLsetVal_i  1,ih1d                    ;pitch factor 2
            FLsetVal_i  1,ih1e                    ;pitch factor 3
            FLsetVal_i  1,ih1f                    ;pitch factor 4

;=========================================================
; Interactive test instrument for granule
; Demonstrated in class on 1/22/2002 
; RFP
;=========================================================

instr   1
  iamp      =  p4
  ivoice    =  p5
  iratio    =  p6
  imode     =  p7
  ithd      =  0
  ifn       =  p22
  ipshift   =  p8      
  igapmin   =  p9
  igapmax   =  p10
  igapvar   =  igapmax-igapmin
  isizmin   =  p11
  isizmax   =  p12
  isizvar   =  isizmax-isizmin
  igskip    =  0
  igskos    =  0
  ilength   =  nsamp(ifn)/sr
  igapoff   =  p16
  isizoff   =  p17
  iatt      =  30      
  idec      =  30
  iseed     =  .13
  ipitch1   =  p18
  ipitch2   =  p19
  ipitch3   =  p20
  ipitch4   =  p21 
            print     imode
  kgap      =  igapmin+igapvar*gkfader1
  ksize     =  isizmin+isizvar*gkfader2
  asig      granule   iamp*gkfader3,ivoice,iratio,imode,ithd,ifn,ipshift,igskip,igskos,ilength,kgap,igapoff, ksize,isizoff,iatt,idec,iseed,ipitch1,ipitch2,ipitch3,ipitch4
            out       asig
endin

instr   11
  inumsnap  inumval   FLsetsnap       i(gknum)
endin

instr   12
            FLsavesnap  "grfader.txt"
endin

instr   13
            FLloadsnap  "grfader.txt"
endin

instr   14
  inumel    FLgetsnap   i(gkGet)
endin   