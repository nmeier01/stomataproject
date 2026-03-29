library(tidyverse)
library(dplyr)
library(magrittr)
library(ggplot2)
library(ggsignif)
library(ggtext)

stomataTidy <-read.csv("./data/outputs/stomataTidy.csv")

densityHighLow <- stomataTidy %>%
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


densityPlot

helix_annotation <- data.frame(
  mpg = 25,   # X-coordinate
  wt = 5,     # Y-coordinate
  species = "H. helix",    # Must specify the facet level
  label = "R = 0.25, p-value = 0.37")

armeniacus_annotation <- data.frame(
  mpg = 25,   # X-coordinate
  wt = 5,     # Y-coordinate
  species = "R. armeniacus",    # Must specify the facet level
  label = "R = -0.299, p-value = 0.346")

densityValues <- stomataTidy %>%
  ggplot(aes(x=light_value, y=stomata_avg, color = species)) + 
  geom_point() + 
  geom_smooth(method = "lm")+
  facet_wrap(~species)+
  geom_text(data=helix_annotation,aes(x=mpg,y=wt,label=label),
            color="black",
            size=4,
            inherit.aes=F)+
  geom_text(data=armeniacus_annotation,aes(x=mpg,y=wt,label=label),
            color="black",
            size=4,
            inherit.aes=F)
densityValues

ggsave('./figures/densityHighLow.PNG', plot = densityHighLow)
ggsave('./figures/densityValues.PNG',plot = densityValues)
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

cor.test(ivyData$light_value,ivyData$stomata_avg)
cor.test(blackberryData$light_value,blackberryData$stomata_avg)
