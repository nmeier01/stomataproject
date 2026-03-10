BIOL 406 – Lab 7 Draft Data Frame


Project Title
Stomatal Density Responses to Light Conditions in Ivy and Himalayan Blackberry


Dataset Description
This dataset contains draft field and laboratory measurements for BIOL 406 plant ecology project investigating how light exposure influences stomatal density in two plant species: English ivy and Himalayan blackberry. Leaves were sampled from sites in Pacific Spirit Park classified as either high-light or low-light environments, with eight sites sampled for each light condition per species. Stomata were counted from microscope images of leaf impressions.


Note
Field data collection is still ongoing. Some values in this dataset are placeholder or dummy values used to demonstrate the intended data structure and workflow for this assignment.




Files in this Dataset


raw_stomata_data.csv
This file contains the raw observational data collected during field sampling and microscope analysis.


tidy_stomata_data.csv
This file contains a cleaned and organized version of the dataset produced using the R script. In this dataset each row represents one observation and each column represents one variable, making it suitable for analysis.


Variables


sample_id
Unique identifier assigned to each sample so that observations can be tracked consistently throughout the dataset and analysis.

area_number
Unique number for the area from which plants were found and their leaves were collected. Some plants were collected in the same area, so they have the same area number. 

sample_number
Unique identifier of the number of the sample collected. Numeric, no letter value included. 


species
Plant species sampled.


Possible values:
ivy – English ivy (Hedera helix)
blackberry – Himalayan blackberry (Rubus armeniacus)


leaf_position
Position of the sampled leaf on the plant. This variable is used to reduce variation caused by differences in plant height or leaf age.


light_condition
Categorical variable indicating whether the plant was sampled in a high-light or low-light environment.


Possible values:
high – high light exposure
low – low light exposure


light_value
Quantitative measurement of light intensity recorded at the sampling location, measured as photosynthetic photon flux density (PPFD).


Units: µmol m⁻² s⁻¹


canopy_cover
Estimated percentage of canopy cover above the sampled plant. This variable provides an additional indicator of light availability.


Units: percent (%)


stomata_count
Number of stomata counted in the microscope image of the sampled leaf impression.


Purpose of the Dataset
The dataset will be used to compare stomatal density between species and across different light environments.