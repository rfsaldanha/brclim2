duckdb2parquet <- function(duckdb_db, parquet_path){
  # Database connection
  conn_duckdb <-  dbConnect(duckdb(), duckdb_db, read.only = TRUE)
  
  # List tables
  tables <- dbListTables(conn = conn_duckdb)
  
  for(t in tables){
    dbExecute(conn_duckdb, glue("COPY (SELECT * FROM '{t}') TO '{parquet_path}/{t}.parquet' (FORMAT 'PARQUET')"))
  }
  
  # Disconnect from duckdb
  dbDisconnect(conn_duckdb, shutdown = TRUE)
  
  return(parquet_path)
}