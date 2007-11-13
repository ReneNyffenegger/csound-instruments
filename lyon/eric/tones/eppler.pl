#!/usr/local/bin/perl
require "/Users/eric/PERL/libperl.pl";
srand;
$st = 0;
$dur = 4;
&header();
#&clust( 400, 800, 8, $st, $dur );
#&clust( 100, 2000, 12, $st, $dur );
#&gliss( 700, 2000, 7, $st, $dur );
#&clust( 500,3000, 11, 4, 8 );
#&gliss( 100, 200, 9, 5, 6 );
#&melos( 0, 7, 100, 500, 80, .2 );
#&melos( 0, 7, 300, 900, 80, .5 );
#&melos( 0, 7, 500, 2500, 80, .9 );

sub melos {
	# disjunct : 0 - 1
	local( $st, $dur, $minf, $maxf, $tempo, $disjunct, $scale ) = @_;
	local($now,$notedur,$noteamp,$tremsp,$pan,$mindur,$olap);
	$mindur = .22;
	$olap = .03;
	$dfac = 60./$tempo;
	$now = $st;
	$pch = &randy( $minf, $maxf );
	while( $now < $st + $dur ){
		$notedur = &aduration() * $dfac;
		$interval = &aninterval( $disjunct );
		$pch *= $interval;
		if( $pch > $maxf || $pch < $minf){
			$pch = &randy( $minf, $maxf );
		}
		$tremsp = &randy(11,20);
		$pan = &randy(.1,.9);
		$noteamp = &randy(.25,.5) * $scale;
		$ifunc = 1;
		$realnotedur = $notedur + $olap;
		if( $realnotedur < $mindur ){
			$realnotedur = $mindur;
		}
		printf "i3 %.4f %.4f $ifunc %.4f %.4f %.4f %.4f\n",
		$now,$realnotedur,$pch,$noteamp,$tremsp,$pan;
		$now += $notedur;
	}
	
}
sub aduration {
	local($rval,$dur);
	$rval = rand;
	if( $rval > .5 ){
		$dur = .25;
	} elsif($rval > .25 ){
		$dur = .5;
	} elsif($rval > .125 ){
		$dur = .75;
	} elsif($rval > .0625 ){
		$dur = .125;
	} else{
		$dur = 1.;
	}
$dur;
}

sub aninterval {
local($dfac) = $_[0];
local($rval,$mult);
local(@small) = (1.125,1.142,1.166,1.2,1.25,1.333,1.5);
local(@large) = ();
	$rval = rand;
	if($rval > $dfac ){
		$intv = $small[ int rand(@small) ];
	} else {
		$rval = rand;
		if( $rval < .5 ){
			$mult = 2;
		} else {
			$mult = 3;
		}
		$intv = $small[ int rand(@small) ] * $mult;
	}
	$rval = rand;
	if( $rval < .5 ){
		$intv = 1./$intv;
	}
$intv;
}
sub gliss {
	local( $minf, $maxf, $n, $st, $dur ) = @_;
	local($i,$ifunc);
	$ifunc = 2;
	for( $i = 0; $i < $n; $i++ ){
		$stpch = &randy($minf,$maxf);
		$endpch = &randy($minf,$maxf);
		$stpan = rand(1);
		$endpan = rand(1);
		$gain = &randy(.1,.8) / $n;
		$gain *= .333 ;
		printf "i1 %.4f %.4f %d %.4f %.4f %.4f %.4f %.4f\n",
		$st,$dur,$ifunc,$stpch,$endpch,$stpan,$endpan,$gain;
	}
}
sub clust {
	local( $minf, $maxf, $n, $st, $dur ) = @_;
	local(@intervals) =  (1.125, 1.25, 1.2, 1.5, 1.666, 1.8);
	local($pch,$index, $i);
	$pch = $minf;
	$ifunc = 3;
	for( $i = 0; $i < $n; $i++ ){
		
		$tsp = &randy(15,25);
		$gain = &randy(.2,.7) / $n;
		$pan = &randy(.1,.9);
		printf "i2 %.4f %.4f %d %.4f %.4f %.4f %.4f\n",
		$st,$dur,$ifunc,$pch,$gain,$pan,$tsp;
		$index = int rand(@intervals);
		$anint =  $intervals[$index];
		$pch *= $anint;

		if( $pch > $maxf ){
			$pch = $minf + ($pch - $maxf);
		}
	}
}



sub header{
print "f1 0 256 10 1 1 1 1
f2 0 256 10 1 .5 .25
f3 0 256 10 1 1 1 1 1 .7 .25 .1
f77 0 1024 10 1 ; sine wave
f78 0 1024 -7 0 512 1 512 0\n";
}

1;