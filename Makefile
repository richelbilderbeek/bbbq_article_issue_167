
all: 15_HLA-A_01_01_predictions.csv

15_HLA-A_01_01_predictions.csv: 15_mers.txt
	Rscript create_epitope_predictions.R

15_mers.txt: 
	Rscript create_n_mers.R

