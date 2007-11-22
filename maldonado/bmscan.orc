  sr        =  44100
  kr        =  882                                ;1764
  ksmps     =  50
  nchnls    =  2


  giTabWidths  ftgen  51, 0, 128, 2, 0
  giTabHeights ftgen  52, 0, 128, 2, 0

;giwidth,giheight,gibpp bmopen  "C:/CSOUND/ga2000/QT2.bmp",giBMP
;iwidth,iheight,ibpp bmopen     "C:/CSOUND/ga2000/Coloured Spices.BMP",1
  iwidth,iheight,ibpp bmopen  "C:/My_Docs/Visual_C/paintlib/testpic/rgb8.pct", 1
            tabw      _i          iwidth, 1, giTabWidths
            tabw      _i          iheight, 1, giTabHeights
  iwidth,iheight,ibpp bmopen  "C:/CSOUND/ga2000/spirali1.bmp", 2
            tabw      _i          iwidth, 2, giTabWidths
            tabw      _i          iheight, 2, giTabHeights
  iwidth,iheight,ibpp bmopen  "C:/CSOUND/ga2000/spirali2.bmp", 3
            tabw      _i          iwidth, 3, giTabWidths
            tabw      _i          iheight, 3, giTabHeights
  iwidth,iheight,ibpp bmopen  "C:/CSOUND/ga2000/spirali3.bmp", 4
            tabw      _i          iwidth, 4, giTabWidths
            tabw      _i          iheight, 4, giTabHeights
  iwidth,iheight,ibpp bmopen  "C:/CSOUND/ga2000/nasca6.bmp", 5
            tabw      _i          iwidth, 5, giTabWidths
            tabw      _i          iheight, 5, giTabHeights
  iwidth,iheight,ibpp bmopen  "C:/CSOUND/ga2000/nasca7.bmp", 6
            tabw      _i          iwidth, 6, giTabWidths
            tabw      _i          iheight, 6, giTabHeights
  iwidth,iheight,ibpp bmopen  "C:/CSOUND/ga2000/nasca7b.bmp", 7
            tabw      _i          iwidth, 7, giTabWidths
            tabw      _i          iheight, 7, giTabHeights
  iwidth,iheight,ibpp bmopen  "C:/CSOUND/ga2000/nasca7c.bmp", 8
            tabw      _i          iwidth, 8, giTabWidths
            tabw      _i          iheight, 8, giTabHeights
  iwidth,iheight,ibpp bmopen  "C:/CSOUND/ga2000/nasca7d.bmp", 9
            tabw      _i          iwidth, 9, giTabWidths
            tabw      _i          iheight, 9, giTabHeights
  iwidth,iheight,ibpp bmopen  "C:/CSOUND/ga2000/nasca7e.bmp", 10
            tabw      _i          iwidth, 10, giTabWidths
            tabw      _i          iheight, 10, giTabHeights
  giElems   init      32

  iTabExp   ftgen     101, 0, 129, 5, .1, 127, 1, 128, 1 ;ascending exponential curve
  giTabExp  ftgen     100, 0, 129, -24, iTabExp, 0, 1 ;** exponential curve for slider mapping

  giTabFreq1   ftgen  1, 0, 512, -7, 1, giElems, 8, 128, 8
  giTabFreq2   ftgen  2, 0, 512, -5, 1, giElems, 2, 128, 2

  giTabRed  ftgen     4, 0, 512, 2, 0
  giTaGreen ftgen     5, 0, 512, 2, 0
  giTaBlue  ftgen     6, 0, 512, 2, 0

  giTaScale ftgen     32, 0, 512, 5, 1, giElems, .08
  giTemp    ftgen     33, 0, 512, 2, 0

  itabsize  init      2048
  gaReverb  init      0

  isine     ftgen     10, 0, itabsize, 10, 1
  isine     ftgen     11, 0, itabsize, 10, 1, 1, 1
  isine     ftgen     12, 0, itabsize, 10, 1, 0, 1
  isine     ftgen     13, 0, itabsize, 10, 1, .5, .2, .1, 0, .05, .02, 0, .01, 0, .01
  isine     ftgen     14, 0, itabsize, 10, 1, 0, .5, .2, 0, .1
  isine     ftgen     15, 0, itabsize, 10, .5, 1, .5, .3, .2, .1
  isine     ftgen     16, 0, itabsize, 10, 1, 0, 0, 0, 0, 0, .5
  isine     ftgen     17, 0, itabsize, 10, 1, 1, 0, 1, 0, .5, 0, .1
  isine     ftgen     18, 0, itabsize, 10, 1, .2, .1, .05
  isine     ftgen     19, 0, itabsize, 10, 1, .1, 0, 0, 0, .1, .05, .02, .01
  isine     ftgen     20, 0, itabsize, 10, 0, 0, 0, 1, 1, 1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 100
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  gk        _1        , gk_2, gk_3, gk_4, gk_5, gk_6, gk_7, gk_8, gk        _9          , gk_10, gk_11, gk_12, gk_13, gk_14, gk_15, gk_16slider161, \ ;        ctl min         maxinitfunc
  1,        0           , 1, .05, giTabExp,       \   ;1  scanning speed (phasor rate)
  2,        1           , 2.5, 1, 0,              \          ;2  frequency table select
  3,        1           , 5, 1, 0,                \            ;3  freqency range adjustment
  4,        0           , 1, 0, 0,                \            ;4  absolute phase of horizontal dimension
  5,        1           , 10.5, 1, 0,             \         ;5  change image
  6,        .25         , 8, .5, giTabExp,        \    ;6  base frequency offset
  7,        10          , 20.5, 10, 0,            \        ;7  audio waveform
  8,      0.01,   5,      0.01,   giTabExp,       \;8  amplitude envelope attack time
  9,      0,      50,     0,      0,              \;9  vibrato depth
  10,     300,    8000,   3200,   0,              \;10  
  11,     0,      2,      0,      0,              \;11  
  12,     0,      3,      0,      0,              \;12  
  13,     0,      .2,     .05,    0,              \;13  
  14,     0,      .5,     0,      0,              \;14  
  15,     0,      3,      0,      0,              \;15  
  16,     .05,    2,      1,      0               ;16 
  a1        tone      gaReverb, 3000
  a2        nreverb   a1*.06, 4.5, .1
  a1        delay     a2, .0899
  a3        delay     a2, .112345
            outs      a1, a3
            clear     gaReverb    

endin 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr   1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ifreq     cpsmidi   
  iamp      ampmidi   10
  ktime     midic7    0, 2, .2
  kphs      phasor    gk_1

  iTabFreq  =  i(gk_2)

  iBMP      =  i(gk_5)                            ;number of present scanned picture
  iwidth    tab       _ii(gk_5), giTabWidths
  iheight   tab       _ii(gk_5), giTabHeights

  isine     =  i(gk_7)

  kphs      =  (kphs+gk_4)*iwidth
  kphs      limit     kphs, 0, iwidth-1
;               kphs, ihorLines,      ifn,  istartLine, ifnR, ifnG, ifnB;
            bmscani   kphs        , iheight/giElems, iBMP, 0, giTabRed, giTaGreen, giTaBlue

            vaddv     giTabRed    , giTaGreen, giElems
            vaddv     giTabRed    , giTaBlue, giElems
            vmultv    giTabRed    , giTaScale, giElems
            vport     giTabRed    , .025, giElems
            vcopy     giTemp      , iTabFreq, giElems
            vpow      giTemp      , gk_3, giElems
  kenv      linsegr   0, i(gk_8), iamp, 1, iamp, .1, 0
  kvib      vibr      gk_9, 4, 10
  a1        adsynt    kenv, ifreq*gk_6*cent(kvib), isine, giTemp, giTabRed, giElems, 1
  a1        tone      a1, 1000
  ipan      linrand   2.99
  ipan      =  int(ipan)/2
            vincr     gaReverb    , a1
            outs      a1*ipan, a1*(1-ipan)
endin 




