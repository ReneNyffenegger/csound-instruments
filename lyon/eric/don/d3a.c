#include <stdio.h>
// cc -o d3 d3.c -L/Users/eric/C/LIB -leric -lericio
main(argc,argv) int argc; char *argv[];
{
float dur;
float minseg = .1 ;
float maxseg = 3.0;
float minf=70, maxf=800. ;
float minf2=.5, maxf2=3. ;
float realtime  = 0.;
float notedur;
float fr1, fr2;
float seed;
float OLAP = .1 ;
float speed ;
int i;
double atof();
float randf();
if(argc < 2 )
  usage();
dur = atof( *++argv );
srandom(time(0));
printf("f1 0 1024 10 1\n");

for( i = 0 ; i < 3; i++ ){
   realtime = 0.;
   while( realtime < dur ){
      notedur = randf( minseg, maxseg );
      if( notedur + realtime >= dur ) 
         notedur = realtime-dur;
      if( notedur <= 0.0 ){
         realtime = dur;
	 continue;
      }
      fr1 = randf(minf,maxf/2.);
      fr2 = randf(fr1, maxf);
      seed = randf(0. , 1.);
      speed = randf(.1, 13. );
      printf("i%d %f %f %f %f %f %f\n",
      i+1,realtime,notedur+OLAP,speed,fr1,fr2,seed);
      realtime += notedur ;
      }
   }
   
for( i = 0 ; i < 3; i++ ){
   realtime = 0.;
   while( realtime < dur ){
      notedur = randf( minseg, maxseg );
      if( notedur + realtime >= dur ) notedur = realtime-dur;
       if( notedur <= 0.0 ){
         realtime = dur;
	 continue;
      }
      fr1 = randf(.5, 20.);
      fr2 = randf(fr1, 200.);
      seed = randf(0. , 1.);
      speed = randf(minf2, maxf2 );
      printf("i%d %f %f %f %f %f %f\n",
      i+4,realtime,notedur+OLAP,speed,fr1,fr2,seed);
      realtime += notedur ;
      }
   }
for( i = 0 ; i < 3; i++ ){
   realtime = 0.;
   while( realtime < dur ){
      notedur = randf( minseg, maxseg );
      if( notedur + realtime >= dur ) notedur = realtime-dur;
      if( notedur <= 0.0 ){
         realtime = dur;
	 continue;
      }
      fr1 = randf(.5, 1.);
      fr2 = randf(fr1, 2.);
      seed = randf(0. , 1.);
      speed = randf(.1, 7. );
      printf("i%d %f %f %f %f %f %f\n",
      i+7,realtime,notedur+OLAP,speed,fr1,fr2,seed);
      realtime += notedur ;
      }
   }

printf("i10 0 %f\n",dur);
}

usage()
{
  fprintf(stderr,"dur\n");
  exit(-1);
}