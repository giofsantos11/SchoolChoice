library(sf)
library(tmap)
library(tidyverse)
library(rnaturalearth)
library(lwgeom)  # Required for st_make_valid
library(ggplot2)
library(maps)
library(mapdata)
library(dplyr)  # Load dplyr for data manipulation

world <- map_data("world")
# List of countries with "Evaluated Education PPPs"
evaluated_ppps <- c("India", "USA", "UK", "Colombia", "Liberia", "Uganda", "Pakistan", "Philippines", "Venezuela", "Peru", "Haiti", "Sierra Leone", "Chile", "Netherlands", "Denmark", "Hong Kong", "Argentina", "Bangladesh", "Switzerland", "Germany", "Latvia", "Kenya", "Sweden", "Canada")

# List of countries with "Education PPP experience"
education_ppp_experience <- c("Hungary", "Guatemala", "Sweden", "Venezuela", "Chile", "Greece", "Haiti", "Gambia", "Honduras", "South Africa", "Uganda", "Bolivia", "New Zealand", "Canada", "Ireland", "Brazil", "Ecuador", "Qatar", "South Korea", "El Salvador", "Ivory Coast", "Netherlands", "Colombia", "Germany", "Dominican Republic", "UK", "USA", "Scotland", "Panama", "Bangladesh", "Nicaragua", "Belgium", "Mauritius", "Thailand", "Czech Republic", "Peru", "Philippines", "Argentina", "Egypt", "Pakistan", "Norway", "Senegal", "Italy", "Paraguay", "Denmark", "India", "Australia")

# Create a data frame to map country names
iso_to_country <- data.frame(
  country = unique(c(evaluated_ppps, education_ppp_experience))
)

# Map the ISO codes in 'world' to their respective country names
world$country <- ifelse(world$region %in% iso_to_country$country, world$region, NA)

# Add a tag to each country indicating if it is in the evaluated_ppps or education_ppp_experience list
world <- world %>%
  mutate(tag = case_when(
    region %in% evaluated_ppps ~ "Evaluated Education PPPs",
    region %in% education_ppp_experience ~ "Education PPP experience",
    TRUE ~ "Otherwise"
  ))

# Plot the map using Mercator projection
ggplot(data = world, aes(x=long, y=lat, group=group)) + 
  geom_polygon(aes(fill = tag)) +  # Map fill to the new 'tag' column
  theme_minimal() + 
  theme(axis.text.x=element_blank(),
        axis.text.y=element_blank(), 
        legend.position = "bottom") +
  scale_fill_manual(values = c("Evaluated Education PPPs" = "#a6611a", "Education PPP experience" = "#1c9099", "Otherwise" = "#bdbdbd"))
