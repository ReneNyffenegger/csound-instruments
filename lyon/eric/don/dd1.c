#include <stdio.h>
main(argc,argv) int argc; char *argv[];
{
int seed, i;
float amp = 1., dur ;
double atof();
float randf();
float ampdb();
int size1,size2,size3;

/***********/
if(argc < 2 )
  usage();
dur = atof( *++argv );
seed = srandom(time(0));
printf("f1 0 1024 10 1\n");
printf("f2 0 1024 10 1 .3 0 .1 .5 .02\n");
size1 = random()%5 + 12;
size2 = random()%5 + 12;
size3 = random()%5 + 12;
mktbl( 3, size1, .2, 3. );
mktbl( 4, size2, .4, 10. );
mktbl( 5, size3, .2, .88);
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

printf("i3 0 %f %d %d %d \n",
dur,size1,size2,size3);
for(i = 0; i < 4; i++ )
	printf("%f ",randf(0.,1.));
printf("\n");

printf("i4 0 %f ",dur);
for(i = 0; i < 2; i++ )
	printf("%f ",randf(0.,1.));
for(i = 0; i < 2; i++ ){
	printf("%f ",randf(50., 100.));
	printf("%f ",randf(100., 200.));
	printf("%f ",randf(200., 400.));
	printf("%f ",randf(400., 800.));

	}
for(i = 0; i < 2; i++ )
	printf("%f ",randf(.4, 3.));
printf("\n");
}

#define MAXTSIZE 16
mktbl( fnum, size, min, max )
int fnum, size;
float min, max;
{
int i;
float randf();
printf("f%d 0 %d -2 ",fnum,MAXTSIZE);
for(i = 0; i < size; i++ )
	printf("%f ",randf(min,max));
printf("\n");
}
usage()
{
  fprintf(stderr,"dur\n");
  exit(-1);
}
