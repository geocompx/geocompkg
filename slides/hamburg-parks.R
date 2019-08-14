library(osmdata)
pa = opq(bbox = "hamburg")
parks2 = add_osm_feature(opq = pa, key = "leisure", value = "park") %>%
  osmdata_sf()

library(tmap)
tmap_mode("view")
qtm(parks2$osm_polygons)
