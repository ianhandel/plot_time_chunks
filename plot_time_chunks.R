#' ---
#' title: "Plotting time chunks"
#' author: "Ian Handel"
#' date: "2019-04-08"
#' output: github_document
#' ---



library(ggplot2) # for plotting
library(dplyr) # to wrangle data
library(forcats) # to change factor levels
library(ggsci) # for palette



#' Make some data with...
#' column for lecture,
#' column for time spent
#' column for class of activity

dat <- tibble(lecture = rep(paste0("lec", 1:4), c(8, 6, 4, 7)),
                  time = sample(1:10, 25, replace = TRUE),
                  type = sample(LETTERS[1:5], 25, replace = TRUE))

dat

#' Then add a column, for each lecture
#' with the cumulative time spent
#' (need this to give unique ID for each chunk)

dat <- dat %>%
  group_by(lecture) %>% 
  mutate(time_cumul = cumsum(time))

dat

#' Then plot
#' Each lecture maps to an x column
#' Time slots 'stack' and have fill colour of 'type'
#' Tidy up axis lables with labs()

ggplot(dat) +
  aes(x = fct_rev(lecture), y = time, fill = type, group = time_cumul) +
  geom_bar(stat = "identity", position = position_stack()) +
  labs(title = "Time chunks in lectures",
       x = "Lecture",
       y = "Time (minutes)",
       fill = "Activity type")

#' Looks nicer if flipped around...
#' coord_flip() could just be added onto code above
#' or this way takes last plot and adds it...

last_plot() +
  coord_flip()

#' Maybe nicer with different colours

last_plot() +
  ggsci::scale_fill_locuszoom()

