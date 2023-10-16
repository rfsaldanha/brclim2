
# Packages and options ----------------------------------------------------

### Load packages required to define the pipeline:
library(targets)
library(tarchetypes)
library(dplyr)
library(geobr)
library(sf)

### Set target options:
tar_option_set(
  packages = c("zonalclim"),
  format = "qs", 
  controller = crew::crew_controller_local(workers = 4)
)


### Run the R scripts in the R/ folder with your custom functions:
tar_source()


# Definitions -------------------------------------------------------------


# Municipalities geom
sf_geom <- read_municipality(simplified = TRUE) %>%
  st_transform(crs = 4326)

# Climate NetCDF file paths
files_2m_dewpoint_temperature <- list.files(
  path = "/media/raphael/lacie/era5land_daily_latin_america/2m_dewpoint_temperature/", 
  pattern = ".nc$",
  full.names = TRUE
)

files_2m_temperature_max <- list.files(
  path = "/media/raphael/lacie/era5land_daily_latin_america/2m_temperature_max/", 
  pattern = ".nc$",
  full.names = TRUE
)

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
  # List 2m max temp data
  tar_target(
    name = list_files_2m_temperature_max,
    command = files_2m_temperature_max,
    format = "file",
    cue = tar_cue(mode = "never")
  ),
  # Prepare max temp data
  # tar_target(
  #   name = max_temperature_data,
  #   command = prepare_climate_data(
  #     files_list = max_temperature_data_files,
  #     zonal_list <- c("mean"),
  #     db_file = "output_data/max_temperature.sqlite"
  #   ),
  #   format = "file"
  # )
)
