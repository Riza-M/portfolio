# Reported tuna catch by vessel flag

# SET UP

# Load packages
library(dplyr)
library(ggplot2)
library(ggspatial)
library(rnaturalearth)

# Load cleaned tuna data
tuna <- readRDS("data/processed/tuna_clean.rds")

# Load country and territory boundaries for the background map
world <- ne_countries(
  scale = "medium",
  type = "map_units",
  returnclass = "sf"
)

# VISUALIZE

# Draw the base map and color areas with matched catch data
tuna_map <- ggplot() +
  geom_sf(data = world, fill = "grey90", color = "white", linewidth = 0.15) +
  geom_sf(
    data = filter(world_catch, !is.na(total_catch_kt)),
    aes(fill = total_catch_kt),
    color = "white",
    linewidth = 0.15
  ) +
  scale_fill_viridis_c() +
  annotation_north_arrow(location = "tl") +
  # At the equator, 18 degrees of longitude span about 2,000 km
  annotate("segment", x = -165, xend = -147, y = 0, yend = 0,
           linewidth = 0.8) +
  annotate("text", x = -156, y = 6,
           label = "Approx. 2,000 km at equator", size = 3) +
  labs(
    title = "Reported tuna catch by vessel flag",
    fill = "Catch (thousand tonnes)",
    caption = paste(
      "Catch data: Inter-American Tropical Tuna Commission (IATTC), CatchByFlagGear1918-2024.",
      "Map boundaries: Natural Earth.",
      "Flag codes not mapped: UNK, OTR, EU (ESP), and FRA (PYF).",
      sep = "\n"
    )
  )
 

print(tuna_map)
# EXPORT

# Save the map as a PNG in the project results folder
dir.create("results/img", recursive = TRUE, showWarnings = FALSE)

ggsave(
  filename = "results/img/tuna_catch_by_flag.png",
  plot = tuna_map,
  width = 10,
  height = 6,
  units = "in",
  dpi = 300
)







































