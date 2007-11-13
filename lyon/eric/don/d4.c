#include <stdio.h>
// cc -o d4 d4.c -L/Users/eric/C/LIB -leric -lericio
main(argc,argv) int argc; char *argv[];
{
float dur;
float minf=100, maxf=500. ;
float fr1, fr2;
float seed1, seed2;
float sp1, sp2 ;
float dev1, dev2;
int closeflag;
double atof();
float randf();
if(argc < 2 )
  usage();
dur = atof( *++argv );
srandom(time(0));
printf("f1 0 1024 11 12 1 .8 \n"); 
//12 harmonics, 1 is lowest, .8 is up gain

fr1 = randf( minf, maxf);
closeflag = random()%2 ;
if( closeflag )
   fr2 = fr1 * (1. + (plus_or_minus(randf(.5,2.03)))) ;
else
   fr2 = randf( minf, maxf);
sp1 = randf(.25, 6.);
sp2 = randf(.25, 6.);
dev1 = randf(.4,.9);
dev2 = randf(.4,.9);
seed1 = randf(0.,1.);
seed2 = randf(0.,1.);
printf("i1 0. %f %f %f %f %f %f %f %f %f\n",
  dur,fr1,fr2,sp1,sp2,dev1,dev2,seed1,seed2);
}

usage()
{
  fprintf(stderr,"dur\n");
  exit(-1);
}
