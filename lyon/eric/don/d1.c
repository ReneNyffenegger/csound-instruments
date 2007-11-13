#include <stdio.h>
// cc -L/Users/eric/C/LIB -leric -lericio
main(argc,argv) int argc; char *argv[];
{
int seed;
double atof();
float randf();
float s1,s2,s3;
float OLAP = .1 ;
float minseg = .1 ;
float maxseg = 1.;
float speed1, speed2, minf, maxf ;
float cm1, cm2;
int inum ;
float realtime  = 0.;
float notedur, dur;
if(argc < 2 )
  usage();
dur = atof( *++argv );
seed = srandom(time(0));
printf("f1 0 8192 10 1\n"); 
printf("f2 0 8192 -9 .5 1.0 0\n"); 
speed1 = randf(.1, 6.);
speed2 = randf(.2, 3.);
minf = randf( 20., 600. );
maxf = randf( minf, 20000. );
s1 = randf( 0., 1. );
s2 = randf( 0., 1. );
s3 = randf( 0., 1. );

printf("i1 0 %f %f %f %f %f %f %f %f\n",
dur, speed1, speed2, minf, maxf, s1, s2, s3);
while( realtime < dur ){
   notedur = randf( minseg, maxseg );
   inum = random()%2 + 2 ;
   cm1 = randf(.25, 5. );
   cm2 = randf( .25, 5. );
   if( inum == 2)
   printf("i2 %f %f %f\n",
   realtime, notedur+OLAP, cm1);
   else if( inum == 3 )
   printf("i3 %f %f %f %f\n",
   realtime, notedur+OLAP, cm1, cm2);
   realtime += notedur ;
}
}

usage()
{
  fprintf(stderr,"dur\n");
  exit(-1);
}