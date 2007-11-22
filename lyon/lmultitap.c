#include<stdio.h>
#define RAND(min,max) ((random()/(float)0x7fffffff)*(max-min))+min
#define NTAPS (5)
#define STEREO "multitap2.sco"
#define MONO "multitap.sco"
main(argc,argv) int argc; char *argv[];
{
float b1a=.1, b1b=.2, b2a=.4, b2b=.7, b3a=.05, b3b=.95;
float atten1=.4, atten2=.7, atten3=.9;
float g1=.7, g2=.3, g3=.15;
float mindel1=.01, maxdel1=.04;
float mindel2=.04, maxdel2=.15;
float mindel3=.1, maxdel3=.3;
float deladd;
float delay, gain, loc;
float dur;
char dataname[64];
char OUTFILE[128];
int nchnls = 1;
FILE *datafp, *fp, *fopen();
double atof();
int i;
if( argc < 3 ) usage();
dur = atof( argv[1] );
nchnls = atoi( argv[2] );
if( nchnls == 1 )
   strcpy( OUTFILE, MONO );
else if( nchnls == 2 )
   strcpy( OUTFILE, STEREO );
else{
   fprintf(stderr,"%d not a valid number of channels\n",nchnls);
   exit(-1);
}
fp = fopen( OUTFILE, "w");
if( argc == 4 ) // ONLY IF DATAFILE IS GIVEN
{
	strcpy( dataname, argv[2] );
	datafp = fopen( dataname, "r");
	fscanf(datafp, "%f %f %f %f %f %f",&b1a,&b1b,&b2a,&b2b,&b3a,&b3b);
	fscanf(datafp, "%f %f %f",&atten1, &atten2, &atten3);
	fscanf(datafp, "%f %f %f",&g1, &g2, &g3);
}
srandom( time( 0 ) );
fprintf(fp, "i1 0 %f 1 0\n",dur);
delay = 0.;
for (i = 0 ; i < NTAPS ; i++ )
	{
	deladd = RAND( mindel1, maxdel1 );
	delay += deladd;
	fprintf(fp, "%f ",delay);
	}
gain = g1;
for (i = 0 ; i < NTAPS ; i++ )
	{
	fprintf(fp, "%f ", gain);
	gain *= atten1;
	}
for (i = 0 ; i < NTAPS ; i++ )
	{
	loc = RAND(b1a, b1b );
	fprintf(fp, "%f ", loc);
	}
	fprintf(fp,"\n");
delay = 0.;
for (i = 0 ; i < NTAPS ; i++ )
	{
	deladd = RAND( mindel2, maxdel2 );
	delay += deladd;
	fprintf(fp,"%f ",delay);
	}
gain = g2;
for (i = 0 ; i < NTAPS ; i++ )
	{
	fprintf(fp,"%f ", gain);
	gain *= atten2;
	}
for (i = 0 ; i < NTAPS ; i++ )
	{
	loc = RAND(b2a, b2b );
	fprintf(fp,"%f ", loc);
	}
	fprintf(fp,"\n");
delay = 0.;
for (i = 0 ; i < NTAPS ; i++ )
	{
	deladd = RAND( mindel3, maxdel3 );
	delay += deladd;
	fprintf(fp,"%f ",delay);
	}
gain = g3;
for (i = 0 ; i < NTAPS ; i++ )
	{
	fprintf(fp,"%f ", gain);
	gain *= atten3;
	}
for (i = 0 ; i < NTAPS ; i++ )
	{
	loc = RAND(b3a, b3b );
	fprintf(fp,"%f ", loc);
	}
	fprintf(fp,"\n");
fprintf(stderr,"SCORE WRITTEN TO %s\n",OUTFILE);
}
usage()
{
	fprintf(stderr,"multi: dur nchnls [datafile] \n");
	fprintf(stderr,"%s%s%s",
	"\nDATAFILE FORMAT: \nband1lim1 band1lim2 band2lim1 band2lim2 band3lim1 band3lim2",
	"\ntap_atten1 tap_atten2 tap_atten3",
	"\ngain1 gain2 gain3\n");
	exit(0);
}
