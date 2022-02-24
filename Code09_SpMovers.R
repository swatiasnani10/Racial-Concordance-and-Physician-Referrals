
##October 27
#Construct PCP mover file
#---------------------------------------------------------
library(plm)
library(dplyr)
library(tidyverse)


#pcp mover strategy

load("FinalData/PSPD.merge.2.RData")  
sp.mover.1 <- PSPD.merge.2    


#28 percent specialists and rest are pcps
temp <- sp.mover.1 %>%
  distinct(npi2)   #62910 specialists  (4 percent of 62910 = 2516 black surgeons)

temp.pcp <- sp.mover.1 %>%
  distinct(npi1)   #178234 pcps (4 percent = 7129 black pcps)



#---------------------------------------------------------
#Generate race for npi1 (This gives 4 percent Black PCPs that exists in the population in real)

sp.mover.1$threshold_1 <- 0.15

sp.mover.1$Race_1 <- ifelse(sp.mover.1$Black_1 >= sp.mover.1$threshold_1, "Black", "")

sp.mover.1$RaceMax_1 <-  pmax(sp.mover.1$`_2PRACE_1`, sp.mover.1$AIAN_1, sp.mover.1$API_1, sp.mover.1$White_1, sp.mover.1$Hispanic_1)

sp.mover.1$Raceproxy_1 <- ifelse(sp.mover.1$White_1 >= sp.mover.1$RaceMax_1 , "White", "")
sp.mover.1$Raceproxy_2 <- ifelse(sp.mover.1$`_2PRACE_1` >= sp.mover.1$RaceMax_1 , "Morethantworace", "")
sp.mover.1$Raceproxy_3 <- ifelse(sp.mover.1$AIAN_1>= sp.mover.1$RaceMax_1 , "AIAN", "")
sp.mover.1$Raceproxy_4 <- ifelse(sp.mover.1$API_1 >= sp.mover.1$RaceMax_1 , "API", "")
sp.mover.1$Raceproxy_5 <- ifelse(sp.mover.1$Hispanic_1 >= sp.mover.1$RaceMax_1 , "Hispanic", "")

sp.mover.1$Race_1 <- ifelse(sp.mover.1$Race_1 == "", sp.mover.1$Raceproxy_1, sp.mover.1$Race_1)
sp.mover.1$Race_1 <- ifelse(sp.mover.1$Race_1 == "", "Other", sp.mover.1$Race_1)


temp.pcp <- sp.mover.1 %>%
  distinct(npi1, .keep_all = TRUE)   

temp.pcp <- temp.pcp %>%
  filter(Race_1 == "Black")   #7130 pcps unique which is 4 percent of total pcps, so this threshold is good for now!
#---------------------------------------------------------

#Generate race for npi2 
sp.mover.1$threshold_1 <- 0.13

sp.mover.1$Race_2 <- ifelse(sp.mover.1$Black_2 >= sp.mover.1$threshold_1, "Black", "")

sp.mover.1$RaceMax_2 <-  pmax(sp.mover.1$`_2PRACE_2`, sp.mover.1$AIAN_2,sp.mover.1$API_2,sp.mover.1$White_2,sp.mover.1$Hispanic_2)

sp.mover.1$Raceproxy_12 <- ifelse(sp.mover.1$White_2 >= sp.mover.1$RaceMax_2 , "White", "")
sp.mover.1$Raceproxy_22 <- ifelse(sp.mover.1$`_2PRACE_2` >= sp.mover.1$RaceMax_2 , "Morethantworace", "")
sp.mover.1$Raceproxy_32 <- ifelse(sp.mover.1$AIAN_2>= sp.mover.1$RaceMax_2 , "AIAN", "")
sp.mover.1$Raceproxy_42 <- ifelse(sp.mover.1$API_2 >= sp.mover.1$RaceMax_2 , "API", "")
sp.mover.1$Raceproxy_52 <- ifelse(sp.mover.1$Hispanic_2 >= sp.mover.1$RaceMax_2 , "Hispanic", "")

sp.mover.1$Race_2 <- ifelse(sp.mover.1$Race_2 == "", sp.mover.1$Raceproxy_12, sp.mover.1$Race_2)
sp.mover.1$Race_2 <- ifelse(sp.mover.1$Race_2 == "", "Other", sp.mover.1$Race_2)

temp.pcp <- sp.mover.1 %>%
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

sp.mover.1 = sp.mover.1[,!(names(sp.mover.1) %in% drop)]  #
#---------------------------------------------------------

###Let us start defining variables for our regression
#1. Define exp. for both pcp and specialist

#Find exp. variable
sp.mover.1 <- sp.mover.1 %>%
  mutate(exp_1 = year - graduation_1) %>%
  mutate(exp_2 = year - graduation_2)        #note: some pcp and specialist have experience NA due to unavailability of graduation year

table(sp.mover.1$exp_2)  #remove outliers later
#---------------------------------------------------------
#create outcome variable
SurgerySchoolrankings2021 <- read_excel("OneDrive - Emory University/Research/Thirdyearpaper/Code/Revised_23Oct/Data/SurgerySchoolrankings2021.xlsx")


sp.mover.1 <- sp.mover.1 %>%
  merge(SurgerySchoolrankings2021, 
        by = "medical_school_1", 
        all.x = TRUE)

SurgerySchoolrankings2021 <- SurgerySchoolrankings2021 %>%
  rename(medical_school_2 = medical_school_1)

sp.mover.1 <- sp.mover.1 %>%
  merge(SurgerySchoolrankings2021, 
        by = "medical_school_2", 
        all.x = TRUE)

sp.mover.1$rank <- "NotTop50"

sp.mover.1$Ranking_1 <- ifelse(is.na(sp.mover.1$Ranking_1), sp.mover.1$rank, sp.mover.1$Ranking_1)


#Define specialists
reg.2 <- sp.mover.1


# #Define specialists
tmp <- sp.mover.1

#top IM pcp
tmp$pcp.id <- ifelse(tmp$Classification_1 == "Internal Medicine" & tmp$Race_1 == "White" & tmp$Ranking_1 == "Top50"|
                       tmp$Classification_1 == "Internal Medicine" & tmp$Race_1 == "White" & tmp$exp_1 > 10 , 1, "")

tmp$pcp.id <- ifelse(tmp$Classification_1 == "Internal Medicine" & tmp$Race_1 == "Black" & tmp$Ranking_1 == "Top50"|
                       tmp$Classification_1 == "Internal Medicine" & tmp$Race_1 == "Black" & tmp$exp_1 > 10, 2, tmp$pcp.id)

tmp$pcp.id <- ifelse(tmp$Classification_1 == "Internal Medicine" & tmp$Race_1 == "Other" & tmp$Ranking_1 == "Top50"|
                       tmp$Classification_1 == "Internal Medicine" & tmp$Race_1 == "Other" & tmp$exp_1 > 10, 3, tmp$pcp.id)


#bad IM PCP
tmp$pcp.id <- ifelse(tmp$Classification_1 == "Internal Medicine" & tmp$Race_1 == "White" & tmp$Ranking_1 == "NotTop50" & tmp$exp_1 <= 10|
                       tmp$Classification_1 == "Internal Medicine" & tmp$Race_1 == "White" & tmp$Ranking_1 == "NotTop50" & is.na(tmp$exp_1), 4, tmp$pcp.id)

tmp$pcp.id <- ifelse(tmp$Classification_1 == "Internal Medicine" & tmp$Race_1 == "Black" & tmp$Ranking_1 == "NotTop50" & tmp$exp_1 <= 10|
                       tmp$Classification_1 == "Internal Medicine" & tmp$Race_1 == "Black" & tmp$Ranking_1 == "NotTop50" & is.na(tmp$exp_1), 5, tmp$pcp.id)

tmp$pcp.id <- ifelse(tmp$Classification_1 == "Internal Medicine" & tmp$Race_1 == "Other" & tmp$Ranking_1 == "NotTop50" & tmp$exp_1 <= 10|
                       tmp$Classification_1 == "Internal Medicine" & tmp$Race_1 == "Other" & tmp$Ranking_1 == "NotTop50" & is.na(tmp$exp_1), 6, tmp$pcp.id)

#---------------------------------------------------------------------------------------------------------------------------------------------
#good
tmp$pcp.id <- ifelse(tmp$Classification_1 == "Family Medicine" & tmp$Race_1 == "White" & tmp$Ranking_1 == "Top50"|
                       tmp$Classification_1 == "Family Medicine" & tmp$Race_1 == "White" & tmp$exp_1 > 10 , 7, tmp$pcp.id)

tmp$pcp.id <- ifelse(tmp$Classification_1 == "Family Medicine" & tmp$Race_1 == "Black" & tmp$Ranking_1 == "Top50"|
                       tmp$Classification_1 == "Family Medicine" & tmp$Race_1 == "Black" & tmp$exp_1 > 10, 8, tmp$pcp.id)

tmp$pcp.id <- ifelse(tmp$Classification_1 == "Family Medicine" & tmp$Race_1 == "Other" & tmp$Ranking_1 == "Top50"|
                       tmp$Classification_1 == "Family Medicine" & tmp$Race_1 == "Other" & tmp$exp_1 > 10, 9, tmp$pcp.id)


#bad
tmp$pcp.id <- ifelse(tmp$Classification_1 == "Family Medicine" & tmp$Race_1 == "White" & tmp$Ranking_1 == "NotTop50" & tmp$exp_1 <= 10|
                       tmp$Classification_1 == "Family Medicine" & tmp$Race_1 == "White" & tmp$Ranking_1 == "NotTop50" & is.na(tmp$exp_1), 10, tmp$pcp.id)

tmp$pcp.id <- ifelse(tmp$Classification_1 == "Family Medicine" & tmp$Race_1 == "Black" & tmp$Ranking_1 == "NotTop50" & tmp$exp_1 <= 10|
                       tmp$Classification_1 == "Family Medicine" & tmp$Race_1 == "Black" & tmp$Ranking_1 == "NotTop50" & is.na(tmp$exp_1), 11, tmp$pcp.id)

tmp$pcp.id <- ifelse(tmp$Classification_1 == "Family Medicine" & tmp$Race_1 == "Other" & tmp$Ranking_1 == "NotTop50" & tmp$exp_1 <= 10|
                       tmp$Classification_1 == "Family Medicine" & tmp$Race_1 == "Other" & tmp$Ranking_1 == "NotTop50" & is.na(tmp$exp_1), 12, tmp$pcp.id)

#---------------------------------------------------------------------------------------------------------------------------------------------
#good thoracic surgeons

#good
tmp$pcp.id <- ifelse(tmp$Classification_1 == "General Practice" & tmp$Race_1 == "White" & tmp$Ranking_1 == "Top50"|
                       tmp$Classification_1 == "General Practice" & tmp$Race_1 == "White" & tmp$exp_1 > 10 , 13, tmp$pcp.id)

tmp$pcp.id <- ifelse(tmp$Classification_1 == "General Practice" & tmp$Race_1 == "Black" & tmp$Ranking_1 == "Top50"|
                       tmp$Classification_1 == "General Practice" & tmp$Race_1 == "Black" & tmp$exp_1 > 10, 14, tmp$pcp.id)

tmp$pcp.id <- ifelse(tmp$Classification_1 == "General Practice" & tmp$Race_1 == "Other" & tmp$Ranking_1 == "Top50"|
                       tmp$Classification_1 == "General Practice" & tmp$Race_1 == "Other" & tmp$exp_1 > 10, 15, tmp$pcp.id)


#bad
tmp$pcp.id <- ifelse(tmp$Classification_1 == "General Practice" & tmp$Race_1 == "White" & tmp$Ranking_1 == "NotTop50" & tmp$exp_1 <= 10|
                       tmp$Classification_1 == "General Practice" & tmp$Race_1 == "White" & tmp$Ranking_1 == "NotTop50" & is.na(tmp$exp_1), 16, tmp$pcp.id)

tmp$pcp.id <- ifelse(tmp$Classification_1 == "General Practice" & tmp$Race_1 == "Black" & tmp$Ranking_1 == "NotTop50" & tmp$exp_1 <= 10|
                       tmp$Classification_1 == "General Practice" & tmp$Race_1 == "Black" & tmp$Ranking_1 == "NotTop50" & is.na(tmp$exp_1), 17, tmp$pcp.id)

tmp$pcp.id <- ifelse(tmp$Classification_1 == "General Practice" & tmp$Race_1 == "Other" & tmp$Ranking_1 == "NotTop50" & tmp$exp_1 <= 10|
                       tmp$Classification_1 == "General Practice" & tmp$Race_1 == "Other" & tmp$Ranking_1 == "NotTop50" & is.na(tmp$exp_1), 18, tmp$pcp.id)

# #---------------------------------------------------------------------------------------------------------------------------------------------

# if a pcp has repetitive sp., it means sum their benecount and make that as one row.
# now, find proportions of each pair shares (each pair should exist in all 2 years)

#count tota patients received by each pcp in a year
tmp <- tmp %>%
  group_by(year, npi2) %>%
  mutate(tot.pat = sum(benecount))

#sum up the patients shared with each category of specialist id (created above)
tmp <- tmp %>%
  group_by(year, npi2, pcp.id) %>%
  mutate(sp.pat = sum(benecount))

#find share of patients shared with each category of specialist (min and max checked, share between 0 and 1)
tmp <- tmp %>%
  group_by(year, npi2, pcp.id) %>%
  mutate(sh.pat = sp.pat/tot.pat)

#  tmp$pcp.hrr.id <- ifelse(tmp$Classification_1 == "Internal Medicine" , 1, "")
# #bad ortho surgeons, without race
#  tmp$pcp.hrr.id <- ifelse(tmp$Classification_1 == "Family Medicin" , 2, tmp$pcp.hrr.id)
# > #good general surgeons, without race
#   > tmp$pcp.hrr.id <- ifelse(tmp$Classification_1 == "General Practice" , 3, tmp$pcp.hrr.id)

#create broader specialist categories to create delta

#top ortho surgeons, without race
tmp$pcp.hrr.id <- ifelse(tmp$Classification_1 == "Internal Medicine" &  tmp$Ranking_1 == "Top50"|
                           tmp$Classification_1 == "Internal Medicine" &  tmp$exp_1 > 10 , 1, "")


#bad ortho surgeons, without race
tmp$pcp.hrr.id <- ifelse(tmp$Classification_1 == "Internal Medicine" & tmp$Ranking_1 == "NotTop50" & tmp$exp_1 <= 10|
                           tmp$Classification_1 == "Internal Medicine" &  tmp$Ranking_1 == "NotTop50" & is.na(tmp$exp_1), 2, tmp$pcp.hrr.id)


#good general surgeons, without race
tmp$pcp.hrr.id <- ifelse(tmp$Classification_1 == "Family Medicine" &  tmp$Ranking_1 == "Top50"|
                           tmp$Classification_1 == "Family Medicine" &  tmp$exp_1 > 10 , 3, tmp$pcp.hrr.id)



#bad general surgeons, without race
tmp$pcp.hrr.id <- ifelse(tmp$Classification_1 == "Family Medicine" &  tmp$Ranking_1 == "NotTop50" & tmp$exp_1 <= 10|
                           tmp$Classification_1 == "Family Medicine"  & tmp$Ranking_1 == "NotTop50" & is.na(tmp$exp_1), 4, tmp$pcp.hrr.id)



tmp$pcp.hrr.id <- ifelse(tmp$Classification_1 == "General Practice" &  tmp$Ranking_1 == "Top50"|
                           tmp$Classification_1 == "General Practice" &  tmp$exp_1 > 10 , 5, tmp$pcp.hrr.id)


tmp$pcp.hrr.id <- ifelse(tmp$Classification_1 == "General Practice" & tmp$Ranking_1 == "NotTop50" & tmp$exp_1 <= 10|
                           tmp$Classification_1 == "General Practice" &  tmp$Ranking_1 == "NotTop50" & is.na(tmp$exp_1), 6, tmp$pcp.hrr.id)



#---------------------------------------------------------------------------------------------------------------------------------------------
#Generate treatment variable (Delta*Post)
tmp <- tmp %>%
  mutate(wh.pcp.ind = ifelse(Race_1 == "White", 1, 0)) %>%
  mutate(bl.pcp.ind = ifelse(Race_1 == "Black", 1, 0)) 

#total number of unique specialist available in each sp. group in an HRR
tmp <- tmp %>%
  group_by(year, hrrnum_2, pcp.hrr.id) %>%
  mutate(pcp.count = length(unique(npi1)))  

##white sp
tmp <- tmp %>%
  mutate(wh.pcp = ifelse(Race_1 == "White", npi1, NA)) %>%
  mutate(bl.pcp = ifelse(Race_1 == "Black", npi1, NA)) %>%
  mutate(ot.pcp = ifelse(Race_1 == "Other", npi1, NA)) 

#length of unique pcp and do not include nas in length
tmp <- tmp %>%
  group_by(year, hrrnum_2, pcp.hrr.id) %>%
  mutate(bl.pcp.count = length(unique(bl.pcp)[!is.na(unique(bl.pcp))])) %>%
  mutate(wh.pcp.count = length(unique(wh.pcp)[!is.na(unique(wh.pcp))]))%>%
  mutate(ot.pcp.count = length(unique(ot.pcp)[!is.na(unique(ot.pcp))]))

#proportion of black/white specialist groups who have been referred to in pcp i's hrr in that year
tmp <- tmp %>%
  group_by(year,hrrnum_2, pcp.hrr.id) %>%
  mutate(bl.pcp.sh = bl.pcp.count/pcp.count) %>%
  mutate(wh.pcp.sh = wh.pcp.count/pcp.count) %>%
  mutate(ot.pcp.sh = ot.pcp.count/pcp.count) 


#this requires sub setting data again to calculate lags properly

#temporary subset
# so subset unique npi1 in each year
sp.mover.temp <- tmp %>%
  group_by(year) %>%
  distinct(npi2, .keep_all = TRUE)

# #declare as panel data for pcp (unbalanced panel)
#sp.mover.temp <- pdata.frame(sp.mover.temp, index=c("npi1","year"))  
#class(sp.mover.temp)


sp.mover.temp <- sp.mover.temp %>%
  select(year, npi2, hrrnum_2, Race_1,Race_2,bl.pcp.sh, wh.pcp.sh, ot.pcp.sh)


sp.15 <- sp.mover.temp %>%
  filter(year == 2015) %>%
  select(npi2, hrrnum_2, bl.pcp.sh, wh.pcp.sh, ot.pcp.sh, year) %>%
  rename(hrr_2015 = hrrnum_2) %>%
  rename(wh.pcp.sh.15 = wh.pcp.sh) %>%
  rename(bl.pcp.sh.15 = bl.pcp.sh) %>%
  rename(ot.pcp.sh.15 = ot.pcp.sh) 

#dropped year var
drop <- "year"
sp.15 <- sp.15[,!names(sp.15) %in% drop]


sp.mover.temp <- sp.mover.temp %>%
  merge(sp.15, by = "npi2", all.x = TRUE)

#calculate delta term
sp.mover.temp <- sp.mover.temp %>%
  mutate(wh.delta = ifelse(year == 2013, wh.pcp.sh.15 - wh.pcp.sh , NA)) %>%
  mutate(bl.delta = ifelse(year == 2013, bl.pcp.sh.15 - bl.pcp.sh , NA)) %>%
  mutate(ot.delta = ifelse(year == 2013, ot.pcp.sh.15 - ot.pcp.sh , NA)) 


#create new var hrr to create origin hrr
sp.mover.temp <- sp.mover.temp %>%
  mutate(hrr13 = ifelse(year == 2013, hrrnum_2 , NA))

sp.mover.temp$ind_1 <- (sp.mover.temp$hrrnum_2 != sp.mover.temp$hrr_2015) &(sp.mover.temp$year == 2013)
sp.mover.temp$ind_1 <- as.numeric(sp.mover.temp$ind_1)

sp.sub <- sp.mover.temp %>%
  filter(year == 2013) %>%
  select(npi2, wh.delta,bl.delta,ot.delta, hrr13, ind_1, year) %>%
  rename(wh.delta_lag = wh.delta)  %>%
  rename(bl.delta_lag = bl.delta)  %>%
  rename(ot.delta_lag = ot.delta)  


#dropped year var
drop <- "year"
sp.sub <- sp.sub[,!names(sp.sub) %in% drop]

sp.mover.temp <- sp.mover.temp %>%
  merge(sp.sub, by = "npi2",all.x = TRUE)

#origin hrr var
sp.mover.temp$OriginHRR <- ifelse(is.na(sp.mover.temp$hrr13.x), sp.mover.temp$hrr13.y , sp.mover.temp$hrr13.x)

#this is of interest to us now
sp.mover.temp$Wh.Delta <- ifelse(is.na(sp.mover.temp$wh.delta), sp.mover.temp$wh.delta_lag , sp.mover.temp$wh.delta)
sp.mover.temp$Bl.Delta <- ifelse(is.na(sp.mover.temp$bl.delta), sp.mover.temp$bl.delta_lag , sp.mover.temp$bl.delta)
sp.mover.temp$Ot.Delta <- ifelse(is.na(sp.mover.temp$ot.delta), sp.mover.temp$ot.delta_lag , sp.mover.temp$ot.delta)


#indicator of mover
sp.mover.temp <- sp.mover.temp %>%
  rename(Mover.Ind = ind_1.y)


sp.mover.temp <- sp.mover.temp %>%
  select(year,npi2, OriginHRR, Wh.Delta, Bl.Delta, Ot.Delta, Mover.Ind)

sp.mover.1 <- merge(tmp,
                    sp.mover.temp,
                    by = c("year","npi2"), all.x = TRUE)


#create other explanatory variables

#create post dummy
sp.mover.1$post <- ifelse(sp.mover.1$year == 2015, 1, 0)

#patient risk-adjusters of each pcp based on his hrr(county) (race composition for that county for people above 65)
sp.mover.1 <- sp.mover.1 %>%
  group_by(year,hrrnum_2, npi2) %>%
  mutate(avg.sh.wh.pat = wh.share_2) %>%    #remember these shares do not sum to 1 as there are other races too (med ppuf)
  mutate(avg.sh.bl.pat = bl.share_2)  

sp.mover.1 <- sp.mover.1 %>%
  group_by(year,hrrnum_2, npi2) %>%
  mutate(avg.pat.age = bene.avg.age_2) 

#------------------------------------------------


#Filter data
reg.2 <- sp.mover.1

reg.2 <- reg.2[!(reg.2$Race_1=="Other"),]                                   
reg.2 <- reg.2[!(reg.2$Race_2=="Other"),]  


#keep only rows with mover in =1. I specify another condition that do not include mover indicator with na values,
#since if I do not put this condition, my data will have some mysterious NA rows.
reg.2 <- reg.2[reg.2$Mover.Ind == 1 & !is.na(reg.2$Mover.Ind),]

reg.2 <- reg.2 %>%
  group_by(year,npi2) %>%
  distinct(pcp.id, .keep_all = TRUE)

# reg.2 <- reg.2 %>%
#   group_by(npi1) %>%
#   filter(all(2013:2015 %in% year))

#generate Delta variable
#declare as panel data
library(plm)

reg.2 <- reg.2 %>% 
  group_by(npi2, pcp.id) %>% 
  mutate(pair_id=cur_group_id()) 

reg.2 <- pdata.frame(reg.2, index=c("pair_id","year"))  
class(reg.2)

#check if now panel is balanced, no!
is.pbalanced(reg.2$pair_id, reg.2$year)

#removed paird that do not repeat across years
reg.2 <- make.pbalanced(reg.2, balance.type = "shared.individuals", index = "pair_id") 


#create interaction term with post*opposite share delta
reg.2$opp.treat <- reg.2$post * reg.2$Bl.Delta
reg.2$same.treat <- reg.2$post * reg.2$Wh.Delta

#keep only rows for which  sp is white 
reg.2 <- reg.2[(reg.2$Race_2=="White"),]  

#keep only rows for which pcp groups are white 
reg.2 <- reg.2[(reg.2$pcp.id== 1|
                  reg.2$pcp.id== 4|
                  reg.2$pcp.id== 7|
                  reg.2$pcp.id== 10|
                  reg.2$pcp.id== 13|
                  reg.2$pcp.id== 16),]

#---------------------------------------------------------
#Add some elements to data
#like dummies of types of bins you are in
#sp id available in this data are: 1, 10, 13, 16, 19, 22, 4, 7



#new dummies
reg.2$ortho <- ifelse(reg.2$Classification_2 == "Orthopaedic Surgery", 1, 0)
reg.2$gen <- ifelse(reg.2$Classification_2 == "General Surgery", 1, 0)
reg.2$thor <- ifelse(reg.2$Classification_2 == "Thoracic Surgery (Cardiothoracic Vascular Surgery)", 1, 0)
reg.2$other <- ifelse(reg.2$Classification_2 == "Other Surgeons", 1, 0)

reg.2$good.qty <- ifelse(reg.2$Ranking_1.y == "Top50", 1, 0)
reg.2$bad.qty <- ifelse(reg.2$Ranking_1.y == "NotTop50", 1, 0)
reg.2$good.qty.1 <- ifelse(reg.2$exp_2 > 10, 1, 0)
reg.2$bad.qty.1 <- ifelse(reg.2$exp_2 <= 10 | is.na(reg.2$exp_2), 1, 0)


#---------------------------------------------------------------------------------------------------------------------------------------------


#General, ortho, cardio and other surgeons (neuro, urology, ent, trauma etc.)

#calculated mean share of patients specialty wise by using commented code categories below
reg.2$avg.ortho.pat   <- reg.2$bene_diab_1

reg.2$avg.general.pat <- rowMeans(reg.2[, c(45,48,53)],na.rm = TRUE)

reg.2$avg.other.pat   <- rowMeans(reg.2[, c(41,42,45,46,47,50,54,55)],na.rm = TRUE)

reg.2$avg.cardio.pat  <- rowMeans(reg.2[, c(40,44,46,48,49,50,51)],na.rm = TRUE)



reg.2$sh.ill.pat <- ifelse(reg.2$sp.hrr.id == 1 | reg.2$sp.hrr.id == 2, reg.2$avg.ortho.pat, reg.2$sh.ill.pat)
reg.2$sh.ill.pat <- ifelse(reg.2$sp.hrr.id == 3 | reg.2$sp.hrr.id == 4, reg.2$avg.general.pat, reg.2$sh.ill.pat)
reg.2$sh.ill.pat <- ifelse(reg.2$sp.hrr.id == 5 | reg.2$sp.hrr.id == 6, reg.2$avg.cardio.pat, reg.2$sh.ill.pat)
reg.2$sh.ill.pat <- ifelse(reg.2$sp.hrr.id == 7 | reg.2$sp.hrr.id == 8, reg.2$avg.other.pat, reg.2$sh.ill.pat)



dd.10 <- lm(sh.pat ~  post + opp.treat + avg.sh.bl.pat + avg.sh.wh.pat + sh.ill.pat +  good.ortho + bad.ortho + good.cardio + 
              bad.cardio + good.general + bad.general + good.other , data=reg.2)
summary(dd.10)
stargazer(dd.9, type = "latex")

dd.11 <- lm(sh.pat ~  post + same.treat + avg.sh.bl.pat + avg.sh.wh.pat + sh.ill.pat +  good.ortho + bad.ortho + good.cardio + 
              bad.cardio + good.general + bad.general + good.other , data=reg.2)
summary(dd.11)
#now the data we have is for ww referrals

# Basic pearson correlation test 
cor.test(reg.2$sh.pat, reg.2$opp.treat)  #insignificantly negative correlation! 


#Classic dd estimation
simple1.reg <- lm(sh.pat ~ opp.treat, data=reg.2)
stargazer(simple1.reg, type = "latex")


#DETAILED REGRESSIONS
#Regressions of ww ref on in black share (WITHOUT pcp FIXED EFFECTS)
ss.1 <- lm(sh.pat ~  post + opp.treat + exp_1  + avg.sh.bl.pat + as.factor(OriginHRR), data=reg.2)

stargazer(ss.1, type = "latex")

#Regressions of ww ref on in black share (WITHOUT pcp FIXED EFFECTS)
ss.2 <- lm(sh.pat ~  post + same.treat  + exp_1 + avg.sh.bl.pat + as.factor(OriginHRR), data=reg.2)

stargazer(ss.2, type = "latex")

#Regressions of ww ref on in black share (WITHOUT pcp FIXED EFFECTS)
ss.3 <- lm(sh.pat ~  Bl.Delta +post + opp.treat + exp_1  + avg.sh.bl.pat + as.factor(OriginHRR), data=reg.2)

stargazer(ss.3, type = "latex")

#Regressions of ww ref on in black share (WITHOUT pcp FIXED EFFECTS)
ss.4 <- lm(sh.pat ~  Wh.Delta + post + same.treat  + exp_1  + avg.sh.bl.pat + as.factor(OriginHRR), data=reg.2)

stargazer(ss.4, type = "latex")


#DETAILED REGRESSIONS
#Regressions of ww ref on in black share (WITHOUT pcp FIXED EFFECTS)
sp.1 <- lm(sh.pat ~  post + opp.treat + exp_1 +  avg.sh.wh.pat  + as.factor(OriginHRR), data=reg.2)

summary(sp.1)

stargazer(dd.1, type = "latex")

#Regressions of ww ref on in black share (WITHOUT pcp FIXED EFFECTS)
dd.2 <- lm(sh.pat ~  post + same.treat  + avg.sh.bl.pat + as.factor(OriginHRR), data=reg.2)

summary(dd.2)

stargazer(dd.2, type = "latex")

#Regressions of ww ref on in black share (WITHOUT pcp FIXED EFFECTS)
dd.3 <- lm(sh.pat ~  Bl.Delta + opp.treat  + avg.sh.bl.pat + as.factor(OriginHRR) + as.factor(year), data=reg.2)

summary(dd.3)

stargazer(dd.2, type = "latex")


# #adjust standard errors
# cov1 <- vcovHC(dd.1, type = "HC1")
# robust_se <- sqrt(diag(cov1))
# 
# cov2 <- vcovHC(dd.2, type = "HC1")
# robust_se2 <- sqrt(diag(cov2))

# #stargazer output with and witout RSE
# stargazer(dd.1, dd.2, type = "latex")









































