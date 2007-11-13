#!/usr/local/bin/perl
require "/Users/eric/PERL/libperl.pl";

@myfunc = &readfunc("func");
$val = &lookup(.8, @myfunc);
print STDERR "$val\n";

sub lookup{
	local($index,@func) = @_;
	$pt = int $index * @func;
	print "$pt $index\n";
	@func[--$pt];
}
sub readfunc{
	local($name,@samps) = $_[0];
	local($cnt) = 0;
	open (FU, $name);
	while( read(FU,$afloat,4) ){
	$samps[$cnt++] = unpack("f",$afloat);
	print STDERR "read\n";
	}
	;
	close FU
	return @samps;
}
1;