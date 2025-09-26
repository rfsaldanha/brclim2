library(dplyr)
library(tidyr)
library(lubridate)
library(arrow)
library(readr)


temp_max <- open_dataset(
  sources = c(
    "output_data/mozambique/parquet/1950_2022/2m_temperature_max.parquet",
    "output_data/mozambique/parquet/2023/2m_temperature_max.parquet",
    "output_data/mozambique/parquet/2024/2m_temperature_max.parquet"
  )
) |>
  filter(name == "2m_temperature_max_mean") |>
  filter(year(date) >= 2000) |>
  arrange(date) |>
  mutate(
    year = year(date),
    month = month(date),
    value = value - 273.15
  ) |>
  collect() |>
  group_by(code_muni, year, month) |>
  summarise(value = round(mean(value, na.rm = TRUE), 2)) |>
  ungroup() |>
  mutate(
    code_muni = as.character(code_muni),
    tipo = 3
  ) |>
  rename(cod = code_muni, ano = year, mes = month, valor = value) |>
  select(cod, ano, mes, tipo, valor) |>
  distinct()


temp_min <- open_dataset(
  sources = c(
    "output_data/mozambique/parquet/1950_2022/2m_temperature_min.parquet",
    "output_data/mozambique/parquet/2023/2m_temperature_min.parquet",
    "output_data/mozambique/parquet/2024/2m_temperature_min.parquet"
  )
) |>
  filter(name == "2m_temperature_min_mean") |>
  filter(year(date) >= 2000) |>
  arrange(date) |>
  mutate(
    year = year(date),
    month = month(date),
    value = value - 273.15
  ) |>
  collect() |>
  group_by(code_muni, year, month) |>
  summarise(value = round(mean(value, na.rm = TRUE), 2)) |>
  ungroup() |>
  mutate(
    code_muni = as.character(code_muni),
    tipo = 1
  ) |>
  rename(cod = code_muni, ano = year, mes = month, valor = value) |>
  select(cod, ano, mes, tipo, valor) |>
  distinct()


temp_mean <- open_dataset(
  sources = c(
    "output_data/mozambique/parquet/1950_2022/2m_temperature_mean.parquet",
    "output_data/mozambique/parquet/2023/2m_temperature_mean.parquet",
    "output_data/mozambique/parquet/2024/2m_temperature_mean.parquet"
  )
) |>
  filter(name == "2m_temperature_mean_mean") |>
  filter(year(date) >= 2000) |>
  arrange(date) |>
  mutate(
    year = year(date),
    month = month(date),
    value = value - 273.15
  ) |>
  collect() |>
  group_by(code_muni, year, month) |>
  summarise(value = round(mean(value, na.rm = TRUE), 2)) |>
  ungroup() |>
  mutate(
    code_muni = as.character(code_muni),
    tipo = 2
  ) |>
  rename(cod = code_muni, ano = year, mes = month, valor = value) |>
  select(cod, ano, mes, tipo, valor) |>
  distinct()

prec_mean <- open_dataset(
  sources = c(
    "output_data/mozambique/parquet/1950_2022/total_precipitation_sum.parquet",
    "output_data/mozambique/parquet/2023/total_precipitation_sum.parquet",
    "output_data/mozambique/parquet/2024/total_precipitation_sum.parquet"
  )
) |>
  filter(name == "total_precipitation_sum_mean") |>
  filter(year(date) >= 2000) |>
  arrange(date) |>
  mutate(
    year = year(date),
    month = month(date),
    value = value * 1e3
  ) |>
  collect() |>
  group_by(code_muni, year, month) |>
  summarise(value = round(sum(value, na.rm = TRUE), 2)) |>
  ungroup() |>
  mutate(
    code_muni = as.character(code_muni),
    tipo = 9
  ) |>
  rename(cod = code_muni, ano = year, mes = month, valor = value) |>
  select(cod, ano, mes, tipo, valor) |>
  distinct()

write_delim(
  x = bind_rows(temp_min, temp_mean, temp_max),
  file = "~/Downloads/temp_mozambique_2000_2024.csv",
  delim = ";",
  na = ""
)

write_delim(
  x = prec_mean,
  file = "~/Downloads/prec_mozambique_2000_2024.csv",
  delim = ";",
  na = ""
)
