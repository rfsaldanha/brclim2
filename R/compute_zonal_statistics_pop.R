# files_list <- files_2m_temperature_max
# sf_geom <- mun_geom
# zonal_list <- z1
# db_file <- tempfile()
# files_pop <- files_pop



compute_zonal_statistics <- function(files_list, sf_geom, zonal_list, db_file, files_pop){

  zonal_tasks_2000 <- zonalclim::create_zonal_tasks(
    nc_files_list = files_list[grepl("2000", files_list)],
    nc_chunk_size = 50,
    sf_geom = sf_geom,
    sf_chunck_size = 50,
    pop = files_pop[grepl("2000", files_pop)],
    zonal_functions = zonal_list
  )
  
  zonal_tasks_2001 <- zonalclim::create_zonal_tasks(
    nc_files_list = files_list[grepl("2001", files_list)],
    nc_chunk_size = 50,
    sf_geom = sf_geom,
    sf_chunck_size = 50,
    pop = files_pop[grepl("2001", files_pop)],
    zonal_functions = zonal_list
  )
  
  zonal_tasks <- dplyr::bind_rows(zonal_tasks_2000, zonal_tasks_2001)
  
  res <- zonalclim::compute_zonal_tasks(
    zonal_tasks = zonal_tasks,
    g_var = "code_muni",
    db_file = db_file
  )
  
  return(db_file)
}