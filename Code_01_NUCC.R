# Code01_NUCC --------------------------------------------------------------------

## Date Created:  9/3/2021
## Date Edited:   10/03/2021
## Description:   Data cleaning: NUCC

# Preliminaries -----------------------------------------------------------

if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, ggplot2, dplyr, lubridate, stargazer, knitr, kableExtra,
               lfe, modelr, gtsummary, ggrepel, dotwhisker, panelView)

library(haven)

#setwd("/Users/swatiasnani/OneDrive - Emory University/Research/Thirdyearpaper")
source('Code/Code00_Paths.R')

crosswalk <-  read_csv(file=paste0(data.path,'/nucc_taxonomy_211.csv'))    
crosswalk <- crosswalk[!(crosswalk$Section == "Non-Individual"),]

#temp <- crosswalk[!(crosswalk$Section == "Individual"),]


table(crosswalk$Grouping)

#Replace spaces from column names into underscore
names(crosswalk)<-str_replace_all(names(crosswalk), c(" " = "_" ))

##Drop unrequired specialties and classifications(using Method 1)
#//535 observations deleted, 331 left
crosswalk_01 <-   crosswalk[!(crosswalk$Grouping=="Behavioral Health & Social Service Providers"| 
                                crosswalk$Grouping=="Dental Providers"| 
                                crosswalk$Grouping=="Dietary & Nutritional Service Providers"| 
                                crosswalk$Grouping=="Emergency Medical Service Providers"| 
                                crosswalk$Grouping=="Eye and Vision Services Providers"| 
                                crosswalk$Grouping=="Suppliers"|
                                crosswalk$Grouping=="Transportation Services"|
                                crosswalk$Grouping=="Agencies"|
                                crosswalk$Grouping=="Group"|
                                crosswalk$Grouping=="Hospital Units"|
                                crosswalk$Grouping=="Hospitals"|
                                crosswalk$Grouping=="Laboratories"|
                                crosswalk$Grouping=="Managed Care Organizations"|
                                crosswalk$Grouping=="Student, Health Care"|
                                crosswalk$Grouping=="Technologists, Technicians & Other Technical Service Providers"|
                                crosswalk$Grouping=="Nursing Service Providers"|
                                crosswalk$Grouping=="Nursing Service Related Providers"|
                                crosswalk$Grouping== "Other Service Providers" |
                                crosswalk$Grouping=="Respite Care Facility"|
                                crosswalk$Grouping=="Pharmacy Service Providers"|
                                crosswalk$Grouping=="Physician Assistants & Advanced Practice Nursing Providers"|
                                crosswalk$Grouping=="Residential Treatment Facilities"|
                                crosswalk$Grouping=="Ambulatory Health Care Facilities"|
                                crosswalk$Grouping=="Nursing & Custodial Care Facilities"|
                                crosswalk$Grouping=="Speech, Language and Hearing Service Providers"),]

##Drop unrequired specialties and classifications (using subset method, 
#this method also removes NA rows under default setting)
##We put a condition to not drop NA rows
crosswalk_01 <- subset(crosswalk_01,  Classification!= "Anesthesiology" & 
                         Classification!= "Art Therapist" & 
                         Classification!= "Assistant, Podiatric" &
                         Classification!= "Clinical Pharmacology" &
                         Classification!= "Dance Therapist" &
                         Classification!= "Emergency Medicine" &
                         Classification!= "Hospitalist" &
                         Classification!= "Independent Medical Examiner" &
                         Classification!= "Legal Medicine" &
                         Classification!= "Massage Therapist" &
                         Classification!= "Music Therapist" &
                         Classification!= "Occupational Therapist" &
                         Classification!= "Occupational Therapy Assistant" &
                         Classification!= "Pain Medicine" &
                         Classification!= "Pathology" &
                         Classification!= "Physical Therapy Assistant" &
                         Classification!= "Preventive Medicine" &
                         Classification!= "Radiology"|is.na(Classification))

##Drop unrequired specialties and classifications (using subset method)
#//11 observations deleted, 239 left
crosswalk_01 <- subset(crosswalk_01,  Classification!= "Art Therapist" &
                         Classification!= "Dance Therapist" & 
                         Classification!= "Kinesiotherapist" & 
                         Classification!= "Mastectomy Fitter" & 
                         Classification!= "Music Therapist" & 
                         Classification!= "Orthotic Fitter" & 
                         Classification!= "Recreation Therapist" & 
                         Classification!= "Recreational Therapist Assistant" & 
                         Classification!= "Orthotist" &
                         Classification!= "Rehabilitation Counselor" &
                         Classification!= "Rehabilitation Practitioner"|is.na(Classification))
##Tabulate conditionally                         
table(crosswalk_01$Classification[crosswalk_01$Grouping=='Allopathic & Osteopathic Physicians'])                         

##Drop specialties under Allopathic and ortho grouping
crosswalk_01 <- subset(crosswalk_01,  Classification!= "Dermatology" &
                         Classification!= "Neuromusculoskeletal Medicine & OMM" & 
                         Classification!= "Neuromusculoskeletal Medicine, Sports Medicine" & 
                         Classification!= "Allergy & Immunology" & 
                         Classification!= "Electrodiagnostic Medicine"|is.na(Classification))

crosswalk_01 <- subset(crosswalk_01,  Specialization!= "Hospice and Palliative Medicine"|is.na(Specialization))


##Drop unnecessary columns (using subset method, which can't take variable names with spaces)
names(crosswalk_01)
crosswalk_01 = subset(crosswalk_01, select = -c(Notes,Section))

##Drop unnecessary columns (by defining a new variable and tellin R to not include the names in that variable)
drop <- c("Deactivation_Date","Effective_Date","Last_Modified_Date")
crosswalk_01 = crosswalk_01[,!(names(crosswalk_01) %in% drop)]

##Tabulate conditionally
table(crosswalk_01$Display_Name[crosswalk_01$Grouping=='Chiropractic Providers'])  

##Drop undesired specialties(rows)
crosswalk_01 <- crosswalk_01[!(crosswalk_01$Grouping=="Chiropractic Providers"),] 

#Drop rows again
crosswalk_01 <- crosswalk_01[!(crosswalk_01$Classification=="Medical Genetics"| 
                                 crosswalk_01$Classification=="Neuromusculoskeletal Medicine, Sports Medicine"| 
                                 crosswalk_01$Classification=="Nuclear Medicine"| 
                                 crosswalk_01$Classification=="Obstetrics & Gynecology"| 
                                 crosswalk_01$Classification=="Ophthalmology"| 
                                 crosswalk_01$Classification=="Oral & Maxillofacial Surgery"|
                                 crosswalk_01$Classification=="Physical Therapist"|
                                 crosswalk_01$Classification=="Prosthetist"|
                                 crosswalk_01$Classification=="Pulmonary Function Technologist"|
                                 crosswalk_01$Classification=="Developmental Therapist"|
                                 crosswalk_01$Classification=="Pediatrics"|
                                 crosswalk_01$Classification=="Respiratory Therapist, Certified"|
                                 crosswalk_01$Classification=="Respiratory Therapist, Registered"|
                                 crosswalk_01$Classification=="Specialist/Technologist"|
                                 crosswalk_01$Classification=="Psychiatry & Neurology"),]
table(crosswalk_01$Display_Name)                              


crosswalk_01 <- crosswalk_01[!(crosswalk_01$Grouping=="Respiratory, Developmental, Rehabilitative and Restorative Service Providers"),]                       


#Drop rows again
crosswalk_01 <- subset(crosswalk_01,  Display_Name!= "Otolaryngology Physician" &
                         Display_Name!= "Otolaryngic Allergy Physician" & 
                         Display_Name!= "Otology & Neurotology Physician" & 
                         Display_Name!= "Pediatric Otolaryngology Physician" & 
                         Display_Name!= "Sleep Medicine (Otolaryngology) Physician" & 
                         Display_Name!= "Phlebology Physician" & 
                         Display_Name!= "Physical Medicine & Rehabilitation Physician" & 
                         Display_Name!= "Brain Injury Medicine (Physical Medicine & Rehabilitation) Physician" & 
                         Display_Name!= "Neuromuscular Medicine (Physical Medicine & Rehabilitation) Physician" &
                         Display_Name!= "Pain Medicine (Physical Medicine & Rehabilitation) Physician" &
                         Display_Name!= "Pediatric Rehabilitation Medicine Physician" &
                         Display_Name!= "Spinal Cord Injury Medicine Physician" &
                         Display_Name!= "Podiatrist" &
                         Display_Name!= "Sports Medicine (Physical Medicine & Rehabilitation) Physician"	 &
                         Display_Name!= "Deactivated - Podiatrist" &
                         Display_Name!= "Primary Podiatric Medicine Podiatrist" &
                         Display_Name!= "Public Medicine Podiatrist" &
                         Display_Name!= "Radiology Podiatrist" &
                         Display_Name!= "Sports Medicine Podiatrist" &
                         Display_Name!= "Pediatric Urology Physician"|is.na(Display_Name))


##Check if there are any duplicates based on Code variable
length(unique(crosswalk_01$Code)) == nrow(crosswalk_01) 

#Output: TRUE, which means no duplicates! 

#Save the R dataset
saveRDS(crosswalk_01, file = "/FinalData/crosswalk_01.Rds")                                  

##################################################################################







