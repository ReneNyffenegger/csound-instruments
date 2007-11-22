;=======================================================;
; Interactive Test Instrument for Csound Filter Opcodes ;
;                                                       ;
; Ins Filter    Description                             ;
; 1   tone      1st-order IIR Low Pass Filter           ;       
; 2   atone     1st-order IIR High Pass Filter          ;
; 3   butterlp  2nd-order IIR Low Pass Filter           ;       
; 4   butterhp  2nd-order IIR High Pass Filter          ;
; 5   butterbp  2nd-order IIR Band Pass Filter          ;
; 6   butterbr  2nd-order IIR Band Reject Filter        ;
; 7   reson     2nd-order IIR BP Filter with scaling    ;
; 8   reson     Cascade 2 resons, use balance           ;
; 9   butterbp  Cascade 2 butterbps, use balance        ;
;                                                       ;
; Sound 1 = white noise                                 ;
; Sound 2 = 32 cosine partials (pulse wave)             ;       
; Sound 3 = sampled speech                              ;
;                                                       ;
; NB: As of this writing, the only version of Csound    ;
; that can use the GUI is Gabriel Maldonado's DirectCS  ;
; It runs well on my home system, which is an 800 MHz   ;
; PIII system running Windows ME. The DirectCS flags    ;
; that I have been using with my GUI instruments are:   ;
; -+S1 -b200                                            ;
;                                                       ;
; RFP 10-16-2001                                        ;
;=======================================================;
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

;various definitions for GUI widget sizes and positions
  itop      =  20
  ileft     =  50
  indent    =  80
  isep      =  10
  isep2     =  15
  iyinc     =  50
  imid1     =  itop
  imid2     =  4*(iyinc+isep)
  imid3     =  imid2+iyinc+isep
  iboxw     =  100
  iboxh     =  30
  ifadw     =  230
  ifadh     =  30
  ivalw     =  70
  ibox2w    =  60
  ileft2    =  25
  ileft3    =  55
  ibutw     =  90

            FLpanel   "Filter Test Panel",410,420
;value display boxes                            width   height  xpos                    ypos
  ihv1      FLvalue   "PkAmp",                        ivalw,  iboxh,  ileft3+ifadw+isep,      itop
  ihv4      FLvalue   "OscHz",                        ivalw,  iboxh,  ileft3+ifadw+isep,      itop+iyinc
  ihv2      FLvalue   "CF",                           ivalw,  iboxh,  ileft3+ifadw+isep,      itop+2*iyinc
  ihv3      FLvalue   "Q",                            ivalw,  iboxh,  ileft3+ifadw+isep,      itop+3*iyinc
;faders                                         min  max    exp type disp       width   height  xpos            ypos
  gkfader1,ihf1       FLslider                    "PkAmp",        50,  32000, -1,   5, ihv1,      ifadw,  ifadh,  ileft3,         itop
  gkfader4,ihf4       FLslider                    "OscHz",        20,  22050, -1,   5, ihv4,      ifadw,  ifadh,  ileft3,         itop+iyinc
  gkfader2,ihf2       FLslider                    "CF",           50,  22050, -1,   5, ihv2,      ifadw,  ifadh,  ileft3,         itop+2*iyinc
  gkfader3,ihf3       FLslider                    "Q",            .5,  30,    0,   5, ihv3,       ifadw,  ifadh,  ileft3,         itop+3*iyinc

;
  gkdur,ihdur  FLtext   "dur",  0, 50, 1, 2,    ibox2w, iboxh,  ileft+isep2+ibutw,      imid2
  gknn,ihnn FLtext    "insno", 1, 20, 1, 2,   ibox2w, iboxh,  ileft+isep2+ibutw+ibox2w+isep2,imid2
  gksn,ihsn FLtext    "soundno", 1, 20, 1, 2, ibox2w, iboxh,  ileft+isep2+ibutw+2*(ibox2w+isep2),imid2
;                       "label",      ion, ioff, itype, iwidth, iheight,  ix,  iy,                op, p1, p2,   p3  
  gk,ih     FLbutton  "Play a note",  3,    0,    11, ibutw,  iboxh,  ileft, imid2,  0,  gknn,  0,  gkdur
  gkload,ihload       FLbutton                    "Load Presets",  3,    0,   11, ibutw,  iboxh,  ileft2,                 imid3,  0,  13, 0,      0 
  gksave,ihsave       FLbutton                    "Save Presets",  3,    0,   11, ibutw,  iboxh,  ileft2+ibutw+isep,      imid3,  0,  12, 0,      0 
  gkstor,ihstor       FLbutton                    "Store Preset",  3,    0,   11, ibutw,  iboxh,  ileft2+2*(ibutw+isep),  imid3,  0,  11, 0,      0 
  gknum,ihnum  FLtext   "Preset",       0, 7, 1, 2,     ibox2w, iboxh,  ileft2+3*(ibutw+isep),  imid3
;                               type, nx, ny,   width,  height, ix,     iy,                     op, p1, p2, p3
  gkGet,ihget  FLbutBank  12,   8,  1,    360,    25,     ileft2, imid3+isep+iyinc,       0,  14,  0,  3
  ihx       FLbox     "Recall snapshots",1,1,14,      360,    20,     ileft2, imid3+2*iyinc-5
            FLsetFont   4,ihx
            FLsetTextType   5,ihx
            FLsetTextColor  180,180,180,ihx
FLpanel_end
            FLrun     
;initialize some widget values
            FLsetVal_i  20,ihdur
            FLsetVal_i  1,ihnn
            FLsetVal_i  1,ihsn
            FLsetVal_i  10000,ihf1
            FLsetVal_i  100,ihf2
            FLsetVal_i  1,ihf3
            FLsetVal_i  100,ihf4

;Filter test instruments with 3 sound sources
instr   1               ;1st-order IIR Low Pass Filter
if      (gksn > 1) kgoto oscil
  ain       rand      gkfader1
            kgoto     filter
oscil:
if      (gksn > 2) kgoto loscil
  ain       oscili    gkfader1,gkfader4,1
            kgoto     filter
loscil:
  ain       loscil    gkfader1,gkfader4,2,100,1,0,131022
filter:
  aout      tone      ain,gkfader2,0
            out       aout
endin
instr    2              ;1st-order IIR High Pass Filter
if      (gksn > 1) kgoto oscil
  ain       rand      gkfader1
            kgoto     filter
oscil:
if      (gksn > 2) kgoto loscil
  ain       oscili    gkfader1,gkfader4,1
            kgoto     filter
loscil:
  ain       loscil    gkfader1,gkfader4,2,100,1,0,131022
filter:
  aout      atone     ain,gkfader2,0
            out       aout
endin
instr    3              ;2nd-order IIR Low Pass Filter
if      (gksn > 1) kgoto oscil
  ain       rand      gkfader1
            kgoto     filter
oscil:
if      (gksn > 2) kgoto loscil
  ain       oscili    gkfader1,gkfader4,1
            kgoto     filter
loscil:
  ain       loscil    gkfader1,gkfader4,2,100,1,0,131022
filter:
  aout      butterlp  ain,gkfader2
            out       aout
endin
instr    4              ;2nd-order IIR High Pass Filter
if      (gksn > 1) kgoto oscil
  ain       rand      gkfader1
            kgoto     filter
oscil:
if      (gksn > 2) kgoto loscil
  ain       oscili    gkfader1,gkfader4,1
            kgoto     filter
loscil:
  ain       loscil    gkfader1,gkfader4,2,100,1,0,131022
filter:
  aout      butterhp  ain,gkfader2
            out       aout
endin
instr    5              ;2nd-order IIR Band Pass Filter
if      (gksn > 1) kgoto oscil
  ain       rand      gkfader1
            kgoto     filter
oscil:
if      (gksn > 2) kgoto loscil
  ain       oscili    gkfader1,gkfader4,1
            kgoto     filter
loscil:
  ain       loscil    gkfader1,gkfader4,2,100,1,0,131022
filter:
  aout      butterbp  ain,gkfader2,gkfader2/gkfader3
            out       aout
endin
instr    6              ;2nd-order IIR Band Reject Filter
if      (gksn > 1) kgoto oscil
  ain       rand      gkfader1
            kgoto     filter
oscil:
if      (gksn > 2) kgoto loscil
  ain       oscili    gkfader1,gkfader4,1
            kgoto     filter
loscil:
  ain       loscil    gkfader1,gkfader4,2,100,1,0,131022
filter:
  aout      butterbr  ain,gkfader2,gkfader2/gkfader3
            out       aout
endin
instr    7              ;2nd-order IIR Band Pass Filter with optional scaling
if      (gksn > 1) kgoto oscil
  ain       rand      gkfader1
            kgoto     filter
oscil:
if      (gksn > 2) kgoto loscil
  ain       oscili    gkfader1,gkfader4,1
            kgoto     filter
loscil:
  ain       loscil    gkfader1,gkfader4,2,100,1,0,131022
filter:
  aout      reson     ain,gkfader2,gkfader2/gkfader3,2 ;scale for noise
            out       aout
endin
instr    8              ;Cascade 2 resons to sharpen slope, use balance
if      (gksn > 1) kgoto oscil
  ain       rand      gkfader1
            kgoto     filter
oscil:
if      (gksn > 2) kgoto loscil
  ain       oscili    gkfader1,gkfader4,1
            kgoto     filter
loscil:
  ain       loscil    gkfader1,gkfader4,2,100,1,0,131022
filter:
  aout1     reson     ain,gkfader2,gkfader2/gkfader3,2
  aout2     reson     aout1,gkfader2,gkfader2/gkfader3,2
  asig      balance   aout2,ain
            out       asig
endin
instr    9              ;Compare 2 butterbps to 2 resons
if      (gksn > 1) kgoto oscil
  ain       rand      gkfader1
            kgoto     filter
oscil:
if      (gksn > 2) kgoto loscil
  ain       oscili    gkfader1,gkfader4,1
            kgoto     filter
loscil:
  ain       loscil    gkfader1,gkfader4,2,100,1,0,131022
filter:
  aout1     butterbp  ain,gkfader2,gkfader2/gkfader3
  aout2     butterbp  aout1,gkfader2,gkfader2/gkfader3
  asig      balance   aout2,ain
            out       asig   
endin


instr   11
  inumsnap  inumval   FLsetsnap       i(gknum)
endin

instr   12
            FLsavesnap  "filttest.txt"
endin

instr   13
            FLloadsnap  "filttest.txt"
endin

instr   14
  inumel    FLgetsnap   i(gkGet)
endin   