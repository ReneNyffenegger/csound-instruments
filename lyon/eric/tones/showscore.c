#include<stdio.h>
#define RAND(min,max) ((random()/(float)0x7fffffff)*(max-min))+min
main(argc,argv) int argc; char *argv[];
{
int nbts;
int atk;
float div;
float tempo;
float now;
float beatval;
float tadj;
int i;
double atof();
if( argc < 2 ) usage();
tempo = atof( argv[1] );
now = 0.;
tadj = 60./tempo;
while(scanf("%i %f", &nbts, &div) != EOF){
	beatval = (4./div)*tadj;
	for(i = 0; i < nbts; i++){
		scanf("%d",&atk);
		if(atk == 1){
			printf("%f\n",now);
			}
		now +=  beatval;
	}
	printf("\n");
}
}

usage()
{
fprintf(stderr,"USE: TEMPO\n");
exit(0);
}
