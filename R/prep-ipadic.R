#' Prepare source IPA dictionary
#' @param dic_dir Directory to write dictionary files.
#' @returns `dic_dir` is returend invisibly.
#' @export
prep_ipadic <- function(dic_dir = tempdir()) {
  # Copy files
  file.copy(
    c(
      system.file("resources/ipadic/char.def", package = "kelpbeds"),
      system.file("resources/ipadic/pos-id.def", package = "kelpbeds"),
      system.file("resources/ipadic/unk.def", package = "kelpbeds"),
      system.file("resources/ipadic/dicrc", package = "kelpbeds")
    ),
    dic_dir,
    overwrite = TRUE
  )
  # Write csv file
  readr::write_csv(
    kelpbeds::ipadic,
    file = file.path(dic_dir, "ipadic-all.csv"),
    na = "",
    col_names = FALSE,
    progress = FALSE
  )
  # Write matrix.def
  readr::write_lines(
    "1316 1316",
    file = file.path(dic_dir, "matrix.def")
  )
  readr::write_delim(
    kelpbeds::ipadicmat,
    file.path(dic_dir, "matrix.def"),
    append = TRUE,
    progress = FALSE
  )

  invisible(dic_dir)
}
