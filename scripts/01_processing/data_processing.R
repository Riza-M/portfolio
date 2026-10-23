# I loaded tidyverse because I use its functions to work with the data.
library(tidyverse)
# I started by reading the original tuna catch data.
raw_data <- read_csv("data/raw/CatchByFlagGear/CatchByFlagGear1918-2024.csv")
View(raw_data)
# Explore the raw data
glimpse(raw_data)
# Check column names
names(raw_data)
# Inspect the first rows of the raw data
head(raw_data)
# # First, I renamed the columns so they are easier to understand and use
clean_data <- raw_data %>%
  rename(
    year = AnoYear,
    flag = BanderaFlag,
    gear = ArteGear,
    species = EspeciesSpecies,
    catch_t = t
  )
# Check the cleaned column names
names(clean_data)
# Check the tuna species in the dataset
unique(clean_data$species)
# Count observations and total catch by species
species_summary <- clean_data %>%
  group_by(species) %>%
  summarise(
    total_catch_t = sum(catch_t, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(total_catch_t))
species_summary
# Summarize total catch by species
species_summary <- clean_data %>%
  group_by(species) %>%
  summarise(
    total_catch_t = sum(catch_t, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(total_catch_t))
species_summary
# Summarize total catch by flag
flag_summary <- clean_data %>%
  group_by(flag) %>%
  summarise(
    total_catch_t = sum(catch_t, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(total_catch_t))
flag_summary
# Check fishing gear types
unique(clean_data$gear)
# Check for missing values
colSums(is.na(clean_data))
# Check for negative catch values
sum(clean_data$catch_t < 0)
# Check how many records have zero catch
sum(clean_data$catch_t == 0)
# Check the year range
range(clean_data$year)
# Calculate total catch by year
year_summary <- clean_data %>%
  group_by(year) %>%
  summarise(
    total_catch_t = sum(catch_t, na.rm = TRUE),
    .groups = "drop"
  )
head(year_summary)
# Calculate total catch by year
year_summary <- clean_data %>%
  group_by(year) %>%
  summarise(
    total_catch_t = sum(catch_t, na.rm = TRUE),
    .groups = "drop"
  )

head(year_summary)
exists("clean_data")
year_summary <- clean_data %>%
  group_by(year) %>%
  summarise(total_catch_t = sum(catch_t, na.rm = TRUE))
head(year_summary)
year_summary %>%
  arrange(desc(total_catch_t)) %>%
  slice_head(n = 5)
# Check special flag categories
clean_data %>%
  count(flag, sort = TRUE)
clean_data %>%
  count(flag, sort = TRUE) %>%
  print(n = Inf)
# Check how many records have positive catch
sum(clean_data$catch_t > 0)
# Convert year to integer
clean_data <- clean_data %>%
  mutate(year = as.integer(year))
glimpse(clean_data)
# Check for duplicate year-flag-gear-species combinations
clean_data %>%
  count(year, flag, gear, species) %>%
  filter(n > 1)
# Convert catch from tons to kilotons
clean_data <- clean_data %>%
  mutate(catch_kt = catch_t / 1000)
head(clean_data)
# # Finally, I saved the cleaned data so I can use it in the visualization script.
write_rds(clean_data, "data/processed/tuna_clean.rds")
file.exists("data/processed/tuna_clean.rds")













