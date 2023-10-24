compute_zonal_statistics <- function(files_list, sf_geom, zonal_list, db_file){

  zonal_tasks <- zonalclim::create_zonal_tasks(
    nc_files_list = files_list,
    nc_chunk_size = 500,
    sf_geom = sf_geom,
    sf_chunck_size = 500,
    zonal_functions = zonal_list
  )
  
  res <- zonalclim::compute_zonal_tasks(
    zonal_tasks = zonal_tasks,
    g_var = "code_muni",
    db_file = db_file
  )
  
  return(db_file)
}