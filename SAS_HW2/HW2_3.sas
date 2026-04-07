proc import out=gasturbine /* name to give dataset once imported into SAS */
	datafile="/home/u64313401/GASTURBINE-1.txt" /* location of txt file to import */
	/*dbms=dlm /*Format of file being imported (dlm assumes spaces are used as delimiters)*/
	dbms=tab /*Format of file being imported (tab assumes spaces are used as tab delimiters)*/
	replace; /*Replace the file if it already exists*/
	getnames=YES; /*Use first row as variable names (set to NO if first row doesn't contain variable names)*/
run;

proc print data=gasturbine;
run;
 
proc reg data=gasturbine;
  model HEATRATE=RPM CPRATIO/p cli clm clb;
run;

data gasturbine2; 
 set gasturbine;
  x1=RPM;
  x2=CPRATIO;
  x1x2=RPM*CPRATIO;
  x1SQ=RPM*RPM;
  x2SQ=CPRATIO*CPRATIO;
run;

proc print data=gasturbine2;
run;

/*Regression of Reduced model*/
proc reg data=gasturbine2;
  model HEATRATE=x1 x2 x1x2;
  title'Reduced model';
run;
/*Regression of complete model*/
proc reg data=gasturbine2;
  model HEATRATE=x1 x2 x1x2 x1SQ  x2SQ;
  title'Full model';
run;

/*Partial F-test*/
proc reg data=gasturbine2;
  model HEATRATE=x1 x2 x1x2 x1SQ  x2SQ;
  quadratic: test x1SQ, x2SQ=0; /*TEst if the quadratic terms significant*/
  title'Partial F-test';
run;
