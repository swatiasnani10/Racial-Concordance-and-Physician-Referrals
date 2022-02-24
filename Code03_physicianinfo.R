
library(dplyr)
library(haven)
library(tidyverse)



#Merging race and medical school info
crosswalk_01 <- readRDS(crosswalk_01, file = "/FinalData/crosswalk_01.Rds")
nppes_01 <- readRDS(nppes_01, file = "/FinalData/nppes_01.Rds")  

#Keep only the matched rows
PhysicianInfo <- merge(x=crosswalk_01,y=nppes_01,by="Code",all=FALSE)           ##524081 obs. of 30 variables

#Rename some columns to enable merging
PhysicianInfo_01 <- rename(PhysicianInfo, 
                           providerfirstname = Provider_First_Name, 
                           providerlastnamelegalname = `Provider_Last_Name_(Legal_Name)`,
                           npi = NPI)

#saveRDS(PhysicianInfo_01, file = "/Users/swatiasnani/OneDrive - Emory University/Research/Thirdyearpaper/Code/Revised_23Oct/Data/PhysicianInfo_01.Rds")    

# -----------------------------------------------------------

RaceInfo <- read_dta("/RawData/APIData.dta")   ##5,72,602 observations

# Remove duplicated rows based on 
# Provider's first and last name
RaceInfo_01 <- RaceInfo %>% distinct(providerfirstname, providerlastnamelegalname, .keep_all = TRUE)  #1 row dropped

#saveRDS(RaceInfo_01, file = "/Users/swatiasnani/Dropbox/Mac/Desktop/3yearpaper/Data/Raw Data/NamePrismData/RaceInfo_01.Rds")    

#left outer join of PhysicianInfo_01 with RaceInfo_01
PhyInfRace <- merge(x=PhysicianInfo_01, y=RaceInfo_01, by = c("providerfirstname","providerlastnamelegalname"), all.x = TRUE)

#Check if the race variables have missing/NA values
sum(is.na(PhyInfRace$Black))
#Ouput: 3 rows, so drop them!
PhyInfRace_01 <- PhyInfRace %>% drop_na(Black)

#Check if there are any duplicated NPI rows in this dataset, by generating a new var
PhyInfRace_01 <- PhyInfRace_01 %>% 
  group_by(npi) %>% 
  mutate(dupe = n()>1)

#Check if any duplicates exist (0 dups here)
table(PhyInfRace_01$dupe)
# -----------------------------------------------------------

#Drop unnecessary variables
#names(nppes_01)
drop <- c("providerfirstname",
          "providerlastnamelegalname",
          "Employer_Identification_Number_(EIN)",
          "Provider_Organization_Name_(Legal_Business_Name)",
          "Provider_First_Line_Business_Mailing_Address",                              
          "Provider_Second_Line_Business_Mailing_Address",                             
          "Provider_Business_Mailing_Address_City_Name",                               
          "Provider_Business_Mailing_Address_State_Name",                              
          "Provider_Business_Mailing_Address_Postal_Code",                             
          "Provider_Business_Mailing_Address_Country_Code_(If_outside_U.S.)",          
          "Provider_Business_Mailing_Address_Telephone_Number",                        
          "Provider_Business_Mailing_Address_Fax_Number",                              
          "Provider_First_Line_Business_Practice_Location_Address",                    
          "Provider_Second_Line_Business_Practice_Location_Address",                   
          "Provider_Business_Practice_Location_Address_City_Name",  
          "Country",
          "Provider_Business_Practice_Location_Address_Telephone_Number",
          "Provider_Business_Practice_Location_Address_Fax_Number",
          "Is_Sole_Proprietor",
          "Certification_Date",
          "num_org_mem",
          "Provider_Business_Practice_Location_Address_Country_Code_(If_outside_U.S.)",
          "dupe",
          "Provider_Business_Practice_Location_Address_Postal_Code")


PhyInfRace_01 = PhyInfRace_01[,!(names(PhyInfRace_01) %in% drop)]                           #Out of 37 variables, now only 13 variables left!


taxonomy <- PhyInfRace_01 %>% 
  rename(t_code = Code,
         desc_tax = Definition) 

taxonomy$npi = as.character(taxonomy$npi)
saveRDS(taxonomy, file = "/FinalData/taxonomy.Rds")    

#---------------------------------------------------------


#tO AVOID VECTOR SIZE ERROR, use the below code and the .R environ technique
options (future.globals.maxSize = 4000 * 1024^5)
Sys.setenv(R_MAX_VSIZE = 16e9)
gc()
sessionInfo()
#---------------------------------------------------------

#Read 90 days shared patient data
psp_2013 <- read_dta(file=paste0(data.path, 'SharedPatient/pspp2013.dta'))

psp_2013 <- psp_2013 %>% distinct(npi1, npi2, .keep_all = TRUE)

drop <- c("begdate", "enddate", "days" )

psp_2013  = psp_2013 [,!(names(psp_2013) %in% drop)]     #92004979 OBS. OF 6 VARIABLES

#saveRDS(psp_2013, file = "/Users/swatiasnani/OneDrive - Emory University/Research/Thirdyearpaper/Data/Raw Data/Sharedpatient/psp_2013.Rds")   

#---------------------------------------------------------

#psp_2013 <- readRDS("~/OneDrive - Emory University/Research/Thirdyearpaper/Data/Raw Data/Sharedpatient/psp_2013.Rds")


PSPD.tax.13 <- psp_2013 %>%
  left_join(taxonomy, by=c("npi1"="npi")) %>%
  rename(t_code1=t_code, desc_tax1=desc_tax)  

#PSPD.tax.13 <- PSPD.tax.13[!(PSPD.tax.13$DoctorType=="Surgeon"),]   #86511497 obs of 18 var.

#Remove rows that are completely NAs (shortcut remove rows with npi1 as NA)
PSPD.tax.13 <- PSPD.tax.13[!is.na(PSPD.tax.13$npi1),]  # 27883004 obs of 18 variables

#Rename variables
PSPD.tax.13  <- rename(PSPD.tax.13 , 
                       `_2PRACE_1` = `_2PRACE`,
                       AIAN_1 = AIAN,
                       API_1=API,
                       Black_1 = Black,
                       Hispanic_1 = Hispanic,
                       White_1 = White)
                
                     

PSPD.tax.13 <- PSPD.tax.13 %>%
  left_join(taxonomy, by=c("npi2"="npi")) %>%
  rename(t_code2=t_code, desc_tax2=desc_tax)  #92004979 obs of 18 var.

PSPD.tax.13  <- rename(PSPD.tax.13 , 
                       `_2PRACE_2` = `_2PRACE`,
                       AIAN_2 = AIAN,
                       API_2=API,
                       Black_2 = Black,
                       Hispanic_2 = Hispanic,
                       White_2 = White)
                       

#Remove rows with NAs in surgeon data columns
PSPD.tax.13<- PSPD.tax.13[!is.na(PSPD.tax.13$Black_2),]  # 10526122 obs of 30 variables

PSPD.tax.13 <- rename(PSPD.tax.13, 
                      Gender_1 = Provider_Gender_Code.x,
                      State_1 = Provider_Business_Practice_Location_Address_State_Name.x,
                      Classification_1 = Classification.x,
                      Grouping_1 = Grouping.x,
                      Specialization_1 = Specialization.x,
                      Display_Name_1 = Display_Name.x,
                      Gender_2 = Provider_Gender_Code.y,
                      State_2 = Provider_Business_Practice_Location_Address_State_Name.y,
                      Classification_2 = Classification.y,
                      Grouping_2 = Grouping.y,
                      Specialization_2 = Specialization.y,
                      Display_Name_2 = Display_Name.y)


PSPD.tax.13 <- PSPD.tax.13 %>%
  filter(Classification_1 == "General Practice"|
           Classification_1 == "Internal Medicine"|
           Classification_1 == "Family Medicine")

PSPD.tax.13 <- PSPD.tax.13 %>%
  filter( Classification_2 == "Neurological Surgery"|
            Classification_2 == "Orthopaedic Surgery"|
            Classification_2 == "Plastic Surgery"|
            Classification_2 == "Surgery"|
            Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)"|
            Classification_2 == "Podiatrist"|
            Classification_2 == "Surgery"|
            Classification_2 == "Colon & Rectal Surgery"|
            Classification_2 == "Urology"|
            Classification_2 == "Transplant Surgery"|
            Classification_2 == "Otolaryngology")

#---------------------------------------------------------
#Read 90 days shared patient data
psp_2015 <- read_dta(file=paste0(data.path, '/SharedPatient/pspp2015.dta'))
psp_2015 <- psp_2015 %>% distinct(npi1, npi2, .keep_all = TRUE)   #56040265 obs of 9 var

drop <- c("begdate", "enddate", "days" )
psp_2015  = psp_2015 [,!(names(psp_2015) %in% drop)]     #92004979 OBS. OF 6 VARIABLES

gc()
options (future.globals.maxSize = 4000 * 1024^5)
Sys.setenv(R_MAX_VSIZE = 16e9)
gc()
sessionInfo()

PSPD.tax.15 <- psp_2015 %>%
  left_join(taxonomy, by=c("npi1"="npi")) %>%
  rename(t_code1=t_code, desc_tax1=desc_tax)  #56040265 obs of 18 var.


#Remove rows that are completely NAs (shortcut remove rows with npi1 as NA)
PSPD.tax.15 <- PSPD.tax.15[!is.na(PSPD.tax.15$npi1),]  # 16965387 obs of 18 variables

#Rename variables
PSPD.tax.15  <- rename(PSPD.tax.15 , 
                       `_2PRACE_1` = `_2PRACE`,
                       AIAN_1 = AIAN,
                       API_1=API,
                       Black_1 = Black,
                       Hispanic_1 = Hispanic,
                       White_1 = White)

PSPD.tax.15 <- PSPD.tax.15 %>%
  left_join(taxonomy, by=c("npi2"="npi")) %>%
  rename(t_code2=t_code, desc_tax2=desc_tax)  

PSPD.tax.15  <- rename(PSPD.tax.15 , 
                       `_2PRACE_2` = `_2PRACE`,
                       AIAN_2 = AIAN,
                       API_2=API,
                       Black_2 = Black,
                       Hispanic_2 = Hispanic,
                       White_2 = White)
                       
                      

#Remove rows with NAs in surgeon data columns
PSPD.tax.15<- PSPD.tax.15[!(is.na(PSPD.tax.15$Black_2)),]  

PSPD.tax.15 <- rename(PSPD.tax.15, 
                     Gender_1 = Provider_Gender_Code.x,
                     State_1 = Provider_Business_Practice_Location_Address_State_Name.x,
                     Classification_1 = Classification.x,
                     Grouping_1 = Grouping.x,
                     Specialization_1 = Specialization.x,
                     Display_Name_1 = Display_Name.x,
                     Gender_2 = Provider_Gender_Code.y,
                     State_2 = Provider_Business_Practice_Location_Address_State_Name.y,
                     Classification_2 = Classification.y,
                     Grouping_2 = Grouping.y,
                     Specialization_2 = Specialization.y,
                     Display_Name_2 = Display_Name.y)


PSPD.tax.15 <- PSPD.tax.15 %>%
  filter(Classification_1 == "General Practice"|
           Classification_1 == "Internal Medicine"|
           Classification_1 == "Family Medicine")

PSPD.tax.15 <- PSPD.tax.15 %>%
  filter( Classification_2 == "Neurological Surgery"|
            Classification_2 == "Orthopaedic Surgery"|
            Classification_2 == "Plastic Surgery"|
            Classification_2 == "Surgery"|
            Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)"|
            Classification_2 == "Podiatrist"|
            Classification_2 == "Surgery"|
            Classification_2 == "Colon & Rectal Surgery"|
            Classification_2 == "Urology"|
            Classification_2 == "Transplant Surgery"|
            Classification_2 == "Otolaryngology")

#################################################################################################

##Constructing final data
PSPD.13.15 <- rbind(PSPD.tax.13,PSPD.tax.15)

PSPD.13.15$Class <- PSPD.13.15$Classification_2

PSPD.13.15 <- PSPD.13.15 %>%
  mutate(Class = ifelse(Classification_2 == "Surgery", "General Surgery", Classification_2)) 

drop <- "Classification_2"

PSPD.13.15 = PSPD.13.15[,!(names(PSPD.13.15) %in% drop)]                    


PSPD.13.15 <- PSPD.13.15 %>%
  rename(Classification_2 = Class)


saveRDS(PSPD.13.15, file = "/FinalData/PSPD.13.15.Rds")    

#################################################################################################





