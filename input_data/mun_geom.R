library(magrittr)

mun_geom <- geobr::read_municipality(simplified = TRUE) %>%
  sf::st_transform(crs = 4326)

qs::qsave(x = mun_geom, file = "input_data/mun_geom.qs")
