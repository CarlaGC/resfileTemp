## Finding your way arround the S file querying 


#### Set up #### 

# Call in supporting packages
library(tidyverse)
# For now most of the exploration is done in Base R as it is very simple 

# Load data - 2022 NIR Resfile
## This the resfile that was produced in 2022 and contains data until 2020.

directory <- "M:/Current Databases retain in m drive/NZCAS datasets/CRA analysis"
resfile_dir <- "/cra_run_qa/res_files"
run_A <- "/official"
dataA <- "NIR2022"


resall_2022  <- readRDS(paste0(directory,resfile_dir,run_A,"/res_all_NIR_2022.rds"))

#### Basics about the Res file #### 

#How big is the file?
dim(resall_2022) #  56 columns (i.e variables) x > 4.5 million rows (i.e observations)
#What type of R object is it
str(resall_2022)  # Dataframe (also renders a quick summary of variables)



#### Explore resfile Columns/variables  #### 

# t89_year
summary(resall_2022$t890_Year) 
## Covers the range of years for which the CRA reports land use changes (1962 - 2020)
## 1962 comes from preparing all the areas and processes we need to have modelled to have the correct set up for 1991 


# Land use columns ####

# t890_FromLandUseSubCategory 
sort(unique(resall_2022$t890_FromLandUseSubCategory)) 
# t890_ToLandUseSubCategory 
sort(unique(resall_2022$t890_ToLandUseSubCategory))
## To and from land uses for the land use change described in the row

# Description of categories

##Land use  is divided into categories and subcategories in three nested levels. 
## Each category has a unique numeric code assigned to it. 
## Below is a description of each subcategory using it code, category and subcategories

### t890_ToLandUseSubCategory - to_land_use_1 - to_land_use_2 - to_land_use_3 


## 82 - Other land - Other land - Other land

## 81 - Settlements - Settlements - Settlements

## 80	Wetlands - Wetland - vegetative non forest	Wetland - vegetative non forest
## 79	Wetlands - Wetland - open water	Wetland - open water

## 78 - Cropland - Cropland - annual - Cropland - annual
## 77 - Cropland - Cropland - perennial	- Cropland - perennial

## 76 - Grassland	Grassland - low producing	Grassland - low producing
## 75 - Grassland	Grassland - high producing	Grassland - high producing
## 74 - Grassland	Grassland - with woody biomass	Grassland - with woody biomass - Operational
### 741 - Grassland	Grassland - with woody biomass	Grassland - with woody biomass - Non-operational

## 73	Forest Land	- Post-1989 Forest Post-1989 Forest - Net Stocked Area
### 731	Forest Land	- Post-1989 Forest	Post-1989 Planted Forest - Unstocked Area ## Areas with roads, tracks, skid sites within planted forests

## 72 - Forest Land	- Pre-1990 Planted Forest - Pre-1990 Planted Forest - Net Stocked Area
### 721 - Forest Land	- Pre-1990 Planted Forest - Pre-1990 Planted Forest - Unstocked Area ## Areas with roads, tracks, skid sites within planted forests
### 722 - Forest Land	- Pre-1990 Planted Forest - Pre-1990 Planted Forest - Riparian etc ## Riparian margings within planted forests

## 71 - Forest Land	- Natural Forest	 - Natural Forest - Tall Forest
### 711 - Forest Land	 - Natural Forest	- Natural Forest - Regenerating
### 712 - Forest Land	- Natural Forest - 	Natural Forest - Post-1989 Regenerating ## HOW is this different from 70? 

## 70 - Forest Land	- Post-1989 Natural Regenerating Forest - Post-1989 Natural Regenerating Forest

# LUC_event_flag
unique(resall_2022$LUC_event_flag) 
## 1 = the corresponding row captures a land use change 
## 0 = the corresponding row does not capture a land use change

# Carbon pools ####

# t890_CarbonPool
sort(unique(resall_2022$t890_CarbonPool))
## 0 = Above-ground biomass (AGB), 1 = Below-ground Biomass (BGB), 2 = Deadwood, 3 = Litter, 4 = Soil 

# Soil type ####

# t890_SoilType
sort(unique(resall_2022$t890_SoilType))
## 0 = Mineral, 1 = Organic 

# t890_OrganicSoilClimate
unique(resall_2022$t890_OrganicSoilClimate)
## 0 = Cold, 1 = Warm
## This distinction is only applicable to organic soils, mineral soils have NA
resall_2022 %>%
  count(t890_OrganicSoilClimate,t890_SoilType, sort= TRUE)
## All mineral soils (0) have NA value for soil climate 

# Unclear ones ####

# 890_LandUseAreaId 
# t890_PreviousLandUseAreaID 
#! Unclear ## Unique ids for the different segments of land?

# Why some columns have the t890 and t891 prefix, what does this mean? 

# t890_AreaRemaining - WHAT does this mean? 
summary(resall_2022$t890_AreaRemaining) 
plot(resall_2022$t890_AreaRemaining)


## t89_UserFlag
unique(resall_2022$t890_UserFlag) # has 3 values, 0.3, 1 WHAT do they mean? 

##t890_PolygonId 
unique(resall_2022$t890_PolygonId) # Any idea where NA IDS come from? 

##t890_PolygonId 
unique(resall_2022$t890_PolygonId) #

# What is the difference between t890 and t891?

# t890_Year - t890_StartYear # start year of an event vs. final year. 
summary(resall_2022$t890_StartYear)
summary(resall_2022$t890_Year)
