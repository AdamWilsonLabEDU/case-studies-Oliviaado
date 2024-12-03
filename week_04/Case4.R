#install and load tidyverse and nycflights13
library(tidyverse)
install.packages("nycflights13")
library(nycflights13)
library(dplyr)

# Dsetination: full name of destination airport farthest from any NYC airports in flights table.
#Select destination and distances
farthest_flight_table <- flights %>%
  filter(flights$origin=='JFK') %>%
  arrange(desc(distance)) %>%
  select(dest, distance, origin)


#Join data
farthest_airport_name <- farthest_flight_table %>%
  left_join(airports, by = c("dest" = "faa")) %>%
  slice(1) %>%
  select(name)
farthest_airport_name


