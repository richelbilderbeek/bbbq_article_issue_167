library(dplyr)

# Check input
for (n in c(9)) {
  source_filename <- paste0(n, "_mers.txt")
  testthat::expect_true(file.exists(source_filename))
}

# EpitopePrediction only knows 9
for (n in c(9)) {
  message("n: ", n)
  source_filename <- paste0(n, "_mers.txt")
  testthat::expect_true(file.exists(source_filename))
  for (haplotype in bbbq::get_mhc1_haplotypes()) {
    message("haplotype: ", haplotype)
    target_filename <- paste0(
      n, "_",
      stringr::str_replace_all(haplotype, "[:|\\*]", "_"),
      "_ic50_ep.csv"
    )
    target_filename


    t <- tibble::tibble(
      peptide = readr::read_lines(source_filename),
      ic50 = NA
    )

    chunk_size <- 100000
    froms <- seq(1, nrow(t), by = chunk_size)
    tos <- froms + chunk_size - 1
    tos[length(tos)] <- nrow(t)
    testthat::expect_equal(length(froms), length(tos))

    for (i in seq_along(froms)) {
      from <- froms[i]
      to <- tos[i]
      message(i, "/", length(froms), " (", from, "-", to, ")")
      t$ic50[from:to] <- EpitopePrediction::smm(
        x = t$peptide[from:to],
        mhc = epiprepreds::to_ep_haplotype_name(haplotype)
      )
    }
    readr::write_csv(x = t, file = target_filename)
  }
}
