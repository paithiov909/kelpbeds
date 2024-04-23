# skkserv
# http://chasen.org/~taku/software/mecab-skkserv/
csv_files <-
  here::here("data-raw/mecab-skkserv/dic.csv")

temp <-
  readr::read_lines(
    here::here("data-raw/mecab-skkserv/dic.csv")
  ) |>
  iconv(from = "euc-jp", to = "utf-8") |>
  stringi::stri_remove_empty_na()

skkserv <-
  readr::read_csv(
    I(temp),
    col_names = c("surface", "left_if", "right_id", "wcost", "feat"),
    col_types = "ciiic",
    na = c("")
  )

# 1281 701
readr::read_lines(
  here::here("data-raw/mecab-skkserv/matrix.def"),
  n_max = 1
)

skkservmat <-
  readr::read_delim(
    here::here("data-raw/mecab-skkserv/matrix.def"),
    skip = 1,
    col_names = c("right", "left", "cost"),
    col_types = "iii"
  )

usethis::use_data(
  skkserv,
  overwrite = TRUE,
  compress = "xz"
)

usethis::use_data(
  skkservmat,
  overwrite = TRUE,
  compress = "xz"
)
