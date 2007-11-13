#!/usr/local/bin/perl
require "/Users/eric/PERL/libperl.pl";
require "eppler.pl";
srand;

$piecedur = 25. ;


$now = 0;
$clustdur = 6.;
$minf = 100;
$maxf = 800;
while( $now < $piecedur ){
	$nc = int &randy(6,13);
	&clust( $minf, $maxf, $nc, $now, $clustdur );
	$minf *= 2;
	$maxf *= 2.5;
	$now += $clustdur * 1.3 ;
	$clustdur *= .8;
}

$now = &randy(0,5);
@gcyc = (2,4);
while( $now < $piecedur ){
	$rval = rand;
	$minf = &randy(500,2000);
	if( $rval < .5 ){
		$maxf = $minf * 1.25;
	} else {
		$maxf = $minf * 2.;
	}
	$nc = int &randy(6,13);
	$gdur = $gcyc[$cnt];
	$cnt = (++$cnt) % 2;
	&gliss( $minf, $maxf, $nc, $now, $gdur );
	$now += $gdur * 1.7;
}

$now = 0;
@meldurs = (1,5,2,4);
$lof = 100;
$hif = 3000;
$fdif = $hif-$lof;
while( $now < $piecedur ){
	$mdur = $meldurs[int rand(@meldurs)];
	$lines = int &randy(2,4);
	$div = $fdif/$lines;
	$minf = $lof;
	$maxf = $lof + $div;
	$tempo = 64;
	for($j = 0; $j < $lines; $j++ ){
		$diss = &randy(.1,.9);
		&melos( $now, $dur,$minf, $maxf,$tempo, $diss, 1./$lines );
		$minf += $div;
		$maxf = $minf + $div;
	}
	$now += $gdur * 1.7;
}
