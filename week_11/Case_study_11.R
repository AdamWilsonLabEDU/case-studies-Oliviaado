# Install required packages if not already installed
install.packages(c("ggmap", "raster", "ggplot2"))

# Load the libraries
library(ggmap)
library(raster)
library(ggplot2)

# Define the coordinates for the center of your area of interest (lat, lon)
lat_center <- 37.7749  # Example: Latitude for San Francisco
lon_center <- -122.4194  # Longitude for San Francisco

# Download the map using ggmap
map <- get_map(location = c(lon = lon_center, lat = lat_center), zoom = 12, source = "google", maptype = "terrain")

# For this example, let's create a mock LST raster object (you can replace this with your own LST raster data)
# Create a 10x10 raster for demonstration purposes
lst_raster <- raster(nrows = 10, ncols = 10)
values(lst_raster) <- runif(ncell(lst_raster), min = 15, max = 40)  # Random LST values between 15 and 40°C

# Plot the raster
plot(lst_raster, main = "Random LST Data", col = terrain.colors(100))

# Convert the raster into a data frame (for ggplot2)
lst_df <- as.data.frame(rasterToPoints(lst_raster), xy = TRUE)
colnames(lst_df) <- c("longitude", "latitude", "LST")  # Rename columns for clarity

# Now, let's plot the map with LST data
ggmap(map) + 
  geom_raster(data = lst_df, aes(x = longitude, y = latitude, fill = LST)) +
  scale_fill_viridis_c(option = "C", name = "LST (°C)") +  # Use the viridis color palette
  labs(title = "Land Surface Temperature Overlay", x = "Longitude", y = "Latitude") +
  theme_minimal()
