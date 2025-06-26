br_1950_2022 <- zendown::zen_file(10036212, "2m_temperature_max.parquet") |>
  arrow::open_dataset()

br_2023 <- zendown::zen_file(10947952, "2m_temperature_max.parquet") |>
  arrow::open_dataset()

br_2024 <- arrow::open_dataset(
  "/mnt/data/onedrive/projetos/brclim2/output_data/brazil/data_2024/parquet/2m_temperature_max.parquet"
)

df1 <- br_1950_2022 |>
  dplyr::filter(code_muni == 3136702) |>
  dplyr::filter(name == "2m_temperature_max_mean") |>
  # head() |>
  dplyr::collect()

df2 <- br_2023 |>
  dplyr::filter(code_muni == 3136702) |>
  dplyr::filter(name == "2m_temperature_max_mean") |>
  # head() |>
  dplyr::collect()

df3 <- br_2024 |>
  dplyr::filter(code_muni == 3136702) |>
  dplyr::filter(name == "2m_temperature_max_mean") |>
  # head() |>
  dplyr::collect()

library(ggplot2)

dplyr::bind_rows(df2, df3) |>
  ggplot(aes(x = date, y = value)) +
  geom_line() +
  geom_smooth()
