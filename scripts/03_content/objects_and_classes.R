objects_and_classes.R
################################################################################
# Object Classes and Assignment
################################################################################
#
# Riza Medetkhan
# Your email here
# 2026-09-25
#
# Description: Exercises on object classes and assignment in R.
#
################################################################################

my_name <- "Riza"
my_lucky_number <- 7
is_student <- TRUE

class(my_name)
class(my_lucky_number)
class(is_student)
# Convert lucky number to character
my_lucky_number <- as.character(my_lucky_number)

# Check that it worked
class(my_lucky_number)
as.numeric(TRUE) # Convert `TRUE` to numeric using `as.numeric()`
as.numeric("hello") # Try to convert `"hello"` to `numeric` - what happens?
# Build a pipeline
my_lucky_number <- 32 # Start with my_lucky_number as numeric again

# And now build the pipeline
my_lucky_number |> 
  as.character() |> 
  class()
length_m <- c(6, 4.1, 2.8, 5.5, 3.9, 5.8)
shark_species <- c(
  "Great White Shark",
  "Lemon Shark",
  "Bull Shark",
  "Hammerhead Shark",
  "Mako Shark",
  "Great White Shark"
)
length(length_m)
length(shark_species)
shark_species |>
  unique() |>
  length()
length_m
max(length_m)
mean(length_m[shark_species == "Great White Shark"])


























