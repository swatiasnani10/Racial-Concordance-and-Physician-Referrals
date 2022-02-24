# Code05_Physician Compare --------------------------------------------------------------------

## Date Created:  10/23/2021
## Date Edited:   10/23/2021

## Description:   Data cleaning: Physician Compare
#---------------------------------------------------------


# 2013Q2 Demographic Data ---------------------------------------------------
phycompare.2013.q2 <- read_csv(paste0(phycom.path,"/Q2_2013.csv"), skip=1,
                               col_names = c("npi","pac_id","enroll_id","last_name","first_name",
                                             "middle_name","suffix","gender","credential",
                                             "medical_school","graduation","specialty_primary",
                                             "specialty_sec1","specialty_sec2","specialty_sec3",
                                             "specialty_sec4","specialty_sec_all","org_name",
                                             "group_practice_id","group_practice_members",
                                             "street_address1","street_address2","street_address2_supress",
                                             "city","state","zipcode","hosp_ccn1","hosp_name1",
                                             "hosp_ccn2","hosp_name2","hosp_ccn3","hosp_name3",
                                             "hosp_ccn4","hosp_name4","hosp_ccn5","hosp_name5",
                                             "hosp_ccn6","hosp_name6","hosp_ccn7","hosp_name7",
                                             "hosp_ccn8","hosp_name8","hosp_ccn9","hosp_name9",
                                             "hosp_ccn10","hosp_name10",
                                             "medicare","erx","pqrs","ehr"),
                               col_types = cols(
                                 npi=col_number(),
                                 pac_id=col_number(),
                                 enroll_id=col_number(),
                                 last_name=col_character(),
                                 first_name=col_character(),
                                 middle_name=col_character(),
                                 suffix=col_character(),
                                 gender=col_character(),
                                 credential=col_character(),
                                 medical_school=col_character(),
                                 graduation=col_integer(),
                                 specialty_primary=col_character(),
                                 specialty_sec1=col_character(),
                                 specialty_sec2=col_character(),
                                 specialty_sec3=col_character(),
                                 specialty_sec4=col_character(),
                                 specialty_sec_all=col_character(),
                                 org_name=col_character(),
                                 group_practice_id=col_character(),
                                 group_practice_members=col_integer(),
                                 street_address1=col_character(),
                                 street_address2=col_character(),
                                 street_address2_supress=col_character(),
                                 city=col_character(),
                                 state=col_character(),
                                 zipcode=col_character(),
                                 hosp_ccn1=col_number(),
                                 hosp_name1=col_character(),
                                 hosp_ccn2=col_number(),
                                 hosp_name2=col_character(),
                                 hosp_ccn3=col_number(),
                                 hosp_name3=col_character(),
                                 hosp_ccn4=col_number(),
                                 hosp_name4=col_character(),
                                 hosp_ccn5=col_number(),
                                 hosp_name5=col_character(),
                                 hosp_ccn6=col_number(),
                                 hosp_name6=col_character(),
                                 hosp_ccn7=col_number(),
                                 hosp_name7=col_character(),
                                 hosp_ccn8=col_number(),
                                 hosp_name8=col_character(),
                                 hosp_ccn9=col_number(),
                                 hosp_name9=col_character(),
                                 hosp_ccn10=col_number(),
                                 hosp_name10=col_character(),
                                 medicare=col_character(),
                                 erx=col_character(),
                                 pqrs=col_character(),
                                 ehr=col_character()
                               ), na=".")




# 2013Q3 Demographic Data ---------------------------------------------------
phycompare.2013.q3 <- read_csv(paste0(phycom.path,"/Q3_2013.csv"), skip=1,
                               col_names = c("npi","pac_id","enroll_id","last_name","first_name",
                                             "middle_name","suffix","gender","credential",
                                             "medical_school","graduation","specialty_primary",
                                             "specialty_sec1","specialty_sec2","specialty_sec3",
                                             "specialty_sec4","specialty_sec_all","org_name",
                                             "group_practice_id","group_practice_members",
                                             "street_address1","street_address2","street_address2_supress",
                                             "city","state","zipcode","hosp_ccn1","hosp_name1",
                                             "hosp_ccn2","hosp_name2","hosp_ccn3","hosp_name3",
                                             "hosp_ccn4","hosp_name4","hosp_ccn5","hosp_name5",
                                             "hosp_ccn6","hosp_name6","hosp_ccn7","hosp_name7",
                                             "hosp_ccn8","hosp_name8","hosp_ccn9","hosp_name9",
                                             "hosp_ccn10","hosp_name10",
                                             "medicare","erx","pqrs","ehr"),
                               col_types = cols(
                                 npi=col_number(),
                                 pac_id=col_number(),
                                 enroll_id=col_number(),
                                 last_name=col_character(),
                                 first_name=col_character(),
                                 middle_name=col_character(),
                                 suffix=col_character(),
                                 gender=col_character(),
                                 credential=col_character(),
                                 medical_school=col_character(),
                                 graduation=col_integer(),
                                 specialty_primary=col_character(),
                                 specialty_sec1=col_character(),
                                 specialty_sec2=col_character(),
                                 specialty_sec3=col_character(),
                                 specialty_sec4=col_character(),
                                 specialty_sec_all=col_character(),
                                 org_name=col_character(),
                                 group_practice_id=col_character(),
                                 group_practice_members=col_integer(),
                                 street_address1=col_character(),
                                 street_address2=col_character(),
                                 street_address2_supress=col_character(),
                                 city=col_character(),
                                 state=col_character(),
                                 zipcode=col_character(),
                                 hosp_ccn1=col_number(),
                                 hosp_name1=col_character(),
                                 hosp_ccn2=col_number(),
                                 hosp_name2=col_character(),
                                 hosp_ccn3=col_number(),
                                 hosp_name3=col_character(),
                                 hosp_ccn4=col_number(),
                                 hosp_name4=col_character(),
                                 hosp_ccn5=col_number(),
                                 hosp_name5=col_character(),
                                 hosp_ccn6=col_number(),
                                 hosp_name6=col_character(),
                                 hosp_ccn7=col_number(),
                                 hosp_name7=col_character(),
                                 hosp_ccn8=col_number(),
                                 hosp_name8=col_character(),
                                 hosp_ccn9=col_number(),
                                 hosp_name9=col_character(),
                                 hosp_ccn10=col_number(),
                                 hosp_name10=col_character(),
                                 medicare=col_character(),
                                 erx=col_character(),
                                 pqrs=col_character(),
                                 ehr=col_character()
                               ), na=".")
#
# 2013 Demographic Data ---------------------------------------------------
phycompare.2013.q4 <- read_csv(paste0(phycom.path,"/Q4_2013.csv"), skip=1,
                               col_names = c("npi","pac_id","enroll_id","last_name","first_name",
                                             "middle_name","suffix","gender","credential",
                                             "medical_school","graduation","specialty_primary",
                                             "specialty_sec1","specialty_sec2","specialty_sec3",
                                             "specialty_sec4","specialty_sec_all","org_name",
                                             "group_practice_id","group_practice_members",
                                             "street_address1","street_address2","street_address2_supress",
                                             "city","state","zipcode","hosp_ccn1","hosp_name1",
                                             "hosp_ccn2","hosp_name2","hosp_ccn3","hosp_name3",
                                             "hosp_ccn4","hosp_name4","hosp_ccn5","hosp_name5",
                                             "hosp_ccn6","hosp_name6","hosp_ccn7","hosp_name7",
                                             "hosp_ccn8","hosp_name8","hosp_ccn9","hosp_name9",
                                             "hosp_ccn10","hosp_name10",
                                             "medicare","erx","pqrs","ehr"),
                               col_types = cols(
                                 npi=col_number(),
                                 pac_id=col_number(),
                                 enroll_id=col_number(),
                                 last_name=col_character(),
                                 first_name=col_character(),
                                 middle_name=col_character(),
                                 suffix=col_character(),
                                 gender=col_character(),
                                 credential=col_character(),
                                 medical_school=col_character(),
                                 graduation=col_integer(),
                                 specialty_primary=col_character(),
                                 specialty_sec1=col_character(),
                                 specialty_sec2=col_character(),
                                 specialty_sec3=col_character(),
                                 specialty_sec4=col_character(),
                                 specialty_sec_all=col_character(),
                                 org_name=col_character(),
                                 group_practice_id=col_character(),
                                 group_practice_members=col_integer(),
                                 street_address1=col_character(),
                                 street_address2=col_character(),
                                 street_address2_supress=col_character(),
                                 city=col_character(),
                                 state=col_character(),
                                 zipcode=col_character(),
                                 hosp_ccn1=col_number(),
                                 hosp_name1=col_character(),
                                 hosp_ccn2=col_number(),
                                 hosp_name2=col_character(),
                                 hosp_ccn3=col_number(),
                                 hosp_name3=col_character(),
                                 hosp_ccn4=col_number(),
                                 hosp_name4=col_character(),
                                 hosp_ccn5=col_number(),
                                 hosp_name5=col_character(),
                                 hosp_ccn6=col_number(),
                                 hosp_name6=col_character(),
                                 hosp_ccn7=col_number(),
                                 hosp_name7=col_character(),
                                 hosp_ccn8=col_number(),
                                 hosp_name8=col_character(),
                                 hosp_ccn9=col_number(),
                                 hosp_name9=col_character(),
                                 hosp_ccn10=col_number(),
                                 hosp_name10=col_character(),
                                 medicare=col_character(),
                                 erx=col_character(),
                                 pqrs=col_character(),
                                 ehr=col_character()
                               ), na=".")



# 2014 Demographic Data ---------------------------------------------------
phycompare.2014.q1 <- read_csv(paste0(phycom.path,"/Q1_2014.csv"), skip=1,
                               col_names = c("npi","pac_id","enroll_id","last_name","first_name",
                                             "middle_name","suffix","gender","credential",
                                             "medical_school","graduation","specialty_primary",
                                             "specialty_sec1","specialty_sec2","specialty_sec3",
                                             "specialty_sec4","specialty_sec_all","org_name",
                                             "group_practice_id","group_practice_members",
                                             "street_address1","street_address2","street_address2_supress",
                                             "city","state","zipcode","hosp_ccn1","hosp_name1",
                                             "hosp_ccn2","hosp_name2","hosp_ccn3","hosp_name3",
                                             "hosp_ccn4","hosp_name4","hosp_ccn5","hosp_name5",
                                             "hosp_ccn6","hosp_name6","hosp_ccn7","hosp_name7",
                                             "hosp_ccn8","hosp_name8","hosp_ccn9","hosp_name9",
                                             "hosp_ccn10","hosp_name10",
                                             "medicare","erx","pqrs","ehr"),
                               col_types = cols(
                                 npi=col_number(),
                                 pac_id=col_number(),
                                 enroll_id=col_number(),
                                 last_name=col_character(),
                                 first_name=col_character(),
                                 middle_name=col_character(),
                                 suffix=col_character(),
                                 gender=col_character(),
                                 credential=col_character(),
                                 medical_school=col_character(),
                                 graduation=col_integer(),
                                 specialty_primary=col_character(),
                                 specialty_sec1=col_character(),
                                 specialty_sec2=col_character(),
                                 specialty_sec3=col_character(),
                                 specialty_sec4=col_character(),
                                 specialty_sec_all=col_character(),
                                 org_name=col_character(),
                                 group_practice_id=col_character(),
                                 group_practice_members=col_integer(),
                                 street_address1=col_character(),
                                 street_address2=col_character(),
                                 street_address2_supress=col_character(),
                                 city=col_character(),
                                 state=col_character(),
                                 zipcode=col_character(),
                                 hosp_ccn1=col_number(),
                                 hosp_name1=col_character(),
                                 hosp_ccn2=col_number(),
                                 hosp_name2=col_character(),
                                 hosp_ccn3=col_number(),
                                 hosp_name3=col_character(),
                                 hosp_ccn4=col_number(),
                                 hosp_name4=col_character(),
                                 hosp_ccn5=col_number(),
                                 hosp_name5=col_character(),
                                 hosp_ccn6=col_number(),
                                 hosp_name6=col_character(),
                                 hosp_ccn7=col_number(),
                                 hosp_name7=col_character(),
                                 hosp_ccn8=col_number(),
                                 hosp_name8=col_character(),
                                 hosp_ccn9=col_number(),
                                 hosp_name9=col_character(),
                                 hosp_ccn10=col_number(),
                                 hosp_name10=col_character(),
                                 medicare=col_character(),
                                 erx=col_character(),
                                 pqrs=col_character(),
                                 ehr=col_character()
                               ), na=".")



# 2013 Demographic Data ---------------------------------------------------
phycompare.2014.q2 <- read_csv(paste0(phycom.path,"/Q2_2014.csv"), skip=1,
                               col_names = c("npi","pac_id","enroll_id","last_name","first_name",
                                             "middle_name","suffix","gender","credential",
                                             "medical_school","graduation","specialty_primary",
                                             "specialty_sec1","specialty_sec2","specialty_sec3",
                                             "specialty_sec4","specialty_sec_all","org_name",
                                             "group_practice_id","group_practice_members",
                                             "street_address1","street_address2","street_address2_supress",
                                             "city","state","zipcode","hosp_ccn1","hosp_name1",
                                             "hosp_ccn2","hosp_name2","hosp_ccn3","hosp_name3",
                                             "hosp_ccn4","hosp_name4","hosp_ccn5","hosp_name5",
                                             "hosp_ccn6","hosp_name6","hosp_ccn7","hosp_name7",
                                             "hosp_ccn8","hosp_name8","hosp_ccn9","hosp_name9",
                                             "hosp_ccn10","hosp_name10",
                                             "medicare","erx","pqrs","ehr"),
                               col_types = cols(
                                 npi=col_number(),
                                 pac_id=col_number(),
                                 enroll_id=col_number(),
                                 last_name=col_character(),
                                 first_name=col_character(),
                                 middle_name=col_character(),
                                 suffix=col_character(),
                                 gender=col_character(),
                                 credential=col_character(),
                                 medical_school=col_character(),
                                 graduation=col_integer(),
                                 specialty_primary=col_character(),
                                 specialty_sec1=col_character(),
                                 specialty_sec2=col_character(),
                                 specialty_sec3=col_character(),
                                 specialty_sec4=col_character(),
                                 specialty_sec_all=col_character(),
                                 org_name=col_character(),
                                 group_practice_id=col_character(),
                                 group_practice_members=col_integer(),
                                 street_address1=col_character(),
                                 street_address2=col_character(),
                                 street_address2_supress=col_character(),
                                 city=col_character(),
                                 state=col_character(),
                                 zipcode=col_character(),
                                 hosp_ccn1=col_number(),
                                 hosp_name1=col_character(),
                                 hosp_ccn2=col_number(),
                                 hosp_name2=col_character(),
                                 hosp_ccn3=col_number(),
                                 hosp_name3=col_character(),
                                 hosp_ccn4=col_number(),
                                 hosp_name4=col_character(),
                                 hosp_ccn5=col_number(),
                                 hosp_name5=col_character(),
                                 hosp_ccn6=col_number(),
                                 hosp_name6=col_character(),
                                 hosp_ccn7=col_number(),
                                 hosp_name7=col_character(),
                                 hosp_ccn8=col_number(),
                                 hosp_name8=col_character(),
                                 hosp_ccn9=col_number(),
                                 hosp_name9=col_character(),
                                 hosp_ccn10=col_number(),
                                 hosp_name10=col_character(),
                                 medicare=col_character(),
                                 erx=col_character(),
                                 pqrs=col_character(),
                                 ehr=col_character()
                               ), na=".")



# 2014 Demographic Data ---------------------------------------------------
phycompare.2014.q3 <- read_csv(paste0(phycom.path,"/Q3_2014.csv"), skip=1,
                               col_names = c("npi","pac_id","enroll_id","last_name","first_name",
                                             "middle_name","suffix","gender","credential",
                                             "medical_school","graduation","specialty_primary",
                                             "specialty_sec1","specialty_sec2","specialty_sec3",
                                             "specialty_sec4","specialty_sec_all","org_name",
                                             "group_practice_id","group_practice_members",
                                             "street_address1","street_address2","street_address2_supress",
                                             "city","state","zipcode","hosp_ccn1","hosp_name1",
                                             "hosp_ccn2","hosp_name2","hosp_ccn3","hosp_name3",
                                             "hosp_ccn4","hosp_name4","hosp_ccn5","hosp_name5",
                                             "hosp_ccn6","hosp_name6","hosp_ccn7","hosp_name7",
                                             "hosp_ccn8","hosp_name8","hosp_ccn9","hosp_name9",
                                             "hosp_ccn10","hosp_name10",
                                             "medicare","erx","pqrs","ehr"),
                               col_types = cols(
                                 npi=col_number(),
                                 pac_id=col_number(),
                                 enroll_id=col_number(),
                                 last_name=col_character(),
                                 first_name=col_character(),
                                 middle_name=col_character(),
                                 suffix=col_character(),
                                 gender=col_character(),
                                 credential=col_character(),
                                 medical_school=col_character(),
                                 graduation=col_integer(),
                                 specialty_primary=col_character(),
                                 specialty_sec1=col_character(),
                                 specialty_sec2=col_character(),
                                 specialty_sec3=col_character(),
                                 specialty_sec4=col_character(),
                                 specialty_sec_all=col_character(),
                                 org_name=col_character(),
                                 group_practice_id=col_character(),
                                 group_practice_members=col_integer(),
                                 street_address1=col_character(),
                                 street_address2=col_character(),
                                 street_address2_supress=col_character(),
                                 city=col_character(),
                                 state=col_character(),
                                 zipcode=col_character(),
                                 hosp_ccn1=col_number(),
                                 hosp_name1=col_character(),
                                 hosp_ccn2=col_number(),
                                 hosp_name2=col_character(),
                                 hosp_ccn3=col_number(),
                                 hosp_name3=col_character(),
                                 hosp_ccn4=col_number(),
                                 hosp_name4=col_character(),
                                 hosp_ccn5=col_number(),
                                 hosp_name5=col_character(),
                                 hosp_ccn6=col_number(),
                                 hosp_name6=col_character(),
                                 hosp_ccn7=col_number(),
                                 hosp_name7=col_character(),
                                 hosp_ccn8=col_number(),
                                 hosp_name8=col_character(),
                                 hosp_ccn9=col_number(),
                                 hosp_name9=col_character(),
                                 hosp_ccn10=col_number(),
                                 hosp_name10=col_character(),
                                 medicare=col_character(),
                                 erx=col_character(),
                                 pqrs=col_character(),
                                 ehr=col_character()
                               ), na=".")



# 2014 Demographic Data ---------------------------------------------------
phycompare.2014.q4 <- read_csv(paste0(phycom.path,"/Q4_2014.csv"), skip=1,
                               col_names = c("npi","pac_id","enroll_id","last_name","first_name",
                                             "middle_name","suffix","gender","credential",
                                             "medical_school","graduation","specialty_primary",
                                             "specialty_sec1","specialty_sec2","specialty_sec3",
                                             "specialty_sec4","specialty_sec_all","org_name",
                                             "group_practice_id","group_practice_members",
                                             "street_address1","street_address2","street_address3","street_address2_supress",
                                             "city","state","zipcode","hosp_ccn1","hosp_name1",
                                             "hosp_ccn2","hosp_name2","hosp_ccn3","hosp_name3",
                                             "hosp_ccn4","hosp_name4","hosp_ccn5","hosp_name5",
                                             "hosp_ccn6","hosp_name6","hosp_ccn7","hosp_name7",
                                             "hosp_ccn8","hosp_name8","hosp_ccn9","hosp_name9",
                                             "hosp_ccn10","hosp_name10",
                                             "medicare","erx","pqrs","ehr"),
                               col_types = cols(
                                 npi=col_number(),
                                 pac_id=col_number(),
                                 enroll_id=col_number(),
                                 last_name=col_character(),
                                 first_name=col_character(),
                                 middle_name=col_character(),
                                 suffix=col_character(),
                                 gender=col_character(),
                                 credential=col_character(),
                                 medical_school=col_character(),
                                 graduation=col_integer(),
                                 specialty_primary=col_character(),
                                 specialty_sec1=col_character(),
                                 specialty_sec2=col_character(),
                                 specialty_sec3=col_character(),
                                 specialty_sec4=col_character(),
                                 specialty_sec_all=col_character(),
                                 org_name=col_character(),
                                 group_practice_id=col_character(),
                                 group_practice_members=col_integer(),
                                 street_address1=col_character(),
                                 street_address2=col_character(),
                                 street_address2_supress=col_character(),
                                 city=col_character(),
                                 state=col_character(),
                                 zipcode=col_character(),
                                 hosp_ccn1=col_number(),
                                 hosp_name1=col_character(),
                                 hosp_ccn2=col_number(),
                                 hosp_name2=col_character(),
                                 hosp_ccn3=col_number(),
                                 hosp_name3=col_character(),
                                 hosp_ccn4=col_number(),
                                 hosp_name4=col_character(),
                                 hosp_ccn5=col_number(),
                                 hosp_name5=col_character(),
                                 hosp_ccn6=col_number(),
                                 hosp_name6=col_character(),
                                 hosp_ccn7=col_number(),
                                 hosp_name7=col_character(),
                                 hosp_ccn8=col_number(),
                                 hosp_name8=col_character(),
                                 hosp_ccn9=col_number(),
                                 hosp_name9=col_character(),
                                 hosp_ccn10=col_number(),
                                 hosp_name10=col_character(),
                                 medicare=col_character(),
                                 erx=col_character(),
                                 pqrs=col_character(),
                                 ehr=col_character()
                               ), na=".")


# 2015 Demographic Data ---------------------------------------------------
phycompare.2015.q1 <- read_csv(paste0(phycom.path,"/Q1_2015.csv"), skip=1,
                               col_names = c("npi","pac_id","enroll_id","last_name","first_name",
                                             "middle_name","suffix","gender","credential",
                                             "medical_school","graduation","specialty_primary",
                                             "specialty_sec1","specialty_sec2","specialty_sec3",
                                             "specialty_sec4","specialty_sec_all","org_name",
                                             "group_practice_id","group_practice_members",
                                             "street_address1","street_address2","street_address3","street_address2_supress",
                                             "city","state","zipcode","hosp_ccn1","hosp_name1",
                                             "hosp_ccn2","hosp_name2","hosp_ccn3","hosp_name3",
                                             "hosp_ccn4","hosp_name4","hosp_ccn5","hosp_name5",
                                             "hosp_ccn6","hosp_name6","hosp_ccn7","hosp_name7",
                                             "hosp_ccn8","hosp_name8","hosp_ccn9","hosp_name9",
                                             "hosp_ccn10","hosp_name10",
                                             "medicare","erx","pqrs","ehr"),
                               col_types = cols(
                                 npi=col_number(),
                                 pac_id=col_number(),
                                 enroll_id=col_number(),
                                 last_name=col_character(),
                                 first_name=col_character(),
                                 middle_name=col_character(),
                                 suffix=col_character(),
                                 gender=col_character(),
                                 credential=col_character(),
                                 medical_school=col_character(),
                                 graduation=col_integer(),
                                 specialty_primary=col_character(),
                                 specialty_sec1=col_character(),
                                 specialty_sec2=col_character(),
                                 specialty_sec3=col_character(),
                                 specialty_sec4=col_character(),
                                 specialty_sec_all=col_character(),
                                 org_name=col_character(),
                                 group_practice_id=col_character(),
                                 group_practice_members=col_integer(),
                                 street_address1=col_character(),
                                 street_address2=col_character(),
                                 street_address2_supress=col_character(),
                                 city=col_character(),
                                 state=col_character(),
                                 zipcode=col_character(),
                                 hosp_ccn1=col_number(),
                                 hosp_name1=col_character(),
                                 hosp_ccn2=col_number(),
                                 hosp_name2=col_character(),
                                 hosp_ccn3=col_number(),
                                 hosp_name3=col_character(),
                                 hosp_ccn4=col_number(),
                                 hosp_name4=col_character(),
                                 hosp_ccn5=col_number(),
                                 hosp_name5=col_character(),
                                 hosp_ccn6=col_number(),
                                 hosp_name6=col_character(),
                                 hosp_ccn7=col_number(),
                                 hosp_name7=col_character(),
                                 hosp_ccn8=col_number(),
                                 hosp_name8=col_character(),
                                 hosp_ccn9=col_number(),
                                 hosp_name9=col_character(),
                                 hosp_ccn10=col_number(),
                                 hosp_name10=col_character(),
                                 medicare=col_character(),
                                 erx=col_character(),
                                 pqrs=col_character(),
                                 ehr=col_character()
                               ), na=".")


# 2015 Demographic Data ---------------------------------------------------
phycompare.2015.q2 <- read_csv(paste0(phycom.path,"/Q2_2015.csv"), skip=1,
                               col_names = c("npi","pac_id","enroll_id","last_name","first_name",
                                             "middle_name","suffix","gender","credential",
                                             "medical_school","graduation","specialty_primary",
                                             "specialty_sec1","specialty_sec2","specialty_sec3",
                                             "specialty_sec4","specialty_sec_all","org_name",
                                             "group_practice_id","group_practice_members",
                                             "street_address1","street_address2","street_address3", "street_address2_supress",
                                             "city","state","zipcode","hosp_ccn1","hosp_name1",
                                             "hosp_ccn2","hosp_name2","hosp_ccn3","hosp_name3",
                                             "hosp_ccn4","hosp_name4","hosp_ccn5","hosp_name5",
                                             "hosp_ccn6","hosp_name6","hosp_ccn7","hosp_name7",
                                             "hosp_ccn8","hosp_name8","hosp_ccn9","hosp_name9",
                                             "hosp_ccn10","hosp_name10",
                                             "medicare","erx","pqrs","ehr"),
                               col_types = cols(
                                 npi=col_number(),
                                 pac_id=col_number(),
                                 enroll_id=col_number(),
                                 last_name=col_character(),
                                 first_name=col_character(),
                                 middle_name=col_character(),
                                 suffix=col_character(),
                                 gender=col_character(),
                                 credential=col_character(),
                                 medical_school=col_character(),
                                 graduation=col_integer(),
                                 specialty_primary=col_character(),
                                 specialty_sec1=col_character(),
                                 specialty_sec2=col_character(),
                                 specialty_sec3=col_character(),
                                 specialty_sec4=col_character(),
                                 specialty_sec_all=col_character(),
                                 org_name=col_character(),
                                 group_practice_id=col_character(),
                                 group_practice_members=col_integer(),
                                 street_address1=col_character(),
                                 street_address2=col_character(),
                                 street_address2_supress=col_character(),
                                 city=col_character(),
                                 state=col_character(),
                                 zipcode=col_character(),
                                 hosp_ccn1=col_number(),
                                 hosp_name1=col_character(),
                                 hosp_ccn2=col_number(),
                                 hosp_name2=col_character(),
                                 hosp_ccn3=col_number(),
                                 hosp_name3=col_character(),
                                 hosp_ccn4=col_number(),
                                 hosp_name4=col_character(),
                                 hosp_ccn5=col_number(),
                                 hosp_name5=col_character(),
                                 hosp_ccn6=col_number(),
                                 hosp_name6=col_character(),
                                 hosp_ccn7=col_number(),
                                 hosp_name7=col_character(),
                                 hosp_ccn8=col_number(),
                                 hosp_name8=col_character(),
                                 hosp_ccn9=col_number(),
                                 hosp_name9=col_character(),
                                 hosp_ccn10=col_number(),
                                 hosp_name10=col_character(),
                                 medicare=col_character(),
                                 erx=col_character(),
                                 pqrs=col_character(),
                                 ehr=col_character()
                               ), na=".")




# 2015 Demographic Data ---------------------------------------------------
phycompare.2015.q3 <- read_csv(paste0(phycom.path,"/Q3_2015.csv"), skip=1,
                               col_names = c("npi","pac_id","enroll_id","last_name","first_name",
                                             "middle_name","suffix","gender","credential",
                                             "medical_school","graduation","specialty_primary",
                                             "specialty_sec1","specialty_sec2","specialty_sec3",
                                             "specialty_sec4","specialty_sec_all","org_name",
                                             "group_practice_id","group_practice_members",
                                             "street_address1","street_address2","street_address3","street_address2_supress",
                                             "city","state","zipcode","hosp_ccn1","hosp_name1",
                                             "hosp_ccn2","hosp_name2","hosp_ccn3","hosp_name3",
                                             "hosp_ccn4","hosp_name4","hosp_ccn5","hosp_name5",
                                             "hosp_ccn6","hosp_name6","hosp_ccn7","hosp_name7",
                                             "hosp_ccn8","hosp_name8","hosp_ccn9","hosp_name9",
                                             "hosp_ccn10","hosp_name10",
                                             "medicare","erx","pqrs","ehr"),
                               col_types = cols(
                                 npi=col_number(),
                                 pac_id=col_number(),
                                 enroll_id=col_number(),
                                 last_name=col_character(),
                                 first_name=col_character(),
                                 middle_name=col_character(),
                                 suffix=col_character(),
                                 gender=col_character(),
                                 credential=col_character(),
                                 medical_school=col_character(),
                                 graduation=col_integer(),
                                 specialty_primary=col_character(),
                                 specialty_sec1=col_character(),
                                 specialty_sec2=col_character(),
                                 specialty_sec3=col_character(),
                                 specialty_sec4=col_character(),
                                 specialty_sec_all=col_character(),
                                 org_name=col_character(),
                                 group_practice_id=col_character(),
                                 group_practice_members=col_integer(),
                                 street_address1=col_character(),
                                 street_address2=col_character(),
                                 street_address2_supress=col_character(),
                                 city=col_character(),
                                 state=col_character(),
                                 zipcode=col_character(),
                                 hosp_ccn1=col_number(),
                                 hosp_name1=col_character(),
                                 hosp_ccn2=col_number(),
                                 hosp_name2=col_character(),
                                 hosp_ccn3=col_number(),
                                 hosp_name3=col_character(),
                                 hosp_ccn4=col_number(),
                                 hosp_name4=col_character(),
                                 hosp_ccn5=col_number(),
                                 hosp_name5=col_character(),
                                 hosp_ccn6=col_number(),
                                 hosp_name6=col_character(),
                                 hosp_ccn7=col_number(),
                                 hosp_name7=col_character(),
                                 hosp_ccn8=col_number(),
                                 hosp_name8=col_character(),
                                 hosp_ccn9=col_number(),
                                 hosp_name9=col_character(),
                                 hosp_ccn10=col_number(),
                                 hosp_name10=col_character(),
                                 medicare=col_character(),
                                 erx=col_character(),
                                 pqrs=col_character(),
                                 ehr=col_character()
                               ), na=".")



# 2015 Demographic Data ---------------------------------------------------
phycompare.2015.q4 <- read_csv(paste0(phycom.path,"/Q4_2015.csv"), skip=1,
                               col_names = c("npi","pac_id","enroll_id","last_name","first_name",
                                             "middle_name","suffix","gender","credential",
                                             "medical_school","graduation","specialty_primary",
                                             "specialty_sec1","specialty_sec2","specialty_sec3",
                                             "specialty_sec4","specialty_sec_all","org_name",
                                             "group_practice_id","group_practice_members",
                                             "street_address1","street_address2","street_address3","street_address2_supress",
                                             "city","state","zipcode","hosp_ccn1","hosp_name1",
                                             "hosp_ccn2","hosp_name2","hosp_ccn3","hosp_name3",
                                             "hosp_ccn4","hosp_name4","hosp_ccn5","hosp_name5",
                                             "hosp_ccn6","hosp_name6","hosp_ccn7","hosp_name7",
                                             "hosp_ccn8","hosp_name8","hosp_ccn9","hosp_name9",
                                             "hosp_ccn10","hosp_name10",
                                             "medicare","erx","pqrs","ehr"),
                               col_types = cols(
                                 npi=col_number(),
                                 pac_id=col_number(),
                                 enroll_id=col_number(),
                                 last_name=col_character(),
                                 first_name=col_character(),
                                 middle_name=col_character(),
                                 suffix=col_character(),
                                 gender=col_character(),
                                 credential=col_character(),
                                 medical_school=col_character(),
                                 graduation=col_integer(),
                                 specialty_primary=col_character(),
                                 specialty_sec1=col_character(),
                                 specialty_sec2=col_character(),
                                 specialty_sec3=col_character(),
                                 specialty_sec4=col_character(),
                                 specialty_sec_all=col_character(),
                                 org_name=col_character(),
                                 group_practice_id=col_character(),
                                 group_practice_members=col_integer(),
                                 street_address1=col_character(),
                                 street_address2=col_character(),
                                 street_address2_supress=col_character(),
                                 city=col_character(),
                                 state=col_character(),
                                 zipcode=col_character(),
                                 hosp_ccn1=col_number(),
                                 hosp_name1=col_character(),
                                 hosp_ccn2=col_number(),
                                 hosp_name2=col_character(),
                                 hosp_ccn3=col_number(),
                                 hosp_name3=col_character(),
                                 hosp_ccn4=col_number(),
                                 hosp_name4=col_character(),
                                 hosp_ccn5=col_number(),
                                 hosp_name5=col_character(),
                                 hosp_ccn6=col_number(),
                                 hosp_name6=col_character(),
                                 hosp_ccn7=col_number(),
                                 hosp_name7=col_character(),
                                 hosp_ccn8=col_number(),
                                 hosp_name8=col_character(),
                                 hosp_ccn9=col_number(),
                                 hosp_name9=col_character(),
                                 hosp_ccn10=col_number(),
                                 hosp_name10=col_character(),
                                 medicare=col_character(),
                                 erx=col_character(),
                                 pqrs=col_character(),
                                 ehr=col_character()
                               ), na=".")

# Clean Data --------------------------------------------------------------

## use 2013 q2 
phycompare.2013.Q2 <- phycompare.2013.q2 %>%
  mutate(zip = str_sub(zipcode, start=1, end=5)) %>%
  select(npi, pac_id, enroll_id, last_name, first_name, suffix, gender, credential, 
         medical_school, graduation, starts_with("specialty"),
         org_name, prac_id=group_practice_id, prac_size=group_practice_members,
         street_address1, city, state, zip, starts_with("hosp"))

phycompare.2013.Q2 <- distinct(phycompare.2013.Q2)

nodes.2013 <- phycompare.2013.Q2 %>%
  distinct(npi)

office.2013 <- phycompare.2013.Q2 %>%
  distinct(npi, street_address1) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=street_address1,
              names_prefix="street_")

city.2013 <- phycompare.2013.Q2 %>%
  distinct(npi, city, state, zip) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(city, state, zip)) %>%
  select(npi, city_1:city_5, state_1:state_5, zip_1:zip_5)

practice.2013 <- phycompare.2013.Q2 %>%
  distinct(npi, prac_id, prac_size) %>%
  arrange(npi, prac_size) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(prac_id, prac_size)) %>%
  select(npi, prac_id_1:prac_id_3, prac_size_1:prac_size_3)

demo.2013 <- phycompare.2013.Q2 %>%
  distinct(npi, gender, credential, medical_school, graduation) %>%
  group_by(npi) %>%
  mutate(count_gender=n_distinct(gender),
         count_cred=n_distinct(credential),
         count_med=n_distinct(medical_school),
         count_grad=n_distinct(graduation)) %>%
  arrange(npi, count_gender, count_cred, count_grad) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(gender, credential, medical_school, graduation)) %>%
  select(-c(starts_with("count_")))

nodes.2013.Q2 <- nodes.2013 %>%
  left_join(city.2013, by="npi") %>%
  left_join(practice.2013, by="npi") %>%
  left_join(demo.2013, by="npi")

nodes.2013.Q2$year <- 2013
nodes.2013.Q2$quarter <- "Q2"

# --------------------------------------------------------------

## use 2013 q3 
phycompare.2013.Q3 <- phycompare.2013.q3 %>%
  mutate(zip = str_sub(zipcode, start=1, end=5)) %>%
  select(npi, pac_id, enroll_id, last_name, first_name, suffix, gender, credential, 
         medical_school, graduation, starts_with("specialty"),
         org_name, prac_id=group_practice_id, prac_size=group_practice_members,
         street_address1, city, state, zip, starts_with("hosp"))

phycompare.2013.Q3 <- distinct(phycompare.2013.Q3)

nodes.2013 <- phycompare.2013.Q3 %>%
  distinct(npi)

office.2013 <- phycompare.2013.Q3 %>%
  distinct(npi, street_address1) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=street_address1,
              names_prefix="street_")

city.2013 <- phycompare.2013.Q3 %>%
  distinct(npi, city, state, zip) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(city, state, zip)) %>%
  select(npi, city_1:city_5, state_1:state_5, zip_1:zip_5)

practice.2013 <- phycompare.2013.Q3 %>%
  distinct(npi, prac_id, prac_size) %>%
  arrange(npi, prac_size) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(prac_id, prac_size)) %>%
  select(npi, prac_id_1:prac_id_3, prac_size_1:prac_size_3)

demo.2013 <- phycompare.2013.Q3 %>%
  distinct(npi, gender, credential, medical_school, graduation) %>%
  group_by(npi) %>%
  mutate(count_gender=n_distinct(gender),
         count_cred=n_distinct(credential),
         count_med=n_distinct(medical_school),
         count_grad=n_distinct(graduation)) %>%
  arrange(npi, count_gender, count_cred, count_grad) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(gender, credential, medical_school, graduation)) %>%
  select(-c(starts_with("count_")))

nodes.2013.Q3 <- nodes.2013 %>%
  left_join(city.2013, by="npi") %>%
  left_join(practice.2013, by="npi") %>%
  left_join(demo.2013, by="npi")


nodes.2013.Q3$year <- 2013
nodes.2013.Q3$quarter <- "Q3"

# --------------------------------------------------------------

## use 2013 q4 
phycompare.2013.Q4 <- phycompare.2013.q4 %>%
  mutate(zip = str_sub(zipcode, start=1, end=5)) %>%
  select(npi, pac_id, enroll_id, last_name, first_name, suffix, gender, credential, 
         medical_school, graduation, starts_with("specialty"),
         org_name, prac_id=group_practice_id, prac_size=group_practice_members,
         street_address1, city, state, zip, starts_with("hosp"))

phycompare.2013.Q4 <- distinct(phycompare.2013.Q4)

nodes.2013 <- phycompare.2013.Q4 %>%
  distinct(npi)

office.2013 <- phycompare.2013.Q4 %>%
  distinct(npi, street_address1) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=street_address1,
              names_prefix="street_")

city.2013 <- phycompare.2013.Q4 %>%
  distinct(npi, city, state, zip) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(city, state, zip)) %>%
  select(npi, city_1:city_5, state_1:state_5, zip_1:zip_5)

practice.2013 <- phycompare.2013.Q4 %>%
  distinct(npi, prac_id, prac_size) %>%
  arrange(npi, prac_size) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(prac_id, prac_size)) %>%
  select(npi, prac_id_1:prac_id_3, prac_size_1:prac_size_3)

demo.2013 <- phycompare.2013.Q4 %>%
  distinct(npi, gender, credential, medical_school, graduation) %>%
  group_by(npi) %>%
  mutate(count_gender=n_distinct(gender),
         count_cred=n_distinct(credential),
         count_med=n_distinct(medical_school),
         count_grad=n_distinct(graduation)) %>%
  arrange(npi, count_gender, count_cred, count_grad) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(gender, credential, medical_school, graduation)) %>%
  select(-c(starts_with("count_")))

nodes.2013.Q4 <- nodes.2013 %>%
  left_join(city.2013, by="npi") %>%
  left_join(practice.2013, by="npi") %>%
  left_join(demo.2013, by="npi")


nodes.2013.Q4$year <- 2013
nodes.2013.Q4$quarter <- "Q4"
rm(office.2013,demo.2013,nodes.2013,practice.2013)
# --------------------------------------------------------------

## use 2014 q1 
phycompare.2014.Q1 <- phycompare.2014.q1 %>%
  mutate(zip = str_sub(zipcode, start=1, end=5)) %>%
  select(npi, pac_id, enroll_id, last_name, first_name, suffix, gender, credential, 
         medical_school, graduation, starts_with("specialty"),
         org_name, prac_id=group_practice_id, prac_size=group_practice_members,
         street_address1, city, state, zip, starts_with("hosp"))

phycompare.2014.Q1 <- distinct(phycompare.2014.Q1)

nodes.2014 <- phycompare.2014.Q1 %>%
  distinct(npi)

office.2014 <- phycompare.2014.Q1 %>%
  distinct(npi, street_address1) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=street_address1,
              names_prefix="street_")

city.2014 <- phycompare.2014.Q1 %>%
  distinct(npi, city, state, zip) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(city, state, zip)) %>%
  select(npi, city_1:city_5, state_1:state_5, zip_1:zip_5)

practice.2014 <- phycompare.2014.Q1 %>%
  distinct(npi, prac_id, prac_size) %>%
  arrange(npi, prac_size) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(prac_id, prac_size)) %>%
  select(npi, prac_id_1:prac_id_3, prac_size_1:prac_size_3)

demo.2014 <- phycompare.2014.Q1 %>%
  distinct(npi, gender, credential, medical_school, graduation) %>%
  group_by(npi) %>%
  mutate(count_gender=n_distinct(gender),
         count_cred=n_distinct(credential),
         count_med=n_distinct(medical_school),
         count_grad=n_distinct(graduation)) %>%
  arrange(npi, count_gender, count_cred, count_grad) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(gender, credential, medical_school, graduation)) %>%
  select(-c(starts_with("count_")))

nodes.2014.Q1 <- nodes.2014 %>%
  left_join(city.2014, by="npi") %>%
  left_join(practice.2014, by="npi") %>%
  left_join(demo.2014, by="npi")


nodes.2014.Q1$year <- 2014
nodes.2014.Q1$quarter <- "Q1"
# --------------------------------------------------------------
## use 2014 q2 
phycompare.2014.Q2 <- phycompare.2014.q2 %>%
  mutate(zip = str_sub(zipcode, start=1, end=5)) %>%
  select(npi, pac_id, enroll_id, last_name, first_name, suffix, gender, credential, 
         medical_school, graduation, starts_with("specialty"),
         org_name, prac_id=group_practice_id, prac_size=group_practice_members,
         street_address1, city, state, zip, starts_with("hosp"))

phycompare.2014.Q2 <- distinct(phycompare.2014.Q2)

nodes.2014 <- phycompare.2014.Q2 %>%
  distinct(npi)

office.2014 <- phycompare.2014.Q2 %>%
  distinct(npi, street_address1) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=street_address1,
              names_prefix="street_")

city.2014 <- phycompare.2014.Q2 %>%
  distinct(npi, city, state, zip) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(city, state, zip)) %>%
  select(npi, city_1:city_5, state_1:state_5, zip_1:zip_5)

practice.2014 <- phycompare.2014.Q2 %>%
  distinct(npi, prac_id, prac_size) %>%
  arrange(npi, prac_size) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(prac_id, prac_size)) %>%
  select(npi, prac_id_1:prac_id_3, prac_size_1:prac_size_3)

demo.2014 <- phycompare.2014.Q2 %>%
  distinct(npi, gender, credential, medical_school, graduation) %>%
  group_by(npi) %>%
  mutate(count_gender=n_distinct(gender),
         count_cred=n_distinct(credential),
         count_med=n_distinct(medical_school),
         count_grad=n_distinct(graduation)) %>%
  arrange(npi, count_gender, count_cred, count_grad) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(gender, credential, medical_school, graduation)) %>%
  select(-c(starts_with("count_")))

nodes.2014.Q2 <- nodes.2014 %>%
  left_join(city.2014, by="npi") %>%
  left_join(practice.2014, by="npi") %>%
  left_join(demo.2014, by="npi")


nodes.2014.Q2$year <- 2014
nodes.2014.Q2$quarter <- "Q2"
# --------------------------------------------------------------
## use 2014 q3 
phycompare.2014.Q3 <- phycompare.2014.q3 %>%
  mutate(zip = str_sub(zipcode, start=1, end=5)) %>%
  select(npi, pac_id, enroll_id, last_name, first_name, suffix, gender, credential, 
         medical_school, graduation, starts_with("specialty"),
         org_name, prac_id=group_practice_id, prac_size=group_practice_members,
         street_address1, city, state, zip, starts_with("hosp"))

phycompare.2014.Q3 <- distinct(phycompare.2014.Q3)

nodes.2014 <- phycompare.2014.Q3 %>%
  distinct(npi)

office.2014 <- phycompare.2014.Q3 %>%
  distinct(npi, street_address1) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=street_address1,
              names_prefix="street_")

city.2014 <- phycompare.2014.Q3 %>%
  distinct(npi, city, state, zip) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(city, state, zip)) %>%
  select(npi, city_1:city_5, state_1:state_5, zip_1:zip_5)

practice.2014 <- phycompare.2014.Q3 %>%
  distinct(npi, prac_id, prac_size) %>%
  arrange(npi, prac_size) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(prac_id, prac_size)) %>%
  select(npi, prac_id_1:prac_id_3, prac_size_1:prac_size_3)

demo.2014 <- phycompare.2014.Q3 %>%
  distinct(npi, gender, credential, medical_school, graduation) %>%
  group_by(npi) %>%
  mutate(count_gender=n_distinct(gender),
         count_cred=n_distinct(credential),
         count_med=n_distinct(medical_school),
         count_grad=n_distinct(graduation)) %>%
  arrange(npi, count_gender, count_cred, count_grad) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(gender, credential, medical_school, graduation)) %>%
  select(-c(starts_with("count_")))

nodes.2014.Q3 <- nodes.2014 %>%
  left_join(city.2014, by="npi") %>%
  left_join(practice.2014, by="npi") %>%
  left_join(demo.2014, by="npi")


nodes.2014.Q3$year <- 2014
nodes.2014.Q3$quarter <- "Q3"
# --------------------------------------------------------------

## use 2014 q4 

phycompare.2014.Q4 <- phycompare.2014.q4 %>%
  mutate(zip = str_sub(zipcode, start=1, end=5)) %>%
  select(npi, pac_id, enroll_id, last_name, first_name, suffix, gender, credential, 
         medical_school, graduation, starts_with("specialty"),
         org_name, prac_id=group_practice_id, prac_size=group_practice_members,
         street_address1, city, state, zip, starts_with("hosp"))

phycompare.2014.Q4 <- distinct(phycompare.2014.Q4)

nodes.2014 <- phycompare.2014.Q4 %>%
  distinct(npi)

office.2014 <- phycompare.2014.Q4 %>%
  distinct(npi, street_address1) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=street_address1,
              names_prefix="street_")

city.2014 <- phycompare.2014.Q4 %>%
  distinct(npi, city, state, zip) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(city, state, zip)) %>%
  select(npi, city_1:city_5, state_1:state_5, zip_1:zip_5)

practice.2014 <- phycompare.2014.Q4 %>%
  distinct(npi, prac_id, prac_size) %>%
  arrange(npi, prac_size) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(prac_id, prac_size)) %>%
  select(npi, prac_id_1:prac_id_3, prac_size_1:prac_size_3)

demo.2014 <- phycompare.2014.Q4 %>%
  distinct(npi, gender, credential, medical_school, graduation) %>%
  group_by(npi) %>%
  mutate(count_gender=n_distinct(gender),
         count_cred=n_distinct(credential),
         count_med=n_distinct(medical_school),
         count_grad=n_distinct(graduation)) %>%
  arrange(npi, count_gender, count_cred, count_grad) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(gender, credential, medical_school, graduation)) %>%
  select(-c(starts_with("count_")))

nodes.2014.Q4 <- nodes.2014 %>%
  left_join(city.2014, by="npi") %>%
  left_join(practice.2014, by="npi") %>%
  left_join(demo.2014, by="npi")


nodes.2014.Q4$year <- 2014
nodes.2014.Q4$quarter <- "Q4"

# --------------------------------------------------------------

## use 2015 q1 
phycompare.2015.Q1 <- phycompare.2015.q1 %>%
  mutate(zip = str_sub(zipcode, start=1, end=5)) %>%
  select(npi, pac_id, enroll_id, last_name, first_name, suffix, gender, credential, 
         medical_school, graduation, starts_with("specialty"),
         org_name, prac_id=group_practice_id, prac_size=group_practice_members,
         street_address1, city, state, zip, starts_with("hosp"))

phycompare.2015.Q1 <- distinct(phycompare.2015.Q1)

nodes.2015 <- phycompare.2015.Q1 %>%
  distinct(npi)

office.2015 <- phycompare.2015.Q1 %>%
  distinct(npi, street_address1) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=street_address1,
              names_prefix="street_")

city.2015 <- phycompare.2015.Q1 %>%
  distinct(npi, city, state, zip) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(city, state, zip)) %>%
  select(npi, city_1:city_5, state_1:state_5, zip_1:zip_5)

practice.2015 <- phycompare.2015.Q1 %>%
  distinct(npi, prac_id, prac_size) %>%
  arrange(npi, prac_size) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(prac_id, prac_size)) %>%
  select(npi, prac_id_1:prac_id_3, prac_size_1:prac_size_3)

demo.2015 <- phycompare.2015.Q1 %>%
  distinct(npi, gender, credential, medical_school, graduation) %>%
  group_by(npi) %>%
  mutate(count_gender=n_distinct(gender),
         count_cred=n_distinct(credential),
         count_med=n_distinct(medical_school),
         count_grad=n_distinct(graduation)) %>%
  arrange(npi, count_gender, count_cred, count_grad) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(gender, credential, medical_school, graduation)) %>%
  select(-c(starts_with("count_")))

nodes.2015.Q1 <- nodes.2015 %>%
  left_join(city.2015, by="npi") %>%
  left_join(practice.2015, by="npi") %>%
  left_join(demo.2015, by="npi")


nodes.2015.Q1$year <- 2015
nodes.2015.Q1$quarter <- "Q1"
# --------------------------------------------------------------
# --------------------------------------------------------------
## use 2015 q2 
phycompare.2015.Q2 <- phycompare.2015.q2 %>%
  mutate(zip = str_sub(zipcode, start=1, end=5)) %>%
  select(npi, pac_id, enroll_id, last_name, first_name, suffix, gender, credential, 
         medical_school, graduation, starts_with("specialty"),
         org_name, prac_id=group_practice_id, prac_size=group_practice_members,
         street_address1, city, state, zip, starts_with("hosp"))

phycompare.2015.Q2 <- distinct(phycompare.2015.Q2)

nodes.2015 <- phycompare.2015.Q2 %>%
  distinct(npi)

office.2015 <- phycompare.2015.Q2 %>%
  distinct(npi, street_address1) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=street_address1,
              names_prefix="street_")

city.2015 <- phycompare.2015.Q2 %>%
  distinct(npi, city, state, zip) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(city, state, zip)) %>%
  select(npi, city_1:city_5, state_1:state_5, zip_1:zip_5)

practice.2015 <- phycompare.2015.Q2 %>%
  distinct(npi, prac_id, prac_size) %>%
  arrange(npi, prac_size) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(prac_id, prac_size)) %>%
  select(npi, prac_id_1:prac_id_3, prac_size_1:prac_size_3)

demo.2015 <- phycompare.2015.Q2 %>%
  distinct(npi, gender, credential, medical_school, graduation) %>%
  group_by(npi) %>%
  mutate(count_gender=n_distinct(gender),
         count_cred=n_distinct(credential),
         count_med=n_distinct(medical_school),
         count_grad=n_distinct(graduation)) %>%
  arrange(npi, count_gender, count_cred, count_grad) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(gender, credential, medical_school, graduation)) %>%
  select(-c(starts_with("count_")))

nodes.2015.Q2 <- nodes.2015 %>%
  left_join(city.2015, by="npi") %>%
  left_join(practice.2015, by="npi") %>%
  left_join(demo.2015, by="npi")


nodes.2015.Q2$year <- 2015
nodes.2015.Q2$quarter <- "Q2"
# --------------------------------------------------------------
## use 2015 q3 
phycompare.2015.Q3 <- phycompare.2015.q3 %>%
  mutate(zip = str_sub(zipcode, start=1, end=5)) %>%
  select(npi, pac_id, enroll_id, last_name, first_name, suffix, gender, credential, 
         medical_school, graduation, starts_with("specialty"),
         org_name, prac_id=group_practice_id, prac_size=group_practice_members,
         street_address1, city, state, zip, starts_with("hosp"))

phycompare.2015.Q3 <- distinct(phycompare.2015.Q3)

nodes.2015 <- phycompare.2015.Q3 %>%
  distinct(npi)

office.2015 <- phycompare.2015.Q3 %>%
  distinct(npi, street_address1) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=street_address1,
              names_prefix="street_")

city.2015 <- phycompare.2015.Q3 %>%
  distinct(npi, city, state, zip) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(city, state, zip)) %>%
  select(npi, city_1:city_5, state_1:state_5, zip_1:zip_5)

practice.2015 <- phycompare.2015.Q3 %>%
  distinct(npi, prac_id, prac_size) %>%
  arrange(npi, prac_size) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(prac_id, prac_size)) %>%
  select(npi, prac_id_1:prac_id_3, prac_size_1:prac_size_3)

demo.2015 <- phycompare.2015.Q3 %>%
  distinct(npi, gender, credential, medical_school, graduation) %>%
  group_by(npi) %>%
  mutate(count_gender=n_distinct(gender),
         count_cred=n_distinct(credential),
         count_med=n_distinct(medical_school),
         count_grad=n_distinct(graduation)) %>%
  arrange(npi, count_gender, count_cred, count_grad) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(gender, credential, medical_school, graduation)) %>%
  select(-c(starts_with("count_")))

nodes.2015.Q3 <- nodes.2015 %>%
  left_join(city.2015, by="npi") %>%
  left_join(practice.2015, by="npi") %>%
  left_join(demo.2015, by="npi")


nodes.2015.Q3$year <- 2015
nodes.2015.Q3$quarter <- "Q3"
# --------------------------------------------------------------

## use 2015 q4 
phycompare.2015.Q4 <- phycompare.2015.q4 %>%
  mutate(zip = str_sub(zipcode, start=1, end=5)) %>%
  select(npi, pac_id, enroll_id, last_name, first_name, suffix, gender, credential, 
         medical_school, graduation, starts_with("specialty"),
         org_name, prac_id=group_practice_id, prac_size=group_practice_members,
         street_address1, city, state, zip, starts_with("hosp"))

phycompare.2015.Q4 <- distinct(phycompare.2015.Q4)

nodes.2015 <- phycompare.2015.Q4 %>%
  distinct(npi)

office.2015 <- phycompare.2015.Q4 %>%
  distinct(npi, street_address1) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=street_address1,
              names_prefix="street_")

city.2015 <- phycompare.2015.Q4 %>%
  distinct(npi, city, state, zip) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(city, state, zip)) %>%
  select(npi, city_1:city_5, state_1:state_5, zip_1:zip_5)

practice.2015 <- phycompare.2015.Q4 %>%
  distinct(npi, prac_id, prac_size) %>%
  arrange(npi, prac_size) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(prac_id, prac_size)) %>%
  select(npi, prac_id_1:prac_id_3, prac_size_1:prac_size_3)

demo.2015 <- phycompare.2015.Q4 %>%
  distinct(npi, gender, credential, medical_school, graduation) %>%
  group_by(npi) %>%
  mutate(count_gender=n_distinct(gender),
         count_cred=n_distinct(credential),
         count_med=n_distinct(medical_school),
         count_grad=n_distinct(graduation)) %>%
  arrange(npi, count_gender, count_cred, count_grad) %>%
  group_by(npi) %>% mutate(npi_count=seq(n())) %>% ungroup() %>%
  pivot_wider(names_from=npi_count, 
              values_from=c(gender, credential, medical_school, graduation)) %>%
  select(-c(starts_with("count_")))

nodes.2015.Q4 <- nodes.2015 %>%
  left_join(city.2015, by="npi") %>%
  left_join(practice.2015, by="npi") %>%
  left_join(demo.2015, by="npi")


nodes.2015.Q4$year <- 2015
nodes.2015.Q4$quarter <- "Q4"

nodes.final <- rbind(nodes.2013.Q2,nodes.2013.Q3,nodes.2013.Q4, nodes.2014.Q1, nodes.2014.Q2, nodes.2014.Q3, nodes.2014.Q4,nodes.2015.Q1, nodes.2015.Q2, nodes.2015.Q3, nodes.2015.Q4)
# --------------------------------------------------------------

#Use hrr information

hrrhsa.2013 <- read_csv(paste0(data.path, "/ZipHsaHrr_2013.csv"))

PhyComp.2013_15 <- nodes.final %>%
  left_join(hrrhsa.2013, by="zip_1") 


#Understand NAs exist due to missing hrr numbers for zipcodes given
PhyComp.2013_15 <- PhyComp.2013_15[!is.na(PhyComp.2013_15$hrrnum_1),]   #9684281 obs. of 14 var


#keep q1 of 2013 and q4 of 2015
PhyComp.2013_15 <- PhyComp.2013_15[(PhyComp.2013_15$year == 2013 & PhyComp.2013_15$quarter == "Q4"| 
                                    PhyComp.2013_15$year == 2015 & PhyComp.2013_15$quarter == "Q1"),]


drop <- c("quarter", "hsa_1", "hsacity_1", "hsastate_1", "hrrcity_1", "hrrstate_1")
PhyComp.2013_15  = PhyComp.2013_15 [,!(names(PhyComp.2013_15) %in% drop)]        #2660731 obs. of 8 var

#do not include non-contiguous states
PhyComp.2013_15 <- PhyComp.2013_15[!(PhyComp.2013_15$state_1 == "HI" |
                                      PhyComp.2013_15$state_1 == "AK" |
                                      PhyComp.2013_15$state_1 == "GU"|
                                      PhyComp.2013_15$state_1 == "PR"|
                                      PhyComp.2013_15$state_1 == "VI"),]


temp <- PhyComp.2013_15
# --------------------------------------------------------------
