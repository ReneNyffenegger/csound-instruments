#include<stdio.h>
#define RAND(min,max) ((random()/(float)0x7fffffff)*(max-min))+min
main(argc,argv) int argc; char *argv[];
{
float pcyc[500] ;
int length=0;
int pt = 0;
float tval;
float amp = .4;
FILE *fp, *fopen();
char pname[40];
if( argc < 2 )
usage();
strcpy( pname, argv[1] );
fp = fopen( pname, "r");
while( fscanf( fp, "%f\n",&pcyc[length++]) !=EOF);
while( scanf("%f",&tval) != EOF ){
	printf("%f %f %f\n",tval, pcyc[pt++],amp);
}
}
usage()
{
fprintf(stderr,"USE: pitchfilename\n");
exit(0);
}
