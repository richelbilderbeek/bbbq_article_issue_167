all: 9_HLA-B_58_01_predictions.csv

9_HLA-B_58_01_predictions.csv: 15_mers.txt
	Rscript create_epitope_predictions.R

15_mers.txt: 
	Rscript create_n_mers.R

