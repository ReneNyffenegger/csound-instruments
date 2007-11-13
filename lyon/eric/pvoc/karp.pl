#!/usr/bin/perl
require "/Users/eric/PERL/libperl.pl";

$frames = $ARGV[0];
$dur = $ARGV[1];
$bins = $ARGV[2] * 2;

$score = "karp"."$SCO";
$dfac = .01 ;
open( SCORE , ">$score");
print SCORE "f1 0 8192 10 1\n";
$size = 2;
while( $size < $frames ){
  $size *= 2;
}
for($i = 2; $i< $bins + 2; $i++ ){
  printf SCORE "f%d 0 %d -1 %d 0\n", $i, $size, $i - 1 ;
}

for($i = 0; $i< $bins; $i+= 2 ){
  $s1 = &randy(0,1);
  $s2 = &randy(0,1);
  $s3 = &randy(0,1);
  printf SCORE "i1 0 %.3f 0 0 $dfac %.4f %.4f %.4f %d %d %d\n", $dur, $s1, $s2, $s3, $i+2, $i + 3, $frames;
}