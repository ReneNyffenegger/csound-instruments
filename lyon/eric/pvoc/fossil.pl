#!/usr/bin/perl
require "/Users/eric/PERL/libperl.pl";

$frames = $ARGV[0];
$dur = $ARGV[1];
$bins = $ARGV[2] * 2;

$score = "fossil.s";

open( SCORE , ">$score");
print SCORE "f1 0 2049 10 1\n";
$size = 2;
while( $size < $frames ){
  $size *= 2;
}
for($i = 2; $i< $bins + 2; $i++ ){
  printf SCORE "f%d 0 %d -1 %d 0\n", $i, $size, $i - 1 ;
}

for($i = 0; $i< $bins; $i+= 2 ){
  printf SCORE "i1 0 %.3f %d %d %d\n", $dur, $i+2, $i + 3, $frames;
}