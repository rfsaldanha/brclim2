
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
mun_geom <- qread(file = "input_data/mun_geom.qs")

# Climate NetCDF file paths
files_2m_temperature_max <- list.files(
  path = "/media/raphael/lacie/era5land_daily_latin_america/2m_temperature_max/", 
  pattern = ".nc$",
  full.names = TRUE
)[1:10]

files_2m_temperature_min <- list.files(
  path = "/media/raphael/lacie/era5land_daily_latin_america/2m_temperature_min/", 
  pattern = ".nc$",
  full.names = TRUE
)

files_2m_temperature_mean <- list.files(
  path = "/media/raphael/lacie/era5land_daily_latin_america/2m_temperature_mean/", 
  pattern = ".nc$",
  full.names = TRUE
)

files_2m_dewpoint_temperature <- list.files(
  path = "/media/raphael/lacie/era5land_daily_latin_america/2m_dewpoint_temperature/", 
  pattern = ".nc$",
  full.names = TRUE
)

files_10m_u_component_of_wind <- list.files(
  path = "/media/raphael/lacie/era5land_daily_latin_america/10m_u_component_of_wind/", 
  pattern = ".nc$",
  full.names = TRUE
)

files_10m_v_component_of_wind <- list.files(
  path = "/media/raphael/lacie/era5land_daily_latin_america/10m_v_component_of_wind/", 
  pattern = ".nc$",
  full.names = TRUE
)

files_surface_pressure <- list.files(
  path = "/media/raphael/lacie/era5land_daily_latin_america/surface_pressure/", 
  pattern = ".nc$",
  full.names = TRUE
)

files_total_precipitation <- list.files(
  path = "/media/raphael/lacie/era5land_daily_latin_america/total_precipitation/", 
  pattern = ".nc$",
  full.names = TRUE
)



# Targets -----------------------------------------------------------------



# Replace the target list below with your own:
list(
  # List max temp data
  tar_target(
    name = list_files_2m_temperature_max,
    command = files_2m_temperature_max,
    format = "file",
    cue = tar_cue(mode = "never")
  ),
  # Compute max temp data
  tar_target(
    name = max_temperature_data_sqlite,
    command = compute_zonal_statistics(
      files_list = list_files_2m_temperature_max,
      sf_geom = mun_geom,
      zonal_list <- z1,
      db_file = "output_data/max_temperature_data.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  # Convert max temp data to duckdb
  tar_target(
    name = max_temperature_data_duckdb,
    command = sqlite2duckdb(
      sqlite_db = max_temperature_data_sqlite,
      duckdb_db = "output_data/max_temperature_data.duckdb"
    ),
    format = "file"
  ),
  # Convert max temp data to parquet
  tar_target(
    name = max_temperature_data_parquet,
    command = duckdb2parquet(
      duckdb_db = max_temperature_data_duckdb,
      parquet_path = "output_data/parquet/"
    ),
    format = "file"
  )
)
