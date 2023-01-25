###################################################
# ESTP Course on Statistical disclosure control (SDC) methods and tools for census 2021
#
# Day 1 Demonstration TRS with R
#
#

# if not already done install needed packages and 
# "recordSwapping" -> targeted record swapping
# install.packages(c("data.table","devtools","R.utils","sdcTable","sdcMicro","sdcHierarchies","remotes"))

.connect2internet(proxypassword = "54h/M.hSMuE",proxyuser = "x34l319")

install.packages(c("data.table","devtools","R.utils","sdcTable","sdcMicro","sdcHierarchies","remotes"),repos = "https://ftp.fau.de/cran/")


# load packages
library(data.table) # useful for dealing with large rectangular data sets
library(sdcMicro)


#####################
# additional infos 
# more detailed explanations/documentation:
vignette("recordSwapping") 

# documentation of core function for TRS
?recordSwap() 
#####################


#####################
## load data
dat <- fread("~/SDC Census/test_data_10k.csv.gz")

# investigate data a little bit
class(dat) # class data.table
print(dat)
View(dat)

head(dat[,.(AGE.M,L001000)],3)

# convert non-numeric values to numeric values (somewhat optional)
dat[,Y_coord:=as.integer(substr(L001000,5,8))]
dat[,X_coord:=as.integer(substr(L001000,10,13))]
dat[1,.(L001000,X_coord,Y_coord)]

dat[,AGE.M_old:=AGE.M]
age_levels <- levels(cut(1:101,breaks=c(seq(0,100,5),Inf),include.lowest = TRUE,right=FALSE))
dat[,AGE.M:=as.integer(factor(AGE.M,levels=age_levels))]
dat[,.N,by=.(AGE.M_old,AGE.M)][order(AGE.M)]


# truncate variables if needed
dat[,Size_original:=Size]
dat[,Size:=pmin(5,Size)]
dat[!duplicated(HID),.N,by=.(Size)][order(Size)]
#####################


#####################
## apply targeted record swapping

# geographic hierarchy 
# read from left to right
# NUTS1 > NUTS2 > ...
hierarchy <- c("NUTS1","NUTS2")

# hid column
hid <- "HID"

# risk variables
risk_variables <- c("COC.M","POB.M")
k_anonymity <- 3


swaprate <- 0.05
similar <- "Size"
seed <- 202301

dat_swapped <- recordSwap(data = dat,                       # data input
                          hid = hid,                        # hid column names
                          hierarchy = hierarchy,            # hierarchy column names
                          similar = similar,                # similarity profiles
                          risk_variables = risk_variables,  # variables used for risk calculation 
                          k_anonymity = k_anonymity,        # k anonymity to determine "high risk" households
                          swaprate = swaprate,              # (minimum) swaprate in general
                          return_swapped_id = TRUE,         # if TRUE original HID and swapped HID are returned
                          seed = seed)                      # set random seed

dat_swapped

# filter on swapped households
dat_swapped[HID!=HID_swapped]

# number of swapped households
dat_swapped[HID!=HID_swapped,uniqueN(HID)]

###### 
# build tables from swapped and original data
# make table by NUTS1 and COC.L
dat[,table(NUTS1,COC.L)]
dat_swapped[,table(NUTS1,COC.L)]


# build combined table and look at differences
tab_vars <- c("NUTS2","SEX","AGE.M","COC.H")
tab1 <- dat[,.(N1=.N),by=c(tab_vars)]
tab2 <- dat_swapped[,.(N2=.N),by=c(tab_vars)]

tab <- merge(tab1,tab2, all=TRUE)
tab[is.na(N1),N1:=0]
tab[is.na(N2),N2:=0]

# mean absolute deviation
ad <- tab[,mean(abs(N1-N2)),by=.(NUTS2)]
ad
mean(ad$V1)


# apply convenience function ~ not quite the same but similar to above
?infoLoss
il <- infoLoss(data=dat, data_swapped = dat_swapped,
               table_vars=c("NUTS2","SEX","AGE.M","COC.H"))
il$overview # overview

il$measures # summary statistics of measures

# cumulative distributions
il$cumdistrabsD
il$cumdistrrelabsD
il$cumdistrabssqrtD

il$false_zero
il$false_nonzero

il$cellvalues[abs(count_o-count_s)>50] # cell values of specified table
# quite high differences for outer margins
# need to controll swapping more by using similarity variables
#####################


#####################
# define similarity variables
similar2 <- c("Size","HST")
# HST <- household type ~ private vs institutional

dat_swapped2 <- recordSwap(data = dat, hid = hid,
                           hierarchy = hierarchy,
                           similar = similar2, # <- new similarity profiles
                           risk_variables = risk_variables,
                           k_anonymity = k_anonymity,
                           swaprate = swaprate,
                           return_swapped_id = TRUE,
                           seed = seed)

# get table for HID and HST
dat_tph <- unique(dat[,.(HID_swapped=HID,HST_swapped=HST)])
select_vars <- c("NUTS1", "NUTS2", "HID", "HID_swapped",
                 "Size", "HST", "HST_swapped","Size_original")
# without similarity variables HST
# apply HST on data set 
dat_swapped[dat_tph,HST_swapped:=HST_swapped,on=.(HID_swapped)]
head(dat_swapped[!duplicated(HID)][HST!=HST_swapped,..select_vars],4)

# with similarity variable HST
dat_swapped2[dat_tph,HST_swapped:=HST_swapped,on=.(HID_swapped)]
# HST identical for every swap
dat_swapped2[,all(HST==HST_swapped)]
dat_swapped2[HID!=HID_swapped & HST ==21][!duplicated(HID),..select_vars]

#####################
# geographic regions still dont make sense (and possibly other variables)

hids_swapped <- dat_swapped2[HID!=HID_swapped] # filter on swapped households

head(hids_swapped[!duplicated(HID),.(NUTS1,NUTS2,NUTS3,LAU2)],4) # show first 4 entries of swapped households

# use carry along variables
carry_along <- c("NUTS3","LAU2","X_coord","Y_coord")

dat_swapped3 <- recordSwap(data = dat, hid = hid,
                           hierarchy = hierarchy,
                           similar = similar2,
                           risk_variables = risk_variables,
                           k_anonymity = k_anonymity,
                           swaprate = swaprate,
                           carry_along = carry_along, # carry along variables
                           return_swapped_id = TRUE,
                           seed = seed)

hids_swapped3 <- dat_swapped3[HID!=HID_swapped]
head(hids_swapped3[!duplicated(HID),.(NUTS1,NUTS2,NUTS3,LAU2)])

