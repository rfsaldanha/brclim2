
# Packages and options ----------------------------------------------------

### Load packages required to define the pipeline:
library(targets)
library(tarchetypes)
library(qs)


### Set target options:
tar_option_set(
  packages = c("zonalclim", "DBI", "RSQLite", "duckdb", "glue"),
  format = "qs", 
  controller = crew::crew_controller_local(workers = 1)
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
files_eto <- list.files(
  path = "/media/raphael/lacie/brdwgd/20240320/eto/", 
  pattern = ".nc$",
  full.names = TRUE
)

files_pr <- list.files(
  path = "/media/raphael/lacie/brdwgd/20240320/pr/", 
  pattern = ".nc$",
  full.names = TRUE
)

files_rh <- list.files(
  path = "/media/raphael/lacie/brdwgd/20240320/rh/", 
  pattern = ".nc$",
  full.names = TRUE
)

files_rs <- list.files(
  path = "/media/raphael/lacie/brdwgd/20240320/rs/", 
  pattern = ".nc$",
  full.names = TRUE
)

files_tmax <- list.files(
  path = "/media/raphael/lacie/brdwgd/20240320/tmax/", 
  pattern = ".nc$",
  full.names = TRUE
)

files_tmin <- list.files(
  path = "/media/raphael/lacie/brdwgd/20240320/tmin/", 
  pattern = ".nc$",
  full.names = TRUE
)

files_u2 <- list.files(
  path = "/media/raphael/lacie/brdwgd/20240320/u2/", 
  pattern = ".nc$",
  full.names = TRUE
)
# Targets -----------------------------------------------------------------



# Replace the target list below with your own:
list(
  ### eto
  tar_target(
    name = eto_sqlite,
    command = compute_zonal_statistics(
      files_list = files_eto,
      sf_geom = mun_geom,
      zonal_list <- z1,
      db_file = "output_data/brdwgd/eto.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = eto_duckdb,
    command = sqlite2duckdb(
      sqlite_db = eto_sqlite,
      duckdb_db = "output_data/brdwgd/eto.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = eto_parquet,
    command = duckdb2parquet(
      duckdb_db = eto_duckdb,
      parquet_path = "output_data/brdwgd/parquet/"
    ),
    format = "file"
  ),

  ### pr
  tar_target(
    name = pr_sqlite,
    command = compute_zonal_statistics(
      files_list = files_pr,
      sf_geom = mun_geom,
      zonal_list <- z2,
      db_file = "output_data/brdwgd/pr.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = pr_duckdb,
    command = sqlite2duckdb(
      sqlite_db = pr_sqlite,
      duckdb_db = "output_data/brdwgd/pr.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = pr_parquet,
    command = duckdb2parquet(
      duckdb_db = pr_duckdb,
      parquet_path = "output_data/brdwgd/parquet/"
    ),
    format = "file"
  ),
  
  ### rh
  tar_target(
    name = rh_sqlite,
    command = compute_zonal_statistics(
      files_list = files_rh,
      sf_geom = mun_geom,
      zonal_list <- z1,
      db_file = "output_data/brdwgd/rh.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = rh_duckdb,
    command = sqlite2duckdb(
      sqlite_db = rh_sqlite,
      duckdb_db = "output_data/brdwgd/rh.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = rh_parquet,
    command = duckdb2parquet(
      duckdb_db = rh_duckdb,
      parquet_path = "output_data/brdwgd/parquet/"
    ),
    format = "file"
  ),

  ### rs
  tar_target(
    name = rs_sqlite,
    command = compute_zonal_statistics(
      files_list = files_rs,
      sf_geom = mun_geom,
      zonal_list <- z1,
      db_file = "output_data/brdwgd/rs.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = rs_duckdb,
    command = sqlite2duckdb(
      sqlite_db = rs_sqlite,
      duckdb_db = "output_data/brdwgd/rs.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = rs_parquet,
    command = duckdb2parquet(
      duckdb_db = rs_duckdb,
      parquet_path = "output_data/brdwgd/parquet/"
    ),
    format = "file"
  ),

  ### tmax
  tar_target(
    name = tmax_sqlite,
    command = compute_zonal_statistics(
      files_list = files_tmax,
      sf_geom = mun_geom,
      zonal_list <- z1,
      db_file = "output_data/brdwgd/tmax.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = tmax_duckdb,
    command = sqlite2duckdb(
      sqlite_db = tmax_sqlite,
      duckdb_db = "output_data/brdwgd/tmax.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = tmax_parquet,
    command = duckdb2parquet(
      duckdb_db = tmax_duckdb,
      parquet_path = "output_data/brdwgd/parquet/"
    ),
    format = "file"
  ),

  ### tmin
  tar_target(
    name = tmin_sqlite,
    command = compute_zonal_statistics(
      files_list = files_tmin,
      sf_geom = mun_geom,
      zonal_list <- z1,
      db_file = "output_data/brdwgd/tmin.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = tmin_duckdb,
    command = sqlite2duckdb(
      sqlite_db = tmin_sqlite,
      duckdb_db = "output_data/brdwgd/tmin.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = tmin_parquet,
    command = duckdb2parquet(
      duckdb_db = tmin_duckdb,
      parquet_path = "output_data/brdwgd/parquet/"
    ),
    format = "file"
  ),

  ### u2
  tar_target(
    name = u2_sqlite,
    command = compute_zonal_statistics(
      files_list = files_u2,
      sf_geom = mun_geom,
      zonal_list <- z1,
      db_file = "output_data/brdwgd/u2.sqlite"
    ),
    format = "file",
    cue = tar_cue(file = FALSE)
  ),
  tar_target(
    name = u2_duckdb,
    command = sqlite2duckdb(
      sqlite_db = u2_sqlite,
      duckdb_db = "output_data/brdwgd/u2.duckdb"
    ),
    format = "file"
  ),
  tar_target(
    name = u2_parquet,
    command = duckdb2parquet(
      duckdb_db = u2_duckdb,
      parquet_path = "output_data/brdwgd/parquet/"
    ),
    format = "file"
  )
  
  
)
