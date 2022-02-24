# --------------------------------------------------------------
#Note: Each HRR number is only associated with one HRR city. So, let's merge these HRR cities with census areas.

#read census data
census <- read_csv(file=paste0(data.path,'/CC-EST2020-ALLDATA6.csv'))

#create county codes smilar to zip crosswalk(combine state and county variable to get county code)
library(stringr)
census1 <- census %>%
  mutate(county=str_c(STATE, COUNTY))  #836038 obs with 51 var

#keep 2012-15 population estimates
census1 <- census1[(census1$YEAR == 6 |census1$YEAR == 7 |census1$YEAR == 8),]  #238868 obs with 51 var

#note there are other races in census data too apart from whites and blacks

census1 <- census1 %>%
  select(county, YEAR, AGEGRP, TOT_POP, TOT_MALE, TOT_FEMALE, WA_MALE, WA_FEMALE,BA_MALE, BA_FEMALE)%>%
  mutate(year2 = ifelse(YEAR == 6, 2013,"" )) %>%
  mutate(year3 = ifelse(YEAR == 7, 2014,"" ))%>%
  mutate(year4 = ifelse(YEAR == 8, 2015,"" ))%>%
  mutate(year = str_c(year2,year3, year4))


drop <- c("year2", "year3", "year4")
census1 <- census1[,!(names(census1) %in% drop)]

#keep only age groups above 65 
census1 <- census1 %>%
  filter(AGEGRP %in% c(14,15,16,17,18))  #758790 obs

#drop duplicate rows
census1 <- census1[!duplicated(census1), ]  #0 dropped

#change 19 Oct
# #Asumming total population across all older age groups(as medicare patients proxy)
census1 <- census1 %>%
  group_by(year,county) %>%
  mutate(tot.pop = sum(TOT_POP)) %>%
  mutate(tot.bl.ma = sum(BA_MALE)) %>%
  mutate(tot.bl.fe = sum(BA_FEMALE)) %>%
  mutate(tot.wh.ma = sum(WA_MALE)) %>%
  mutate(tot.wh.fe = sum(WA_FEMALE)) %>%
  mutate(tot.male = sum(TOT_MALE)) %>%
  mutate(tot.female = sum(TOT_FEMALE))


drop <- c("TOT_POP", "TOT_MALE","TOT_FEMALE","WA_MALE", "WA_FEMALE",  "BA_MALE","BA_FEMALE")
census1 <- census1[,!(names(census1) %in% drop)]

census1 <- census1 %>%
  filter(AGEGRP == 14)

drop <- c("YEAR", "AGEGRP")
census1 <- census1[,!(names(census1) %in% drop)]

#Note: We are calcularing race composition in counties for people above 65 years old only
census1 <- census1 %>%
  mutate(wh.pop = tot.wh.ma  + tot.wh.fe) %>%
  mutate(bl.pop = tot.bl.ma + tot.bl.fe) %>%
  mutate(wh.share = wh.pop/tot.pop) %>%
  mutate(bl.share = bl.pop/tot.pop) 

census1 <- census1 %>%
  mutate(year = as.numeric(year))


# --------------------------------------------------------------
#read zip crosswalk
library(readxl)
zip_crosswalk <- read_excel(paste0(data.path, "/COUNTY_ZIP_122013.xlsx"))
zip_crosswalk <- zip_crosswalk %>%
  mutate(county = COUNTY) %>%
  select(county,ZIP)

# --------------------------------------------------------------
#merge them and keep necessary variables(after reading description of census var in pdf)
census1 <- census1 %>%
  left_join(zip_crosswalk, by = "county") %>%
  select(county, ZIP, year, tot.pop, wh.pop, bl.pop, wh.share, bl.share)    #151758 obs of 8 var

census1 <- census1 %>%
  rename(zip_1 = ZIP)

#remove duplicated rows (do not exist)
census1 <- census1 %>% distinct()

#since we figured a problem that two different counties may have same zips,
#we just keep unique zips for each year as phy compare is a zip level data and we want race composition from just one county. might cause some errors!
census1<- census1 %>% 
  group_by(year) %>%
  distinct(zip_1, .keep_all = TRUE)                                                       #116796 obs


#drop na rows
census1<-  census1[!is.na(census1$zip_1),]                               #116793 obs

# --------------------------------------------------------------

#for now let's keep all zip codes, even if we do not have race composition for those as we may get this from med ppuf.
#so, in below data, we do not have racial composition for everyone.
ph.com.cens <- merge(temp, census1, 
                     by=c("zip_1", "year"),
                     all.x = TRUE)


#now load med ppuf files and then match with this above file.

#Keep only matched rows in both data so do natural join
# ph.com.cens <- merge(temp, census1, 
#         by=c("zip_1", "year"),
#         all = FALSE)                                                    #9676270 obs. of 20 var
#NOTE:race composition information not available for all zip codes in phy compare  




