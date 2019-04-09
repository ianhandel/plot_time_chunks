#' ---
#' title: "Plotting time chunks"
#' author: "Ian Handel"
#' date: "2019-04-09"
#' output: github_document
#' ---


# for plotting
library(ggplot2)
# to wrangle data
suppressPackageStartupMessages(library(dplyr))
# for factor manipulation
library(forcats)
# for palette
library(ggsci)

#' set random number seed so data the same each time
set.seed(111)

#' Make some test data with...
#'
#' column for lecture,
#'
#' column for time spent
#'
#' column for class of activity

dat <- tibble(
  lecture = rep(paste0("lec", 1:4), c(8, 6, 4, 7)),
  duration = sample(1:10, 25, replace = TRUE),
  type = sample(LETTERS[1:5], 25, replace = TRUE)
)

dat

#' Now work out start and end times for the chunk
#'
#' Assumes start at zero time

dat <- dat %>%
  group_by(lecture) %>%
  mutate(
    end = cumsum(duration),
    start = dplyr::lag(end, default = 0)
  )

#' Then plot...
#'
#' using geom_tile need to..
#'
#' give centre of tile
#'
#' and its height and width
#'
#' width is duration
#'
#' Tidy up axis lables with labs()

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


#' Maybe different colours

last_plot() +
  ggsci::scale_fill_locuszoom()
