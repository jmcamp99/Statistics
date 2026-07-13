data carvalue;
  input Size $	Price 	Cost_Mile	Road_Test_Score	Predicted_Reliability	Value_Score;
  datalines;
Small_Sedan  16.419  0.44  70  4  1.99
Small_Sedan  18.895  0.50  74  5  1.94
Small_Sedan  18.404  0.47  71  4  1.89
Small_Sedan  19.745  0.52  70  5  1.82
Small_Sedan  18.445  0.53  80  3  1.64
Small_Sedan  20.150  0.57  74  4  1.51
Small_Sedan  19.040  0.57  71  3  1.32
Small_Sedan  20.280  0.52  68  2  1.30
Small_Sedan  16.595  0.47  61  2  1.25
Small_Sedan  20.300  0.54  60  3  1.24
Small_Sedan  25.100  0.50  68  2  1.18
Small_Sedan  18.375  0.57  67  1  0.96
Small_Sedan  20.530  0.60  69  1  0.91
Family_Sedan  23.970  0.59  91  4  1.75
Family_Sedan  21.885  0.58  81  4  1.73
Family_Sedan  23.830  0.59  83  4  1.73
Family_Sedan  32.360  0.63  84  5  1.70
Family_Sedan  23.730  0.56  80  4  1.62
Family_Sedan  22.035  0.58  73  4  1.60
Family_Sedan  21.800  0.56  89  3  1.58
Family_Sedan  23.625  0.57  76  4  1.55
Family_Sedan  24.115  0.57  74  3  1.48
Family_Sedan  29.050  0.72  84  4  1.43
Family_Sedan  28.400  0.67  80  4  1.42
Family_Sedan  30.335  0.69  93  4  1.42
Family_Sedan  28.090  0.66  89  3  1.39
Family_Sedan  28.695  0.67  90  3  1.36
Family_Sedan  30.790  0.74  81  4  1.34
Family_Sedan  30.055  0.71  75  4  1.32
Family_Sedan  30.094  0.71  88  3  1.29
Family_Sedan  28.045  0.67  83  3  1.20
Family_Sedan  27.825  0.70  52  5  1.20
Family_Sedan  28.995  0.67  63  3  1.05
Upscale_Sedan  38.615  0.77  91  5  1.45
Upscale_Sedan  36.465  0.75  82  5  1.41
Upscale_Sedan  33.734  0.75  84  5  1.40
Upscale_Sedan  34.225  0.73  86  4  1.37
Upscale_Sedan  38.939  0.75  83  4  1.36
Upscale_Sedan  29.675  0.67  84  3  1.35
Upscale_Sedan  37.225  0.79  95  4  1.33
Upscale_Sedan  35.485  0.73  86  3  1.27
Upscale_Sedan  39.850  0.78  92  3  1.22
Upscale_Sedan  35.100  0.76  77  4  1.18
Upscale_Sedan  33.700  0.78  83  3  1.17
Upscale_Sedan  28.840  0.65  77  2  1.14
Upscale_Sedan  37.160  0.80  77  4  1.12
Upscale_Sedan  39.175  0.79  77  3  1.10
Upscale_Sedan  35.895  0.76  76  3  1.08
Upscale_Sedan  34.980  0.78  73  3  1.07
Upscale_Sedan  32.135  0.71  79  2  1.06
Upscale_Sedan  37.325  0.83  77  3  1.04
Upscale_Sedan  32.680  0.73  82  2  1.04
Upscale_Sedan  31.615  0.70  69  3  1.00
Upscale_Sedan  37.555  0.81  74  2  0.82
;
run;

/*proc reg data=carvalue;
  Forward: model Value_Score=Price Cost_Mile Road_Test_Score Predicted_Reliability/selection=forward DETAILS=SUMMARY SLENTRY=0.10 SLSTAY=0.10;
  Backward: model Value_Score=Price Cost_Mile Road_Test_Score Predicted_Reliability/selection=backward DETAILS=SUMMARY SLENTRY=0.10 SLSTAY=0.10;
  Stepwise: model Value_Score=Price Cost_Mile Road_Test_Score Predicted_Reliability/selection=stepwise DETAILS=SUMMARY SLENTRY=0.10 SLSTAY=0.10;
  Rsquaradjust: model Value_Score=Price Cost_Mile Road_Test_Score Predicted_Reliability/selection=adjrsq cp aic bic sbc  best=6;
  cp: model Value_Score=Price Cost_Mile Road_Test_Score Predicted_Reliability/selection=cp adjrsq aic bic sbc best=6;
run;

proc reg data=carvalue;
  model Value_Score=Road_Test_Score Predicted_Reliability/ p cli clm clb;
  output out=pred_results
		p=predicted_value
		r=residual;
run; */

proc reg data=carvalue;
  model Value_Score=Cost_Mile Road_Test_Score Predicted_Reliability/dw;
  output out=pred_results
		p=predicted_value
		r=residual;
run;

 proc reg data=carvalue;
  model Value_Score=Cost_Mile Road_Test_Score Predicted_Reliability/influence R;
  output out=analysis student=strsid h=lever rstudent=stdelres cookd=cooksdis ;
run;

proc print data=analysis;
run; 

data carvalue2;
	set carvalue;
	RTS_PR=Road_Test_Score*Predicted_Reliability;
run;

proc reg data=carvalue2;
  model Value_Score=Road_Test_Score Predicted_Reliability RTS_PR/ p cli clm clb;
run;


