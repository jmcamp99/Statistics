proc import out=Boxing /* name to give dataset once imported into SAS */
	datafile="/home/u64313401/BOXING2.txt" /* location of txt file to import */
	/*dbms=dlm /*Format of file being imported (dlm assumes spaces are used as delimiters)*/
	dbms=tab /*Format of file being imported (tab assumes spaces are used as tab delimiters)*/
	replace; /*Replace the file if it already exists*/
	getnames=YES; /*Use first row as variable names (set to NO if first row doesn't contain variable names)*/
run;

 proc print data=Boxing;
 run;
	
data boxing1;
	input x y;
	datalines;
	3.8 7
	4.2 7
	4.8 11
	4.1 12
	5.0 12
	5.3 12
	4.2 13
	2.4 17
	3.7 17
	5.3 17
	5.8 18
	6.0 18
	5.9 21
	6.3 21
	5.5 20
	6.5 24
	;
	run;
	
proc print data=boxing1;
run;
proc sgplot data=boxing1;
	scatter x=x y=y;
run;
proc reg data=boxing1;
	model y=x;
	output out=pred_results
		p=predicted_value
		r=residual;
run;

proc print data=pred_results;
run;

proc import out=Heat /* name to give dataset once imported into SAS */
	datafile="/home/u64313401/HEAT-1.txt" /* location of txt file to import */
	/*dbms=dlm /*Format of file being imported (dlm assumes spaces are used as delimiters)*/
	dbms=tab /*Format of file being imported (tab assumes spaces are used as tab delimiters)*/
	replace; /*Replace the file if it already exists*/
	getnames=YES; /*Use first row as variable names (set to NO if first row doesn't contain variable names)*/
run;

 proc print data=Heat;
 run;
	
data heat1;
	input x y;
	datalines;
	1.93 4.4
	1.95 5.3
	1.78 4.5
	1.64 4.5
	1.54 3.7
	1.32 2.8
	2.12 6.1
	1.88 4.9
	1.70 4.9
	1.58 4.1
	2.47 7.0
	2.37 6.7
	2.00 5.2
	1.77 4.7
	1.62 4.2
	2.77 6.0
	2.47 5.8
	2.24 5.2
	1.32 3.5
	1.26 3.2
	1.21 2.9
	2.26 5.3
	2.04 5.1
	1.88 4.6
	;
	run;

proc print data=heat1;
run;
proc sgplot data=heat1;
	scatter x=x y=y;
run;
proc reg data=heat1;
	model y=x;
	output out=pred_results
		p=predicted_value
		r=residual;
run;

proc print data=pred_results;
run;

proc import out=Snowgeese /* name to give dataset once imported into SAS */
	datafile="/home/u64313401/SNOWGEESE.txt" /* location of txt file to import */
	/*dbms=dlm /*Format of file being imported (dlm assumes spaces are used as delimiters)*/
	dbms=tab /*Format of file being imported (tab assumes spaces are used as tab delimiters)*/
	replace; /*Replace the file if it already exists*/
	getnames=YES; /*Use first row as variable names (set to NO if first row doesn't contain variable names)*/
run;

 proc print data=Snowgeese;
 run;
 
data snowgeese1;
	input x y;
	datalines;
	0 -6
	2.5 -5
	5 -4.5
	0 0
	0 2
	1 3.5
	2.5 -2
	10 -2.5
	20 -3.5
	12.5 -2.5 
	28 -3
	30 -8.5
	18 -3.5
	15 -3
	17.5 -2.5
	18 -0.5
	23 0
	20 1
	15 2
	31 6
	15 2
	21 2
	30 2.5
	33 2.5
	27.5 0
	29 0.5
	32.5 -1
	42 -3
	39 -2.5
	35.5 -2
	39 0.5
	39 5.5
	50 7.5
	62.5 0
	63 0
	69  2
	42.5 8
	59 9
	52.5 12
	75 8.5
	72.5 10.5
	69 14
	;
	run;

proc print data=snowgeese1;
run;
proc sgplot data=snowgeese1;
	scatter x=x y=y;
run;
proc reg data=snowgeese1;
	model y=x;
	output out=pred_results
		p=predicted_value
		r=residual;
run;

proc print data=pred_results;
run;

proc import out=Whitespruce /* name to give dataset once imported into SAS */
	datafile="/home/u64313401/WHITESPRUCE.txt" /* location of txt file to import */
	/*dbms=dlm /*Format of file being imported (dlm assumes spaces are used as delimiters)*/
	dbms=tab /*Format of file being imported (tab assumes spaces are used as tab delimiters)*/
	replace; /*Replace the file if it already exists*/
	getnames=YES; /*Use first row as variable names (set to NO if first row doesn't contain variable names)*/
run;

 proc print data=Whitespruce;
 run;
 
/*Getting prediction and confidence intervals for specific values of x*/
proc reg data=Whitespruce;
  model Diameter=Height/ clb p clm cli alpha=0.10; /*clb:C.I.for beta1. p:predicted value. clm:C.I.for estimated mean. cli:P.I.for particular response.*/
run;

/*Prediction and estimation for values of x that are not in the data set*/
/*Create new observations*/
data whitespruce1;
	input Diameter Height;
	datalines;
	20 18.78
;
run;
	
/*Add whitespruce1 to Whitespruce*/
data whitespruce2;
	set Whitespruce whitespruce1;
run;

proc print data=whitespruce2;
run;

proc reg data=whitespruce2;
  model Diameter=Height/ clb p clm cli alpha=0.10;
run;