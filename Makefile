all: \
  covid_9_HLA-B_58_01_ic50_ep.csv

human: human_9_HLA-B_58_01_ic50_ep.csv

myco: myco_9_HLA-B_58_01_ic50_ep.csv

covid_9_HLA-B_58_01_ic50_ep.csv: covid_9_mers.txt
	Rscript create_epitope_predictions.R covid 9

covid_9_mers.txt: 
	Rscript create_n_mers.R covid 9

covid_15_mers.txt: 
	Rscript create_n_mers.R covid 15

human_9_HLA-B_58_01_ic50_ep.csv: human_9_mers.txt
	Rscript create_epitope_predictions.R human 9

human_9_mers.txt: 
	Rscript create_n_mers.R human 9

human_15_mers.txt: 
	Rscript create_n_mers.R human 15

myco_9_HLA-B_58_01_ic50_ep.csv: myco_9_mers.txt
	Rscript create_epitope_predictions.R myco 9

myco_9_mers.txt: 
	Rscript create_n_mers.R myco 9

myco_15_mers.txt: 
	Rscript create_n_mers.R myco 15

