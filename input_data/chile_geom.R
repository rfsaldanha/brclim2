library(magrittr)

chile_geom <- sf::read_sf("input_data/shapes_chile/Datos_Geoestadisticos_Region_Provincia_SS_Comunas.shp") %>%
  sf::st_make_valid() %>%
  sf::st_transform(crs = 4326) %>%
  dplyr::select(code_muni = CUT_COM, name = COMUNA) %>%
  rmapshaper::ms_simplify(keep = 0.01, keep_shapes = TRUE)

sf::write_sf(chile_geom, "input_data/shapes_chile/Datos_Geoestadisticos_Region_Provincia_SS_Comunas_simp.shp")

qs::qsave(x = chile_geom, file = "input_data/chile_geom.qs")

table(table(unique(chile_geom$code_muni)) > 1)
