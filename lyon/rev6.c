#include<stdio.h>
#define RAND(min,max) ((random()/(float)0x7fffffff)*(max-min))+min
#define GAIN (1.)
#define OUTFILE "rev6.sco"
/*
I find it useful to use the full pathname here:

#define OUTFILE "/Net/judy/Export/Users/eric/csound/REVERB/rev6.sco"
*/

main(argc,argv) int argc; char *argv[];
{
FILE *fp, *openfile();
double atof();
float dur, iorig, ifile=1., iskip=0.0;
float rvt, res1, res2, res3, res4, echot, echolp1, echolp2, iecho;
if( argc < 3 ) usage();
srandom( time( 0 ) );
dur = atof( argv[1] );
iorig = atof( argv[2] );
if( argc > 3 ){
   ifile = atof( argv[3] );
   iskip = atof( argv[4] );
}
fp = openfile( OUTFILE, "w" );
rvt = RAND(2.,3.);
res1 = RAND(20.,40.);
res2 = RAND(30.,50.);
res3 = RAND(40.,60.);
res4 = RAND(50.,70.);
echot = RAND(.3,1.5);
echolp1 = RAND(.05,.15);
echolp2 = RAND(.05,.15);
iecho = RAND(.05,.25);
fprintf(fp,"i1 0 %f %.0f %f %f %f %f %f %f %f %f %f %f %f %f\n",
dur, ifile, iskip, rvt, res1, res2, res3, res4, echot, echolp1, echolp2,
iorig, iecho, GAIN);
scoremsg( OUTFILE );
}
FILE * openfile( fname, mode ) const char *fname, *mode ; 
{
FILE *fp, *fopen();
if( (fp = fopen(fname, mode)) == NULL) {
  fprintf(stderr,"could not open %s\n",fname);
  exit(-1);
}
return( fp );
}

scoremsg(fname) char fname[];
{
   fprintf(stderr,"SCORE WRITTEN TO %s\n",fname);
}
usage()
{
fprintf(stderr,"USE: duration percent_dry [file skip]\n");
exit(0);
}
