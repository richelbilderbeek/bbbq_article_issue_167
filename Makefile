all: \
  covid_9_HLA-B_58_01_ic50_ep.csv

not_now: human_9_HLA-B_58_01_ic50_ep.csv

covid_9_HLA-B_58_01_ic50_ep.csv: covid_9_mers.txt
	Rscript create_epitope_predictions.R covid 9

covid_9_mers.txt: 
	Rscript create_n_mers.R covid 9

human_9_HLA-B_58_01_ic50_ep.csv: human_9_mers.txt
	Rscript create_epitope_predictions.R human 9

human_9_mers.txt: 
	Rscript create_n_mers.R human 9

