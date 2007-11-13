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
X = ( Multiband *) space( MAXSEGS, sizeof(Multiband )) ;
seed = srandom(time(0));
while( realtime < dur ){
   X[cnt].segdur = randf( minseg, maxseg );
   if( realtime + X[cnt].segdur > dur )
      X[cnt].segdur = dur - realtime;
   if( X[cnt].segdur < MINDUR )
      break ;
   X[cnt].fundie  = randf(minf,maxf);
   for( i = 0; i < NFLTS; i++ )
      X[cnt].amps[i] = ampdb(randf(MINAMP, 0. ));
   realtime += X[cnt].segdur;
   ++cnt;
   // HOLD AND THEN TRANSITION
   X[cnt].fundie = X[cnt-1].fundie;
   for( i = 0; i < NFLTS; i++ )
      X[cnt].amps[i] = X[cnt-1].amps[i];
   X[cnt].segdur = TRANSDUR ;
   realtime += TRANSDUR;
   }
   for(i = 0; i < cnt ; i++ ){
      X[i].segpoints = dur2samp( X[i].segdur/dur, FLEN );
   /* fprintf(stderr,"%d pt = %d dur = %f\n",i,X[i].segpoints,X[i].segdur); */
      }
   ptcnt = 0;
   for(i = 0; i < cnt ; i++ )
      ptcnt += X[i].segpoints;
   leftovers = ptcnt - FLEN;
   if( leftovers > 0 ){
      i = 0;
      while( leftovers > 0 ){
         --(X[i].segpoints);
	 i++;
	 --leftovers;
	 if( i == cnt )
	    i = 0;
      }
   } else if (leftovers < 0 ) {
      i = 0;
      while( leftovers < 0 ){
         ++(X[i].segpoints);
         i++;
         ++leftovers;
         if(i == cnt)
           i = 0;
         }
   }
   for(i = 0; i < NFLTS; i++ ){
      printf("f%d 0 %d -7 ",i+1,FLEN);
      for( j = 0; j < cnt; j++ ){
        printf("%f %d ", X[j].amps[i],X[j].segpoints);
      }
      printf("%f\n",X[cnt-1].amps[i]);
   }
   printf("f%d 0 %d -7 ",NFLTS+1,FLEN);
   for(i = 0; i < cnt; i++ ){        
      printf("%.2f %d ", X[i].fundie,X[i].segpoints);
   }
   printf("%.2f\n\n", X[cnt-1].fundie);
   printf("i1 0. %f\n",dur);

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