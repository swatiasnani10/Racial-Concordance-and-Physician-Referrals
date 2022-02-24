##October 27
#Construct PCP mover file
#---------------------------------------------------------
library(plm)
library(dplyr)
library(tidyverse)


#pcp mover strategy

load("FinalData/PSPD.merge.2.RData")  
pcp.mover.1 <- PSPD.merge.2    


#28 percent specialists and rest are pcps
temp <- pcp.mover.1 %>%
  distinct(npi2)   #62910 specialists  (4 percent of 62910 = 2516 black surgeons)

temp.pcp <- pcp.mover.1 %>%
  distinct(npi1)   #178234 pcps (4 percent = 7129 black pcps)

#---------------------------------------------------------
#Generate race for npi1 (This gives 4 percent Black PCPs that exists in the population in real)

pcp.mover.1$threshold_1 <- 0.15

pcp.mover.1$Race_1 <- ifelse(pcp.mover.1$Black_1 >= pcp.mover.1$threshold_1, "Black", "")

pcp.mover.1$RaceMax_1 <-  pmax(pcp.mover.1$`_2PRACE_1`, pcp.mover.1$AIAN_1, pcp.mover.1$API_1, pcp.mover.1$White_1, pcp.mover.1$Hispanic_1)

pcp.mover.1$Raceproxy_1 <- ifelse(pcp.mover.1$White_1 >= pcp.mover.1$RaceMax_1 , "White", "")
pcp.mover.1$Raceproxy_2 <- ifelse(pcp.mover.1$`_2PRACE_1` >= pcp.mover.1$RaceMax_1 , "Morethantworace", "")
pcp.mover.1$Raceproxy_3 <- ifelse(pcp.mover.1$AIAN_1>= pcp.mover.1$RaceMax_1 , "AIAN", "")
pcp.mover.1$Raceproxy_4 <- ifelse(pcp.mover.1$API_1 >= pcp.mover.1$RaceMax_1 , "API", "")
pcp.mover.1$Raceproxy_5 <- ifelse(pcp.mover.1$Hispanic_1 >= pcp.mover.1$RaceMax_1 , "Hispanic", "")

pcp.mover.1$Race_1 <- ifelse(pcp.mover.1$Race_1 == "", pcp.mover.1$Raceproxy_1, pcp.mover.1$Race_1)
pcp.mover.1$Race_1 <- ifelse(pcp.mover.1$Race_1 == "", "Other", pcp.mover.1$Race_1)


temp.pcp <- pcp.mover.1 %>%
  distinct(npi1, .keep_all = TRUE)   

temp.pcp <- temp.pcp %>%
  filter(Race_1 == "Black")   #7130 pcps unique which is 4 percent of total pcps, so this threshold is good for now!
#---------------------------------------------------------

#Generate race for npi2 
pcp.mover.1$threshold_1 <- 0.13

pcp.mover.1$Race_2 <- ifelse(pcp.mover.1$Black_2 >= pcp.mover.1$threshold_1, "Black", "")

pcp.mover.1$RaceMax_2 <-  pmax(pcp.mover.1$`_2PRACE_2`, pcp.mover.1$AIAN_2,pcp.mover.1$API_2,pcp.mover.1$White_2,pcp.mover.1$Hispanic_2)

pcp.mover.1$Raceproxy_12 <- ifelse(pcp.mover.1$White_2 >= pcp.mover.1$RaceMax_2 , "White", "")
pcp.mover.1$Raceproxy_22 <- ifelse(pcp.mover.1$`_2PRACE_2` >= pcp.mover.1$RaceMax_2 , "Morethantworace", "")
pcp.mover.1$Raceproxy_32 <- ifelse(pcp.mover.1$AIAN_2>= pcp.mover.1$RaceMax_2 , "AIAN", "")
pcp.mover.1$Raceproxy_42 <- ifelse(pcp.mover.1$API_2 >= pcp.mover.1$RaceMax_2 , "API", "")
pcp.mover.1$Raceproxy_52 <- ifelse(pcp.mover.1$Hispanic_2 >= pcp.mover.1$RaceMax_2 , "Hispanic", "")

pcp.mover.1$Race_2 <- ifelse(pcp.mover.1$Race_2 == "", pcp.mover.1$Raceproxy_12, pcp.mover.1$Race_2)
pcp.mover.1$Race_2 <- ifelse(pcp.mover.1$Race_2 == "", "Other", pcp.mover.1$Race_2)

temp.pcp <- pcp.mover.1 %>%
  distinct(npi2, .keep_all = TRUE)   

temp.pcp <- temp.pcp %>%
  filter(Race_2 == "Black")   #gives 2760 Black specialists which is a little more than 4 percent of total specialists,so a decent threshold for now.

#---------------------------------------------------------


#DRop unnecessary variables
drop <- c("_2PRACE_2" , 
          "AIAN_2" ,
          "API_2" , 
          "Black_2" ,
          "Hispanic_2" ,
          "White_2" , 
          "_2PRACE_1" , 
          "AIAN_1" ,
          "API_1" , 
          "Black_1" ,
          "Hispanic_1" ,
          "White_1" ,
          "Raceproxy_1" ,  
          "Raceproxy_2" ,  
          "Raceproxy_3" ,  
          "Raceproxy_4" ,  
          "Raceproxy_5" ,
          "Raceproxy_12" , 
          "Raceproxy_22" , 
          "Raceproxy_32" , 
          "Raceproxy_42" , 
          "Raceproxy_52",
          "threshold_1",
          "RaceMax_2",
          "RaceMax_1",
          "DoctorType_1",
          "DoctorType_2")

pcp.mover.1 = pcp.mover.1[,!(names(pcp.mover.1) %in% drop)]  #
#---------------------------------------------------------

###Let us start defining variables for our regression
#1. Define exp. for both pcp and specialist

#Find exp. variable
pcp.mover.1 <- pcp.mover.1 %>%
  mutate(exp_1 = year - graduation_1) %>%
  mutate(exp_2 = year - graduation_2)        #note: some pcp and specialist have experience NA due to unavailability of graduation year

table(pcp.mover.1$exp_2)  #remove outliers later
#---------------------------------------------------------
#create specialist bins
SurgerySchoolrankings2021 <- read_excel("/RawData/SurgerySchoolrankings2021.xlsx")

SurgerySchoolrankings2021 <- SurgerySchoolrankings2021 %>%
  rename(medical_school_2 = medical_school_1)

#to get sp. school ranking
pcp.mover.1 <- pcp.mover.1 %>%
  merge(SurgerySchoolrankings2021, 
        by = "medical_school_2", 
        all.x = TRUE)


pcp.mover.1$rank <- "NotTop50"

pcp.mover.1$Ranking_1 <- ifelse(is.na(pcp.mover.1$Ranking_1), pcp.mover.1$rank, pcp.mover.1$Ranking_1)

pcp.mover.1 <- pcp.mover.1 %>%
  rename(Ranking_2 = Ranking_1)
######################################
pcp.mover.1$uro <- "General Surgery"

#treat urology and colon and rectal as general surgeons
pcp.mover.1$Classification_2 <- ifelse(pcp.mover.1$Classification_2 == "Urology", pcp.mover.1$uro, pcp.mover.1$Classification_2)
pcp.mover.1$Classification_2 <- ifelse(pcp.mover.1$Classification_2 == "Colon & Rectal Surgery", pcp.mover.1$uro, pcp.mover.1$Classification_2)

pcp.mover.1$ortho <- "Orthopaedic Surgery"
pcp.mover.1$Classification_2 <- ifelse(pcp.mover.1$Classification_2 == "Podiatrist", pcp.mover.1$ortho, pcp.mover.1$Classification_2)

#Category of surgeons that are not referred a lot by pcps (less in number in our data)
pcp.mover.1$other <- "Other Surgeons"
pcp.mover.1$Classification_2 <- ifelse(pcp.mover.1$Classification_2 == "Transplant Surgery", pcp.mover.1$other, pcp.mover.1$Classification_2)
pcp.mover.1$Classification_2 <- ifelse(pcp.mover.1$Classification_2 == "Plastic Surgery", pcp.mover.1$other, pcp.mover.1$Classification_2)
pcp.mover.1$Classification_2 <- ifelse(pcp.mover.1$Classification_2 == "Otolaryngology", pcp.mover.1$other, pcp.mover.1$Classification_2)
pcp.mover.1$Classification_2 <- ifelse(pcp.mover.1$Classification_2 == "Neurological Surgery", pcp.mover.1$other, pcp.mover.1$Classification_2)


#Define specialists
tmp <- pcp.mover.1

#top ortho surgeons
tmp$sp.id <- ifelse(tmp$Classification_2 == "Orthopaedic Surgery" & tmp$Race_2 == "White" & tmp$Ranking_2 == "Top50"|
                    tmp$Classification_2 == "Orthopaedic Surgery" & tmp$Race_2 == "White" & tmp$exp_2 > 10 , 1, "")

tmp$sp.id <- ifelse(tmp$Classification_2 == "Orthopaedic Surgery" & tmp$Race_2 == "Black" & tmp$Ranking_2 == "Top50"|
                    tmp$Classification_2 == "Orthopaedic Surgery" & tmp$Race_2 == "Black" & tmp$exp_2 > 10, 2, tmp$sp.id)

tmp$sp.id <- ifelse(tmp$Classification_2 == "Orthopaedic Surgery" & tmp$Race_2 == "Other" & tmp$Ranking_2 == "Top50"|
                    tmp$Classification_2 == "Orthopaedic Surgery" & tmp$Race_2 == "Other" & tmp$exp_2 > 10, 3, tmp$sp.id)


#bad ortho surgeons
tmp$sp.id <- ifelse(tmp$Classification_2 == "Orthopaedic Surgery" & tmp$Race_2 == "White" & tmp$Ranking_2 == "NotTop50" & tmp$exp_2 <= 10|
                    tmp$Classification_2 == "Orthopaedic Surgery" & tmp$Race_2 == "White" & tmp$Ranking_2 == "NotTop50" & is.na(tmp$exp_2), 4, tmp$sp.id)

tmp$sp.id <- ifelse(tmp$Classification_2 == "Orthopaedic Surgery" & tmp$Race_2 == "Black" & tmp$Ranking_2 == "NotTop50" & tmp$exp_2 <= 10|
                    tmp$Classification_2 == "Orthopaedic Surgery" & tmp$Race_2 == "Black" & tmp$Ranking_2 == "NotTop50" & is.na(tmp$exp_2), 5, tmp$sp.id)

tmp$sp.id <- ifelse(tmp$Classification_2 == "Orthopaedic Surgery" & tmp$Race_2 == "Other" & tmp$Ranking_2 == "NotTop50" & tmp$exp_2 <= 10|
                    tmp$Classification_2 == "Orthopaedic Surgery" & tmp$Race_2 == "Other" & tmp$Ranking_2 == "NotTop50" & is.na(tmp$exp_2), 6, tmp$sp.id)
                     
#---------------------------------------------------------------------------------------------------------------------------------------------
#good general surgeons
tmp$sp.id <- ifelse(tmp$Classification_2 == "General Surgery" & tmp$Race_2 == "White" & tmp$Ranking_2 == "Top50"|
                      tmp$Classification_2 == "General Surgery" & tmp$Race_2 == "White" & tmp$exp_2 > 10 , 7, tmp$sp.id)

tmp$sp.id <- ifelse(tmp$Classification_2 == "General Surgery" & tmp$Race_2 == "Black" & tmp$Ranking_2 == "Top50"|
                      tmp$Classification_2 == "General Surgery" & tmp$Race_2 == "Black" & tmp$exp_2 > 10, 8, tmp$sp.id)

tmp$sp.id <- ifelse(tmp$Classification_2 == "General Surgery" & tmp$Race_2 == "Other" & tmp$Ranking_2 == "Top50"|
                      tmp$Classification_2 == "General Surgery" & tmp$Race_2 == "Other" & tmp$exp_2 > 10, 9, tmp$sp.id)


#bad general surgeons
tmp$sp.id <- ifelse(tmp$Classification_2 == "General Surgery" & tmp$Race_2 == "White" & tmp$Ranking_2 == "NotTop50" & tmp$exp_2 <= 10|
                      tmp$Classification_2 == "General Surgery" & tmp$Race_2 == "White" & tmp$Ranking_2 == "NotTop50" & is.na(tmp$exp_2), 10, tmp$sp.id)

tmp$sp.id <- ifelse(tmp$Classification_2 == "General Surgery" & tmp$Race_2 == "Black" & tmp$Ranking_2 == "NotTop50" & tmp$exp_2 <= 10|
                      tmp$Classification_2 == "General Surgery" & tmp$Race_2 == "Black" & tmp$Ranking_2 == "NotTop50" & is.na(tmp$exp_2), 11, tmp$sp.id)

tmp$sp.id <- ifelse(tmp$Classification_2 == "General Surgery" & tmp$Race_2 == "Other" & tmp$Ranking_2 == "NotTop50" & tmp$exp_2 <= 10|
                      tmp$Classification_2 == "General Surgery" & tmp$Race_2 == "Other" & tmp$Ranking_2 == "NotTop50" & is.na(tmp$exp_2), 12, tmp$sp.id)

#---------------------------------------------------------------------------------------------------------------------------------------------
#good thoracic surgeons

tmp$sp.id <- ifelse(tmp$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)" & tmp$Race_2 == "White" & tmp$Ranking_2 == "Top50"|
                      tmp$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)" & tmp$Race_2 == "White" & tmp$exp_2 > 10 , 13, tmp$sp.id)

tmp$sp.id <- ifelse(tmp$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)" & tmp$Race_2 == "Black" & tmp$Ranking_2 == "Top50"|
                      tmp$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)" & tmp$Race_2 == "Black" & tmp$exp_2 > 10, 14, tmp$sp.id)

tmp$sp.id <- ifelse(tmp$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)" & tmp$Race_2 == "Other" & tmp$Ranking_2 == "Top50"|
                      tmp$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)" & tmp$Race_2 == "Other" & tmp$exp_2 > 10, 15, tmp$sp.id)


#bad thoracic surgeons
tmp$sp.id <- ifelse(tmp$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)" & tmp$Race_2 == "White" & tmp$Ranking_2 == "NotTop50" & tmp$exp_2 <= 10|
                      tmp$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)" & tmp$Race_2 == "White" & tmp$Ranking_2 == "NotTop50" & is.na(tmp$exp_2), 16, tmp$sp.id)

tmp$sp.id <- ifelse(tmp$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)" & tmp$Race_2 == "Black" & tmp$Ranking_2 == "NotTop50" & tmp$exp_2 <= 10|
                      tmp$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)" & tmp$Race_2 == "Black" & tmp$Ranking_2 == "NotTop50" & is.na(tmp$exp_2), 17, tmp$sp.id)

tmp$sp.id <- ifelse(tmp$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)" & tmp$Race_2 == "Other" & tmp$Ranking_2 == "NotTop50" & tmp$exp_2 <= 10|
                      tmp$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)" & tmp$Race_2 == "Other" & tmp$Ranking_2 == "NotTop50" & is.na(tmp$exp_2), 18, tmp$sp.id)

#---------------------------------------------------------------------------------------------------------------------------------------------
#good other surgeons

tmp$sp.id <- ifelse(tmp$Classification_2 == "Other Surgeons" & tmp$Race_2 == "White" & tmp$Ranking_2 == "Top50"|
                      tmp$Classification_2 == "Other Surgeons" & tmp$Race_2 == "White" & tmp$exp_2 > 10 , 19, tmp$sp.id)

tmp$sp.id <- ifelse(tmp$Classification_2 == "Other Surgeons" & tmp$Race_2 == "Black" & tmp$Ranking_2 == "Top50"|
                      tmp$Classification_2 == "Other Surgeons" & tmp$Race_2 == "Black" & tmp$exp_2 > 10, 20, tmp$sp.id)

tmp$sp.id <- ifelse(tmp$Classification_2 == "Other Surgeons" & tmp$Race_2 == "Other" & tmp$Ranking_2 == "Top50"|
                      tmp$Classification_2 == "Other Surgeons" & tmp$Race_2 == "Other" & tmp$exp_2 > 10, 21, tmp$sp.id)


#bad other surgeons
tmp$sp.id <- ifelse(tmp$Classification_2 == "Other Surgeons" & tmp$Race_2 == "White" & tmp$Ranking_2 == "NotTop50" & tmp$exp_2 <= 10|
                      tmp$Classification_2 == "Other Surgeons" & tmp$Race_2 == "White" & tmp$Ranking_2 == "NotTop50" & is.na(tmp$exp_2), 22, tmp$sp.id)

tmp$sp.id <- ifelse(tmp$Classification_2 == "Other Surgeons" & tmp$Race_2 == "Black" & tmp$Ranking_2 == "NotTop50" & tmp$exp_2 <= 10|
                      tmp$Classification_2 == "Other Surgeons" & tmp$Race_2 == "Black" & tmp$Ranking_2 == "NotTop50" & is.na(tmp$exp_2), 23, tmp$sp.id)

tmp$sp.id <- ifelse(tmp$Classification_2 == "Other Surgeons" & tmp$Race_2 == "Other" & tmp$Ranking_2 == "NotTop50" & tmp$exp_2 <= 10|
                      tmp$Classification_2 == "Other Surgeons" & tmp$Race_2 == "Other" & tmp$Ranking_2 == "NotTop50" & is.na(tmp$exp_2), 24, tmp$sp.id)

#---------------------------------------------------------------------------------------------------------------------------------------------
#create outcome variable: type 1: share
# if a pcp has repetitive sp., it means sum their benecount and make that as one row.
# now, find proportions of each pair shares (each pair should exist in all 2 years)

#count tota patients received by each pcp in a year
tmp <- tmp %>%
  group_by(year, npi1) %>%
  mutate(tot.pat = sum(benecount))

#sum up the patients shared with each category of specialist id (created above)
tmp <- tmp %>%
  group_by(year, npi1, sp.id) %>%
  mutate(sp.pat = sum(benecount))

#find share of patients shared with each category of specialist (min and max checked, share between 0 and 1)
tmp <- tmp %>%
  group_by(year, npi1, sp.id) %>%
  mutate(sh.pat = sp.pat/tot.pat)
#---------------------------------------------------------------------------------------------------------------------------------------------
#create outcome variable: type 1: Relative share (ratio less than, equal to or greater than 1)
#---------------------------------------------------------------------------------------------------------------------------------------------




#---------------------------------------------------------------------------------------------------------------------------------------------

#create broader specialist categories to create delta

#top ortho surgeons, without race
tmp$sp.hrr.id <- ifelse(tmp$Classification_2 == "Orthopaedic Surgery" &  tmp$Ranking_2 == "Top50"|
                      tmp$Classification_2 == "Orthopaedic Surgery" &  tmp$exp_2 > 10 , 1, "")


#bad ortho surgeons, without race
tmp$sp.hrr.id <- ifelse(tmp$Classification_2 == "Orthopaedic Surgery" & tmp$Ranking_2 == "NotTop50" & tmp$exp_2 <= 10|
                      tmp$Classification_2 == "Orthopaedic Surgery" &  tmp$Ranking_2 == "NotTop50" & is.na(tmp$exp_2), 2, tmp$sp.hrr.id)


#good general surgeons, without race
tmp$sp.hrr.id <- ifelse(tmp$Classification_2 == "General Surgery" &  tmp$Ranking_2 == "Top50"|
                      tmp$Classification_2 == "General Surgery" &  tmp$exp_2 > 10 , 3, tmp$sp.hrr.id)



#bad general surgeons, without race
tmp$sp.hrr.id <- ifelse(tmp$Classification_2 == "General Surgery" &  tmp$Ranking_2 == "NotTop50" & tmp$exp_2 <= 10|
                      tmp$Classification_2 == "General Surgery"  & tmp$Ranking_2 == "NotTop50" & is.na(tmp$exp_2), 4, tmp$sp.hrr.id)


#good thoracic surgeons, without race

tmp$sp.hrr.id <- ifelse(tmp$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)"  & tmp$Ranking_2 == "Top50"|
                      tmp$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)" &  tmp$exp_2 > 10 , 5, tmp$sp.hrr.id)



#bad thoracic surgeons, without race
tmp$sp.hrr.id <- ifelse(tmp$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)" & tmp$Ranking_2 == "NotTop50" & tmp$exp_2 <= 10|
                      tmp$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)" &  tmp$Ranking_2 == "NotTop50" & is.na(tmp$exp_2), 6, tmp$sp.hrr.id)


#good other surgeons, without race

tmp$sp.hrr.id <- ifelse(tmp$Classification_2 == "Other Surgeons" & tmp$Ranking_2 == "Top50"|
                      tmp$Classification_2 == "Other Surgeons" &  tmp$exp_2 > 10 , 7, tmp$sp.hrr.id)


#bad other surgeons, without race
tmp$sp.hrr.id <- ifelse(tmp$Classification_2 == "Other Surgeons" &  tmp$Ranking_2 == "NotTop50" & tmp$exp_2 <= 10|
                      tmp$Classification_2 == "Other Surgeons" & tmp$Ranking_2 == "NotTop50" & is.na(tmp$exp_2), 8, tmp$sp.hrr.id)


#---------------------------------------------------------------------------------------------------------------------------------------------
#Generate treatment variable (Delta*Post)
tmp <- tmp %>%
  mutate(wh.sp.ind = ifelse(Race_2 == "White", 1, 0)) %>%
  mutate(bl.sp.ind = ifelse(Race_2 == "Black", 1, 0)) 

#total number of unique specialist available in each sp. group in an HRR
tmp <- tmp %>%
  group_by(year, hrrnum_1, sp.hrr.id) %>%
  mutate(sp.count = length(unique(npi2)))  

##white sp
tmp <- tmp %>%
  mutate(wh.sp = ifelse(Race_2 == "White", npi2, NA)) %>%
  mutate(bl.sp = ifelse(Race_2 == "Black", npi2, NA)) %>%
  mutate(ot.sp = ifelse(Race_2 == "Other", npi2, NA)) 

#length of unique sp and do not include nas in length
tmp <- tmp %>%
  group_by(year, hrrnum_1, sp.hrr.id) %>%
  mutate(bl.sp.count = length(unique(bl.sp)[!is.na(unique(bl.sp))])) %>%
  mutate(wh.sp.count = length(unique(wh.sp)[!is.na(unique(wh.sp))]))%>%
  mutate(ot.sp.count = length(unique(ot.sp)[!is.na(unique(ot.sp))]))

#proportion of black/white specialist groups who have been referred to in pcp i's hrr in that year
tmp <- tmp %>%
  group_by(year,hrrnum_1, sp.hrr.id) %>%
  mutate(bl.sp.sh = bl.sp.count/sp.count) %>%
  mutate(wh.sp.sh = wh.sp.count/sp.count) %>%
  mutate(ot.sp.sh = ot.sp.count/sp.count) 

#---------------------------------------------------------

#temporary subset
# so subset unique npi1 in each year
pcp.mover.temp <- tmp %>%
  group_by(year) %>%
  distinct(npi1, .keep_all = TRUE)


pcp.mover.temp <- pcp.mover.temp %>%
  select(year, npi1, hrrnum_1, Race_1,Race_2,bl.sp.sh, wh.sp.sh, ot.sp.sh)


pcp.15 <- pcp.mover.temp %>%
  filter(year == 2015) %>%
  select(npi1, hrrnum_1, bl.sp.sh, wh.sp.sh, ot.sp.sh, year) %>%
  rename(hrr_2015 = hrrnum_1) %>%
  rename(wh.sp.sh.15 = wh.sp.sh) %>%
  rename(bl.sp.sh.15 = bl.sp.sh) %>%
  rename(ot.sp.sh.15 = ot.sp.sh) 

#dropped year var
drop <- "year"
pcp.15 <- pcp.15[,!names(pcp.15) %in% drop]


pcp.mover.temp <- pcp.mover.temp %>%
  merge(pcp.15, by = "npi1", all.x = TRUE)

#calculate delta term
pcp.mover.temp <- pcp.mover.temp %>%
  mutate(wh.delta = ifelse(year == 2013, wh.sp.sh.15 - wh.sp.sh , NA)) %>%
  mutate(bl.delta = ifelse(year == 2013, bl.sp.sh.15 - bl.sp.sh , NA)) %>%
  mutate(ot.delta = ifelse(year == 2013, ot.sp.sh.15 - ot.sp.sh , NA)) 
  

#create new var hrr to create origin hrr
pcp.mover.temp <- pcp.mover.temp %>%
  mutate(hrr13 = ifelse(year == 2013, hrrnum_1 , NA))

pcp.mover.temp$ind_1 <- (pcp.mover.temp$hrrnum_1 != pcp.mover.temp$hrr_2015) &(pcp.mover.temp$year == 2013)
pcp.mover.temp$ind_1 <- as.numeric(pcp.mover.temp$ind_1)

pcp.sub <- pcp.mover.temp %>%
  filter(year == 2013) %>%
  select(npi1, wh.delta,bl.delta,ot.delta, hrr13, ind_1, year) %>%
  rename(wh.delta_lag = wh.delta)  %>%
  rename(bl.delta_lag = bl.delta)  %>%
  rename(ot.delta_lag = ot.delta)  
  

#dropped year var
drop <- "year"
pcp.sub <- pcp.sub[,!names(pcp.sub) %in% drop]

pcp.mover.temp <- pcp.mover.temp %>%
  merge(pcp.sub, by = "npi1",all.x = TRUE)

#origin hrr var
pcp.mover.temp$OriginHRR <- ifelse(is.na(pcp.mover.temp$hrr13.x), pcp.mover.temp$hrr13.y , pcp.mover.temp$hrr13.x)

#this is of interest to us now
pcp.mover.temp$Wh.Delta <- ifelse(is.na(pcp.mover.temp$wh.delta), pcp.mover.temp$wh.delta_lag , pcp.mover.temp$wh.delta)
pcp.mover.temp$Bl.Delta <- ifelse(is.na(pcp.mover.temp$bl.delta), pcp.mover.temp$bl.delta_lag , pcp.mover.temp$bl.delta)
pcp.mover.temp$Ot.Delta <- ifelse(is.na(pcp.mover.temp$ot.delta), pcp.mover.temp$ot.delta_lag , pcp.mover.temp$ot.delta)


#indicator of mover
pcp.mover.temp <- pcp.mover.temp %>%
  rename(Mover.Ind = ind_1.y)


pcp.mover.temp <- pcp.mover.temp %>%
  select(year,npi1, OriginHRR, Wh.Delta, Bl.Delta, Ot.Delta, Mover.Ind)

pcp.mover.1 <- merge(tmp,
                     pcp.mover.temp,
                     by = c("year","npi1"), all.x = TRUE)

#create other explanatory variables

#create post dummy
pcp.mover.1$post <- ifelse(pcp.mover.1$year == 2015, 1, 0)

#patient risk-adjusters of each pcp based on his hrr(county) (race composition for that county for people above 65)
pcp.mover.1 <- pcp.mover.1 %>%
  group_by(year,hrrnum_1, npi1) %>%
  mutate(avg.sh.wh.pat = wh.share_1) %>%    #remember these shares do not sum to 1 as there are other races too (med ppuf)
  mutate(avg.sh.bl.pat = bl.share_1)  

pcp.mover.1 <- pcp.mover.1 %>%
  group_by(year,hrrnum_1, npi1) %>%
  mutate(avg.pat.age = bene.avg.age_1) 

#------------------------------------------------

#Filter data
reg.1 <- pcp.mover.1

reg.1 <- reg.1[!(reg.1$Race_1=="Other"),]                                   
reg.1 <- reg.1[!(reg.1$Race_2=="Other"),]  


#keep only rows with mover in =1. I specify another condition that do not include mover indicator with na values,
#since if I do not put this condition, my data will have some mysterious NA rows.
reg.1 <- reg.1[reg.1$Mover.Ind == 1 & !is.na(reg.1$Mover.Ind),]

reg.1 <- reg.1 %>%
  group_by(year,npi1) %>%
  distinct(sp.id, .keep_all = TRUE)

# reg.1 <- reg.1 %>%
#   group_by(npi1) %>%
#   filter(all(2013:2015 %in% year))

#generate Delta variable
#declare as panel data
library(plm)

reg.1 <- reg.1 %>% 
  group_by(npi1, sp.id) %>% 
  mutate(pair_id=cur_group_id()) 

reg.1 <- pdata.frame(reg.1, index=c("pair_id","year"))  
class(reg.1)

#check if now panel is balanced, no!
is.pbalanced(reg.1$pair_id, reg.1$year)

#removed paird that do not repeat across years
reg.1 <- make.pbalanced(reg.1, balance.type = "shared.individuals", index = "pair_id") 


#create interaction term with post*opposite share delta
reg.1$opp.treat <- reg.1$post * reg.1$Bl.Delta
reg.1$same.treat <- reg.1$post * reg.1$Wh.Delta

#keep only rows for which  pcp is white 
reg.1 <- reg.1[(reg.1$Race_1=="White"),]  

#keep only rows for which specialist groups are white 
reg.1 <- reg.1[(reg.1$sp.id== 1|
                  reg.1$sp.id== 4|
                  reg.1$sp.id== 7|
                  reg.1$sp.id== 10|
                  reg.1$sp.id== 13|
                  reg.1$sp.id== 16|
                  reg.1$sp.id== 19|
                  reg.1$sp.id== 22),]
                  

# #---------------------------------------------------------
# #Add some elements to data
#like dummies of types of bins you are in
#sp id available in this data are: 1, 10, 13, 16, 19, 22, 4, 7

reg.1$good.ortho <- ifelse(reg.1$Classification_2 == "Orthopaedic Surgery" & reg.1$Ranking_2 == "Top50"|
                             reg.1$Classification_2 == "Orthopaedic Surgery" & reg.1$exp_2 > 10, 1, 0)
                           
                             
reg.1$bad.ortho <- ifelse(reg.1$Classification_2 == "Orthopaedic Surgery" & reg.1$Ranking_2 == "NotTop50" & reg.1$exp_2 <= 10|
                             reg.1$Classification_2 == "Orthopaedic Surgery" & reg.1$Ranking_2 == "NotTop50" & is.na(reg.1$exp_2), 1, 0)


reg.1$good.general <- ifelse(reg.1$Classification_2 == "General Surgery" & reg.1$Ranking_2 == "Top50"|
                             reg.1$Classification_2 == "General Surgery" & reg.1$exp_2 > 10, 1, 0)


reg.1$bad.general <- ifelse(reg.1$Classification_2 == "General Surgery" & reg.1$Ranking_2 == "NotTop50" &  reg.1$exp_2 <= 10|
                           reg.1$Classification_2 == "General Surgery" & reg.1$Ranking_2 == "NotTop50" & is.na(reg.1$exp_2), 1, 0)


reg.1$good.cardio <- ifelse(reg.1$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)" & reg.1$Ranking_2 == "Top50"|
                               reg.1$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)" & reg.1$exp_2 > 10, 1, 0)


reg.1$bad.cardio <- ifelse(reg.1$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)" & reg.1$Ranking_2 == "NotTop50" &  reg.1$exp_2 <= 10|
                              reg.1$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)" & reg.1$Ranking_2 == "NotTop50" & is.na(reg.1$exp_2), 1, 0)


reg.1$good.other <- ifelse(reg.1$Classification_2 == "Other Surgeons" & reg.1$Ranking_2 == "Top50"|
                              reg.1$Classification_2 == "Other Surgeons" & reg.1$exp_2 > 10, 1, 0)


reg.1$bad.other <- ifelse(reg.1$Classification_2 == "Other Surgeons" & reg.1$Ranking_2 == "NotTop50" &  reg.1$exp_2 <= 10|
                             reg.1$Classification_2 == "Other Surgeons" & reg.1$Ranking_2 == "NotTop50" & is.na(reg.1$exp_2), 1, 0)
#---------------------------------------------------------------------------------------------------------------------------------------------

#LET'S CREATE A NEW VARIABLE FOR AVERAGE PATIENT CHARACTERISTICS
#for each bin

#share of relevant ill patients for each specialist bin
reg.1$sh.ill.pat <- 0


#General, ortho, cardio and other surgeons (neuro, urology, ent, trauma etc.)

#calculated mean share of patients specialty wise by using commented code categories below
reg.1$avg.ortho.pat   <- reg.1$bene_diab_1

reg.1$avg.general.pat <- rowMeans(reg.1[, c(45,48,53)],na.rm = TRUE)

reg.1$avg.other.pat   <- rowMeans(reg.1[, c(41,42,45,46,47,50,54,55)],na.rm = TRUE)

reg.1$avg.cardio.pat  <- rowMeans(reg.1[, c(40,44,46,48,49,50,51)],na.rm = TRUE)


reg.1$sh.ill.pat <- ifelse(reg.1$sp.hrr.id == 1 | reg.1$sp.hrr.id == 2, reg.1$avg.ortho.pat, reg.1$sh.ill.pat)
reg.1$sh.ill.pat <- ifelse(reg.1$sp.hrr.id == 3 | reg.1$sp.hrr.id == 4, reg.1$avg.general.pat, reg.1$sh.ill.pat)
reg.1$sh.ill.pat <- ifelse(reg.1$sp.hrr.id == 5 | reg.1$sp.hrr.id == 6, reg.1$avg.cardio.pat, reg.1$sh.ill.pat)
reg.1$sh.ill.pat <- ifelse(reg.1$sp.hrr.id == 7 | reg.1$sp.hrr.id == 8, reg.1$avg.other.pat, reg.1$sh.ill.pat)

#---------------------------------------------------------------------------------------------------------------------------------------------

sample.1 <- reg.1 %>%
  select(sh.pat, post, opp.treat, same.treat, avg.sh.bl.pat, avg.sh.wh.pat, sh.ill.pat, good.ortho, bad.ortho, good.general, bad.general,
         good.cardio, bad.cardio, good.other, bad.other, exp_1)

dd.10 <- lm(sh.pat ~  post + opp.treat + exp_1 + avg.sh.bl.pat + avg.sh.wh.pat + sh.ill.pat +  good.ortho + bad.ortho + good.cardio + 
             bad.cardio + good.general + bad.general + good.other , data=sample.1)

summary(dd.10)

stargazer(dd.10, type = "latex")
#---------------------------------------------------------------------------------------------------------------------------------------------


dd.11 <- lm(sh.pat ~  post + same.treat + avg.sh.bl.pat + avg.sh.wh.pat + sh.ill.pat +  good.ortho + bad.ortho + good.cardio + 
              bad.cardio + good.general + bad.general + good.other , data=reg.1)
summary(dd.11)

stargazer(dd.11, type = "latex")
