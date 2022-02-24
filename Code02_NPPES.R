# Code02_NPPES------------------------------------------------------------------

## Date Created:  10/23/2021
## Date Edited:   10/23/2021
## Description:   Data cleaning: NPPES

library(haven)
library(dplyr)

# Preliminaries -----------------------------------------------------------
# if (!require("pacman")) install.packages("pacman")
# pacman::p_load(tidyverse, ggplot2, dplyr, lubridate, stargazer, knitr, 
#                kableExtra,lfe, modelr, gtsummary, ggrepel, dotwhisker, panelView)


nppes <-  read_csv(file=paste0(data.path,'/npidata_pfile_20050523-20210613.csv'))  #330 vars, 6,891,678 obs

#Refer to "NPPES_Data_Dissemination_CodeValues.pdf" in the NPPES Data Dissessimination files 
#for explanation of variables and to "https://taxonomy.nucc.org/" for definitions of taxonomy codes.

#Replace spaces from column names into underscore
names(nppes)<-str_replace_all(names(nppes), c(" " = "_" ))

#Rename one column's name
nppes_01 <- rename(nppes, Code = Healthcare_Provider_Taxonomy_Code_1)

#Tabulate entity code ()
table(nppes_01$Entity_Type_Code)
typeof(nppes_01$Entity_Type_Code)

#Keep rows whose entity code ==1, and drop missing(NA) and type 2 codes
nppes_01 <- subset(nppes_01,  Entity_Type_Code!= 2)                              #330 vars, 5,218,962 obs

#Drop unnecessary variables
#names(nppes_01)
drop <- c("Entity_Type_Code","Replacement_NPI", "Is_Organization_Subpart", "NPI_Deactivation_Reason_Code" )
nppes_01 = nppes_01[,!(names(nppes_01) %in% drop)]                               #326 vars, 5,218,962 obs


#Drop all variables with containing words 'Other_Provider_Identifier'
nppes_01 <- nppes_01 %>% select(-contains(c( "Other_Provider_Identifier",
                                             "Provider_License_Number",
                                             "Healthcare_Provider_Taxonomy_Group",
                                             "Healthcare_Provider_Primary_Taxonomy_Switch",
                                             "Provider_Other",
                                             "Healthcare_Provider_Taxonomy_Code",
                                             "Parent_Organization",
                                             "Authorized_Official")))           #33 vars, 5,211,031 obs


#Drop unnecessary variables/columns
rm(drop)
drop <- c("Provider_Name_Prefix_Text",
          "Provider_Name_Suffix_Text",
          "Provider_Credential_Text",
          "Entity_Type_Code",
          "Replacement_NPI",
          "Is_Organization_Subpart",
          "NPI_Deactivation_Reason_Code",
          "NPI_Deactivation_Date",
          "NPI_Reactivation_Date", 
          "Last_Update_Date",  
          "Provider_Enumeration_Date",
          "Provider_Middle_Name")
nppes_01 = nppes_01[,!(names(nppes_01) %in% drop)]                              #25 vars, 5,211,031 obs


#setwd("/Users/swatiasnani/OneDrive - Emory University/Research/Thirdyearpaper/Code/Revised_23Oct/Data")
saveRDS(nppes_01, file = "/FinalData/nppes_01.Rds")                                  

                               







