library(tidyverse)
library(dplyr)

stomataData <- read.csv("./data/raw_stomata_data.csv", stringsAsFactors = TRUE)

stomataDataTidy <- stomataData %>% 
  mutate(area_number = substr(sample_id,1,1)) %>%
  mutate(sample_number = c(1:32))

write.csv(stomataDataTidy,file="./data/outputs/stomataTidy.csv")

#So that we can analyze properties of the species as a whole

blackberryData <- stomataData %>% 
  filter(species =="blackberry")
#So that we can analyze properties of the species as a whole

highexposure <- stomataData %>% 
  filter(light_condition =="high")
#So that we can compare factors about plants grown in high light conditions

lowexposure <-stomataData %>% 
  filter(light_condition =="low")
#So that we can compare factors about plants grown in low light conditions


highIvy <- highexposure %>% 
  filter(species =="ivy")
#So that we can look at ivy grown in high light condition


lowIvy <- lowexposure %>% 
  filter(species =="ivy")
#So that we can look at ivy grown in low light conditions

highBb <- highexposure %>% 
  filter(species =="blackberry")
#So that we can look at blackberry grown in high light condition


lowBb <- lowexposure %>% 
  filter(species =="blackberry")
#So that we can look at blackberry grown in low light conditions


lowPlants <- stomataData %>% 
  filter(leaf_position =="low")

#filters for plants that are only low to the ground to reduce potential variations caused from height of plant leaves

lowCover <- stomataData %>% 
  filter(canopy_cover <= "60")
#Filters for plants that have less than or equal to 60% canopy cover

highCover <-  stomataData %>% 
  filter(canopy_cover > "60")
#Filters for plants that have more than 60% canopy cover

openIvy <- lowCover %>% 
  filter(species =="ivy")
#Filters for ivy with low cover

coveredIvy <- highCover %>% 
  filter(species =="ivy")
#Filters for ivy with high cover

openBB <- lowCover %>% 
  filter(species =="blackberry")
#Filters for blackberry with low cover

coveredBB <- highCover %>% 
  filter(species =="blackberry")
#Filters for blackberry with high cover
