br_1950_2022 <- zendown::zen_file(
  10036212,
  "10m_u_component_of_wind_mean.parquet"
) |>
  arrow::open_dataset()

br_2023 <- zendown::zen_file(
  10947952,
  "10m_u_component_of_wind_mean.parquet"
) |>
  arrow::open_dataset()

br_2024 <- arrow::open_dataset(
  "/mnt/data/onedrive/projetos/brclim2/output_data/brazil/data_2024/parquet/10m_u_component_of_wind_mean.parquet"
)

br_2024 |>
  head() |>
  dplyr::collect()

df1 <- br_1950_2022 |>
  dplyr::filter(code_muni == 3136702) |>
  dplyr::filter(name == "10m_u_component_of_wind_mean_mean") |>
  # head() |>
  dplyr::collect()

df2 <- br_2023 |>
  dplyr::filter(code_muni == 3136702) |>
  dplyr::filter(name == "10m_u_component_of_wind_mean_mean") |>
  # head() |>
  dplyr::collect()

df3 <- br_2024 |>
  dplyr::filter(code_muni == 3136702) |>
  dplyr::filter(name == "10m_u_component_of_wind_mean_mean") |>
  # head() |>
  dplyr::collect()

library(ggplot2)

dplyr::bind_rows(df2, df3) |>
  ggplot(aes(x = date, y = value)) +
  geom_line() +
  geom_smooth()


con <- DBI::dbConnect(
  RSQLite::SQLite(),
  "output_data/brazil/data_2024/u_component_of_wind_data.sqlite"
)
DBI::dbListTables(con)


u2023 <- terra::rast(
  "/media/raphaelsaldanha/lacie/era5land_daily_latin_america/data_2023/10m_u_component_of_wind/10m_u_component_of_wind_2023-01-01_2023-01-31_day_mean.nc"
)

u2024 <- terra::rast(
  "/media/raphaelsaldanha/lacie/era5land_daily_latin_america/data_2024/10m_u_component_of_wind/10m_u_component_of_wind_2024-07-01_2024-07-31_day_mean.nc"
)

u2024b <- terra::rast(
  "../era5daily/latin_america/data/10m_u_component_of_wind_2024-09-01_2024-09-30_day_mean.nc"
)

names(u2023)
names(u2024)
names(u2024b)
