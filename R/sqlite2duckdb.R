sqlite2duckdb <- function(sqlite_db, duckdb_db){
  # Create connetion to sqlite
  conn_sqlite <- dbConnect(SQLite(), sqlite_db, extended_types = TRUE)
  
  # List tables
  tables <- dbListTables(conn = conn_sqlite)
  
  # Convert date fields from bigint unixepoch to date
  for(t in tables){
    dbExecute(conn_sqlite, glue("CREATE TABLE '{t}_2'(code_muni bigint, date varchar, name varchar, value float)"))
    dbExecute(conn_sqlite, glue("INSERT INTO '{t}_2' SELECT code_muni, strftime('%Y-%m-%d', date*24*60*60, 'unixepoch'), name, value FROM '{t}'"))
  }
  
  # Delete file if exist
  if(file.exists(duckdb_db)) unlink(duckdb_db)
  
  # Create connection
  conn_duckdb <- dbConnect(duckdb(), duckdb_db)
  
  # Load SQLite helpers
  dbExecute(conn_duckdb, "INSTALL sqlite;")
  dbExecute(conn_duckdb, "LOAD sqlite;")
  dbExecute(conn_duckdb, "SET GLOBAL sqlite_all_varchar=true;")
  
  # Transfer data from SQLite to DuckDB. 
  # All fields from SQLite were loaded as varchar, and type will be automatically
  # selected by DuckDB
  for(t in tables){
    dbExecute(conn_duckdb, glue("CREATE TABLE '{t}'(code_muni bigint, date date, name varchar, value float)"))
    dbExecute(conn_duckdb, glue("INSERT INTO '{t}' SELECT * FROM sqlite_scan('{sqlite_db}', '{t}_2');"))
    dbRemoveTable(conn_sqlite, glue("{t}_2"))
  }
  
  # Disconnect from sqlite
  dbDisconnect(conn_sqlite)
  
  # Disconnect from duckdb
  dbDisconnect(conn_duckdb, shutdown = TRUE)
  
  return(duckdb_db)
  
}