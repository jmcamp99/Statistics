proc import out=flag /* name to give dataset once imported into SAS */
	datafile="/home/u64313401/FLAG2.txt" /* location of txt file to import */
	/*dbms=dlm /*Format of file being imported (dlm assumes spaces are used as delimiters)*/
	dbms=tab /*Format of file being imported (tab assumes spaces are used as tab delimiters)*/
	replace; /*Replace the file if it already exists*/
	getnames=YES; /*Use first row as variable names (set to NO if first row doesn't contain variable names)*/
run;

data flag2; 
 set flag;
  y=LOWBID;
  x1=DOTEST;
  x2=LBERATIO;
  x3=STATUS;
  x4=DISTRICT;
  x5=NUMIDS;
  x6=DAYSEST;
  x7=RDLNGTH;
  x8=PCTASPH;
  x9=PCTBASE;
  x10=PCTEXCAV;
  x11=PCTMOBIL;
  x12=PCTSTRUC;
  x13=PCTTRAF;
  x14=SUBCONT;
run;

proc reg data=flag2;
  Forward: model y=x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14/selection=forward DETAILS=SUMMARY SLENTRY=0.05 SLSTAY=0.05;
  Backward: model y=x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14/selection=backward DETAILS=SUMMARY SLENTRY=0.05 SLSTAY=0.05;
  Stepwise: model y=x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14/selection=stepwise DETAILS=SUMMARY SLENTRY=0.05 SLSTAY=0.05;
run;

proc reg data=flag2;
  model Y = x1 x2/ p cli clm clb;
run;

/* 8.2 plot residuals */

data PlotResiduals;
	input y x;
	datalines;
5 2
10 4
12 7
22 10
25 12
27 15
39 18
50 20
47 21
65 25
;
run;
	
proc reg data=PlotResiduals;
  model y=x/ p cli clm clb;
  output out=pred_results
		p=predicted_value
		r=residual;
run;

/* 8.3 New tire wear tests */

proc import out=tires /* name to give dataset once imported into SAS */
	datafile="/home/u64313401/TIRES.txt" /* location of txt file to import */
	/*dbms=dlm /*Format of file being imported (dlm assumes spaces are used as delimiters)*/
	dbms=tab /*Format of file being imported (tab assumes spaces are used as tab delimiters)*/
	replace; /*Replace the file if it already exists*/
	getnames=YES; /*Use first row as variable names (set to NO if first row doesn't contain variable names)*/
run;

proc reg data=tires;
  model MILEAGE_Y=PRESS_X/ p cli clm clb;
  output out=pred_results
		p=predicted_value
		r=residual;
run;

data tires2;
	set tires;
	x2 = PRESS_X**2;
run;
	
proc reg data=tires2;
	model MILEAGE_Y=PRESS_X x2/ p cli clm clb;
	output out=pred_results
		p=predicted_value
		r=residual;
run;
	
/* 8.30 Cooling method for gas turbines */

proc import out=gasturbine /* name to give dataset once imported into SAS */
	datafile="/home/u64313401/GASTURBINE-2.txt" /* location of txt file to import */
	/*dbms=dlm /*Format of file being imported (dlm assumes spaces are used as delimiters)*/
	dbms=tab /*Format of file being imported (tab assumes spaces are used as tab delimiters)*/
	replace; /*Replace the file if it already exists*/
	getnames=YES; /*Use first row as variable names (set to NO if first row doesn't contain variable names)*/
run;

data gasturbine2;
  set gasturbine;
  if ENGINE='Traditional' then x1=1; else x1=0;
  if ENGINE='Advanced' then x2=1; else x2=0;
  if ENGINE='Aeroderiv' then x3=1; else x3=0;
run; 

proc reg data=gasturbine2;
  model HEATRATE=SHAFTS RPM CPRATIO INLET_TEMP EXH_TEMP AIRFLOW POWER x1 x2 x3/influence R;
  output out=analysis student=strsid h=lever rstudent=stdelres cookd=cooksdis ;
run;

proc print data=analysis;
run;

/* Buying power of the dollar */

proc import out=buypower /* name to give dataset once imported into SAS */
	datafile="/home/u64313401/BUYPOWER.txt" /* location of txt file to import */
	/*dbms=dlm /*Format of file being imported (dlm assumes spaces are used as delimiters)*/
	dbms=tab /*Format of file being imported (tab assumes spaces are used as tab delimiters)*/
	replace; /*Replace the file if it already exists*/
	getnames=YES; /*Use first row as variable names (set to NO if first row doesn't contain variable names)*/
run;

proc reg data=buypower;
  model VALUE=T/influence R;
  output out=analysis student=strsid h=lever rstudent=stdelres cookd=cooksdis ;
run;

proc print data=analysis;
run;

/* Cost of modifying a naval fleet*/

proc import out=navalfleet /* name to give dataset once imported into SAS */
	datafile="/home/u64313401/NAVALFLEET.txt" /* location of txt file to import */
	/*dbms=dlm /*Format of file being imported (dlm assumes spaces are used as delimiters)*/
	dbms=tab /*Format of file being imported (tab assumes spaces are used as tab delimiters)*/
	replace; /*Replace the file if it already exists*/
	getnames=YES; /*Use first row as variable names (set to NO if first row doesn't contain variable names)*/
run;

proc reg data=navalfleet;
  model IMPROVE=COST/influence R;
  output out=analysis student=strsid h=lever rstudent=stdelres cookd=cooksdis ;
run;

proc print data=analysis;
run;