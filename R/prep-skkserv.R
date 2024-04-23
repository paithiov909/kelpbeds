#' Prepare source MeCab SKKServ dictionary
#' @param dic_dir Directory to write dictionary files.
#' @returns `dic_dir` is returend invisibly.
#' @export
prep_skkserv <- function(dic_dir = tempdir()) {
  # Copy files
  file.copy(
    c(
      system.file("resources/skkserv/char.def", package = "kelpbeds"),
      system.file("resources/skkserv/unk.def", package = "kelpbeds"),
      system.file("resources/skkserv/dicrc", package = "kelpbeds")
    ),
    dic_dir,
    overwrite = TRUE
  )
  # Write csv file
  readr::write_csv(
    skkserv,
    file = file.path(dic_dir, "skkserv-all.csv"),
    na = "",
    col_names = FALSE,
    progress = FALSE
  )
  # Write matrix.def
  readr::write_lines(
    "1281 701",
    file = file.path(dic_dir, "matrix.def")
  )
  readr::write_delim(
    skkservmat,
    file.path(dic_dir, "matrix.def"),
    append = TRUE,
    progress = FALSE
  )

  invisible(dic_dir)
}
