#include <stdio.h>
// cc -o d5 d5.c -L/Users/eric/C/LIB -leric -lericio
#define MINDUR (.05)
#define NFLTS (7)
#define MAXSEGS (500)
#define TRANSDUR (.08)
#define FLEN (4096)
#define MINAMP (-45.)
typedef struct
{
   float amps[NFLTS] ;
   float segdur ;
   int segpoints ;
   float fundie ;
} Multiband ;
main(argc,argv) int argc; char *argv[];
{
Multiband *X ;
int seed;
float s[6];
double atof();
float randf();
float ampdb();
float minseg = .1 ;
float maxseg = .3;
float minf=15., maxf=50. ;
int cnt = 0;
float realtime  = 0.;
float notedur, dur;
int ptcnt, leftovers;
int i,j;
if(argc < 2 )
  usage();
dur = atof( *++argv );
seed = srandom(time(0));
for(i=0;i<5;i++)
	s[i] = randf(0.,1.);
printf("f1 0 1024 10 1\n");
printf("f2 0 1024 10 1 .3 .2 0 0 0 .1 .3 0 0 .05 .05\n");
printf("i1 0 %f %f %f %f %f %f\n",dur,s[0],s[1],s[2],s[3],s[4]);
// hoarmony
printf("i2 0 %f 1. .5\n",dur);
printf("i2 0 %f 1.25 .5\n",dur);
printf("i2 0 %f 1.5 .5\n",dur);
printf("i3 0 %f %f\n",dur,randf(.05,.15));
printf("i3 0 %f %f\n",dur,randf(.05,.15));
printf("i4 0 %f\n",dur);
}

usage()
{
  fprintf(stderr,"dur\n");
  exit(-1);
}
dur2samp( d, sr ) float d; int sr;
{
   return( (int) (d*(float)sr));
}
float ampdb( db ) float db;
{
double pow();
   return( pow((double)10.0, (double)(db/20.0)) );
}