install.packages("terra")

# load packages
library(terra)
library(ggplot2)
library(RColorBrewer)

# load raster file
# landcover_path <- "/Users/oliviaadomabea/Downloads/LAIRD.tif"
landcover_path <- "/Users/oliviaadomabea/Documents/Spatial_Data_Analysis_Respo/case-studies-Oliviaado/Final Project/data/gaplf2011lc_v30_MN/gaplf2011lc_v30_mn.tif"
landcover_raster <- rast(landcover_path)
print(landcover_raster)

# explore raster file
landcover_categories <- unique(values(landcover_raster))
print(landcover_categories)

# count pixels per landcover category
pixel_counts <- freq(landcover_raster, digits = 0)
print(pixel_counts)

# convert pixel counts to a df
pixel_counts_df <- as.data.frame(pixel_counts[, c(2,3)])
colnames(pixel_counts_df) <- c("Landcover_Class", "Pixel_Count")
print(pixel_counts_df)

# adding proportion to the df
total_pixels <- sum(pixel_counts_df$Pixel_Count)
pixel_counts_df$Percentage <- (pixel_counts_df$Pixel_Count / total_pixels) * 100


# some exploratory data analysis
# 1. bar plot
ggplot(data = pixel_counts_df, aes(x = factor(Landcover_Class), y = Pixel_Count)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Pixel Count per Landcover Category",
       x = "Landcover Category",
       y = "Number of Pixels") +
  theme_minimal()

# 2. pie chart of land cover categories
ggplot(pixel_counts_df, aes(x = "", y = Percentage, fill = factor(Landcover_Class))) +
  geom_col(width = 1, color = "white") +
  coord_polar(theta = "y") +
  scale_fill_brewer(palette = "Set3") +
  labs(title = "Landcover Category Proportions",
       fill = "Landcover Category") +
  theme_void()

# 3. visualizing the raster file spatially
n_classes <- length(landcover_categories)
palette <- brewer.pal(n = n_classes, name = "Set3")

plot(landcover_raster, col = palette, legend = TRUE,
     main = "Spatial Distribution of Landcover Categories")


################################################################################
# taking the analysis further --change detection
# load raster files
year1 <- rast("path/to/landcover_2000.tif")
year2 <- rast("path/to/landcover_2020.tif")

# preprocessing steps: resampling
year2 <- resample(year2, year1, method = "near")

# 2. change detection
change <- year2 - year1
change_areas <- which(change != 0, cells = TRUE)

# calculate the number of changed pixels
num_changed_pixels <- length(change_areas)
print(paste("Number of pixels that changed:", num_changed_pixels))

# plot
plot(change_raster, col = terrain.colors(10), main = "Landcover Change from 2000 to 2020")


