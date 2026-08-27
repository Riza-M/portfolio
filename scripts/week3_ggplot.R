# EVR 628 - Week 3: Using ggplot2

library(EVR628tools)
library(tidyverse)
ggplot(data = data_lionfish,
       mapping = aes(x = depth_m, y = total_length_mm)) +
  geom_point()
ggplot(data = data_lionfish,
       mapping = aes(x = depth_m, y = total_length_mm)) +
  geom_point(shape = 21,
             fill = "steelblue",
             size = 2) +
  labs(x = "Depth (m)",
       y = "Total weight (gr)",
       title = "Body length and depth",
       subtitle = "Larger fish tend to live deeper",
       caption = "Source EVR628tools::data_lionfish")
# Basic bar plot with site
ggplot(data = data_lionfish, aes(x = site)) +
  geom_bar() +
  coord_flip() +
  labs(x = "Site", y = "Number of fish")
# Histogram of lengths
ggplot(data = data_lionfish, aes(x = total_length_mm)) +
  geom_histogram(bins = 15) +
  labs(x = "Total length (mm)", y = "Count")                            
# Numerical vs categorical: depth by size class
ggplot(data = data_lionfish, aes(x = size_class, y = depth_m)) +
  geom_boxplot() +
  labs(x = "Size class", y = "Depth (m)")
# Two categorical variables: N by size class and site
ggplot(data = data_lionfish, aes(x = site, y = size_class)) +
  geom_bin2d() +
  coord_flip() +
  labs(x = "Site", y = "Number of fish", fill = "Size class")
# Three or more variables: length vs depth with size for weight
ggplot(data = data_lionfish,
       aes(x = depth_m, y = total_length_mm,
           size = total_weight_gr,
           color = temperature_C)) +
  geom_point() +
  scale_size_continuous(range = c(1, 5)) +
  labs(x = "Depth (m)",
       y = "Total length (mm)",
       size = "Weight (gr)",
       color = "Temperature (°C)")
p <- ggplot(data = data_lionfish,
            aes(x = depth_m, y = total_length_mm,
                size = total_weight_gr,
                color = temperature_C)) +
  geom_point() +
  scale_size_continuous(range = c(1, 5)) +
  labs(x = "Depth (m)",
       y = "Total length (mm)",
       size = "Weight (gr)",
       color = "Temperature (°C)") +
  scale_color_viridis_c()

p
p +
  scale_color_viridis_c(option = "mako")
p +
  scale_color_gradientn(
    colours = palette_IPCC(var = "temp", type = "seq")
  )p +
  scale_color_gradient(low = "green",
                       high = "orange")p +
  scale_color_gradient2(low = "green",
                        mid = "white",
                        high = "orange")p +
  scale_color_gradient2(low = "green",
                        mid = "white",
                        high = "orange",
                        midpoint = 29)p <- ggplot(data = data_milton,
                                                  aes(x = iso_time, y = pressure, color = sshs)) +
  geom_point()p +
  scale_color_manual(values = palette_UM(n = 10))p +
  scale_color_viridis_d()
# Example with manual color scale for discrete variables
ggplot(data = data_lionfish, aes(x = site, fill = size_class)) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = c("small" = "lightblue",
                               "medium" = "blue",
                               "large" = "darkblue")) +
  labs(x = "Site", y = "Number of fish", fill = "Size class")# Save plot to object
p <- ggplot(data = data_lionfish,
            mapping = aes(x = depth_m, y = total_length_mm)) +
  geom_point(shape = 21, fill = "steelblue", size = 2) +
  labs(x = "Depth (m)",
       y = "Total length (mm)",
       title = "Body length and depth")ggsave("lionfish_depth_length.png", p,
                                              width = 8,
                                              height = 6,
                                              dpi = 300)p <- ggplot(data = data_milton,
                                                                    mapping = aes(x = iso_time,
                                                                                  y = pressure)) +
  geom_line() +
  geom_point(aes(color = wind_speed),
             size = 2)

p +
  scale_color_gradientn(
    colours = palette_IPCC(var = "wind", type = "seq")
  )# Facet wrap example
ggplot(data = data_lionfish, aes(x = depth_m, y = total_length_mm)) +
  geom_point() +
  facet_wrap(~size_class, ncol = 3) +
  labs(x = "Depth (m)", y = "Total length (mm)")# Facet grid example
ggplot(data = data_lionfish, aes(x = depth_m, y = total_length_mm)) +
  geom_point() +
  facet_grid(size_class ~ site) +
  labs(x = "Depth (m)", y = "Total length (mm)")ggplot(data = data_lionfish, aes(x = depth_m, y = total_length_mm)) +
  geom_point() +
  facet_wrap(~size_class, ncol = 3, scales = "free_y") +
  labs(x = "Depth (m)", y = "Total length (mm)")
