# ipadic
csv_files <-
  fs::dir_ls(
    here::here("../gibasa/mecab/ipadic-eucjp"),
    glob = "*.csv"
  )

ipadic <-
  readr::read_csv(
    csv_files,
    col_names = c("surface", "left_id", "right_id", "wcost", gibasa::get_dict_features("ipa")),
    col_types = "ciiiccccccccc",
    na = c(""),
    locale = readr::locale(encoding = "euc-jp")
  )

ipadicmat <-
  readr::read_delim(
    here::here("../gibasa/mecab/ipadic-eucjp/matrix.def"),
    skip = 1,
    col_names = c("right", "left", "cost"),
    col_types = "iii"
  )
# lobstr::obj_size(IPAdicMatrixDef)

usethis::use_data(
  ipadic,
  overwrite = TRUE,
  compress = "xz"
)

usethis::use_data(
  ipadicmat,
  overwrite = TRUE,
  compress = "xz"
)
