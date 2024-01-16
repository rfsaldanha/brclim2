library(magrittr)

mozambique_geom <- sf::read_sf("input_data/shapes_mocambique/Localidades.shp") %>%
  sf::st_make_valid() %>%
  sf::st_transform(crs = 4326) %>%
  dplyr::rename(code_muni = GID_3) %>%
  dplyr::mutate(code_muni = stringr::str_remove_all(code_muni, "MOZ")) %>%
  dplyr::mutate(code_muni = stringr::str_remove_all(code_muni, "[\\.]")) %>%
  dplyr::mutate(code_muni = stringr::str_remove_all(code_muni, "[\\_]"))

qs::qsave(x = mozambique_geom, file = "input_data/mozambique_geom.qs")

table(table(unique(mozambique_geom$code_muni)) > 1)
