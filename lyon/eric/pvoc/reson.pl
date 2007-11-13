#!/usr/bin/perl
require "/Users/eric/PERL/libperl.pl";

if( $#ARGV < 2 ){
  die "frames dur bins\n";
}
$frames = $ARGV[0];
$dur = $ARGV[1];
$bins = $ARGV[2] * 2;

$score = "reson.s";

open( SCORE , ">$score");
# print SCORE "f1 0 2048 10 1\n";
$size = 2;
while( $size < $frames ){
  $size *= 2;
}
for($i = 2; $i< $bins + 2; $i++ ){
  printf SCORE "f%d 0 %d -1 %d 0\n", $i, $size, $i - 1 ;
}

for($i = 0; $i< $bins; $i+= 2 ){
  $seed = &randy(0.,1.);
  printf SCORE "i1 0 %.3f %d %d %d %.6f\n", $dur, $i+2, $i + 3, $frames, $seed;
}
