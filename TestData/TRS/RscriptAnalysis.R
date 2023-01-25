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

#table NUTS1 x COC.L
#original data
dat[,table(NUTS1,COC.L)]
#swapped data
dat_swapped[,table(NUTS1,COC.L)]

#some information loss measures
#table NUTS2 x SEX x AGE.M x COC.H
tab_vars <- c("NUTS2","SEX","AGE.M","COC.H")
tab1 <- dat[,.(N1=.N),by=tab_vars]
tab2 <- dat_swapped[,.(N2=.N),by=tab_vars]

tab <- merge(tab1,tab2,all=TRUE)
tab[is.na(N1),N1:=0]
tab[is.na(N2),N2:=0]

#mean absolute deviation
ad <- tab[,mean(abs(N1-N2)),by=.(NUTS2)]
ad
#average over regions
ad[,mean(V1)]

#use subtable for NUTS2, SEX and AGE.M due to small cell count
#totL relative absolute deviation
rad <- tab[,.(N1=sum(N1),N2=sum(N2)),by=.(NUTS2,SEX,AGE.M)]
rad <- rad[,sum(abs(N1-N2)/N1),by=.(NUTS2)]
rad
#average over regions
rad[,mean(V1)]

#Distance of square roots (DR)
dr <- tab[,sqrt(1/2*sum((sqrt(N1)-sqrt(N2))^2)), by=.(NUTS2)]
dr
#Hellinger distance 
dr[,mean(V1)]

#Simple risk estimation: proportion of unperturbed cells with count < 3 in NUTS2 ? SEX ? AGE.M ? COC.H
tab[,sum(N1<3&N2==N1)/sum(N1<3)]


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
                        