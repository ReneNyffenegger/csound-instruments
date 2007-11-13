#!/usr/local/bin/perl

while(<>)
{
	($st,$dur,$fr,$amp) = split(' ');
	$seed = rand(1);
	printf "i2 %.4f %.4f %.4f %.4f %.4f\n",
	$st,$dur,$fr,$amp,$seed;
}