library(tidyverse)
library(dplyr)
library(magrittr)
library(ggplot2)

stomataTidy <-read.csv("./data/outputs/stomataTidy.csv")

stomataTidy %>%
  ggplot(aes(x=species,y=stomata_avg,fill = light_condition))+
  geom_boxplot()+
  scale_fill_manual(values = c("high" = "white", "low" = "darkgrey"))+
  labs(x = "Species", y="Stomatal Count", fill = "Light Condition")



blackberryData <- stomataTidy %>% 
  filter(species =="blackberry")

blackberryStats <- blackberryData%>%
  filter(!is.na(stomata_avg))

ivyData <- stomataTidy %>% 
  filter(species =="ivy")

ivyStats <- ivyData %>%
  filter(!is.na(stomata_avg))

t.test(as.numeric(stomata_avg) ~ light_condition, data = ivyStats)

t.test(as.numeric(stomata_avg) ~ light_condition, data = blackberryStats)
