#include <stdio.h>
// cc -o d2 d2.c -L/Users/eric/C/LIB -leric -lericio
main(argc,argv) int argc; char *argv[];
{
int seed;
double atof();
float randf();
float a1,a2,a3,a4,a5,a6,a7;
float funda ;
float OLAP = .1 ;
float minseg = .5 ;
float maxseg = 3.;
float minf=15., maxf=50. ;
float cm1, cm2;
int inum ;
float realtime  = 0.;
float notedur, dur;
if(argc < 2 )
  usage();
dur = atof( *++argv );
seed = srandom(time(0));
funda = randf(minf,maxf);
a1 = randf(-70., 0. );
a2 = randf(-70., 0. );
a3 = randf(-70., 0. );
a4 = randf(-70., 0. );
a5 = randf(-70., 0. );
a6 = randf(-70., 0. );
a7 = randf(-70., 0. );

printf("i1 0 %f 1 0\n",dur);
while( realtime < dur ){
   notedur = randf( minseg, maxseg );
   funda = randf(minf,maxf);
   a1 = randf(-70., 0. );
   a2 = randf(-70., 0. );
   a3 = randf(-70., 0. );
   a4 = randf(-70., 0. );
   a5 = randf(-70., 0. );
   a6 = randf(-70., 0. );
   a7 = randf(-70., 0. );
   printf("i2 %f %f %f %f %f %f %f %f %f %f\n",
   realtime, notedur+OLAP, funda, a1,a2,a3,a4,a5,a6,a7);
   realtime += notedur;
   }
printf("i4 0 %f\n",dur);
}

usage()
{
  fprintf(stderr,"dur\n");
  exit(-1);
}
