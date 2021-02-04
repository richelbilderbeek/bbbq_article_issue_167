library(dplyr, warn.conflicts = FALSE, quietly = TRUE)

args <- commandArgs(trailingOnly = TRUE)
message("args: {", paste0(args, collapse = ", "), "}")

if (1 == 2) {
  args <- c("covid", "9")
  args <- c("human", "9")
  args <- c("covid", "14")
  args <- c("covid", "15")
}
testthat::expect_equal(length(args), 2)
target_name <- args[1]
message("target_name: ", target_name)
bbbq::check_target_name(target_name)
n <- as.numeric(args[2])
message("n: ", n)
testthat::expect_true(n > 0)
testthat::expect_true(n < 30)

source_filename <- paste0(target_name, "_", n, "_mers.txt")
testthat::expect_true(file.exists(source_filename))

haplotypes <- NA
ic50_prediction_tool <- NA
if (n == 9) {
  ic50_prediction_tool <- "EpitopePrediction"
  haplotypes <- bbbq::get_mhc1_haplotypes()
} else {
  testthat::expect_true(n %in% c(14, 15))
  ic50_prediction_tool <- "mhcnuggetsr"
  # ic50_prediction_tool <- "netmhc2pan"
  haplotypes <- bbbq::get_mhc2_haplotypes()
}
bbbq::check_ic50_prediction_tool(ic50_prediction_tool)
message("ic50_prediction_tool: ", ic50_prediction_tool)
message("haplotypes: ", paste0(haplotypes, collapse = ", "))

for (haplotype in haplotypes) {
  message("haplotype: ", haplotype)
  target_filename <- paste0(
    target_name, "_",
    n, "_",
    stringr::str_replace_all(haplotype, "[:|/\\*]", "_"),
    "_ic50_",
    ic50_prediction_tool,
    ".csv"
  )
  message("target_filename: ", target_filename)
  if (file.exists(target_filename)) {
    message("File already exists, going to the next one")
    next
  }


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
    if (ic50_prediction_tool == "EpitopePrediction") {
      t$ic50[from:to] <- EpitopePrediction::smm(
        x = t$peptide[from:to],
        mhc = epiprepreds::to_ep_haplotype_name(haplotype)
      )
    } else if (ic50_prediction_tool == "mhcnuggetsr") {
      t$ic50[from:to] <- mhcnuggetsr::predict_ic50(
        mhcnuggets_options = mhcnuggetsr::create_mhcnuggets_options(
          mhc_class = NA, # Deduce automatically
          mhc = mhcnuggetsr::to_mhcnuggets_name(haplotype)
        ),
        peptides = t$peptide[from:to],
      )$ic50
    } else {
      testthat::expect_equal("netmhc2pan", ic50_prediction_tool)
      t$ic50[from:to] <- netmhc2pan::predict_ic50(
        peptides = t$peptide[from:to],
        mhc_haplotype = netmhc2pan::to_netmhc2pan_name(haplotype)
      )$ic50
    }
  }
  readr::write_csv(x = t, file = target_filename)
}
