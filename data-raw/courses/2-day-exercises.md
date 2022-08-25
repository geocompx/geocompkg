Geocomputation with: R Practical Exercises
================

These practicals aim to test your knowledge and improve your skills in
relation to the 2 day Geocomputation with R course, hosted at
<https://git.io/geocompr-2-day-course>

It will use the following CRAN packages:

``` r
library(dplyr)
library(osmdata)
library(pct)
library(sf)
library(tmap)
library(mapview)
```

# Project set-up

  - Check your packages are up-to-date with `update.packages()`
  - Create an RStudio project with an appropriate name for this course
    (e.g. `geo2day`)
  - Create a script called `set-up.R`, e.g. with the following command:

<!-- end list -->

``` r
file.edit("set-up.R") 
```

  - Create a data frame representing coffee consumption across the
    country as follows (note: this may not be representative):

<!-- end list -->

``` r
person_name = c("arron", "bob", "carl")
n_coffee = c(5, 1, 0)
likes_herbal_tea = c(TRUE, FALSE, TRUE)
home_region = c("west-yorkshire", "avon", "london")
coffee = tibble::tibble(person_name, n_coffee, likes_herbal_tea,
                        home_region)
```

  - Filter rows in which the `person_name == "bob"`

  - Create a subset of the data containing only rows in which
    `likes_herbal_tea` is `TRUE`

  - Bonus: return all rows in which the `person_name` contains the
    letter `o` (hint: type `?grepl` for help)

  - Save the data as a file called `coffee.csv` using
    `readr::write_csv()`

  - Read-in the data to objects called `coffee2` and `coffee3` using
    `read_csv()` from the `readr` package and `read.csv()` from base R
    as follows:

<!-- end list -->

``` r
readr::write_csv(coffee, "coffee.csv")
coffee1 = read_csv("coffee.csv")
coffee2 = read.csv("coffee.csv")
```

  - Use the function `purrr::map_chr(coffee2, class)` to find the class
    of each column. What’s the difference between `coffee2` and the
    other datasets?

# R’s spatial ecosystem

  - Create an interactive map showing the course location with the
    following commands (you should see the map shown below):

<!-- end list -->

``` r
library(leaflet)
library(osmdata)
library(tmap)
lida = opq("Leeds") %>% 
  add_osm_feature(key = "name", value = "Worsley Building") %>% 
  osmdata_sf()
# m = mapview::mapview(lida$osm_polygons, zoom = 16)
lida_centroid = lida$osm_polygons %>% 
  sf::st_centroid()
lon = sf::st_coordinates(lida_centroid)[1]
lat = sf::st_coordinates(lida_centroid)[2]
m = tm_shape(lida$osm_polygons) +
  tm_polygons(col = "red") +
  tm_view(set.view = c(lon + 0.005, lat - 0.005, 15)) +
  tm_basemap(server = leaflet::providers$CartoDB.Positron) +
  tm_minimap(server = leaflet::providers$OpenTopoMap, zoomLevelOffset = -10) +
  tm_scale_bar()
tmap_mode("view")
```

<img src="geolida_files/figure-gfm/unnamed-chunk-2-1.png" width="50%" />

  - Bonus: add a layer showing a road along which you travelled to get
    here (hint: you can search for road names at <http://osm.org/> )

<!-- end list -->

1)  Think about the terms ‘GIS’, ‘GDS’ and ‘Geocomputation’ described
    above. Which (if any) best describes the work you would like to do
    using geo\* methods and software and
why?

<!-- - There is no right answer. Your choice may depend on the methods (if it's focussed on spatial relationships and map overlays, GIS may be more appropriate), sector ('data science' is a generic term used in many tech companies) or personal preference. -->

2)  Provide 3 reasons for using a scriptable language such R for
    geocomputation instead of established GIS programs such as
QGIS.

<!-- - Reproducibility: a sequence of operations is much easier to save and share when using a scripting language. -->

<!-- - Scalability: scripting languages make it easy to break-up the work and parallelise, making it more scalable. -->

<!-- - Flexibility: the building blocks of the language allows it to interface efficiently with external software, enabling R to perform a wide range of tasks (e.g. animations, online interactive maps). -->

<!-- - Efficiency: the GUI of GIS programs can be slow to use and install. -->

3)  Name two advantages and two disadvantages of using mature packages
    compared with ‘cutting edge’ packages for spatial data (for example
    **sp** vs
**sf**).

<!-- - `+` Stability (newer packages may be more buggy) -->

<!-- - `+` Number of packages currently supported (although this is changine) -->

<!-- - `-` Slow performance for some operations -->

<!-- - `-` Non standard data representation -->

<!-- - `-` Fewer features -->

<!-- - `-` (Maybe) less future-proof -->

# Attribute operations

Load `sf` and `spData` with the following commands:

``` r
library(sf)
library(dplyr)
library(spData)
```

You should now have the `world` data in your namespace, which you can
check by plotting the object, which should generate the following
result:

    ## Warning: plotting the first 9 out of 10 attributes; use max.plot = 10 to
    ## plot all

<img src="2-day-exercises_files/figure-gfm/unnamed-chunk-8-1.png" height="9.6cm" />

You can filter and subset the data as follows:

1.  Create and plot an object called `europe` representing the countries
    of Europe
2.  Use the commands `dim()` and `nrow()` to find out: how many
    countries are there in Europe?
      - Bonus: cast the `europe` object into a new object called
        `europe_poly`. How many rows does it have and why does it have
        more rows than `europe` does?
3.  Create an object called `world_names` containing only country names.
      - Bonus: what is the class of this new object?
      - Bonus: What is its geometry type?
4.  Create an object containing only countries with at least 100 million
    inhabitants
      - Bonus: which continent has most small countries (with less than
        10 million inhabitants)?

# Spatial data operations

The input data for this part will be point and polygon data representing
New Zealand (`nz`), from Chapter 4 of *Geocomputation with R*. The best
place to start is to plot the data so the first exercise is:

  - Create a plot of the data so it looks like the map of New Zealand
    below (hint: use the `add = TRUE` argument).

![](2-day-exercises_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

1.  Canterbury is the region of New Zealand containing most of the 100
    highest points in the country. Create an object called `canterbury`
    and use this to subset all points within the region. How many of
    these high points does the Canterbury region contain?

2.  Which region has the second highest number of `nz_height` points in,
    and how many does it have?
    
      - Bonus: geralizing the question to all regions, how many of New
        Zealand’s 16 regions contain points which belong to the top 100
        highest points in the country? Which regions?
      - Bonus: create a table listing these regions in order of the
        number of points and their name.

# Reading and writing geographic data

The solutions assume the following packages are attached (other packages
will be attached when needed):

1)  List and describe three types of vector, raster, and geodatabase
    formats.

<!-- Vector formats: Shapefile (old format supported by many programs), GeoPackage (more recent format with better support of attribute data) and GeoJSON (common format for web mapping). -->

<!-- Raster formats: GeoTiff, Arc ASCII, R-raster (see book for descriptions). -->

<!-- Database formats: PostGIS, SQLite, FileGDB (see book for details). -->

2)  Name at least two differences between `read_sf()` and the more
    well-known function
`st_read()`.

<!-- `st_read()` prints outputs and keeps strings as text strings (`st_read()` creates factors). This can be seen from the source code of `read_sf()`, which show's it wraps `st_read()`: -->

3)  Read the `cycle_hire_xy.csv` file from the **spData** package as a
    spatial object (Hint: it is located in the `misc\` folder,
    `system.file("misc/cycle_hire_xy.csv", package = "spData")`). What
    is a geometry type of the loaded object?

<!-- The loaded object has the POINT geometry. -->

4)  Download the borders of Germany using **rnaturalearth**, and create
    a new object called `germany_borders`. Write this new object to a
    file of the GeoPackage format.

5)  Bonus: Download the global monthly minimum temperature with a
    spatial resolution of five minutes using the **raster** package.
    Extract the June values, and save them to a file named
    `tmin_june.tif` file (hint: use `raster::subset()`).

# Geometric operations

Some of the exercises use a vector (`random_points`) and raster dataset
(`ndvi`) from the **RQGIS** package. They also use a polygonal ‘convex
hull’ derived from the vector dataset (`ch`) to represent the area of
interest:

1)  Generate and plot simplified versions of the `nz` dataset.
    Experiment with different values of `keep` (ranging from 0.5 to
    0.00005) for `ms_simplify()` and `dTolerance` (from 100 to 100,000)
    `st_simplify()` .
    
      - At what value does the form of the result start to break-down
        for each method, making New Zealand unrecognizable?
      - Advanced: What is different about the geometry type of the
        results from `st_simplify()` compared with the geometry type of
        `ms_simplify()`? What problems does this create and how can this
        be resolved?

2)  In the first exercise in this
    [Chapter](https://geocompr.robinlovelace.net/spatial-data-operations.html)
    it was established that Canterbury region had 70 of the 101 highest
    points in New Zealand. Using `st_buffer()`, how many points in
    `nz_height` are within 100 km of Canterbury?

3)  Find the geographic centroid of New Zealand. How far is it from the
    geographic centroid of Canterbury?

4)  Most world maps have a north-up orientation. A world map with a
    south-up orientation could be created by a reflection (one of the
    affine transformations not mentioned in this
    [section](https://geocompr.robinlovelace.net/geometric-operations.html#affine-transformations))
    of the `world` object’s geometry. Write code to do so. Hint: you
    need to use a two-element vector for this transformation.
    
      - Bonus: create a upside down map of your country.

# Visualisation

These exercises rely on the object `europe`. Create it using the `world`
and `worldbank_df` datasets from the **spData** package as follows (see
Section
[2.2](https://geocompr.robinlovelace.net/spatial-class.html#intro-sf) of
Geocomputation with R for details):

1.  Create a map showing the geographic distribution of the Human
    Development Index (`HDI`) across Europe with base **graphics**
    (hint: use `plot()`) and **tmap** packages (hint: use
    `tm_shape(europe) + ...`).
2.  Extend the **tmap** created for the previous exercise so the legend
    has three bins: “High” (`HDI` above 0.7), “Medium” (`HDI` between
    0.55 and 0.7) and “Low” (`HDI` below 0.55).
      - Bonus: improve the map aesthetics, for example by changing the
        legend title, class labels and color palette.
3.  Represent `europe`’s subregions on the map.

![](2-day-exercises_files/figure-gfm/unnamed-chunk-21-1.png)<!-- -->

# Working on your own data

  - Option A: identify a dataset that is similar to one you use in your
    work and ask questions of it (e.g. what does it tell us about policy
    X)

  - Option B: work through one of the applied chapters in
    *Geocomputation with R*, on
    [transport](https://geocompr.robinlovelace.net/transport.html)
    planning,
    [location](https://geocompr.robinlovelace.net/location.html)
    analysis or [species](https://geocompr.robinlovelace.net/eco.html)
    distributions (chapters 12:14 in Geocomputation with R, hosted at
    <https://geocompr.robinlovelace.net> )
