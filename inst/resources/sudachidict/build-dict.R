# 使い方 ----
# 1. このファイルがあるディレクトリにSudachiDictのCSVファイルを配置します
# 2. `src`ディレクトリにSudachiDictのmatrix.defを配置します
# 3. このスクリプトを実行すると、`build`ディレクトリに辞書を作成します
#
# 参考 ----
# https://github.com/WorksApplications/SudachiDict

stopifnot(
  requireNamespace("this.path", quietly = TRUE),
  requireNamespace("fs", quietly = TRUE),
  requireNamespace("readr", quietly = TRUE),
  requireNamespace("dplyr", quietly = TRUE),
  requireNamespace("gibasa", quietly = TRUE)
)

csv_files <-
  fs::dir_ls(
    this.path::this.dir(),
    glob = "*.csv"
  )

# https://github.com/WorksApplications/Sudachi/blob/develop/docs/user_dict.md
col_names <-
  c(
    "trie_form",
    "left_id",
    "right_id",
    "wcost",
    "surface_form",
    "pos1",
    "pos2",
    "pos3",
    "pos4",
    "ctype",
    "cform",
    "reading",
    "normalized",
    "dic_form_id",
    "seg_type",
    "info1",
    "info2",
    "info3",
    "info4"
  )

df <-
  readr::read_csv(
    csv_files,
    col_names = col_names,
    col_types = "ciiiccccccccc_c____"
  ) |>
  dplyr::filter(
    left_id != -1,
    right_id != -1,
    seg_type == "A"
  ) |>
  dplyr::select(
    "trie_form",
    "left_id",
    "right_id",
    "wcost",
    "pos1",
    "pos2",
    "pos3",
    "pos4",
    "ctype",
    "cform",
    "surface_form",
    "normalized",
    "reading"
    # "seg_type"
  )

readr::write_csv(
  df,
  file.path(this.path::this.dir(), "src/all.csv"),
  na = "　", # 空白,pos_id=5967
  col_names = FALSE
)

fs::dir_create(
  file.path(this.path::this.dir(), "build")
)

gibasa::build_sys_dic(
  file.path(this.path::this.dir(), "src"),
  file.path(this.path::this.dir(), "build"),
  "UTF-8"
)

file.copy(
  file.path(this.path::this.dir(), "src/dicrc"),
  file.path(this.path::this.dir(), "build/dicrc"),
  overwrite = TRUE
)
