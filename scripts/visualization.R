library(tidyverse)
library(dplyr)
library(magrittr)
library(ggplot2)
library(ggsignif)
library(ggtext)

stomataTidy <-read.csv("./data/outputs/stomataTidy.csv")

stomataTidy %>%
  ggplot(aes(x=species,y=stomata_avg,fill = light_condition))+
  geom_boxplot()+
  scale_fill_manual(values = c("high" = "white", "low" = "darkgrey"))+
  labs(x = "Species", y="Stomatal Count per 0.16 square mm", fill = "Light Condition", 
       caption = "Figure 1. Stomatal count (per field of view, 0.16 square mm) for English ivy (Hedera helix) and Himalayan blackberry (Rubus armeniacus) collected from high-light and low-light environments in Pacific Spirit Park. The x-axis represents plant species, and the y-axis represents stomatal count per field of view. Boxplots show the distribution of stomatal counts for each species and light condition, where boxes represent the interquartile range, the horizontal line indicates the median, and whiskers represent the range of the data. Light conditions are indicated by shading (light grey = high light, dark grey = low light). Each group includes n = 8 samples. P-values represent results from a two-sample t-test comparing stomatal counts between high- and low-light conditions within each species. P-values for differences between high and low light treatments for both species were above 0.05 and therefore statistically non-significant. T-test values for ivy and blackberry were 0.722 and -1.715, respectively. Data were collected on February 28, 2026.")+
  theme(
    plot.caption = element_textbox_simple(
      width = unit(1, "npc"),  # full plot width
      margin = margin(t = 20)))+
  annotate("text", x = 2, y = 37, label = "p-value = 0.1171", 
           color = "black", fontface = "bold")+
  annotate("text", x = 1, y = 17, label = "p-value = 0.4898", 
           color = "black", fontface = "bold")

blackberryData <- stomataTidy %>% 
  filter(species =="R. armeniacus")

blackberryStats <- blackberryData%>%
  filter(!is.na(stomata_avg))

ivyData <- stomataTidy %>% 
  filter(species =="H. helix")

ivyStats <- ivyData %>%
  filter(!is.na(stomata_avg))

t.test(as.numeric(stomata_avg) ~ light_condition, data = ivyStats)

t.test(as.numeric(stomata_avg) ~ light_condition, data = blackberryStats)
