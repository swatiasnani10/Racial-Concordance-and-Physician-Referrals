#---------------------------------------------------------

#Make two copies of ph.info data
#19 oct change: removed mover indicators from below codes, since they do not exist now
#not saving these changes to final data RdS

npi1.dta <- ph.info

#think what variables you need for npi1 (pcp characteristics needed in my regression)
npi1.dta <- npi1.dta %>%
  select(npi, year, zip_1, medical_school_1, graduation_1, hrrnum_1, county, tot.pop, wh.pop, bl.pop,
         wh.share, bl.share, Rndrng_Prvdr_Type, Tot_Benes, Tot_Srvcs, Bene_Avg_Age, Bene_Race_Black_Cnt, Bene_Race_Wht_Cnt,
         Bene_CC_AF_Pct, Bene_CC_Alzhmr_Pct,   Bene_CC_Asthma_Pct,   Bene_CC_Cncr_Pct,     Bene_CC_CHF_Pct,      Bene_CC_CKD_Pct,     
         Bene_CC_COPD_Pct, Bene_CC_Dprssn_Pct,   Bene_CC_Dbts_Pct,   Bene_CC_Hyplpdma_Pct, Bene_CC_Hyprtnsn_Pct, Bene_CC_IHD_Pct,     
         Bene_CC_Opo_Pct, Bene_CC_RAOA_Pct,  Bene_CC_Sz_Pct, Bene_CC_Strok_Pct,Bene_Avg_Risk_Scre,
         Tot_Sbmtd_Chrg, Tot_Mdcr_Alowd_Amt, Tot_Mdcr_Pymt_Amt,Med_Mdcr_Stdzd_Amt) %>%
  rename(npi1 = npi,
         #avg.phy.qty_1 = avg.phy.qty,
         county_1 = county,
         tot.pop_1 = tot.pop,
         wh.pop_1 = wh.pop, 
         bl.pop_1 = bl.pop,
         wh.share_1 = wh.share,
         bl.share_1 = bl.share, 
         prvdr.type_1 = Rndrng_Prvdr_Type, 
         tot.benes_1 = Tot_Benes, 
         tot.srvcs_1 = Tot_Srvcs,
         bene.avg.age_1 = Bene_Avg_Age,
         bene_Black_Cnt_1 = Bene_Race_Black_Cnt,
         bene_Wht_Cnt_1 = Bene_Race_Wht_Cnt,
         bene_AF_1 = Bene_CC_AF_Pct,
         bene_Alzhmr_1 = Bene_CC_Alzhmr_Pct,
         bene_Asthma_1 =   Bene_CC_Asthma_Pct,
         bene_cncr_1 =  Bene_CC_Cncr_Pct,
         bene_chf_1 = Bene_CC_CHF_Pct,
         bene_kidney_1 =  Bene_CC_CKD_Pct,   
         bene_copd_1= Bene_CC_COPD_Pct,
         bene_depr_1 = Bene_CC_Dprssn_Pct, 
         bene_diab_1= Bene_CC_Dbts_Pct,
         bene_hyplpdma_1 = Bene_CC_Hyplpdma_Pct,
         bene_hypertension_1 = Bene_CC_Hyprtnsn_Pct,
         bene_cc_ihd_1 = Bene_CC_IHD_Pct,     
         bene_cc_opo_1 = Bene_CC_Opo_Pct,
         bene_cc_rapa_1 = Bene_CC_RAOA_Pct,
         bene_scz_1 = Bene_CC_Sz_Pct, 
         bene_stroke_1 = Bene_CC_Strok_Pct,
         bene_risk_score_1 = Bene_Avg_Risk_Scre,
         Tot_Sbmtd_Chrg_1 = Tot_Sbmtd_Chrg, 
         Tot_Mdcr_Alowd_Amt_1 = Tot_Mdcr_Alowd_Amt, 
         Tot_Mdcr_Pymt_Amt_1 = Tot_Mdcr_Pymt_Amt,
         Med_Mdcr_Stdzd_Amt_1 = Med_Mdcr_Stdzd_Amt)

npi1.dta <- npi1.dta %>%
  #mutate(year = as.numeric(year)) %>%
  mutate(npi1 = as.character(npi1))

#---------------------------------------------------------

npi2.dta <- ph.info

#think what variables you need for npi1 (pcp characteristics needed in my regression)
npi2.dta <- npi2.dta %>%
  select(npi, year, zip_1, medical_school_1, graduation_1, hrrnum_1, county, tot.pop, wh.pop, bl.pop,
         wh.share, bl.share, Rndrng_Prvdr_Type, Tot_Benes, Tot_Srvcs, Bene_Avg_Age, Bene_Race_Black_Cnt, Bene_Race_Wht_Cnt,
         Bene_CC_AF_Pct, Bene_CC_Alzhmr_Pct,   Bene_CC_Asthma_Pct,   Bene_CC_Cncr_Pct,     Bene_CC_CHF_Pct,      Bene_CC_CKD_Pct,     
         Bene_CC_COPD_Pct, Bene_CC_Dprssn_Pct,   Bene_CC_Dbts_Pct,   Bene_CC_Hyplpdma_Pct, Bene_CC_Hyprtnsn_Pct, Bene_CC_IHD_Pct,     
         Bene_CC_Opo_Pct, Bene_CC_RAOA_Pct,  Bene_CC_Sz_Pct, Bene_CC_Strok_Pct,Bene_Avg_Risk_Scre,
         Tot_Sbmtd_Chrg, Tot_Mdcr_Alowd_Amt, Tot_Mdcr_Pymt_Amt,Med_Mdcr_Stdzd_Amt) %>%
  rename(npi2 = npi,
         zip_2 = zip_1,
         medical_school_2 = medical_school_1,
         graduation_2 = graduation_1,
         hrrnum_2 = hrrnum_1,
         county_2 = county,
         tot.pop_2 = tot.pop,
         wh.pop_2 = wh.pop, 
         bl.pop_2 = bl.pop,
         wh.share_2 = wh.share,
         bl.share_2 = bl.share, 
         prvdr.type_2 = Rndrng_Prvdr_Type, 
         tot.benes_2 = Tot_Benes, 
         tot.srvcs_2 = Tot_Srvcs,
         bene.avg.age_2 = Bene_Avg_Age,
         bene_Black_Cnt_2 = Bene_Race_Black_Cnt,
         bene_Wht_Cnt_2 = Bene_Race_Wht_Cnt,
         bene_AF_2 = Bene_CC_AF_Pct,
         bene_Alzhmr_2 = Bene_CC_Alzhmr_Pct,
         bene_Asthma_2 =   Bene_CC_Asthma_Pct,
         bene_cncr_2 =  Bene_CC_Cncr_Pct,
         bene_chf_2 = Bene_CC_CHF_Pct,
         bene_kidney_2 =  Bene_CC_CKD_Pct,   
         bene_copd_2= Bene_CC_COPD_Pct,
         bene_depr_2 = Bene_CC_Dprssn_Pct, 
         bene_diab_2= Bene_CC_Dbts_Pct,
         bene_hyplpdma_2 = Bene_CC_Hyplpdma_Pct,
         bene_hypertension_2 = Bene_CC_Hyprtnsn_Pct,
         bene_cc_ihd_2 = Bene_CC_IHD_Pct,     
         bene_cc_opo_2 = Bene_CC_Opo_Pct,
         bene_cc_rapa_2 = Bene_CC_RAOA_Pct,
         bene_scz_2 = Bene_CC_Sz_Pct, 
         bene_stroke_2 = Bene_CC_Strok_Pct,
         bene_risk_score_2 = Bene_Avg_Risk_Scre,
         Tot_Sbmtd_Chrg_2 = Tot_Sbmtd_Chrg, 
         Tot_Mdcr_Alowd_Amt_2 = Tot_Mdcr_Alowd_Amt, 
         Tot_Mdcr_Pymt_Amt_2 = Tot_Mdcr_Pymt_Amt,
         Med_Mdcr_Stdzd_Amt_2 = Med_Mdcr_Stdzd_Amt)

npi2.dta <- npi2.dta %>%
  #mutate(year = as.numeric(year)) %>%
  mutate(npi2 = as.character(npi2))



#just keeping two years in pspd data for now
PSPD.merge.1 <- merge(PSPD.13.15, 
                      npi1.dta, 
                      by = c("npi1", "year"),
                      all.x = TRUE)


PSPD.merge.2 <- merge(PSPD.merge.1, 
                      npi2.dta, 
                      by = c("npi2", "year"),
                      all.x = TRUE)


save(PSPD.merge.2, file = "/FinalData/PSPD.merge.2.RData")

#---------------------------------------------------------




