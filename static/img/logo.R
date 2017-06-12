library(ggplot2)
library(hrbrthemes)


set.seed(1000)

n <- 1e4
d <- tibble::tibble(
  x = seq(-5, 5, length.out = n),
  y = -0.1 * x^2 + rnorm(n, sd = 0.5)
)


# static image
(p <- ggplot(d, aes(x, y)) + 
  geom_point(alpha = 0.1) +
  geom_smooth(se = T) +
  annotate(
    "text", label = "CPS", 0, -3, 
    size = 80, family = "Arial Narrow", 
    hjust = 0.5, vjust = 0.5, alpha = 0.9
  ) +
  #scale_x_continuous(limits = c(0.8, 2.5)) +
  scale_y_continuous(limits = c(-5, 1)) +
  theme_void() +
  theme(
    plot.margin = margin(0,0,0,0), 
    panel.spacing = unit(0, "pt"),
    axis.ticks = element_blank()
  ))

ggsave("logo.png", p, width = 8, height = 8, units = "in", dpi = 40)

# too large!
# ggsave("logo.svg", width = 12.152778, height = 7.916667, units = "in")




# 
# 
# library(ggplot2)
# library(hrbrthemes)
# 
# # static image
# ggplot() + 
#   annotate("text", label = "CPS", 2, 2, size = 60) +
#   #annotate("text", label = "C", 1, 3, size = 60) +
#   #annotate("text", label = "P", 2, 2, size = 60) +
#   #annotate("text", label = "S", 3, 1, size = 60) +
#   coord_equal() +
#   scale_x_continuous(limits = c(0, 4)) +
#   scale_y_continuous(limits = c(0, 4)) +
#   theme_ipsum() +
#   theme(
#     axis.title = element_blank(),
#     axis.text = element_blank()
#   ) 
# 
# 
# 
# 
