
<!-- badges: start -->

[![R build
status](https://github.com/geocompx/geocompkg/workflows/pkgdown/badge.svg)](https://github.com/geocompx/geocompkg/actions)
[![Codecov test
coverage](https://codecov.io/gh/geocompx/geocompkg/branch/master/graph/badge.svg)](https://codecov.io/gh/geocompx/geocompkg?branch=master)
[![R build
status](https://github.com/geocompx/geocompkg/workflows/R-CMD-check/badge.svg)](https://github.com/geocompx/geocompkg/actions)
[![R-CMD-check](https://github.com/geocompx/geocompkg/workflows/R-CMD-check/badge.svg)](https://github.com/geocompx/geocompkg/actions)
[![R-CMD-check](https://github.com/geocompx/geocompkg/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/geocompx/geocompkg/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

<!-- README.md is generated from README.Rmd. Please edit that file -->

# geocompkg

This is a ‘metapackage’ support the book [Gecomputation with
R](https://r.geocompx.org/). Installing installing it will give you the
dependencies needed to run the code in the book. The repository also
contains up-to-date solutions additional materials to supplement the
book. See [the vignettes
folder](https://github.com/geocompx/geocompkg/tree/master/vignettes) for
the source code.

## Installation

You can install the packages needed to reproduce the code in
Geocompuation with R by installing the
[geocompkg](https://github.com/geocompx/geocompkg) package as follows:

``` r
devtools::install_github("geocompx/geocompkg")
```

If you have any issues, check-out [Chapter
2](https://r.geocompx.org/spatial-class.html) of the book. You may need
to install **spDataLarge** from drat:

``` r
install.packages("spDataLarge", repos = "https://nowosad.github.io/drat/",
                 type = "source")
```
