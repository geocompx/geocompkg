# Code demonstrating how to answer questions arisng during the course

# - Find the slides here:
# https://github.com/geocompr/geocompkg/tree/master/slides

# Agenda:


# Intro + R's spatial ecosystem: (10:00 - 10:30)
#         See section 1.4 of Geocomputation with R
#     Working with attribute data (10:30 - 11:00)
#         Section 3.2 of handouts
#
# Coffee break: (11:00 - 11:15)
#
#     Spatial data and the tidyverse lecture (11:15 - 11:30)
#     Vector data classes
#         Online tutorial: 2.1 of Geocomputation with R (11:30 - 12:00)
#
#     Raster data classes and functions lecture (12:00 - 12:15)
#         Online tutorial: 2.2 of Geocomputation with R
#
#     Practical working (12:15 - 13:00):
#         Working-through code and Exercises in Chapter 2 of 'geocompr'
#         Identify pitfalls of tidyverse
#
# LUNCH and discussing at your data (13:00 - 14:00)

plot(1:4)

library(sf)
library(tidyverse)

library(osmdata)
cardiff = getbb("cardiff, uk", format_out = "sf_polygon")
mapview::mapview(cardiff)
library(spData)
class(nz)
head(nz)
n = nz
plot(n)

plot[nz]

# with pythonic set
# [1, 2, 4]
x = c(1, 2, 4)
dim(x)
x[3]
nz[3, ]
dim(nz)
x_array = array(dim = c(3, 3, 3))
x_array[ 1, 2, 3]
`[`(x, 3)
sum2 = function(x, y) {
  res = sum(x, y)
  res
}
y = 4:5
x
sum2(x, y)

# create points from x y data
st_centroid(cardiff)
x_random = rnorm(n = 1000, mean = -3.2, sd = 0.1)
y_random = rnorm(n = 1000, mean = 51.5, sd = 0.1)
plot(x_random, y_random)
library(leaflet)
leaflet() %>%
  addTiles() %>%
  addCircles(lng = x_random, lat = y_random)

class(x_random)
x_df = data.frame(
  x = x_random,
  y = y_random,
  z = 1:length(x_random)
)
class(x_df)
x_sf = st_as_sf(x_df, coords = c("x", "y"))
class(x_sf)
st_crs(x_sf)
st_crs(x_sf) = 4326
mapview::mapview(x_sf)
x_sf_cardiff = x_sf[cardiff, ]
mapview::mapview(x_sf_cardiff)
nrow(x_sf)
nrow(x_sf_cardiff)
x_osbg = st_transform(x_sf, 27700)

# remember to ask: what crs is this data in?
# see: https://geocompr.robinlovelace.net/reproj-geo-data.html
# how to find basemaps
leaflet::providers$OpenStreetMap.Mapnik

# tip: use Ctl-Shift-F for global search

# viz chapter: https://geocompr.robinlovelace.net/adv-map.html
# link for feedback:
# https://www.jumpingrivers.com/q/rss.html
