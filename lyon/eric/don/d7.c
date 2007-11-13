#include <stdio.h>
// cc -o d7 d7.c -L/Users/eric/C/LIB -leric -lericio
main(argc,argv) int argc; char *argv[];
{
int seed, i;
float amp = 1., dur ;
double atof();
float randf();
float ampdb();
if(argc < 2 )
  usage();
dur = atof( *++argv );
seed = srandom(time(0));
printf("f1 0 1024 10 1\n");
printf("f2 0 1024 10 1 .3 0 .1 .5 .02\n");
printf("i1 0 %f ",dur);
for(i = 0; i < 5; i++ )
   printf("%f ",randf(0.,1.));
printf("\n");
printf("i2 0 %f ",dur);
printf("%f %f ",randf(.8,1.2),amp);
for(i = 0; i < 4; i++ )
   printf("%f ",randf(0.,1.));
for(i = 0; i < 4; i++ )
   printf("%f ",randf(.25, 4.)); // SPEED
printf("\n");

}

usage()
{
  fprintf(stderr,"dur\n");
  exit(-1);
}
