#include<stdio.h>
#define RAND(min,max) ((random()/(float)0x7fffffff)*(max-min))+min
#define DESTFUNC "/scratch/eric/soundin.80"
#define FLEN (512)
#define SCOREFILE "comp1.s"
#define MINLEN (.1)
#define MAXLEN (2.)
#define MINREST (.1)
#define MAXREST (2.)
/* FOR USE WITH comp1.orch */
main(argc,argv) int argc; char *argv[];
{
double atof();
float dur;
int nlines, i;
float minfreq, maxfreq;
float notedur;
float freq, amp;
float realtime;
float min, max;
float fstep;
FILE *fp, *fopen();
int play;

if( argc < 5 ) usage();
dur = atof( argv[1] );
nlines = atoi( argv[2] );
minfreq = atof( argv[3] );
maxfreq = atof( argv[4] );
amp = 1.0/(float) nlines ;
srandom( time( 0 ) );
fp = fopen( SCOREFILE, "w" );
makefunc();
putfuncs(fp);
fstep = (maxfreq-minfreq)/(float)nlines;
max = maxfreq; min = maxfreq - fstep;
for( i = 0 ; i < nlines ; i++ )
	{
	freq = RAND( min, max );
	max = min; min = max - fstep;
	play = 1;
	realtime = 0.0;
	while( realtime < dur )
		{
		if( play )
			{
			notedur = RAND(MINLEN, MAXLEN);
			putnote( realtime, notedur, freq, amp, fp );
			realtime += notedur;
			play = 0;
			}
		else 	{
			realtime += RAND(MINREST, MAXREST);
			play = 1;
			}
		}
	}
}
putnote( now, dur, fr, amp, fptr ) float now, dur, fr, amp ; FILE *fptr;
{
float fspeed, phase, dev, devsp, seed1, seed2, envsp;
int efunc ;
float ampadj;
fspeed = RAND(5.,21.);
phase = RAND(0.,1.);
dev = RAND(.01,.05);
devsp = RAND(1.,3.);
seed1 = RAND(0.,1.);
envsp = RAND(2.,21.);
seed2 = RAND(0.,1.);
ampadj = RAND(.25, 4.);
efunc = (random()%4) + 1;
fprintf(fptr,"i1 %f %f %f %f %f %f %f %f %f %f %f %d\n",
now, dur, fspeed, phase, dev, devsp, seed1, amp*ampadj, envsp, seed2, fr, efunc);
}
putfuncs( fp ) FILE *fp;
{
fprintf(fp,"f1 0 %d -1 80 0\n", FLEN);
fprintf(fp,"f2 0 2048 10 1 .2 .1 .4 0 .05\n");
fprintf(fp,"f3 0 16384 13 1 1 0 5 0 3 0 1\n");
fprintf(fp,"f4 0 4096 1 50 0\n");
fprintf(fp,"f5 0 4096 1 51 0\n");
fprintf(fp,"f6 0 4096 1 52 0\n");
fprintf(fp,"f7 0 4096 1 53 0\n");
}
makefunc()
{
int i;
static float max = 2.0 ;
static float min = .5 ;
static float ints[] = { 1., .5, .667, 1.2, 1.25, 1.6667, 1.333, .8 };
static int nint = 8;
int wint,lastint;
float current;
FILE *fp, *fopen();
fp = fopen(DESTFUNC,"w");
lastint = wint = 0;
current = 1.0;
for( i = 0 ; i < FLEN ; i++ )
	{
		while( lastint == wint )
			{
			wint = random()%nint;
			}
		current *= ints[ wint ];
		if( current >= max ) current /= (2.0*ints[wint]) ;
		else if( current <= min ) current *= (2.0*ints[wint]) ;
		fwrite(&current, sizeof (float), 1, fp);
		lastint = wint;
	}
}
usage()
{
	fprintf(stderr,"dur nlines minfreq maxfreq\n");
	exit(0);
}
