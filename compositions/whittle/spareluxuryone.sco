; SL_ONE.SCO   SPARE LUXURY ONE - ROBIN WHITTLE
; 
; SEE DOCO AT THE END OF THIS FILE WHICH TOGETHER WITH SL_ONE.ORC 
; PROVIDES AN EXPLANATION OF MY BINAURAL MODEL.
;
; BLIND PEOPLE - SEARCH FOR BINARUAL MODEL OVERVIEW.
;
;
; ORIGINALLY SPARE LUXURY 19 20 APRIL 1995.
;
; SCORE MODIFIED TO MAKE IT SHORTER 7 MIN 40 SEC = 460 SEC. IT WAS 8 MINUTES.
; I HAD ENCOUNTED ANOMALOUS VOLUME DROPS AT 7 MINUTES 43.67 SECONDS, AND 
; I COULD NOT FIGURE OUT WHY.
;
;-----------------------------------------------------------------------------

;----------------------------------------------------------------------------
;
;                     DETAILS OF TABLES PROVIDED BY SCORE.
;                     ALL WAVEFORM TABLES ARE -1 TO +1
;
; TABLE  1 = 2048 SINE
; TABLE  2 = 16 STEP "CASIO" WAVEFORM A BROAD SPECTRUM
; TABLE  3 = 16 STEP "CASIO" WAVEFORM B SINE LIKE
; TABLE  4 = 16 STEP "CASIO" WAVEFORM C NARROW PULSE
;
; TABLE 50 = 1024 STEP LINEAR FOR RISE OF ENVLPX EG


f1  0 257   10    1  

f2  0 17    2     0     +.5   -0.2  +1.0  +0.2  -0.4  -0.8  -0.3  -1.0  -0.5  0     +0.4  +0.7  +0.4  +0.2  +0.1  0

f3  0 17    2     0     +.2   +.3   +0.8  +1.0  +0.8  +0.5  0.2   0     -0.3  -0.5  -0.8  -1.0  -0.9  -0.7  -0.3  0

f4  0 17    2     0     +1.0  0     0     0     0     0     0     0     -0.3  -0.4  -0.2  -0.1  0     0     0     1   

f50 0 1025  7     0     1024  1



;-----------------------------------------------------------------------------
;
; Instrument 1  Can't get linenr to hold on - tried 0.00001, .01 and .1.
;         Now trying envlpx
;
; An interpolated table waveform instrument.
; Output to one of four gvars ga0 - ga4.
;
; Parm     3   Duration
;     4   Frequency cps
;     5   Volume 
;     6   Table number
;     7   Output channel 0 to 3
;     8   Rise time - linear
;     9   Decay time after note off
;    10   Tremelo period seconds = 1/frequency
;    11   Tremelo depth eg. 0.2 gives .8 to 1.2 volume
;
;-----------------------------------------------------------------------------


;Inst     Start     Dur. p4   p5   p6   p7   p8   p9   p10  p11
;              pitch     vol  table     chan attack    decay     tper tdepth
; Major 7th Chords
;

i1  0  460    64     10     3      0      320    100    1      0    
i1  10 450    80     8      3      0      320    100    1      0    
i1  20 440    96     8      3      0      320    100    1      0    
i1  30 430    120    8      3      0      320    100    1      0    

i1  0  460    256    .8     2      1      40     150    6.66   0.5
i1  10 460    320    .8     2      1      20     150    11.11  0.5  
i1  20 440    384    .7     2      1      10     150    10     0.5 
i1  30 410    480    .6     2      1      15     150    8.33   0.5

i1  20 440    512.3  0.5    2      2      70     60     10     0.9 
i1  40 420    640.3  0.4    2      2      70     50     6.666  0.9  
i1  60 400    768.3  0.5    2      2      70     40     4      0.9  
i1  80 380    960.3  0.3    2      2      70     30     5      0.9  

i1  80 380    2048.15       0.4    4      3      60     15     21     0.3 
i1  80 380    2560   0.3    4      3      60     20     16     0.3  
i1  120       340    3072.23       0.4    4      3      60     27     12     0.3 
i1  120       340    5120.2 0.3    4      3      60     37     0.9    0.2


;-----------------------------------------------------------------------------
;
; Instrument 50 Flanger for inputs ga0-3 output = ga4-7
;
;
; Parm     4   Delay time Max = 0.1 sec
;     5   Mix level 1 = purely delayed
;     6   Feedback ratio > 1 = feedback
;     7   Period of sine LFO cps
;     8   Deviation from delay time eg. 0.2 => 0.8 to 1.2
;     9   Input channel ga0 to ga3
;    10   Output channel ga4 to ga7
;
;
;-----------------------------------------------------------------------------
;Inst     Start     Dur. p4   p5   p6   p7   p8   p9   p10
;              del  mix  feedb     period    dev  in   out

i50 0  460    0.03   0.5    0.7    20     0.4    0      4    
i50 0  460    0.0039 0.4    0.5    22.22  0.3    1      5    
i50 0  460    0.03125       0.3    0.97   35     0.03   2      6    
i50 0  460    0.00097       0.4    -0.9   55.55  0.4    3      7    



;-----------------------------------------------------------------------------
;
; Instrument 90  Provide X, Y and R for head.
;
; parm    3    Duration
;    4    Initial X
;    5    Initial Y
;    6    Initial R 0 to 2pi anticlockwise
;    7    Final     X
;    8    Final     Y
;    9    Final     R
;
;-----------------------------------------------------------------------------

;Inst     Start     Dur. p4   p5   p6   p7   p8   p9   p10  p11
;              iX   iY   iR   fX   fY   fR

i90 0  460    0      -40    0      0      40     0   


;-----------------------------------------------------------------------------
;
; Instrument 95  Get a sound, and map it to the head.
;
; parm    3    Duration
;    4    gax 4 to 7
;    5    not used
;    6    Table number
;    7    not used
;    
;    8    Initial X
;    9    Cyclic    X range
;    10   Cyclic    X time for sine cycle ACW
;    11   Cyclic  X - where to start in cycle 0 - 1
;
;    12   Initial Y
;    13   Cyclic    Y range
;    14   Cyclic    Y time for sine cycle ACW
;    15   Cyclic  Y - where to start in cycle 0 - 1
;
;    16   Initial Z
;    17   Cyclic    Z range
;    18   Cyclic    Z time for sine cycle ACW
;    19   Cyclic  Z - where to start in cycle 0 - 1
;
;
;-----------------------------------------------------------------------------

;Inst     Start     Dur. p4   p5   p6   p7   p8   p9   p10  p11  p12  p13  p14  p15
;              Source    ..   ..   ..   X    Xr   Xct  Xst  Y    Yr   Yct  Yst  Z    Zr   Zct  Zst

i95 0  460    4      0      0      0      7      20     20     0      0      20     20     0      24     0      1 0
i95 0  460    5      0      0      0      -7     10     15.7   0      -10    10     15.7   0      4      0      1 0
i95 0  460    6      0      0      0      -3     15     37     0      7      15     37     0      3      0      1 0
i95 0  460    7      0      0      0      7      10     10     0      20     10     10     0      4      0      1 0


;-----------------------------------------------------------------------------
;
; Instrument 100
;
; Output instrument to mix gal and gar into a stereo mix.
;
; Parm     4   Scale factor for final output.
;
;-----------------------------------------------------------------------------

;Inst     Start     Dur. Scale factor

i100   0      460    740



;-----------------------------------------------------------------------------
;
; Dummy f0 lines to cause it to make reports every second.
; 
;    Put an 'e' on a separate line for the time when the piece ends.


f0  0
f0  1  
f0  2  
f0  3  
f0  4  
f0  5  
f0  6  
f0  7  
f0  8  
f0  9  
f0  10  
f0  11  
f0  12  
f0  13  
f0  14  
f0  15  
f0  16  
f0  17  
f0  18  
f0  19  
f0  20  
f0  21  
f0  22  
f0  23  
f0  24  
f0  25  
f0  26  
f0  27  
f0  28  
f0  29  
f0  30  
f0  31  
f0  32  
f0  33  
f0  34  
f0  35  
f0  36  
f0  37  
f0  38  
f0  39  
f0  40  
f0  41  
f0  42  
f0  43  
f0  44  
f0  45  
f0  46  
f0  47  
f0  48  
f0  49  
f0  50  
f0  51  
f0  52  
f0  53  
f0  54  
f0  55  
f0  56  
f0  57  
f0  58  
f0  59  
f0  60
f0  61  
f0  62  
f0  63  
f0  64  
f0  65  
f0  66  
f0  67  
f0  68  
f0  69  
f0  70  
f0  71  
f0  72  
f0  73  
f0  74  
f0  75  
f0  76  
f0  77  
f0  78  
f0  79  
f0  80  
f0  81  
f0  82  
f0  83  
f0  84  
f0  85  
f0  86  
f0  87  
f0  88  
f0  89  
f0  90  
f0  91  
f0  92  
f0  93  
f0  94  
f0  95  
f0  96  
f0  97  
f0  98  
f0  99  

f0  100
f0  101  
f0  102  
f0  103  
f0  104  
f0  105  
f0  106  
f0  107  
f0  108  
f0  109  
f0  110  
f0  111  
f0  112  
f0  113  
f0  114  
f0  115  
f0  116  
f0  117  
f0  118  
f0  119  
f0  120  
f0  121  
f0  122  
f0  123  
f0  124  
f0  125  
f0  126  
f0  127  
f0  128  
f0  129  
f0  130  
f0  131  
f0  132  
f0  133  
f0  134  
f0  135  
f0  136  
f0  137  
f0  138  
f0  139  
f0  140  
f0  141  
f0  142  
f0  143  
f0  144  
f0  145  
f0  146  
f0  147  
f0  148  
f0  149  
f0  150  
f0  151  
f0  152  
f0  153  
f0  154  
f0  155  
f0  156  
f0  157  
f0  158  
f0  159  
f0  160
f0  161  
f0  162  
f0  163  
f0  164  
f0  165  
f0  166  
f0  167  
f0  168  
f0  169  
f0  170  
f0  171  
f0  172  
f0  173  
f0  174  
f0  175  
f0  176  
f0  177  
f0  178  
f0  179  
f0  180  
f0  181  
f0  182  
f0  183  
f0  184  
f0  185  
f0  186  
f0  187  
f0  188  
f0  189  
f0  190  
f0  191  
f0  192  
f0  193  
f0  194  
f0  195  
f0  196  
f0  197  
f0  198  
f0  199  

f0  200
f0  201  
f0  202  
f0  203  
f0  204  
f0  205  
f0  206  
f0  207  
f0  208  
f0  209  
f0  210  
f0  211  
f0  212  
f0  213  
f0  214  
f0  215  
f0  216  
f0  217  
f0  218  
f0  219  
f0  220  
f0  221  
f0  222  
f0  223  
f0  224  
f0  225  
f0  226  
f0  227  
f0  228  
f0  229  
f0  230  
f0  231  
f0  232  
f0  233  
f0  234  
f0  235  
f0  236  
f0  237  
f0  238  
f0  239  
f0  240  
f0  241  
f0  242  
f0  243  
f0  244  
f0  245  
f0  246  
f0  247  
f0  248  
f0  249  
f0  250  
f0  251  
f0  252  
f0  253  
f0  254  
f0  255  
f0  256  
f0  257  
f0  258  
f0  259  
f0  260
f0  261  
f0  262  
f0  263  
f0  264  
f0  265  
f0  266  
f0  267  
f0  268  
f0  269  
f0  270  
f0  271  
f0  272  
f0  273  
f0  274  
f0  275  
f0  276  
f0  277  
f0  278  
f0  279  
f0  280  
f0  281  
f0  282  
f0  283  
f0  284  
f0  285  
f0  286  
f0  287  
f0  288  
f0  289  
f0  290  
f0  291  
f0  292  
f0  293  
f0  294  
f0  295  
f0  296  
f0  297  
f0  298  
f0  299  

f0  300
f0  301  
f0  302  
f0  303  
f0  304  
f0  305  
f0  306  
f0  307  
f0  308  
f0  309  
f0  310  
f0  311  
f0  312  
f0  313  
f0  314  
f0  315  
f0  316  
f0  317  
f0  318  
f0  319  
f0  320  
f0  321  
f0  322  
f0  323  
f0  324  
f0  325  
f0  326  
f0  327  
f0  328  
f0  329  
f0  330  
f0  331  
f0  332  
f0  333  
f0  334  
f0  335  
f0  336  
f0  337  
f0  338  
f0  339  
f0  340  
f0  341  
f0  342  
f0  343  
f0  344  
f0  345  
f0  346  
f0  347  
f0  348  
f0  349  
f0  350  
f0  351  
f0  352  
f0  353  
f0  354  
f0  355  
f0  356  
f0  357  
f0  358  
f0  359  
f0  360
f0  361  
f0  362  
f0  363  
f0  364  
f0  365  
f0  366  
f0  367  
f0  368  
f0  369  
f0  370  
f0  371  
f0  372  
f0  373  
f0  374  
f0  375  
f0  376  
f0  377  
f0  378  
f0  379  
f0  380  
f0  381  
f0  382  
f0  383  
f0  384  
f0  385  
f0  386  
f0  387  
f0  388  
f0  389  
f0  390  
f0  391  
f0  392  
f0  393  
f0  394  
f0  395  
f0  396  
f0  397  
f0  398  
f0  399  

f0  400
f0  401  
f0  402  
f0  403  
f0  404  
f0  405  
f0  406  
f0  407  
f0  408  
f0  409  
f0  410  
f0  411  
f0  412  
f0  413  
f0  414  
f0  415  
f0  416  
f0  417  
f0  418  
f0  419  
f0  420  
f0  421  
f0  422  
f0  423  
f0  424  
f0  425  
f0  426  
f0  427  
f0  428  
f0  429  
f0  430  
f0  431  
f0  432  
f0  433  
f0  434  
f0  435  
f0  436  
f0  437  
f0  438  
f0  439  
f0  440  
f0  441  
f0  442  
f0  443  
f0  444  
f0  445  
f0  446  
f0  447  
f0  448  
f0  449  
f0  450  
f0  451  
f0  452  
f0  453  
f0  454  
f0  455  
f0  456  
f0  457  
f0  458  
f0  459  
f0  460
e
f0  461  
f0  462  
f0  463  
f0  464  
f0  465  
f0  466  
f0  467  
f0  468  
f0  469  
f0  470  
f0  471  
f0  472  
f0  473  
f0  474  
f0  475  
f0  476  
f0  477  
f0  478  
f0  479  
f0  480  


;*****************************************************************************
;
; BINAURAL MODEL OVERVIEW - Robin Whittle 20 April 1995
;
; Binaural recordings in the physical world involve two microphones on a 
; real or dummy head, to record what a person would hear if they were at that
; spot.  This creates time delays, volume changes, filtering etc, which 
; the human ear and brain uses to determine the locality of sounds.
; When listened to on headphones, the brain can use these cues almost as well
; as it could if the person's head was really there.  This gives a feeling of
; being somewhere, with the music surrounding you.
;
; This Csound code aims to produce satisfying binarual recordings for both
; headphone and speaker playback.  This represents a compromise from a pure
; headphone arrangement, where differing volumes in each channel are not
; as pronounced as are required to get good placement with speakers.
;
; The aim is to make a sensual spacious "recording" system, rather than 
; something which is technically accurate. Although I have gone to quite a lot
; of trouble to give a front/back perspective (which is weak even with a 
; natural head) the aim has been to minimise the computations involved, so as
; not to bog Csound down too much.  I am using a 486DX33, so I a can't afford
; to waste CPU time.
;
; The Space
; ---------
;
; There is an X (left to right, west to east) dimension, a Y (back to front, 
; south to north) dimension and a Z (down to up) dimension. 
;
;              +Y
;
;    
;          -X   O   +X
;
;
;              -Y
;
; Sound sources can be moved around anywhere in these dimensions, and the 
; sound source has no directionality.
;
; The head is always at Z = 0.  Its axis is vertical (pointing to +Z) and 
; it can be rotated on this axis.
;
; In keeping with the geometry I learnt at school, a positive rotation is 
; anti-clockwise (ACW), but the starting point is where the nose is 
; pointing - along the positive Y axis.
;
; Instrument 90 does this, as well as move the head.  The head location and 
; the location of the two ears and the two reference points are all global
; control rate variables.  A more advanced system than Instrument 90 could be 
; devised to move the head.
;
; All dimensions in this space are in msec of sound - approximately a foot or
; 30 cm.  There is a global variable for the maximum delay time in the
; binaral model - be sure that ears and sound sources are not separated by 
; more than this time (in seconds) or the code will attempt to get longer
; delay times (this could crash it). There is no performance penalty (I think)
; in assigning longer delay times, but it chews memory - at 44.1 kHz, with 4
; bytes for each sample, a 0.3 second delay (max 300 feet between sound source
; and ears) takes up 52,920 bytes - so the limitation is how much memory 
; you have to play with before (on the MSDOS version) Csound starts using 
; slower forms of memory - virtual memory via hard-disk.
;
; The basic delay and volume algorithm
; ------------------------------------
;
; Most of the binaural effect comes from delaying the left and right ear 
; signals exactly according to the distance from the source to each ear, and
; by scaling the volume of each signal in proportion to the inverse square
; of the distance.
;
; In this case, I decided to do it to the inverse power 1.5 instead, since
; the space is totally empty, and the power 2 was rather severe in attenuating
; volume as the sound moved away.  If I start to use reflectors in the space,
; I could choose to change this.  Also, for bass sounds, in the physical world
; the sound source has a significant area, so doubling the distance would not 
; lead to a 1/4 level.  Likewise the size of a room encloses the sound - 
; especially for bass frequencies.
;
; If this delay and volume was all we were doing, we would get a striking
; binaural effect, which has no forward or backward cue.  It is relatively 
; easy to code, and gives most of the effect.
;
; Ear directionality - volume and frequency response
; --------------------------------------------------
;
; To simulate the fact that the outer ear picks up high frequency sounds
; better when they are coming straight into it, I do several things.
;
; Firstly I control the volume of the sound according to direction - where
; the axis of the right ear is assumed to be 40 degrees forward of the left-
; right line which passes through both ears. In fact I expect that any such
; axis would be less than 40 degrees, but I have made it more to accentuate
; front/back perceptions.
;
; If the sound comes from within a 50 degree range of this 40 degree axis, 
; then volume is normal.  Outside this it falls off, leading to a 
; minimum when the sound is coming from the opposite end of the 40 degree axis,
; from the left and behind, in the case of the right ear.
;
; Note that at no stage do I calculate angles - there is no arc-tan function
; to do this (although a table could be used).  The calculations are based
; on the differences in distances times from the source to the ear and to a 
; rear reference point, at the centre of the head and 40 degrees behind the 
; ear.
;
; We need a top view diagram! 
; (This may be elongated on your screen. Blind people search for END to get
; past the diagram.)
;
; O is the centre of the head, about which it rotates on a vertical axis.
;
;            Nose                            
;                  .                          
;                 . .                                 S1
;              ...   ...                                        
;           ...         ...                     
;          .               .                    
;         .  front ref pt.  .                            
;         .                 .                 
;        .         F         .                 
;        .                   .                
;        .                   .               
; left   .                   .                
; ear    l                   r                
;        L         O         R                 
;        l                   r                 
;      ll.                   .rr                
;        .                   .                
;         .                 .                  
;         .        B        .                   
;          .               .                    
;           ..   back    ..                       
;             ..       ..
;               .......                               
;
;
; S2
;
; END
;
; The distance between the ears is assumed to be 6 inches - 0.5 msec.
;
; The axis for volume and filtering is level and at 0 Z elevation.
; For the right ear it extends through the B point and the R ear location.
;
; S1 and S2 depict sources which are directly on this axis.  A source at 
; Z = 0, directly in front of the nose (and a long way away) would be at
; 50 degrees from this axis, and so would come through at normal volume.
; If it was a little to the left, it would be more than 50 degrees and the 
; volume would be attenuated.  If it was at the S2 location, its volume 
; would be attenuated the most.
;
; Sound sources can have + or - Z elevations.  This 50 degree limit resembles
; a cone around the axis, so if S1 was 50 degrees above the ear, then it 
; would be on the verge of having its right ear level attenuated.
; 
; The details of how I change the volume can be seen in the code.  All of these
; could be fine-tuned more than I have done so far.
;
; The second factor is a greatly increased attenuation for the highest 
; frequencies when the source approaches the S2 position, because short
; wavelength sounds do not diffract well around the head.
;
; There is a mechanism for making this occur within around 80 degrees of the
; S2 end of the axis, with the effect getting much stronger as the source
; approaches the axis.
;
; There is also a mechanism for reducing the cutoff frequency of these filters
; as the source approaches the S2 position.  These mechanisms are partly 
; based on rough guesses and on a few trials to see what was too extreme.
;
; I am aiming for a slightly stronger effect than normal, partly to counter
; the fact that the natural cues are relatively weak, and that it is supposed
; to give some feeling of "going behind the head" (getting quieter and less
; crisp) even on speakers.
;
; Ear directionality - extra delay
; --------------------------------
;
; I have defined a second axis for each ear, sweeping 40 degrees _backwards_ 
; from the left-right line through the ears.  This is for adding a little 
; extra delay when the sound is coming from almost exactly the opposite side
; of the head.  This is because the sound has to wrap around the head.
; 
; The ears on _my_ head are located somewhat behind the physical centre on the 
; head, so the maximum delay would occur (for my right ear) when the source
; was about 25 to 30 degres forward of the left-right axis.  Again I have
; chosen 40 degrees for the mathematical model of the recording head to 
; accentuate the forward/backwards cues.
;
; The extra delay only gets added as the source approaches the extreme of
; where the ear is on the head.  Once again, this forms a conical area, in
; this case it extends to 63 degrees from the axis.  (This may be too far, 
; but the extra delay at this point is very small.)
;
; See the code for how I do this.  Again it is guesswork based on what seemed
; to be physically correct and not too extreme, although this .25 msec 
; delay is greater than the 0.14 theoretical delay of the extra distance 
; a sound must take to get round the back curvature of the head.
;
;
; What is the vertical axis for?
; ------------------------------
;
; There are no specific up/down cues in this model.  The cues in a natural 
; head would not be strong anyway, and I expect they could be inordinately 
; complex to compute (maybe in a decade when I have heaps of CPUs I will do 
; it).
;
; However the Z dimension has a very important function.  There is a big; difference between a sound source going round in a 10 ft radius circle
; going as close as 1 ft from your right ear (eg the circle is in the X and Y
; dimensions and is entirely at Z = 0), and the same circle being 10 ft 
; above your head.
;
; One thing I did to demo this was to have a 30 ft radius circle, with the
; centre at X = -7, Y = +30, and have a buzz sound going round every 8 seconds.
;
; I made a Z cycle as well, with a centre at 50 ft and a very slow cycle 
; bringing it down slowly to Z = 0.  The sound started remotely, with little
; volume change or doppler, but after a while it got more intense and 
; whizzed straight past your ear and nose.  Very dramatic!
;
; What next?
; ----------
;
; I am reasonably happy with the model and want to make some music with it
; rather than fuss over its finer points.  I really like what I have 
; acheived with "Spare Luxury One" (or SL_ONE.ORC and SL_ONE.SCO).
;
; I would really like to make it faster! I expect that some of this could
; be written into internal Csound functions. I haven't attempted compiling
; Csound yet, but it would be worth it to speed up some of this stuff.
;
; The cues could all be refined.  Somewhere I have some info on measurements
; of dummy head recordings, which would help me refine it.
;
; It would be possible to make the head move in the Z plane as well, and to 
; give it tilt etc. - but I am happy to use it as it is.
;
; After getting a bigger hard disk, I will make my output files use floating
; point so I don't have to worry about a scaling factor for the 16 bit output.
; After the Csound run, I will use another program (I will write it in C) to
; read the floating point file, find the largest peaks, and write a second
; .WAV file based on it with appropriate scaling.  I am hanging out for a
; faster CPU too!. SL_ONE takes 11 hours for nearly 8 minutes of music.
;
; Then I may investigate adding reflectors - sources which receive all the 
; other sources (with delay and volume drops based on distance) and "re-trans-
; mit" the sum to the head and all other reflectors.  This would be a monster
; to compute, but there would be no tricky directionality stuff.
; I would probably add some simple reverb into each reflector to make the most
; fun with just four or six reflectors.
;
; Then the fun begins!  Reflectors, sources and the head all moving according
; to various algorithms - including cellular automata.
;
; Lets have a flock of singing sources programmed to fly around the head and
; a head programmed to avoid them as much as possible.  The sounds could 
; rise in stridency as the target was approached.
;
; Or a more sensual experience from a squadron of the aural equivalents of 
; cuttlefish, floating at respectful distance, each doing their own thing as
; part of their society.  [Totally off the topic but ... cuttlefish are a 
; form of squid, with big eyes and tentacles pointing forward.  They 
; communicate with ripples of colour on their bodies.  I have heard that 
; a male could be swimming between a female on the left and a male on the 
; right, and the right side of the central male is quite stable, while the
; left is rippling with colours!]
;
; Sound sources from previously recorded analogue synthesisers - especially
; my Devil Fish modified TB-303 Bassline - jumping around the space according
; to their volume or other aspects of the sound.
;
; Cellular automata of Csound processes which change their locations, listen to
; the sounds they hear there, make their own sounds, and generally do their 
; thing - resulting in unexpected group behaviours.
;
; Reverb with moving reflectors - all the walls of a small room expand to 
; resemble a hall . . . reverb with doppler!
;
; Instead of point reflectors, creat a "wall" concept, where the ear (and other
; reflectors on one side of the wall also get reflected sound from sources
; which are on this side of the wall, but are made to appear is if they were 
; in a mirror image - on the other side of the wall.  This may not be too 
; tricky.  Then maybe have the walls move around.
;
;
; There are questions of aesthetics here.  Am I trying to make a slavish 
; replication of the physical world?  No - too much hard work, and I am 
; attracted by a relatively pure model.  Interest will come from the 
; interactions of sounds and processes, not from the stunning nature of the
; binaural effects.
;
; Will I use it to make "hyper real" sonic experiences, as if they were real?
; Maybe - but just for fun.
;
; Will I pretend to be doing something in the real world? No.
;
; Whatever the outcome, the easy use of _super_dramatic_ binaural sound 
; experiences could easily be over-done. It is awfully easy to use this
; system just for special effects.  That would be fun for a while, but 
; ultimately it is a yawn.  That is "see how big my tool is" rather than
; "lets see what fiendish and playful things we can do with it". 
;
; In music, as in other sensual aspects of life, my interest is primarily in
; caressing and teasing the listener - but as a Scorpio, I reserve the right 
; to sting when the time is right.
; 
; This Spare Luxury One piece has a few moments of piquancy.  If you want
; to experiment with the wilder side of the binaual model, bring in your own 
; sounds, and have them whizzing right past your face at a hundred feet/sec!
