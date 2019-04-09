Plotting time chunks
================
Ian Handel
2019-04-09

``` r
# for plotting
library(ggplot2)
# to wrangle data
suppressPackageStartupMessages(library(dplyr))
```

    ## Warning: package 'dplyr' was built under R version 3.5.2

``` r
# for factor manipulation
library(forcats)
# for palette
library(ggsci)
```

set random number seed so data the same each time

``` r
set.seed(111)
```

Make some test data with...

column for lecture,

column for time spent

column for class of activity

``` r
dat <- tibble(
  lecture = rep(paste0("lec", 1:4), c(8, 6, 4, 7)),
  duration = sample(1:10, 25, replace = TRUE),
  type = sample(LETTERS[1:5], 25, replace = TRUE)
)

dat
```

    ## # A tibble: 25 x 3
    ##    lecture duration type 
    ##    <chr>      <int> <chr>
    ##  1 lec1           6 B    
    ##  2 lec1           8 D    
    ##  3 lec1           4 B    
    ##  4 lec1           6 D    
    ##  5 lec1           4 C    
    ##  6 lec1           5 A    
    ##  7 lec1           1 C    
    ##  8 lec1           6 C    
    ##  9 lec2           5 C    
    ## 10 lec2           1 B    
    ## # … with 15 more rows

Now work out start and end times for the chunk

Assumes start at zero time

``` r
dat <- dat %>%
  group_by(lecture) %>%
  mutate(
    end = cumsum(duration),
    start = dplyr::lag(end, default = 0)
  )
```

Then plot...

using geom\_tile need to..

give centre of tile

and its height and width

width is duration

Tidy up axis lables with labs()

``` r
ggplot(dat) +
  aes(
    x = start + duration / 2,
    width = duration,
    y = fct_rev(lecture),
    fill = type
  ) +
  geom_tile(
    height = 0.5,
    colour = "white"
  ) +
  labs(
    title = "Time chunks in lectures",
    y = "Lecture",
    x = "Time (minutes)",
    fill = "Activity type"
  )
```

![](plot_time_chunks_files/figure-markdown_github/unnamed-chunk-5-1.png)

Maybe different colours

``` r
last_plot() +
  ggsci::scale_fill_locuszoom()
```

![](plot_time_chunks_files/figure-markdown_github/unnamed-chunk-6-1.png)
