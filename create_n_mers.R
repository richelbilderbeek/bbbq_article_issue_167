# as in, n-mer: the number of amino acids
library(dplyr)

for (n in c(9, 13, 15)) {
  message("n: ", n)
  target_filename <- paste0(n, "_mers.txt")

  t_proteome_all <- bbbq::get_proteome(
    target_name = "human",
    proteome_type = "representative",
    keep_selenoproteins = FALSE
  )
  if (n == 9) testthat::expect_equal(nrow(t_proteome_all), 20575)

  # Remove all proteins that are shorter than the n-mers
  # For 9-mers, these are 7 proteins removed
  t_proteome <- t_proteome_all %>% filter(nchar(sequence) >= n)
  if (n == 9) testthat::expect_equal(nrow(t_proteome), 20575 - 7)

  tibbles <- list()
  for (i in seq_len(nrow(t_proteome))) {
    message(i, "/", nrow(t_proteome))
    tibbles[[i]] <- bbbq::create_n_mers(string = t_proteome$sequence[i], n)
  }
  all_n_mers <- unlist(tibbles)
  if (n == 9) testthat::expect_equal(length(all_n_mers), 11223087)
  unique_n_mers <- unique(all_n_mers)
  if (n == 9) testthat::expect_equal(length(unique_n_mers), 10390570)
  n_mers <- sort(unique_n_mers)
  if (n == 9) testthat::expect_equal(length(n_mers), 10390570)
  readr::write_lines(n_mers, target_filename)
}
