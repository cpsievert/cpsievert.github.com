# setwd("~/pitchfx")
library(pitchRx)
library(dplyr)
library(openWAR)
library(gridSVG)
#library(mosiac)
library(lattice)
db <- src_sqlite("pitchRx.sqlite3")
# Grab data for a single game
hip.day <- collect(tbl(db, sql("SELECT * FROM hip WHERE hip.gameday_link LIKE '%2013_06_01%'")))

# Borrowed from https://github.com/beanumber/openWAR/blob/master/R/GameDay.R
recenter <- function (data, ...) {
  # From MLBAM specs
  data = transform(data, our.x = x - 125)
  data = transform(data, our.y = 199 - y)
  # set distance from home to 2B
  scale = sqrt(90^2 + 90^2) / 51
  data = transform(data, r = scale * sqrt(our.x^2 + our.y^2))
  data = transform(data, theta = atan2(our.y, our.x))
  data = transform(data, our.x = r * cos(theta))
  data = transform(data, our.y = r * sin(theta))
  return(data)
}

hip.day <- recenter(hip.day)
hip.day$type <- factor(hip.day$type)

# Borrowed from https://github.com/beanumber/openWAR/blob/master/R/GameDayPlays.R
xyplot(our.y ~ our.x, groups=type, data=hip.day, panel = function(x,y, ...) {
                panel.segments(0, 0, -400, 400, col="darkgrey") # LF line
                panel.segments(0, 0, 400, 400, col="darkgrey") # RF line
                bw = 2
                # midpoint is at (0, 127.27)
                base2.y = sqrt(90^2 + 90^2)
                panel.polygon(c(-bw, 0, bw, 0), c(base2.y, base2.y - bw, base2.y, base2.y + bw), col="darkgrey")
                # back corner is 90' away on the line
                base1.x = 90 * cos(pi/4)
                base1.y = 90 * sin(pi/4)
                panel.polygon(c(base1.x, base1.x - bw, base1.x - 2*bw, base1.x - bw), c(base1.y, base1.y - bw, base1.y, base1.y + bw), col="darkgrey")
                # back corner is 90' away on the line
                base3.x = 90 * cos(3*pi/4)
                panel.polygon(c(base3.x, base3.x + bw, base3.x + 2*bw, base3.x + bw), c(base1.y, base1.y - bw, base1.y, base1.y + bw), col="darkgrey")
                # infield cutout is 95' from the pitcher's mound
                panel.curve(60.5 + sqrt(95^2 - x^2), from=base3.x - 26, to=base1.x + 26, col="darkgrey")
                # pitching rubber
                panel.rect(-bw, 60.5 - bw/2, bw, 60.5 + bw/2, col="darkgrey")
                # home plate
                panel.polygon(c(0, -8.5/12, -8.5/12, 8.5/12, 8.5/12), c(0, 8.5/12, 17/12, 17/12, 8.5/12), col="darkgrey")
                # distance curves
                distances = seq(from=200, to=500, by = 100)
                for (i in 1:length(distances)) {
                  d = distances[i]
                  panel.curve(sqrt(d^2 - x^2), from= d * cos(3*pi/4), to=d * cos(pi/4), col="darkgrey")
                }
                panel.xyplot(x,y, alpha = 0.3, ...)
              }
              , auto.key=list(columns=4)
              , xlim = c(-350, 350), ylim = c(-20, 525)
              , xlab = "Horizontal Distance from Home Plate (ft.)"
              , ylab = "Vertical Distance from Home Plate (ft.)"
)


grid.export("field.svg")



