# Tuna Catch in the Eastern Pacific Ocean, 1918–2024

I used catch data from the Inter-American Tropical Tuna Commission (IATTC) to explore tuna catch by year, species, fishing gear, and vessel flag. This repository includes the original and cleaned data, the R scripts I used, three plots, and a map of catch by vessel flag.

## Data sources

- File in this repository: `data/raw/CatchByFlagGear/CatchByFlagGear1918-2024.csv`
- Dataset title: EPO total estimated catch by year, flag, gear, species
- Source: [IATTC public domain data for download](https://www.iattc.org/en-US/Data/Public-domain)
- Version used: The data cover 1918–2024. The PDF that came with the data gives December 2025 as the publication date.
- What the data contain: The estimated amount of catch kept in the Eastern Pacific Ocean, reported in metric tonnes by year, vessel flag, fishing gear, and species.

## Repository structure and contents

- `.gitignore`: Tells Git to ignore local files such as `.DS_Store`.
- `Portfolio 2.Rproj`: Opens this repository as a project in RStudio.
- `README.md`: Explains the project, where the data came from, and what each file does.

- `data/`: Contains the original IATTC files and the cleaned data.
  - `data/raw/CatchByFlagGear/`: Contains the original CSV and the PDF that came with it.
    - `data/raw/CatchByFlagGear/CatchByFlagGear1918-2024.csv`: Original IATTC catch data. Both `scripts/01_processing/data_processing.R` and `scripts/02_analysis/tuna_analysis.R` read this file.
    - `data/raw/CatchByFlagGear/CatchByFlagGear.pdf`: Explains the data columns, units, and codes.
  - `data/processed/`: Contains the cleaned data used for the plots and map.
    - `data/processed/tuna_clean.rds`: Cleaned catch data saved by `scripts/01_processing/data_processing.R`. Both visualization scripts read this file.

- `scripts/`: Contains the R scripts for cleaning, exploring, and plotting the data.
  - `scripts/01_processing/`: Contains the data cleaning script.
    - `scripts/01_processing/data_processing.R`: Reads `data/raw/CatchByFlagGear/CatchByFlagGear1918-2024.csv`, renames columns, converts years to integers, and adds a catch column in kilotonnes. It saves the cleaned data as `data/processed/tuna_clean.rds`.
  - `scripts/02_analysis/`: Contains the additional catch analysis.
    - `scripts/02_analysis/tuna_analysis.R`: Reads the original IATTC CSV. It includes calculations for estimated bigeye tuna revenue and extra exercises on catch by species and vessel flag.
  - `scripts/03_content/`: Contains the scripts for making the plots and map.
    - `scripts/03_content/exploratory_data_visualization.R`: Reads `data/processed/tuna_clean.rds` and saves three plots of total catch by year, species, and fishing gear in `results/img/`.
    - `scripts/03_content/spatial_data_visualization.R`: Reads `data/processed/tuna_clean.rds` and adds up catch by vessel flag. It uses Natural Earth boundaries from the `rnaturalearth` package and saves the map as `results/img/tuna_catch_by_flag.png`.

- `results/`: Contains the figures saved by the visualization scripts.
  - `results/img/`: Contains the three plots and the map.
    - `results/img/total_catch_by_gear.png`: Bar chart of total catch in kilotonnes by fishing gear. Made by `scripts/03_content/exploratory_data_visualization.R`.
    - `results/img/total_catch_by_species.png`: Bar chart of total catch in kilotonnes by species. Made by `scripts/03_content/exploratory_data_visualization.R`.
    - `results/img/total_tuna_catch_over_time.png`: Line plot of total catch in kilotonnes by year. Made by `scripts/03_content/exploratory_data_visualization.R`.
    - `results/img/tuna_catch_by_flag.png`: Map of total catch in kilotonnes by vessel flag. The color shows the total reported catch for each vessel flag. Made by `scripts/03_content/spatial_data_visualization.R`.