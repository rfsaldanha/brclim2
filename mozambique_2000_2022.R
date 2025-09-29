# Packages and options ----------------------------------------------------

### Load packages required to define the pipeline:
library(targets)
library(tarchetypes)
library(qs)


### Set target options:
tar_option_set(
  packages = c("zonalclim", "DBI", "RSQLite", "duckdb", "glue"),
  format = "qs",
  controller = crew::crew_controller_local(workers = 4)
)


### Run the R scripts in the R/ folder with your custom functions:
tar_source()


# Definitions -------------------------------------------------------------

# Zonal statistics sets
z1 <- c("mean", "max", "min", "stdev", "count")
z2 <- c("mean", "max", "min", "stdev", "sum", "count")

# Municipalities geom
mun_geom <- qread(file = "input_data/mozambique_geom.qs")

# Climate NetCDF file paths
files_2m_temperature_max <- list.files(
  path = "/media/raphaelsaldanha/lacie/era5land_daily_africa/2m_temperature_max/2000_2022/",
  pattern = ".nc$",
  full.names = TRUE
)

files_2m_temperature_min <- list.files(
  path = "/media/raphaelsaldanha/lacie/era5land_daily_africa/2m_temperature_min/2000_2022/",
  pattern = ".nc$",
  full.names = TRUE
)

files_2m_temperature_mean <- list.files(
  path = "/media/raphaelsaldanha/lacie/era5land_daily_africa/2m_temperature_mean/2000_2022/",
  pattern = ".nc$",
  full.names = TRUE
)

files_total_precipitation <- list.files(
  path = "/media/raphaelsaldanha/lacie/era5land_daily_africa/total_precipitation/2000_2022/",
  pattern = ".nc$",
  full.names = TRUE
)


# Targets -----------------------------------------------------------------

# Replace the target list below with your own:
list(
  ### Max temp
  tar_target(
    name = max_temperature_data_sqlite,
    command = compute_zonal_statistics(
      files_list = files_2m_temperature_max,
      sf_geom = mun_geom,
      zonal_list <- z1,
      db_file = "output_data/mozambique/max_temperature_data.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = max_temperature_data_duckdb,
    command = sqlite2duckdb(
      sqlite_db = max_temperature_data_sqlite,
      duckdb_db = "output_data/mozambique/max_temperature_data.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = max_temperature_data_parquet,
    command = duckdb2parquet(
      duckdb_db = max_temperature_data_duckdb,
      parquet_path = "output_data/mozambique/parquet/"
    ),
    format = "file"
  ),

  ### Min temp
  tar_target(
    name = min_temperature_data_sqlite,
    command = compute_zonal_statistics(
      files_list = files_2m_temperature_min,
      sf_geom = mun_geom,
      zonal_list <- z1,
      db_file = "output_data/mozambique/min_temperature_data.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = min_temperature_data_duckdb,
    command = sqlite2duckdb(
      sqlite_db = min_temperature_data_sqlite,
      duckdb_db = "output_data/mozambique/min_temperature_data.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = min_temperature_data_parquet,
    command = duckdb2parquet(
      duckdb_db = min_temperature_data_duckdb,
      parquet_path = "output_data/mozambique/parquet/"
    ),
    format = "file"
  ),

  ### Mean temp
  tar_target(
    name = mean_temperature_data_sqlite,
    command = compute_zonal_statistics(
      files_list = files_2m_temperature_mean,
      sf_geom = mun_geom,
      zonal_list <- z1,
      db_file = "output_data/mozambique/mean_temperature_data.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = mean_temperature_data_duckdb,
    command = sqlite2duckdb(
      sqlite_db = mean_temperature_data_sqlite,
      duckdb_db = "output_data/mozambique/mean_temperature_data.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = mean_temperature_data_parquet,
    command = duckdb2parquet(
      duckdb_db = mean_temperature_data_duckdb,
      parquet_path = "output_data/mozambique/parquet/"
    ),
    format = "file"
  ),

  ### total precipitation
  tar_target(
    name = total_precipitation_data_sqlite,
    command = compute_zonal_statistics(
      files_list = files_total_precipitation,
      sf_geom = mun_geom,
      zonal_list <- z2,
      db_file = "output_data/mozambique/total_precipitation_data.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = total_precipitation_data_duckdb,
    command = sqlite2duckdb(
      sqlite_db = total_precipitation_data_sqlite,
      duckdb_db = "output_data/mozambique/total_precipitation_data.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = total_precipitation_data_parquet,
    command = duckdb2parquet(
      duckdb_db = total_precipitation_data_duckdb,
      parquet_path = "output_data/mozambique/parquet/"
    ),
    format = "file"
  )
)
