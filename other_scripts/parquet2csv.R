library(tidyverse)

arrow::open_dataset(sources = "output_data/mozambique/parquet/2m_temperature_max.parquet") %>%
  collect() %>%
  write_csv2(file = "output_data/mozambique/csv/2m_temperature_max.csv")

arrow::open_dataset(sources = "output_data/mozambique/parquet/2m_temperature_mean.parquet") %>%
  collect() %>%
  write_csv2(file = "output_data/mozambique/csv/2m_temperature_mean.csv")

arrow::open_dataset(sources = "output_data/mozambique/parquet/2m_temperature_min.parquet") %>%
  collect() %>%
  write_csv2(file = "output_data/mozambique/csv/2m_temperature_min.csv")

arrow::open_dataset(sources = "output_data/mozambique/parquet/total_precipitation_sum.parquet") %>%
  collect() %>%
  write_csv2(file = "output_data/mozambique/csv/total_precipitation_sum.csv")

###

arrow::open_dataset(sources = "output_data/chile/parquet/2m_temperature_max.parquet") %>%
  collect() %>%
  write_csv2(file = "output_data/chile/csv/2m_temperature_max.csv")

arrow::open_dataset(sources = "output_data/chile/parquet/2m_temperature_mean.parquet") %>%
  collect() %>%
  write_csv2(file = "output_data/chile/csv/2m_temperature_mean.csv")

arrow::open_dataset(sources = "output_data/chile/parquet/2m_temperature_min.parquet") %>%
  collect() %>%
  write_csv2(file = "output_data/chile/csv/2m_temperature_min.csv")

arrow::open_dataset(sources = "output_data/chile/parquet/total_precipitation_sum.parquet") %>%
  collect() %>%
  write_csv2(file = "output_data/chile/csv/total_precipitation_sum.csv")
