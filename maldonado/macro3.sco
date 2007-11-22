F1      0       128     10      1       ; score function
f1  0 512   10    1     .3    .4    .2    .1    .05   0     0     .05   0     0     0     .05   0     0     0     .08 

#define RndSeed(seed) # (1 R ($seed)) #
#define Rand(min'max) # ( ($min) + ((($max)-($min)) R 0)  ) #
#define Table(tabnum'index) # (($tabnum) T ($index)) #

#define Up1(steps'var) # ((($var)-1)/(($steps)-1)) #
#define Down1(steps'var) #((($steps)-($var))/(($steps)-1))#

#define   Up(steps'var) #( ($var)/(($steps)-1) )  #
#define Down(steps'var) #((($steps)-($var)-1) / (($steps)-1))#


#define Expon1(steps'var'a'b) # ( ($a) *(((($b)/($a))^(1/(($steps)-1)))^($var-1)) ) #
#define  Line1(steps'var'a'b) # ( ($a) +  (($b)-($a))*(($var-1))/(($steps)-1)  ) #

#define Expon(steps' var' a' b) # ( ($a) *(((($b)/($a))^(1/(($steps)-1)))^($var))  ) #
#define  Line(steps' var' a' b) # ( ($a) +  (($b)-($a))*(($var))/(($steps)-1)  ) #



#define SPEZZONE(A' B' C' D) #
i1  [$A]      [1*$B] [5000*$C]     [440*$D]
i1  [$A+(1*$B)]      [2*$B] [5000*$C]     [880*$D]
i1  [$A+(.5*$B)]     [1*$B] [5000*$C]     [1000*$D]
i1  [$A+(2*$B)]      [2*$B] [5000*$C]     [220*$D]

#

#define J(K) #
$SPEZZONE(1' [$K]' 1000' 500)
#

#define DSPEZZ(E' F' G' H) #
$SPEZZONE($E'$F'$G'$H)
$SPEZZONE([$E+4]'[$F*.8]'[$G*.8]'$H)
$SPEZZONE([$E+4+4*.8]'[$F*.6]'[$G*.65]'[$H/2])
$SPEZZONE([$E+4+4*.8+4*.6]'[$F*.4]'[$G*.5]'$H)
$SPEZZONE([$E+4+4*.8+4*.6+4*.4]'[$F*.3]'[$G*.4]'[$H*2])
$SPEZZONE([$E+4+4*.8+4*.6+4*.4+4*.3]'[$F*.2]'[$G*.4]'[$H*4])
$SPEZZONE([$E+4+4*.8+4*.6+4*.4+4*.3+4*.2]'[$F*.1]'[$G*.4]'$H)
$SPEZZONE([$E+4+4*.8+4*.6+4*.4+4*.3+4*.2+4*.1]'[$F*.08]'[$G*.4]'$H)
#

/*
#define DSPEZZ2(A' B' C' D) #
$SPEZZONE($A'$B'$C'$D)
$SPEZZONE([$A+4]'[$B*.8]'[$C*.8]'$D)
$SPEZZONE([$A+4+4*.8]'[$B*.6]'[$C*.65]'[$D/2])
$SPEZZONE([$A+4+4*.8+4*.6]'[$B*.4]'[$C*.5]'$D)
$SPEZZONE([$A+4+4*.8+4*.6+4*.4]'[$B*.3]'[$C*.4]'[$D*2])
$SPEZZONE([$A+4+4*.8+4*.6+4*.4+4*.3]'[$B*.2]'[$C*.4]'[$D*4])
$SPEZZONE([$A+4+4*.8+4*.6+4*.4+4*.3+4*.2]'[$B*.1]'[$C*.4]'$D)
$SPEZZONE([$A+4+4*.8+4*.6+4*.4+4*.3+4*.2+4*.1]'[$B*.08]'[$C*.4]'$D)
#
*/


;$DSPEZZ(0' 1' 1' 1)

/*
{ 10 nn
i1  0  .1
}
*/



{ 10 nn
i1  [$nn/2]   .5     [$Line(10'    $nn    '      10000' 4000)] [$Line(10'$nn'440'110)]
{ 5 bb
i1  [$nn/2+$bb/10]   .1     [(1+$nn/4)*$Line(10  '      $bb'   2000'  500)]  [$Line(10'    $bb'   400'   600)]
}
}


/*
{ 10 nn
i1  [$nn/2]   .5     [$Line(10'    $nn    '      10000' 4000)] [$Line(10'$nn'440'110)]
{ 5 bb
i1  [$nn/2+$bb/10]   .1     [(1+$nn/4)*$Line(10  '      $bb'   2000'  500)]  [$Line(10'    $bb'   400'   600)]
}
}

*/

s
;**** exponenential ramp (new symbol)
i1  0  .1     10000  440
i.  +  .      (      (    
i.  +  .      (      (    
i.  +  .      (      (    
i.  +  .      (      (    
i.  +  .      (      (    
i.  +  .      (      (    
i.  +  .      (      (    
i.  +  .      1000   1600

s


{ 11 nn
i1  [$nn/11+1]       .2     [$Expon(11'$nn'400'15000)]  [$Expon(11'$nn'880'55       )]    
}

{ 10 nn
i1  [$nn/10+2]       .1     [$Line(10'$nn'20000'400)]   [$Line(10'$nn'55'440 )]
}

{ 10 nn
i1  [$nn/10+3]       .05    [$Expon(10'$nn'25000'800)]  [$Expon(10'$nn'55'1760)]
}

{ 32 NN
i1  [$Expon(32'$NN'.4'2.4)-.4      ]      .05    5000   [100   *      $Expon(32'$NN'1'16)]
}

{ 32 NN
i1  [$Expon(32'$NN'.4'4.4)  +2.135 -.4]   .01    10000  [100   *      $Expon(32'$NN'16'1)]
}

v 1
b       0     
i1  0  2.2    3000   110
i1  +  2.2    2000   220
i1  +  2.2    1000   440

s
#define la(speed) # 
i1  0  [$speed]      3000   110
i1  +  .      2000   220
i1  +  .      1000   440
#
$la(1)
s
$la(.5)
s
r       4       NN    
$la([.25/$NN])

r       120     NN  
$la([$Expon(120'$NN'.05'.001)] )
s

;*** ascending random MASK
{ 96 NN
i1  [$Expon(96'$NN'.2'9)]   .08    5000   [100   *(2^   $Rand(0'1))   *      $Expon(96'$NN'1'16)] 
}

s


b       8     
;*** 15 cycles of sinusoid driving frequency
;*** the amount of frequency deviation increases of 3 octaves
{ 64 NN
v  [$Expon(64'$NN'.5'1.5)]
i1  [($NN-1)*.08]    .08    5000   [200   *(2^($Table(1 '      $NN    *      15)*(3 *      $Up(64'$NN))))] 
}

s
b       10    
;*** 9 cycles of sinusoid driving frequency
;*** the amount of frequency deviation decreases of 4 octaves
{ 64 NN		
v [$Expon(64'$NN'1.5'.5)]
i1  [($NN-1)*.09]    .09    5000   [200   *(2^($Table(1 '      $NN*9)*(4*$Down(64'$NN))))] 
}


s
$SPEZZONE(0 ' .5' .1' 1)  ;*** three out-of-phase phrases
$SPEZZONE(1 ' .5' .1' 1)
$SPEZZONE(2 ' .5' .1' 1)
v 1.1
b0
$SPEZZONE(0' .5' .2 ' 1)
$SPEZZONE(1' .5' .25' 1)
$SPEZZONE(2' .5' .3 ' 1)
v 1.05
b0
$SPEZZONE(0' .5' .3 ' 1)
$SPEZZONE(1' .5' .35' 1)
$SPEZZONE(2' .5' .4 ' 1)
s


{ 8 NN
v [$Expon(8'$NN'.2'1)]
$SPEZZONE([0+$NN*.3]' .3  ' [.5*(2^(2*($NN-1)/7)) ] ' .5)
}

{ 30 NN
v [$Expon(30'$NN'2'.2)]
;v [3^$Down($NN ' 30)] ;****** exponential increasing of speed
$SPEZZONE([8+$NN*.25]'  .25 ' [.1 * (2^(4*(30-$NN)/30))]   ' 1.5)
}
{ 15 NN
v [$Expon(15'$NN'.2'.8)]
$SPEZZONE([16+$NN*.4]'  .25 ' .8   ' 2)
}


s
v 1
b       0     
$SPEZZONE(0' .2'  2   ' 1)

b       1     
$SPEZZONE(0' .1' .3   '1.5)

b       1.5   
$SPEZZONE(0' .1' 1   ' 2)

b       2     
$SPEZZONE(0' .1' .5  ' 2.5)
e ;******* END **********



