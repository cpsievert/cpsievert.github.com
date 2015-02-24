library("magrittr")
library("dplyr")
library("lubridate")
library("animint")
library("maps")

# restrict to central/south america
countries <- map_data("world") %>%
  filter(lat < 38, lat > -24) %>%
  filter(long < -54, long > -118)

data(climate, package = "animint")
# compute temperature deviation from monthly norm
climate <- climate %>%
  group_by(id, month) %>%
  summarise(avgtemp = mean(temperature)) %>%
  left_join(climate) %>%
  mutate(tempdev = temperature - avgtemp) %>%
  mutate(time_num = decimal_date(ymd(date))) %>%
  arrange(desc(time_num)) %>% as.data.frame()

dates <- climate %>%
  select(date, year, time_num) %>% unique() %>%
  mutate(textdate = paste(month(date, label = TRUE), year))

ts <- ggplot() +
  make_tallrect(data = climate, "time_num") +
  geom_line(data = climate, aes(x = time_num, y = temperature, group = id, showSelected = id)) +
  geom_text(data = dates, aes(x = 1998, y = -5, label = textdate, showSelected = time_num))

tile_map <- ggplot() +
  geom_tile(data = climate,
            aes(x = long, y = lat, fill = tempdev,
                clickSelects = id, showSelected = time_num)) +
  geom_path(data = countries, aes(x = long, y = lat, group = group)) +
  geom_text(data = dates,
            aes(x = -86, y = 39, label = textdate, showSelected = time_num)) +
  scale_fill_gradient2("deg. C", limits = c(-20, 20)) +
  ggtitle("Temperature Deviation from Monthly Norm") +
  theme(axis.line = element_blank(), axis.text = element_blank(),
      axis.ticks = element_blank(), axis.title = element_blank())

p_list <- list(
  ts = ts,
  map = tile_map,
  time = list(variable = "time_num", ms = 300),
  selector.types = list(id = "multiple")
)

animint2dir(p_list, out.dir = "climate", open.browser = FALSE)
# servr::httd("climate")