#' Prepare directory for building 'Sudachi' dictionary
#' @param dir Directory to write dictionary files.
#' @returns `file.path(dir, "sudachidict")` is returend invisibly.
#' @export
prep_sudachidict <- function(dir = tempdir()) {
  file.copy(
    system.file("resources/sudachidict", package = "kelpbeds"),
    dir,
    recursive = TRUE
  )
  invisible(file.path(dir, "sudachidict"))
}
