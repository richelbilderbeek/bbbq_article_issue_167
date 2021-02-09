all: \
  covid_9_HLA-B_58_01_ic50_EpitopePrediction.csv \
  covid_12_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv \
  covid_13_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv \
  covid_14_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv \
  covid_15_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv

human: \
  human_9_HLA-B_58_01_ic50_EpitopePrediction.csv \
  human_12_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv \
  human_13_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv \
  human_14_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv \
  human_15_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv

myco: \
  myco_9_HLA-B_58_01_ic50_EpitopePrediction.csv \
  myco_12_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv \
  myco_13_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv \
  myco_14_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv \
  myco_15_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv

covid_9_HLA-B_58_01_ic50_EpitopePrediction.csv: covid_9_mers.txt
	Rscript create_epitope_predictions.R covid 9

covid_12_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv: covid_12_mers.txt
	Rscript create_epitope_predictions.R covid 12

covid_13_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv: covid_13_mers.txt
	Rscript create_epitope_predictions.R covid 13

covid_14_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv: covid_14_mers.txt
	Rscript create_epitope_predictions.R covid 14

covid_15_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv: covid_15_mers.txt
	Rscript create_epitope_predictions.R covid 15

covid_9_mers.txt: 
	Rscript create_n_mers.R covid 9

covid_12_mers.txt: 
	Rscript create_n_mers.R covid 12

covid_13_mers.txt: 
	Rscript create_n_mers.R covid 13

covid_14_mers.txt: 
	Rscript create_n_mers.R covid 14

covid_15_mers.txt: 
	Rscript create_n_mers.R covid 15

human_9_HLA-B_58_01_ic50_EpitopePrediction.csv: human_9_mers.txt
	Rscript create_epitope_predictions.R human 9

human_12_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv: human_12_mers.txt
	Rscript create_epitope_predictions.R human 12

human_13_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv: human_13_mers.txt
	Rscript create_epitope_predictions.R human 13

human_14_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv: human_14_mers.txt
	Rscript create_epitope_predictions.R human 14

human_15_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv: human_15_mers.txt
	Rscript create_epitope_predictions.R human 15

human_9_mers.txt: 
	Rscript create_n_mers.R human 9

human_12_mers.txt: 
	Rscript create_n_mers.R human 12

human_13_mers.txt: 
	Rscript create_n_mers.R human 13

human_14_mers.txt: 
	Rscript create_n_mers.R human 14

human_15_mers.txt: 
	Rscript create_n_mers.R human 15

myco_9_HLA-B_58_01_ic50_EpitopePrediction.csv: myco_9_mers.txt
	Rscript create_epitope_predictions.R myco 9

myco_12_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv: myco_12_mers.txt
	Rscript create_epitope_predictions.R myco 12

myco_13_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv: myco_13_mers.txt
	Rscript create_epitope_predictions.R myco 13

myco_14_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv: myco_14_mers.txt
	Rscript create_epitope_predictions.R myco 14

myco_15_HLA-DQA1_0102_DQB1_0602_ic50_mhcnuggetsr.csv: myco_15_mers.txt
	Rscript create_epitope_predictions.R myco 15

myco_9_mers.txt: 
	Rscript create_n_mers.R myco 9

myco_12_mers.txt: 
	Rscript create_n_mers.R myco 12

myco_13_mers.txt: 
	Rscript create_n_mers.R myco 13

myco_14_mers.txt: 
	Rscript create_n_mers.R myco 14

myco_15_mers.txt: 
	Rscript create_n_mers.R myco 15

