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
  labs(x = "Species", y=expression("Stomatal count per 0.16 mm"^2*""), fill = "Light Condition", 
       caption = "Figure 1. Stomatal count (per field of view, 0.16 square mm) for English ivy (Hedera helix) and Himalayan blackberry (Rubus armeniacus) collected from high-light and low-light environments in Pacific Spirit Park. The x-axis represents plant species, and the y-axis represents stomatal count per field of view. Boxplots show the distribution of stomatal counts for each species and light condition, where boxes represent the interquartile range, the horizontal line indicates the median, and whiskers represent the range of the data. Light conditions are indicated by shading (light grey = high light, dark grey = low light). Each group includes n = 8 samples. P-values represent results from a two-sample t-test comparing stomatal counts between high- and low-light conditions within each species. P-values for differences between high and low light treatments for both species were above 0.05 and therefore statistically non-significant. T-test values for ivy and blackberry were 0.722 and -1.715, respectively. Data were collected on February 28, 2026.")+
  theme(
    plot.caption = element_textbox_simple(
      width = unit(1, "npc"),  # full plot width
      margin = margin(t = 20)))+
  annotate("text", x = 2, y = 37, label = "p-value = 0.1171", 
           color = "black", fontface = "bold")+
  annotate("text", x = 1, y = 17, label = "p-value = 0.4898", 
           color = "black", fontface = "bold")


densityHighLow


#figure 2.
helix_annotation <- data.frame(
  mpg = 25,   # X-coordinate
  wt = 5,     # Y-coordinate
  species = "H. helix",    # Facet
  label = "R = 0.25, p-value = 0.37")

armeniacus_annotation <- data.frame(
  mpg = 25,   # X-coordinate
  wt = 5,     # Y-coordinate
  species = "R. armeniacus",    # Facet
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
            inherit.aes=F) + 
  labs(x = expression("PPFD Light Value (µmol m"^-2*" s"^-1*")"), y=expression("Stomatal count per 0.16 mm"^2*""), caption="Figure 2: Relationship between stomatal density (stomata per 0.16 mm²) and incident light (PPFD, µmol m^-2 s^-1) for Hedera helix and Rubus armeniacus in Pacific Spirit Park. Points represent individual samples, and lines represent linear regression fits with 95% confidence intervals. Sample sizes are n = 32 for H. helix and n = 30 for R. armeniacus.")+
  theme(
  plot.caption = element_textbox_simple(
    width = unit(1, "npc"),  # full plot width
    margin = margin(t = 20)))
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


#Figure 3.

cor.test(ivyData$canopy_cover,ivyData$stomata_avg)
cor.test(blackberryData$canopy_cover,blackberryData$stomata_avg)

helix_annotation_canopy <- data.frame(
  mpg = 40,   # X-coordinate
  wt = 5,     # Y-coordinate
  species = "H. helix",    # Must specify the facet level
  label = "R = -0.44, p-value = 0.09")

armeniacus_annotation_canopy <- data.frame(
  mpg = 40,   # X-coordinate
  wt = 5,     # Y-coordinate
  species = "R. armeniacus",    # Must specify the facet level
  label = "R = -0.244, p-value = 0.45")

canopyValues <- stomataTidy %>%
  ggplot(aes(x=canopy_cover, y=stomata_avg, color = species)) + 
  geom_point() + 
  geom_smooth(method = "lm")+
  facet_wrap(~species)+
  geom_text(data=helix_annotation_canopy,aes(x=mpg,y=wt,label=label),
            color="black",
            size=4,
            inherit.aes=F)+
  geom_text(data=armeniacus_annotation_canopy,aes(x=mpg,y=wt,label=label),
            color="black",
            size=4,
            inherit.aes=F) + 
  labs(x = "Canopy Cover (%)", y=expression("Stomatal count per 0.16 mm"^2*""),caption="Figure 3: Relationship between stomatal density (stomata per 0.16 mm²) and canopy cover (%) for Hedera helix and Rubus armeniacus in Pacific Spirit Park. Points represent individual samples, and lines represent fitted trend lines. Sample sizes are n = 32 for H. helix and n = 30 for R. armeniacus.")+
  theme(
    plot.caption = element_textbox_simple(
      width = unit(1, "npc"),  # full plot width
      margin = margin(t = 20)))

canopyValues

#Figure 4.
t.test(as.numeric(stomata_avg) ~ leaf_position, data = ivyStats)
t.test(as.numeric(stomata_avg) ~ leaf_position, data = blackberryStats)


helix_annotation_height <- data.frame(
  mpg = 1.5,   # X-coordinate
  wt = 5,     # Y-coordinate
  species = "H. helix",    # Must specify the facet level
  label = "t = -1.73, p-value = 0.155")

armeniacus_annotation_height <- data.frame(
  mpg = 1.5,   # X-coordinate
  wt = 5,     # Y-coordinate
  species = "R. armeniacus",    # Must specify the facet level
  label = "t = 2.76, p-value = 0.06")

heightValues <- stomataTidy %>%
  ggplot(aes(x=leaf_position, y=stomata_avg, fill = leaf_position)) + 
  geom_boxplot() + 
  scale_fill_manual(values = c("low" = "#b37724", "med" = "#FFAA33"))+
  geom_smooth(method = "lm")+
  facet_wrap(~species) + 
  geom_text(data=helix_annotation_height,aes(x=mpg,y=wt,label=label),
            color="black",
            size=4,
            inherit.aes=F)+
  geom_text(data=armeniacus_annotation_height,aes(x=mpg,y=wt,label=label),
            color="black",
            size=4,
            inherit.aes=F) +
  labs(x = "Height", y=expression("Stomatal count per 0.16 mm"^2*""), caption = "Figure 4. Stomatal count (per field of view, 0.16 square mm) for English ivy (Hedera helix) and Himalayan blackberry (Rubus armeniacus) collected from differing heights in Pacific Spirit Park. \nThe x-axis represents the categorical height of plants seperated into their respective species, and the y-axis represents stomatal count per field of view. Light conditions are indicated by shading (dark yellow = low height, orange yellow = medium height). Each group includes n = 8 samples. \nP-values represent results from a two-sample t-test comparing stomatal counts between medium and low plant conditions within each species. P-values for differences between high and low light treatments for both species \nwere above 0.05 and therefore statistically non-significant. T-test values for ivy and blackberry were -1.73 and 2.76, respectively. \nData were collected on February 28, 2026.")+
  theme(
    plot.caption = element_textbox_simple(
      width = unit(1, "npc"),  # full plot width
      margin = margin(t = 20)))
heightValues

ggsave('./figures/canopyValues.PNG', plot = canopyValues)
ggsave('./figures/heightValues.PNG',plot = heightValues)
