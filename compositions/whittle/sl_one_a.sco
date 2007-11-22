;                        Original file date 17 September 1995
;                        Bug fixed 11 February 1996 for 
;                        distribution to Csounders.
;                        Guardpoint for f4 set to 0.
;
; SL_ONE_A.SCO Same as SL_ONE except that it uses the zak system.
; 
; 17 September 95
;
; Spare Luxury One - Robin Whittle
; 
; See doco at the end of this file which together with SL_ONE.ORC 
; provides an explanation of my binaural model.
;
; Blind people - search for BINARUAL MODEL OVERVIEW.
;
;
; Originally Spare Luxury 19 20 April 1995.
;
; Score modified to make it shorter 7 min 40 sec = 460 sec. It was 8 minutes.
; I had encounted anomalous volume drops at 7 minutes 43.67 seconds, and 
; I could not figure out why.
;
;-----------------------------------------------------------------------------

;----------------------------------------------------------------------------
;
;                     Details of tables provided by score.
;                     All waveform tables are -1 to +1
;
; Table  1 = 2048 sine
; Table  2 = 16 step "Casio" waveform A Broad spectrum
; Table  3 = 16 step "Casio" waveform B Sine like
; Table  4 = 16 step "Casio" waveform C Narrow pulse
;
; Table 50 = 1024 step linear for rise of envlpx EG


f1  0 257   10    1  

;          0    1    2    3    4    5    6    7    8    9    10   11   12   13   14   15   gp  
;          |    |    |    |    |    |    |    |    |    |    |    |    |    |    |    |    |


f2  0 17    2     0     +.5   -0.2  +1.0  +0.2  -0.4  -0.8  -0.3  -1.0  -0.5  0     +0.4  +0.7  +0.4  +0.2  +0.1  0

f3  0 17    2     0     +.2   +.3   +0.8  +1.0  +0.8  +0.5  0.2   0     -0.3  -0.5  -0.8  -1.0  -0.9  -0.7  -0.3  0

f4  0 17    2     0     +1.0  0     0     0     0     0     0     0     -0.3  -0.4  -0.2  -0.1  0     0     0     0   


f50 0 1025  7     0     1024  1



;----------------------------------------------------------------------------
;
; Instrument 5 and 200 Direct write to zk destination, with linear ramping. 
;
; Parm     4   Output zk variable
;     5   Output mode 0 = write, !0 = mix     
;     6   Value to write at start
;     7   Value to write at end
;
;-----------------------------------------------------------------------------
;
;Inst     Start     Dur. p4   p5   p6   p7   
;              Output__mix    Start     End
;              zk        
; Set up volumes for the
; four binaural mixers.

i05 0  1      103    0      1      1    
i05 0  1      113    0      1      1    
i05 0  1      123    0      1      1    
i05 0  1      133    0      1      1    


;-----------------------------------------------------------------------------
;
; Instrument 10 Sound with linear attack, exponential decay and tremelo
;
; An interpolated table waveform instrument.
; Ouput to a za variable.
;
; Parm     3   Duration
;     4   Output za number
;     5   Output mode 0 = write, !0 = mix
;     6   Frequency Hz
;     7   ^zk mod   
;     8   Volume
;     9   ^zk mod 
;    10   Table number
;    11   Rise time - linear
;    12   Decay time after note off
;    13   Tremelo period seconds = 1/frequency
;    14   Tremelo depth eg. 0.2 gives .8 to 1.2 volume
;
;    zk mod   0 means no change 
;         +N means add value from zk variable N
;         -N means multiply by value from zk variable N
;
;-----------------------------------------------------------------------------
;
;Inst     Start     Dur. p4   p5   p6   p7   p8   p9   p10  p11  p12  p13  p14
;              Output__mix    Freq____mod    Volume__mod    Table     trise     tdecay    trperiod trdepth
;              za        Hz   zk        p9


i10 0  460    0      0      64     0      10     0      3      320    100    1      0    
i10 10 450    0      1      80     0      8      0      3      320    100    1      0    
i10 20 440    0      1      96     0      8      0      3      320    100    1      0    
i10 30 430    0      1      120    0      8      0      3      320    100    1      0    

i10 0  460    1      0      256    0      .8     0      2      40     150    6.66   0.5
i10 10 460    1      1      320    0      .8     0      2      20     150    11.11  0.5  
i10 20 440    1      1      384    0      .7     0      2      10     150    10     0.5 
i10 30 410    1      1      480    0      .6     0      2      15     150    8.33   0.5

i10 20 440    2      0      512.3  0      0.5    0      2      70     60     10     0.9 
i10 40 420    2      1      640.3  0      0.4    0      2      70     50     6.666  0.9  
i10 60 400    2      1      768.3  0      0.5    0      2      70     40     4      0.9  
i10 80 380    2      1      960.3  0      0.3    0      2      70     30     5      0.9  

i10 80 380    3      0      2048.15       0      0.4    0      4      60     15     21     0.3 
i10 80 380    3      1      2560   0      0.3    0      4      60     20     16     0.3  
i10 120       340    3      1      3072.23       0      0.4    0      4      60     27     12     0.3 
i10 120       340    3      1      5120.2 0      0.3    0      4      60     37     0.9    0.2


;-----------------------------------------------------------------------------
;
; Instrument 401 & 20 Self contained flanger with za input and output
;
; Parm     4   Output za variable
;     5   Output mode 0 = write, !0 = mix
;     6   Input za variable
;     7   ^ Gain
;     8   Delay time Max = 0.1 sec
;     9   Mix level 1 = purely delayed
;    10   Feedback ratio > 1 = feedback
;    11   Period of sine LFO 
;    12   Deviation from delay time eg. 0.2 => 0.8 to 1.2
;
;-----------------------------------------------------------------------------
;
;Inst     Start     Dur. p4   p5   p6   p7   p8   p9   p10  p11  p12
;              Output__mix    Input___gain   Delay     Del mix   Feed-     LFO  Range
;              za        za             level     back Period


i20 0  460    4      0      0      1      0.03   0.5    0.7    20     0.4  
i20 0  460    5      0      1      1      0.0039 0.4    0.5    22.22  0.3  
i20 0  460    6      0      2      1      0.03125       0.3    0.97   35     0.03 
i20 0  460    7      0      3      1      0.00097       0.4    -0.9   55.55  0.4  


;-----------------------------------------------------------------------------
;
; Instrument 100 Provide X, Y and R for head.
;          Drive output to zk0 to zk2, with a mix option.
;
; parm    3    Duration
;    4    Initial X
;    5    Initial Y
;    6    Initial R 0 to 1 anticlockwise
;    7    Final     X
;    8    Final     Y
;    9    Final     R
;    10   Mix or write (0) to zk locations.
;
;-----------------------------------------------------------------------------

;Inst     Start     Dur. p4   p5   p6   p7   p8   p9   p10  
;              Initial__________   Final____________   Mix/write
;              X    Y    R    X    Y    R    
;

i100   0      460    0      -40    0      0      40     0      0    
;i100     0    460  0    0    0    0    40   0    0


;-----------------------------------------------------------------------------
;
; Instrument 110 Convert the X, Y and R head location values in zk0 to zk2 into 
;          global variables for the ears and reference points.
;
; parm    3    Duration
;
;-----------------------------------------------------------------------------

;Inst     Start     Dur. 
;    

i110   0      460  



;-----------------------------------------------------------------------------
;
; Instrument 120 Binaural mix system part 1 - locate the source
;
;         There could be many ways of moving the location.  This one
;         works with sine/cosine waves in x, y and z locations.
;
;         The output of this can write to the destination set of zk
;         variables, or it can mix to them.
;
; parm    3    Duration
;    4    Destination zk set
;    5    ^ mix or write (0) to zk lcoations.
;    6    zk source for modulation of cyclic range     } 0 = no change
;    7    zk source for modulation of cyclic frequency } !=0 = zk source
;                                       } for multiplicative
;                                       } moduluation                           
;    
;    8    Initial X
;    9    Final     X
;    10   Cyclic    X range
;    11   Cyclic    X time for cosine cycle ACW starting at East
;    12   Cyclic  X - where to start in cycle 0 - 1
;
;    13   Initial Y
;    14   Final     Y
;    15   Cyclic    Y range
;    16   Cyclic    Y time for sine cycle ACW starting at East
;    17   Cyclic  Y - where to start in cycle 0 - 1
;
;    18   Initial Z
;    19   Final   Z
;    20   Cyclic    Z range
;    21   Cyclic    Z time for sine cycle going up from centre point
;    22   Cyclic  Z - where to start in cycle 0 - 1
;
;-----------------------------------------------------------------------------

;Inst     Start     Dur. p4   p5   p6   p7   p8   p9   p10  p11  p12  p13  p14  p15  p16  p17  p18  p19  p20  p21  p22
;              Destination    Range     Freq X                        Y                        Z
;              three zks mod  mod  X Init    Final          Cycle     Cycle     Y Init    Final          Cycle     Cycle     Z Init    Final          Cycle     Cycle
;              zk______Mix/wr zk   zk   X pos     pos  Range     time phase     Y pos     pos  Range     time phase     Z pos     pos  Range     time phase

i120   0      460    100    0      0      0      7      7      20     20     0      0      0      20     20     0 24 24 0 1 0
i120   0      460    110    0      0      0      -7     -7     10     15.7   0      -10    -10    10     15.7   0 4 4 0 1 0
i120   0      460    120    0      0      0      -3     -3     15     37     0      7      7      15     37     0 3 3 0 1 0
i120   0      460    130    0      0      0      7      7      10     10     0      20     20     10     10     0 4 4 0 1 0



;-----------------------------------------------------------------------------
;
; Instrument 130 Binaural mix system  part 2
;
; parm    3    Duration
;    4    za audio input source 
;    5    zk start of four zk variables for x, y, z and volume.
;
;-----------------------------------------------------------------------------

;Inst     Start     Dur. p4   p5   
;              Source    Control
;              za   zk

i130   0      460    4      100  
i130   0      460    5      110  
i130   0      460    6      120  
i130   0      460    7      130  


;-----------------------------------------------------------------------------
; Instrument 131  Debugging replacement for Binaural mix system, 
;          mixes directly to left and right ears - no binaural stuff - 
;          to speed up debugging of sound sources.
;
; parm    3    Duration
;    4    Source - 4, 5, 6 or 7 for ga4 - ga7
;-----------------------------------------------------------------------------
;Inst     Start     Dur. p4   
;              Source    
;              za        

;i131     0    460  4    
;i131     0    460  5    
;i131     0    460  6    
;i131     0    460  7    


;-----------------------------------------------------------------------------
;
; Instrument 810    Print a za value, preceded by a certain number of
;              spaces at a certain time interval
;
; Parm     4   za variable
;     5   Number of spaces before printing number
;     6   Time interval in seconds for each print
;
;-----------------------------------------------------------------------------
;
;Inst     Start     Dur. p4   p5   p6   
;              Source    Spaces    Time
;              za        


;i810     0    20   0    0    0.1
;i810     0    20   4    10   0.1


;-----------------------------------------------------------------------------
;
; Instrument 812    Print a zk value, preceded by a certain number of
;              spaces at a certain time interval
;
; Parm     4   zk variable
;     5   Number of spaces before printing number
;     6   Time interval in seconds for each print
;
;-----------------------------------------------------------------------------
;
;Inst     Start     Dur. p4   p5   p6   
;              Source    Spaces    Time
;              zk        


;-----------------------------------------------------------------------------
;
; Instrument 900
;
; Output instrument to mix gal and gar into a stereo mix.
;
; Parm     4   Scale factor
;
;-----------------------------------------------------------------------------
;
;Inst     Start     Dur. p4   
;              Scale

i900   0      460    740




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

