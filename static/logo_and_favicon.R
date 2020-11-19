library(dplyr)
library(tidyr)
library(ggplot2)
library(ggridges)

pulsar <- read.csv("pulsar.csv", header = FALSE) %>%
    mutate(row = row_number()) %>%
    gather(col, height, -row) %>%
    mutate(
        col = sub("^V", "", col) %>% as.integer()
    )

p1 <- ggplot(pulsar, aes(x = col, y = row, height = height, group = row)) +
    geom_ridgeline(
        min_height = min(pulsar$height),
        scale = 0.2,
        size = 1,
        colour = "#e63e00",
        fill = NA
    ) +
    scale_y_reverse() +
    theme_void() +
    # set transparency
    theme(
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = "transparent", colour = NA),
        plot.background = element_rect(fill = "transparent", colour = NA)
    )
p1

ggsave(file = "logo.png", plot = p1, dpi = 72, width = 115, height = 155, units = "mm", bg = "transparent")