# as in, n-mer: the number of amino acids
library(dplyr, warn.conflicts = FALSE, quietly = TRUE)

args <- commandArgs(trailingOnly = TRUE)
message("args: {", paste0(args, collapse = ", "), "}")

if (1 == 2) {
  args <- c("covid", "9")
  args <- c("human", "9")
}
testthat::expect_equal(length(args), 2)
target_name <- args[1]
message("target_name: ", target_name)
bbbq::check_target_name(target_name)
n <- as.numeric(args[2])
message("n: ", n)
testthat::expect_true(n %in% c(9, 11, 13, 15))

target_filename <- paste0(target_name, "_", n, "_mers.txt")
message("target_filename: ", target_filename)

proteome_type <- NA
if (target_name == "human") {
  proteome_type <- "representative"
} else {
  proteome_type <- "full"
}

t_proteome_all <- bbbq::get_proteome(
  target_name = target_name,
  proteome_type = proteome_type,
  keep_selenoproteins = FALSE
)
if (target_name == "covid" && n == 9) testthat::expect_equal(nrow(t_proteome_all), 14)
if (target_name == "human" && n == 9) testthat::expect_equal(nrow(t_proteome_all), 20575)

# Remove all proteins that are shorter than the n-mers
# In humans, For 9-mers, these are 7 proteins removed
t_proteome <- t_proteome_all %>% filter(nchar(sequence) >= n)
if (target_name == "covid" && n == 9) testthat::expect_equal(nrow(t_proteome), 14 - 0)
if (target_name == "human" && n == 9) testthat::expect_equal(nrow(t_proteome), 20575 - 7)

tibbles <- list()
for (i in seq_len(nrow(t_proteome))) {
  message(i, "/", nrow(t_proteome))
  tibbles[[i]] <- bbbq::create_n_mers(string = t_proteome$sequence[i], n)
}
all_n_mers <- unlist(tibbles)
if (target_name == "human" && n == 9) testthat::expect_equal(length(all_n_mers), 11223087)
if (target_name == "covid" && n == 9) testthat::expect_equal(length(all_n_mers), 14207)
unique_n_mers <- unique(all_n_mers)
if (target_name == "covid" && n == 9) testthat::expect_equal(length(unique_n_mers), 9814)
if (target_name == "human" && n == 9) testthat::expect_equal(length(unique_n_mers), 10390570)
# Must all be amino acids
# ALQXPAPWS breaks
regexpr <- paste0("^[", paste0(Peptides::aaList(), collapse = ""), "]+$")
unique_good_n_mers <- stringr::str_subset(unique_n_mers, regexpr)
if (target_name == "covid" && n == 9) testthat::expect_equal(length(unique_good_n_mers), 9814)
if (target_name == "human" && n == 9) testthat::expect_equal(length(unique_good_n_mers), 10390489)
n_mers <- sort(unique_good_n_mers)
if (target_name == "covid" && n == 9) testthat::expect_equal(length(n_mers), 9814)
if (target_name == "human" && n == 9) testthat::expect_equal(length(n_mers), 10390489)
readr::write_lines(n_mers, target_filename)
