#!/usr/bin/perl
require "/Users/eric/PERL/libperl.pl";

$frames = $ARGV[0];
$dur = $ARGV[1];
$bins = $ARGV[2] * 2;

$score = "bather.s";

open( SCORE , ">$score");
print SCORE 
"f1 0 4096 10 1 0 .3 0 .5 0 .1 0 .05
f2 0 4096 10 1 .3 0 .5 0 .1 0 .05
f3 0 4096 10 1
f4 0 16384 13 1 1 .1 .2 .4 .3 .01 .03 .05\n" ;
$foffset = 5 ;
$size = 2;
while( $size < $frames ){
  $size *= 2;
}
for($i = $foffset; $i< $bins + $foffset ; $i++ ){
  printf SCORE "f%d 0 %d -1 %d 0\n", $i, $size, $i - $foffset + 1 ;
}

for($i = 0; $i< $bins; $i+= 2 ){
  $speed = &randy(.25, 2.);
  printf SCORE "i1 0 %.3f %d %d %d %.6f\n", $dur, $i+$foffset,$i+$foffset+1, $frames, $speed;
}