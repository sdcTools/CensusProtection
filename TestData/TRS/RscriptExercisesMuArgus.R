library(data.table)

#set working directory
setwd("C:\\Users\\pwof\\Documents\\Courses\\Eurostat\\2023\\CensusSDC\\Exercises\\TRS")

#original data
dat <- fread("test_data_10k_mu.csv")
#swapped data
dat_swapped <- fread("out\\test_data_10k_muSafe.saf")
names(dat_swapped) <- names(dat)

#Number of swapped households when NUTS2 is lowest level
dat_compare_hh <- merge(unique(dat[,.(HID,NUTS2)]),unique(dat_swapped[,.(HID,NUTS2_swapped = NUTS2)]),by="HID")
nrow(dat_compare_hh[NUTS2!=NUTS2_swapped])

#table NUTS2 x SEX
#original data
dat[,table(NUTS2,SEX)]
#swapped data
dat_swapped[,table(NUTS2,SEX)]


#some information loss measures
#table NUTS2 x SEX
tab_vars <- c("NUTS2","SEX")
tab1 <- dat[,.(N1=.N),by=tab_vars]
tab2 <- dat_swapped[,.(N2=.N),by=tab_vars]

tab <- merge(tab1,tab2,all=TRUE)
tab[is.na(N1),N1:=0]
tab[is.na(N2),N2:=0]

#mean absolute deviation
ad <- tab[,mean(abs(N1-N2)),by=.(NUTS2)]
ad

rad <- tab[,.(N1=sum(N1),N2=sum(N2)),by=.(NUTS2,SEX)]
rad <- rad[,sum(abs(N1-N2)/N1),by=.(NUTS2)]
rad

#Distance of square roots (DR)
hd <- tab[,sqrt(1/2*sum((sqrt(N1)-sqrt(N2))^2)), by=.(NUTS2)]
hd
#Hellinger distance 
hd[,mean(V1)]


#mixed up variables?
dat_compare <- dat_swapped[(dat_swapped$HID %in% 
                              dat_compare_hh[NUTS2!=NUTS2_swapped]$HID),]
head(dat_compare[!duplicated(HID),.(NUTS1,NUTS2,NUTS3,LAU2),],6)

#Read new output
dat_swapped <- fread("out\\test_data_10k_muSafeCarry.saf")
names(dat_swapped) <- names(dat)
dat_compare_hh <- merge(unique(dat[,.(HID,NUTS2)]),
                        unique(dat_swapped[,.(HID,NUTS2_swapped=NUTS2)]),
                        by="HID")

dat_compare <- dat_swapped[(dat_swapped$HID %in% 
                              dat_compare_hh[NUTS2!=NUTS2_swapped]$HID),]
                        
head(dat_compare[!duplicated(HID),.(NUTS1,NUTS2,NUTS3,LAU2),],6)
                        