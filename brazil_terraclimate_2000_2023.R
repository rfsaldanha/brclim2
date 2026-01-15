# Packages and options ----------------------------------------------------

### Load packages required to define the pipeline:
library(targets)
library(tarchetypes)
library(qs)


### Set target options:
tar_option_set(
  packages = c("zonalclim", "DBI", "RSQLite", "duckdb", "glue"),
  format = "qs",
  controller = crew::crew_controller_local(workers = 2)
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
files_aet <- list.files(
  path = "input_data/terraclimate/aet/",
  pattern = ".nc$",
  full.names = TRUE
)

files_def <- list.files(
  path = "input_data/terraclimate/def/",
  pattern = ".nc$",
  full.names = TRUE
)

files_pdsi <- list.files(
  path = "input_data/terraclimate/pdsi/",
  pattern = ".nc$",
  full.names = TRUE
)

files_pet <- list.files(
  path = "input_data/terraclimate/pet/",
  pattern = ".nc$",
  full.names = TRUE
)

files_ppt <- list.files(
  path = "input_data/terraclimate/ppt/",
  pattern = ".nc$",
  full.names = TRUE
)

files_q <- list.files(
  path = "input_data/terraclimate/q/",
  pattern = ".nc$",
  full.names = TRUE
)

files_aet <- list.files(
  path = "input_data/terraclimate/aet/",
  pattern = ".nc$",
  full.names = TRUE
)

files_soil <- list.files(
  path = "input_data/terraclimate/soil/",
  pattern = ".nc$",
  full.names = TRUE
)

files_srad <- list.files(
  path = "input_data/terraclimate/srad/",
  pattern = ".nc$",
  full.names = TRUE
)

files_swe <- list.files(
  path = "input_data/terraclimate/swe/",
  pattern = ".nc$",
  full.names = TRUE
)

files_tmax <- list.files(
  path = "input_data/terraclimate/tmax/",
  pattern = ".nc$",
  full.names = TRUE
)

files_tmin <- list.files(
  path = "input_data/terraclimate/tmin/",
  pattern = ".nc$",
  full.names = TRUE
)

files_vap <- list.files(
  path = "input_data/terraclimate/vap/",
  pattern = ".nc$",
  full.names = TRUE
)

files_vpd <- list.files(
  path = "input_data/terraclimate/vpd/",
  pattern = ".nc$",
  full.names = TRUE
)

files_ws <- list.files(
  path = "input_data/terraclimate/ws/",
  pattern = ".nc$",
  full.names = TRUE
)


# Targets -----------------------------------------------------------------

list(
  ### aet
  tar_target(
    name = aet_data_sqlite,
    command = compute_zonal_statistics(
      files_list = files_aet,
      sf_geom = mun_geom,
      zonal_list <- z2,
      db_file = "output_data/terraclimate/aet_data.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = aet_data_duckdb,
    command = sqlite2duckdb(
      sqlite_db = aet_data_sqlite,
      duckdb_db = "output_data/terraclimate/aet_data.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = aet_data_parquet,
    command = duckdb2parquet(
      duckdb_db = aet_data_duckdb,
      parquet_path = "output_data/terraclimate/parquet/"
    ),
    format = "file"
  ),

  ### def
  tar_target(
    name = def_data_sqlite,
    command = compute_zonal_statistics(
      files_list = files_def,
      sf_geom = mun_geom,
      zonal_list <- z2,
      db_file = "output_data/terraclimate/def_data.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = def_data_duckdb,
    command = sqlite2duckdb(
      sqlite_db = def_data_sqlite,
      duckdb_db = "output_data/terraclimate/def_data.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = def_data_parquet,
    command = duckdb2parquet(
      duckdb_db = def_data_duckdb,
      parquet_path = "output_data/terraclimate/parquet/"
    ),
    format = "file"
  ),

  ### pdsi
  tar_target(
    name = pdsi_data_sqlite,
    command = compute_zonal_statistics(
      files_list = files_pdsi,
      sf_geom = mun_geom,
      zonal_list <- z1,
      db_file = "output_data/terraclimate/pdsi_data.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = pdsi_data_duckdb,
    command = sqlite2duckdb(
      sqlite_db = pdsi_data_sqlite,
      duckdb_db = "output_data/terraclimate/pdsi_data.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = pdsi_data_parquet,
    command = duckdb2parquet(
      duckdb_db = pdsi_data_duckdb,
      parquet_path = "output_data/terraclimate/parquet/"
    ),
    format = "file"
  ),

  ### pet
  tar_target(
    name = pet_data_sqlite,
    command = compute_zonal_statistics(
      files_list = files_pet,
      sf_geom = mun_geom,
      zonal_list <- z2,
      db_file = "output_data/terraclimate/pet_data.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = pet_data_duckdb,
    command = sqlite2duckdb(
      sqlite_db = pet_data_sqlite,
      duckdb_db = "output_data/terraclimate/pet_data.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = pet_data_parquet,
    command = duckdb2parquet(
      duckdb_db = pet_data_duckdb,
      parquet_path = "output_data/terraclimate/parquet/"
    ),
    format = "file"
  ),

  ### ppt
  tar_target(
    name = ppt_data_sqlite,
    command = compute_zonal_statistics(
      files_list = files_ppt,
      sf_geom = mun_geom,
      zonal_list <- z2,
      db_file = "output_data/terraclimate/ppt_data.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = ppt_data_duckdb,
    command = sqlite2duckdb(
      sqlite_db = ppt_data_sqlite,
      duckdb_db = "output_data/terraclimate/ppt_data.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = ppt_data_parquet,
    command = duckdb2parquet(
      duckdb_db = ppt_data_duckdb,
      parquet_path = "output_data/terraclimate/parquet/"
    ),
    format = "file"
  ),

  ### q
  tar_target(
    name = q_data_sqlite,
    command = compute_zonal_statistics(
      files_list = files_q,
      sf_geom = mun_geom,
      zonal_list <- z2,
      db_file = "output_data/terraclimate/q_data.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = q_data_duckdb,
    command = sqlite2duckdb(
      sqlite_db = q_data_sqlite,
      duckdb_db = "output_data/terraclimate/q_data.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = q_data_parquet,
    command = duckdb2parquet(
      duckdb_db = q_data_duckdb,
      parquet_path = "output_data/terraclimate/parquet/"
    ),
    format = "file"
  ),

  ### soil
  tar_target(
    name = soil_data_sqlite,
    command = compute_zonal_statistics(
      files_list = files_soil,
      sf_geom = mun_geom,
      zonal_list <- z2,
      db_file = "output_data/terraclimate/soil_data.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = soil_data_duckdb,
    command = sqlite2duckdb(
      sqlite_db = soil_data_sqlite,
      duckdb_db = "output_data/terraclimate/soil_data.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = soil_data_parquet,
    command = duckdb2parquet(
      duckdb_db = soil_data_duckdb,
      parquet_path = "output_data/terraclimate/parquet/"
    ),
    format = "file"
  ),

  ### srad
  tar_target(
    name = srad_data_sqlite,
    command = compute_zonal_statistics(
      files_list = files_srad,
      sf_geom = mun_geom,
      zonal_list <- z2,
      db_file = "output_data/terraclimate/srad_data.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = srad_data_duckdb,
    command = sqlite2duckdb(
      sqlite_db = srad_data_sqlite,
      duckdb_db = "output_data/terraclimate/srad_data.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = srad_data_parquet,
    command = duckdb2parquet(
      duckdb_db = srad_data_duckdb,
      parquet_path = "output_data/terraclimate/parquet/"
    ),
    format = "file"
  ),

  ### swe
  tar_target(
    name = swe_data_sqlite,
    command = compute_zonal_statistics(
      files_list = files_swe,
      sf_geom = mun_geom,
      zonal_list <- z2,
      db_file = "output_data/terraclimate/swe_data.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = swe_data_duckdb,
    command = sqlite2duckdb(
      sqlite_db = swe_data_sqlite,
      duckdb_db = "output_data/terraclimate/swe_data.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = swe_data_parquet,
    command = duckdb2parquet(
      duckdb_db = swe_data_duckdb,
      parquet_path = "output_data/terraclimate/parquet/"
    ),
    format = "file"
  ),

  ### tmax
  tar_target(
    name = tmax_data_sqlite,
    command = compute_zonal_statistics(
      files_list = files_tmax,
      sf_geom = mun_geom,
      zonal_list <- z1,
      db_file = "output_data/terraclimate/tmax_data.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = tmax_data_duckdb,
    command = sqlite2duckdb(
      sqlite_db = tmax_data_sqlite,
      duckdb_db = "output_data/terraclimate/tmax_data.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = tmax_data_parquet,
    command = duckdb2parquet(
      duckdb_db = tmax_data_duckdb,
      parquet_path = "output_data/terraclimate/parquet/"
    ),
    format = "file"
  ),

  ### tmin
  tar_target(
    name = tmin_data_sqlite,
    command = compute_zonal_statistics(
      files_list = files_tmin,
      sf_geom = mun_geom,
      zonal_list <- z1,
      db_file = "output_data/terraclimate/tmin_data.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = tmin_data_duckdb,
    command = sqlite2duckdb(
      sqlite_db = tmin_data_sqlite,
      duckdb_db = "output_data/terraclimate/tmin_data.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = tmin_data_parquet,
    command = duckdb2parquet(
      duckdb_db = tmin_data_duckdb,
      parquet_path = "output_data/terraclimate/parquet/"
    ),
    format = "file"
  ),

  ### vap
  tar_target(
    name = vap_data_sqlite,
    command = compute_zonal_statistics(
      files_list = files_vap,
      sf_geom = mun_geom,
      zonal_list <- z1,
      db_file = "output_data/terraclimate/vap_data.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = vap_data_duckdb,
    command = sqlite2duckdb(
      sqlite_db = vap_data_sqlite,
      duckdb_db = "output_data/terraclimate/vap_data.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = vap_data_parquet,
    command = duckdb2parquet(
      duckdb_db = vap_data_duckdb,
      parquet_path = "output_data/terraclimate/parquet/"
    ),
    format = "file"
  ),

  ### vpd
  tar_target(
    name = vpd_data_sqlite,
    command = compute_zonal_statistics(
      files_list = files_vpd,
      sf_geom = mun_geom,
      zonal_list <- z1,
      db_file = "output_data/terraclimate/vpd_data.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = vpd_data_duckdb,
    command = sqlite2duckdb(
      sqlite_db = vpd_data_sqlite,
      duckdb_db = "output_data/terraclimate/vpd_data.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = vpd_data_parquet,
    command = duckdb2parquet(
      duckdb_db = vpd_data_duckdb,
      parquet_path = "output_data/terraclimate/parquet/"
    ),
    format = "file"
  ),

  ### ws
  tar_target(
    name = ws_data_sqlite,
    command = compute_zonal_statistics(
      files_list = files_ws,
      sf_geom = mun_geom,
      zonal_list <- z1,
      db_file = "output_data/terraclimate/ws_data.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = ws_data_duckdb,
    command = sqlite2duckdb(
      sqlite_db = ws_data_sqlite,
      duckdb_db = "output_data/terraclimate/ws_data.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = ws_data_parquet,
    command = duckdb2parquet(
      duckdb_db = ws_data_duckdb,
      parquet_path = "output_data/terraclimate/parquet/"
    ),
    format = "file"
  )
)
