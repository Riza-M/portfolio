# Tuna analysis

# Part B: Reading data
# Part C: Renaming columns
# Part D: Filtering rows
# Part E: Creating new columns
# Part F: Calculating group summaries
# Part G: Visualizing the data

# Load packages
library(tidyverse)
library(janitor)
# Load the data
tuna_data <- read_csv("data/raw/CatchByFlagGear/CatchByFlagGear1918-2024.csv") |>
  clean_names() |>
  rename(
    year = ano_year,
    flag = bandera_flag,
    gear = arte_gear,
    species = especies_species,
    catch = t
  )
# Part C: Renaming columns
# Check column names
colnames(tuna_data)
# Part D: Filtering rows

# Check species codes
unique(tuna_data$species)
# Check fishing gear codes
unique(tuna_data$gear)
# Filter for bigeye tuna caught by purse seine since 2000
# Create a new data set called ps_tuna_data after filtering
ps_tuna_data <- tuna_data |> 
  filter(
    species == "BET",  # Retain BET values only
    gear == "PS",      # Retain PS values only
    year >= 2000       # Retain data from 2000 onwards
  ) |> 
  mutate(
    revenue = catch * 1000 * 2 / 1e6  # Calculate revenue in Millions of USD
  )
group_by(year) |> 
  summarize(
    catch = sum(catch),
    revenue = sum(revenue)
  )
# Part G: Visualize the data and answer the question

# Get total revenue
sum(ps_tuna_data$revenue)
# Get mean annual revenue
mean(ps_tuna_data$revenue)
# Build plot
ggplot(data = ps_tuna_data,
       mapping = aes(x = year, y = revenue)) +
  geom_line(linetype = "dashed") +
  geom_point() +
  labs(x = "Year",
       y = "Revenue (M USD)",
       title = "Value of the Bigeye tuna fishery in the Eastern Tropical Pacific",
       subtitle = "The x-axis is year, y-axis is Revenue (mt). Points representa annual totals",
       caption = "Data source: IATTC") +
  theme_minimal(base_size = 14,
                base_family = "Times")

  unique() |> 
  length()
  # Extra Exercise 1: Total catch by species during 2023

catch_2023 <- tuna_data |> 
  filter(year == 2023) |> 
  group_by(species) |> 
  summarize(total_catch = sum(catch) / 1e3)
# Build the figure
ggplot(data = catch_2023,
       aes(x = fct_reorder(species, total_catch, .desc = T),
           y = total_catch)) +
  geom_col() +
  labs(x = "Species code",
       y = "Total catch ('000 tons)") +
  coord_flip() +
  theme_bw()
# Extra Exercise 2: Which country caught the most tuna during 2020?

country_catch <- tuna_data |> 
  filter(year == 2020) |> 
  group_by(flag) |> 
  summarize(total_catch = sum(catch))

country_catch$flag[country_catch$total_catch == max(country_catch$total_catch)]
# Extra Exercise 3: Year of maximum catch for each species

tuna_data |> 
  group_by(year, species) |> 
  summarize(total_catch = sum(catch)) |> 
  group_by(species) |> 
  filter(total_catch == max(total_catch)) |> 
  select(species, year_of_max_catch = year) |> 
  arrange(species)
# Extra Exercise 4: Species caught by Mexican-flagged vessels since 2000

tuna_data |> 
  filter(
    flag == "MEX",
    year >= 2000
  ) |> 
  pull(species) |>
  unique() |> 
  length()


