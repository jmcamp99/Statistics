proc import out=gasturbine /* name to give dataset once imported into SAS */
	datafile="/home/u64313401/GASTURBINE.txt" /* location of txt file to import */
	/*dbms=dlm /*Format of file being imported (dlm assumes spaces are used as delimiters)*/
	dbms=tab /*Format of file being imported (tab assumes spaces are used as tab delimiters)*/
	replace; /*Replace the file if it already exists*/
	getnames=YES; /*Use first row as variable names (set to NO if first row doesn't contain variable names)*/
run;

 proc print data=gasturbine;
 run;
 
 proc reg data=gasturbine;
  model HEATRATE=INLET_TEMP EXH_TEMP AIRFLOW/p cli clm clb;
run;

data gasturbine2;
	set gasturbine;
	inletAirflow=INLET_TEMP*AIRFLOW;
	exhAirflow=EXH_TEMP*AIRFLOW;
run;

proc print data=gasturbine2;
run;

proc reg data=gasturbine2;
	model HEATRATE=INLET_TEMP EXH_TEMP AIRFLOW inletAirflow exhAirflow/p cli clm clb;
run;


proc import out=wafer /* name to give dataset once imported into SAS */
	datafile="/home/u64313401/WAFER.txt" /* location of txt file to import */
	/*dbms=dlm /*Format of file being imported (dlm assumes spaces are used as delimiters)*/
	dbms=tab /*Format of file being imported (tab assumes spaces are used as tab delimiters)*/
	replace; /*Replace the file if it already exists*/
	getnames=YES; /*Use first row as variable names (set to NO if first row doesn't contain variable names)*/
run;

 proc print data=wafer;
 run;
 
 proc reg data=wafer;
  model HEATRATE=INLET_TEMP EXH_TEMP AIRFLOW/p cli clm clb;
run;

proc sgplot data=wafer;
	scatter x=FAILTIME y=TEMP;
run;

data wafer2;
	set wafer;
	tempx2= TEMP ** 2;
run;

proc print data=wafer2;
run;

proc reg data=wafer2;
	model FAILTIME=TEMP TEMPx2/p cli clm clb;
run;