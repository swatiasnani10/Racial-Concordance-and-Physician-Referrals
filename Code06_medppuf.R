#read provider utilization files (by provider)
#these files have information on patient characteristics 
paste0(data.path, "/Medicare_Physician_Other_Practitioners_by_Provider_2015_12_31.csv")
med.pro.13 <- read.csv(paste0(data.path, "/Medicare_Physician_Other_Practitioners_by_Provider_2013_12_31.csv"))

pro.13 <- med.pro.13 %>%
  select("Rndrng_NPI", "Rndrng_Prvdr_Type" , "Tot_Benes" ,"Tot_Srvcs" , "Tot_Sbmtd_Chrg", "Tot_Mdcr_Alowd_Amt", "Tot_Mdcr_Pymt_Amt","Med_Mdcr_Stdzd_Amt",
         "Bene_Avg_Age", "Bene_Age_LT_65_Cnt", "Bene_Age_65_74_Cnt", "Bene_Age_75_84_Cnt" , "Bene_Age_GT_84_Cnt", "Bene_Race_Black_Cnt" , "Bene_Race_Wht_Cnt",  "Bene_CC_AF_Pct", "Bene_CC_Alzhmr_Pct", "Bene_CC_Asthma_Pct",   
         "Bene_CC_Cncr_Pct" , "Bene_CC_CHF_Pct",  "Bene_CC_CKD_Pct" , "Bene_CC_COPD_Pct" ,"Bene_CC_Dprssn_Pct", "Bene_CC_Dbts_Pct",  "Bene_CC_Hyplpdma_Pct" ,         "Bene_CC_Hyprtnsn_Pct" ,         "Bene_CC_IHD_Pct" ,             
         "Bene_CC_Opo_Pct", "Bene_CC_RAOA_Pct", "Bene_CC_Sz_Pct","Bene_CC_Strok_Pct" ,"Bene_Avg_Risk_Scre")

pro.13$year <- 2013


pro.13 <- pro.13 %>%
  rename(npi = Rndrng_NPI)
# --------------------------------------------------------------

med.pro.14 <- read.csv(paste0(data.path, "/Medicare_Physician_Other_Practitioners_by_Provider_2014_12_31.csv"))

pro.14 <- med.pro.14 %>%
  select("Rndrng_NPI", "Rndrng_Prvdr_Type" , "Tot_Benes" ,"Tot_Srvcs" ,"Tot_Sbmtd_Chrg", "Tot_Mdcr_Alowd_Amt", "Tot_Mdcr_Pymt_Amt","Med_Mdcr_Stdzd_Amt",
         "Bene_Avg_Age", "Bene_Age_LT_65_Cnt", "Bene_Age_65_74_Cnt","Bene_Age_75_84_Cnt" , "Bene_Age_GT_84_Cnt", "Bene_Race_Black_Cnt" , "Bene_Race_Wht_Cnt",  "Bene_CC_AF_Pct", "Bene_CC_Alzhmr_Pct", "Bene_CC_Asthma_Pct",   
         "Bene_CC_Cncr_Pct" , "Bene_CC_CHF_Pct",  "Bene_CC_CKD_Pct" , "Bene_CC_COPD_Pct" ,"Bene_CC_Dprssn_Pct", "Bene_CC_Dbts_Pct",  "Bene_CC_Hyplpdma_Pct" ,         "Bene_CC_Hyprtnsn_Pct" ,         "Bene_CC_IHD_Pct" ,             
         "Bene_CC_Opo_Pct", "Bene_CC_RAOA_Pct", "Bene_CC_Sz_Pct","Bene_CC_Strok_Pct" ,"Bene_Avg_Risk_Scre")

pro.14$year <- 2014

pro.14 <- pro.14 %>%
  rename(npi = Rndrng_NPI)
# --------------------------------------------------------------

med.pro.15 <- read.csv(paste0(data.path, "/Medicare_Physician_Other_Practitioners_by_Provider_2015_12_31.csv"))

pro.15 <- med.pro.15 %>%
  select("Rndrng_NPI", "Rndrng_Prvdr_Type" , "Tot_Benes" ,"Tot_Srvcs" , "Tot_Sbmtd_Chrg", "Tot_Mdcr_Alowd_Amt", "Tot_Mdcr_Pymt_Amt","Med_Mdcr_Stdzd_Amt",
         "Bene_Avg_Age", "Bene_Age_LT_65_Cnt", "Bene_Age_65_74_Cnt","Bene_Age_75_84_Cnt" , "Bene_Age_GT_84_Cnt", "Bene_Race_Black_Cnt" , "Bene_Race_Wht_Cnt",  "Bene_CC_AF_Pct", "Bene_CC_Alzhmr_Pct", "Bene_CC_Asthma_Pct",   
         "Bene_CC_Cncr_Pct" , "Bene_CC_CHF_Pct",  "Bene_CC_CKD_Pct" , "Bene_CC_COPD_Pct" ,"Bene_CC_Dprssn_Pct", "Bene_CC_Dbts_Pct",  "Bene_CC_Hyplpdma_Pct" ,         "Bene_CC_Hyprtnsn_Pct" ,         "Bene_CC_IHD_Pct" ,             
         "Bene_CC_Opo_Pct", "Bene_CC_RAOA_Pct", "Bene_CC_Sz_Pct","Bene_CC_Strok_Pct" ,"Bene_Avg_Risk_Scre")

pro.15$year <- 2015

pro.15 <- pro.15 %>%
  rename(npi = Rndrng_NPI)

med.ppuf <- rbind(pro.13,pro.14, pro.15)

#note: all ids do not have data for all three years.

save(med.ppuf, file = "/FinalData/med.ppuf.RData")
# --------------------------------------------------------------
#merge ph.com.cens created in code05 file with med.ppuf

ph.info <- merge(ph.com.cens, med.ppuf, 
                 by=c("npi", "year"),
                 all.x = TRUE)



#use total benes as patient footfall variable for specialist quality!
#use patient characteristics from these files!
# --------------------------------------------------------------



