#install & load packages
library(terra)
library(spData)
library(tidyverse)
library(sf)
#intall ncdf4
library(ncdf4)
#loading the world data
world_2 <- world %>% filter(continent == "Antartica")
#downloading file
download.file("https://crudata.uea.ac.uk/cru/data/temperature/absolute.nc","crudata.nc")
# read in the data using the rast() function from the terra package
tmean=rast("crudata.nc")
#preparing the climate data
tmean=rast("crudata.nc")
#inspecting tmean
tmean
#making a plot
plot(tmean)
#calculating maximum temperature
max(tmean)%>% plot()
tmean_max <- max(tmean)
#plotting maximum temperature
plot(tmean_max)
# calculating number of layers
#identifing the maximum temperature observed in each country
data("world")
world_temp_max <- terra::extract(tmean_max, world, fun = max, na.rm=T, small=T)
world_clim<- bind_cols(world, world_temp_max)
ggplot()  +
  geom_sf(data = world_clim, aes(fill=max)) +
scale_fill_viridis_c(name="Maximum\nTemperature (C)") +
  theme(legend.position = 'bottom')
#using dplyr tools
#load dplyr
library(dplyr) 
#analyzing the hottest
hottest_continents <- world_clim %>%
  group_by(continent) %>%
  arrange(desc(max)) %>% top_n(1, max)
#table
final_table <- hottest_continents %>% select(name_long, continent, max)
#print table
print(final_table)
