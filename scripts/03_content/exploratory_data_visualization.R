# Load packages
library(tidyverse)
# Read processed data
clean_data <- read_rds("data/processed/tuna_clean.rds")
glimpse(clean_data)
# Summarize total catch by year
year_summary <- clean_data %>%
  group_by(year) %>%
  summarise(
    total_catch_kt = sum(catch_kt, na.rm = TRUE),
    .groups = "drop"
  )
# Plot total catch over time
p_year <- ggplot(year_summary, aes(x = year, y = total_catch_kt)) +
  geom_line() +
  labs(
    title = "Total Tuna Catch Over Time",
    x = "Year",
    y = "Total Catch (kt)",
    caption = "Source: IATTC Catch by Flag and Gear dataset"
  )

# Save the plot as a PNG file
ggsave(
  filename = "results/img/total_tuna_catch_over_time.png",
  plot = p_year,
  width = 8,
  height = 5,
  dpi = 300
)
# Summarize total catch by species
species_summary <- clean_data %>%
  group_by(species) %>%
  summarise(
    total_catch_kt = sum(catch_kt, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(total_catch_kt))
# Plot total catch by species
p_species <- ggplot(species_summary, aes(x = reorder(species, total_catch_kt), y = total_catch_kt)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Total Catch by Species",
    x = "Species",
    y = "Total Catch (kt)",
    caption = "Source: IATTC Catch by Flag and Gear dataset"
  )

# Save the plot as a PNG file
ggsave(
  filename = "results/img/total_catch_by_species.png",
  plot = p_species,
  width = 8,
  height = 5,
  dpi = 300
)
# Summarize total catch by gear type
gear_summary <- clean_data %>%
  group_by(gear) %>%
  summarise(
    total_catch_kt = sum(catch_kt, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(total_catch_kt))
# Plot total catch by gear type
p_gear <- ggplot(gear_summary, aes(x = reorder(gear, total_catch_kt), y = total_catch_kt)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Total Catch by Gear Type",
    x = "Gear Type",
    y = "Total Catch (kt)",
    caption = "Source: IATTC Catch by Flag and Gear dataset"
  )

# Save the plot as a PNG file
ggsave(
  filename = "results/img/total_catch_by_gear.png",
  plot = p_gear,
  width = 8,
  height = 5,
  dpi = 300
)










