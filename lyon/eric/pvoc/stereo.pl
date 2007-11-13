#!/usr/bin/perl
#require "/Users/eric/PERL/libperl.pl";

if( $#ARGV < 2 ){
   die "nframes dur nbins\n";
}
srand;
$frames = $ARGV[0];
$dur = $ARGV[1];
$bins = $ARGV[2] * 2;

$score = "stereo.s";

open( SCORE , ">$score");
print SCORE "f1 0 2048 10 1 .5 .3 .1 .05 .025 .05.1 .5\n";
$size = 2;
while( $size < $frames ){
  $size *= 2;
}
for($i = 2; $i< $bins + 2; $i++ ){
  printf SCORE "f%d 0 %d -1 %d 0 6 1\n", $i, $size, $i - 1 ;
}

for($i = 0; $i< $bins; $i+= 2 ){
  $val = &randy(0,1);
  if( $val > .666 ){
     $pan = &randy(0,.333);
  } elsif( $val > .333 ) {
     $pan = &randy(.666, 1);
  } else {
     $pan = &randy(.333,.666);
  }
  printf SCORE "i1 0 %.3f %d %d %d %.3f\n", $dur, $i+2, $i + 3, $frames, $pan;
}
