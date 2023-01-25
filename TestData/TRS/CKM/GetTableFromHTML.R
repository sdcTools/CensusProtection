library(rvest)
setwd("E:\\W7\\Users\\Peter-Paul\\MyDocuments\\Thuiswerk\\Cursus\\ESTP\\2021\\CensusSDC\\CKM")

html <- read_html("out\\test_data_10k_tau_out.html")
html_table(html_nodes(html,"table")[[7]], header=TRUE, dec=",")
