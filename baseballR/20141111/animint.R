library(mgcv)
library(animint)
library(dplyr)
# load the model and data from this post:
# http://baseballwithr.wordpress.com/2014/10/23/a-probabilistic-model-for-interpreting-strike-zone-expansion-7/
load("~/Desktop/github/local/cpsievert.github.com/baseballR/20141021/model2.rdata")
load("~/Desktop/github/local/cpsievert.github.com/baseballR/20141021/dat2.rdata")

# make predictions over a (somewhat) arbitrary grid
grid <- expand.grid(px = seq(-2, 2, by = 0.5), pz = seq(0.7, 4.2, by = 0.5),
                    year = c("2008", "2014"), stand = c("L", "R"),
                    count = sort(unique(dat$count)))
fit <- predict(m1, newdata = grid, type = "response", se.fit = TRUE,
               newdata.guaranteed = TRUE)

# lb and ub are upper and lower bounds to an *approximate* 95% confidence interval
# http://stats.stackexchange.com/questions/33327/confidence-interval-for-gam-model
grid2 <- grid %>% tbl_df %>%
  mutate(est = as.numeric(fit$fit), se = as.numeric(fit$se.fit),
         id = paste0("px=", px, "; ", "pz=", pz),
         lb = pmax(0, est-1.96*se), ub = pmin(1, est+1.96*se),
         count = paste0("count:", count), stand = paste0("stand:", stand)) 

# odds and differences in probability (for heat map)
diffs <- grid2 %>%
  group_by(px, pz, count, stand, id) %>%
  # can I assume independence here?
  summarise(diff_est = diff(rev(est)), diff_se = sqrt(se[1]^2 + se[2]^2),
            times = round(est[2]/est[1], 1), odds_lb = lb[2]/ub[1], 
            odds_ub = ub[2]/lb[1]) %>%
  mutate(year = "diff")

# Build the viz
viz <- list()
viz$heat <- ggplot() + geom_tile(data = diffs, 
                                 aes(tooltip = paste("(", round(odds_lb, 2), ", ", round(odds_ub, 2), ")"),
                                   x = px, y = pz, fill = diff_est, clickSelects = id)) + 
  geom_text(data = diffs, aes(showSelected = id, x = px, y = pz - 0.1, label = times)) +
  facet_wrap(~ count + stand, ncol = 2, scales = "free") + 
  ylab("Vertical location") + xlab("Horizontal Location") +
  scale_fill_gradient2(midpoint = 0) + 
  ggtitle("Difference/odds in estimated strike probability") +
  theme_animint(height = 2200, width = 450)
grid2$count2 <- factor(grid2$count, rev(levels(grid2$count)))
grid2$year <- factor(grid2$year, rev(levels(grid2$year)))
viz$intervals <- ggplot() + 
                  geom_segment(data = grid2, size = 10,
                    aes(showSelected = id, x = lb, xend = ub, y = count2, 
                        yend = count2, color = year,
                        tooltip = paste("(", round(lb, 2), ", ", round(ub, 2), ")"))) +
                    xlab("Probability of a called strike") + ylab("") +
                facet_wrap(~ count + stand, ncol = 2, scales = "free") +
                ggtitle("95% intervals for strike probability") +
                theme(axis.ticks.y = element_blank(), axis.text.y  = element_blank()) +
                theme_animint(height = 2200, width = 450)
viz$first <- list(id="px=0; pz=1.7")
animint2dir(viz, "viz")
