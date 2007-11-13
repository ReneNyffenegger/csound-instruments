#include <stdio.h>
// cc -o d7 d7.c -L/Users/eric/C/LIB -leric -lericio
#define MAXTABLE 32
main(argc,argv) int argc; char *argv[];
{
int seed, i;
float amp = 1., dur ;
float car, indy, cm, incr ;
double atof();
float randf();
float ampdb();
int ncars, nindies, ncms, nincr;
float speed1, speed2, speed3, speed4 ;
//-------
if(argc < 2 )
  usage();
dur = atof( *++argv );
seed = srandom(time(0));
ncars = random()%16 + 4 ;
nindies = random()%20 + 4;
ncms = random()%7 + 3 ;
nincr = random()%20 + 2 ;
printf("f1 0 %d -2 ",MAXTABLE);
for( i = 0; i < ncars; i++ ){
	car = randf(70.,1300.);
	printf("%f ",car);
} printf("\n");
printf("f2 0 %d -2 ",MAXTABLE);
for( i = 0; i < nindies; i++ ){
	indy = randf(.2,1.5);
	printf("%f ",indy);
}
printf("\n");
printf("f3 0 %d -2 ",MAXTABLE);
for( i = 0; i < ncms; i++ ){
	cm = (float) (random()%5 + 1);
	cm /= 2. ;
	cm *= randf(.95, 1.05);
	printf("%f ",cm);
}
printf("\n");

printf("f4 0 %d -2 ",MAXTABLE);
for( i = 0; i < ncms; i++ ){
	incr = randf(.8,1.2);
	printf("%f ",incr);
}
printf("\n");

speed1 = randf( .7, 7.) / (float) ncars;
speed2 = randf( .1, 4.) / (float) nindies;
speed3 = randf( .2, 4.) / (float) ncms;
speed4 = randf( .1, 2.) / (float) nincr;

printf("f5 0 1024 10 1\n\n");
printf("i1 0 %f %d %d %d %d %f %f %f %f\n", dur, ncars,
nindies, ncms, nincr, speed1, speed2, speed3, speed4 );
}

usage()
{
  fprintf(stderr,"dur\n");
  exit(-1);
}
