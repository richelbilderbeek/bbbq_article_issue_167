library(dplyr)

# Check input
for (n in c(9, 13, 15)) {
  source_filename <- paste0(n, "_mers.txt")
  testthat::expect_true(file.exists(source_filename))
}

for (n in c(9, 13, 15)) {
  message("n: ", n)
  source_filename <- paste0(n, "_mers.txt")
  testthat::expect_true(file.exists(source_filename))
  for (haplotype in bbbq::get_mhc1_haplotypes()) {
    message("haplotype: ", haplotype)
    target_filename <- paste0(
      n, "_",
      stringr::str_replace_all(haplotype, "[:|\\*]", "_"),
      "_predictions.csv"
    )
    target_filename


    t <- tibble::tibble(
      peptide = readr::read_lines(source_filename),
      ic50 = NA
    )

    if (1 == 2) {
      chunk_size <- 1000
      froms <- seq(1, nrow(t), by = chunk_size)
      tos <- froms + chunk_size - 1
      tos[length(tos)] <- nrow(t)
    } else {
      chunk_size <- 1
      froms <- seq(384742, 384742, by = chunk_size)
      tos <- froms + chunk_size - 1
      tos[length(tos)] <- nrow(t)

    # There is an error in 384001-385000
    # 742/1000( 384742-384742)
    }
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
