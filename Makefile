
all: 15_mers.txt

something.txt: 15_mers.txt
	Rscript create_epitope_predictions.R

15_mers.txt: 
	Rscript create_n_mers.R

