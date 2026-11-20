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

# Calculate total catch by vessel flag in thousand tonnes
catch_by_flag <- tuna %>%
  group_by(flag) %>%
  summarise(
    total_catch_kt = sum(catch_kt, na.rm = TRUE),
    .groups = "drop"
  )

# Join catch totals to the map using three-letter codes
world_catch <- world %>%
  left_join(catch_by_flag, by = c("iso_a3" = "flag"))
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
  annotation_scale(location = "bl") +
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
 








































