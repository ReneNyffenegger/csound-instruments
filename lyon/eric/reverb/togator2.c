#include<stdio.h>
#define RAND(min,max) ((random()/(float)0x7fffffff)*(max-min))+min
#define OUTFILE "gator2.sco"
main(argc,argv) int argc; char *argv[];
{
float dur;
float speed;
float idel1, idel2, idel3, idel4;
float icf1, icf2, icf3, icf4 ;
float speedfac = 1.0;
float SMALL = .000001 ;
FILE *fp, *fopen();
double atof();
int i;
int nchnls;
if( argc < 4 ) usage();
dur = atof( argv[1] );
speedfac = atof( argv[2] );
nchnls = atoi( argv[3] );

fp = fopen( OUTFILE, "w");
/* USE WITH CARL gen SCRIPTS:
fprintf(fp,"f1 0 2048 -1 50 0 6\n");
fprintf(fp,"f2 0 2048 -1 51 0 6\n");
fprintf(fp,"f3 0 2048 -1 52 0 6\n");
fprintf(fp,"f4 0 2048 -1 53 0 6\n");
*/
fprintf(fp,"f1 0 2048 -5 %f 205 1.0 205 .4 1638 %f\n",SMALL,SMALL);
fprintf(fp,"f2 0 2048 -5 %f 103 1.0 205 .25 921 %f 819 %f\n",SMALL,SMALL,SMALL);
fprintf(fp,"f3 0 2048 -5 %f 410 1.0 512 .5 102 %f 1024 %f\n",SMALL,SMALL,SMALL);
fprintf(fp,"f4 0 2048 -5 %f 1434 1.0 614 %f\n",SMALL,SMALL);

srandom( time( 0 ) );
if( nchnls == 1 )
   fprintf(fp, "i1 0 %f 1 0\n",dur);
else if ( nchnls == 2 )
   fprintf(fp, "i2 0 %f 1 0\n",dur);
else{
   fprintf(stderr,"%d not a legal number of channels\n",nchnls);
   exit(-1);
}
for(i = 0; i < 4; i++ ){
   speed = (RAND( .8, 1.3 )) * speedfac;
   fprintf(fp,"%f  ", speed );
}
fprintf(fp,"\n");
idel1 = RAND(.01,.05);
idel2 = RAND(.05,.1);
idel3 = RAND(.08,.15);
idel4 = RAND(.1, .25 );
fprintf(fp,"%f %f %f %f\n",idel1, idel2, idel3, idel4);
icf1 = RAND(2000.0, 4000.0);
icf2 = RAND(500.0,1500.0);
icf3 = RAND(150.0,400.0);
icf4 = RAND( 40.0, 80.0 );
fprintf(fp,"%f %f %f %f\n",icf1,icf2,icf3,icf4);
fprintf(fp,"\n");
fprintf(stderr,"SCORE WRITTEN TO %s\n",OUTFILE);
}
usage()
{
	fprintf(stderr,"togator2: dur speedfac nchnls[of input]\n");
	exit(-1);
}
