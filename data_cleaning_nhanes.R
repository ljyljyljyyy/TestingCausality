#### Preamble ####
# Purpose: Prepare and clean the NHANES survey data
# Author: Jia Yuan Liu
# Date: 8 December 2020
# Contact: jiayuan.liu@mail.utoronto.ca

setwd("/Users/ljy/Desktop/")

library(NHANES)
library(tidyverse)
library(broom)
library(knitr)

small.nhanes <- NHANESraw %>%
  filter(NHANESraw$SurveyYr=="2009_10" & NHANESraw$Age > 17) %>% #only keep participants > 17 age and survey year 2009-10
  select("ID","Gender", "Age", "Poverty","Race1","Depressed","Education","BPSysAve","BPDiaAve","SleepHrsNight", "PhysActive",  "Smoke100","SleepTrouble") %>% # select rows of interest
  drop_na() # remove na observations

small.nhanes <- small.nhanes %>%
  mutate(Smoke = ifelse(Smoke100 == "Yes",1,0)) %>%
  mutate(SleepTrouble1 = ifelse(SleepTrouble == "Yes",1,0)) %>%
  mutate(Depression = ifelse(Depressed == "None",0,1))

# Saving the census data as a csv file in my
# working directory
write_csv(small.nhanes, "small_nhanes.csv")
