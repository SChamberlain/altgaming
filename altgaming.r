# gaming/signal detection
library(rplos); library(ggplot2); library(plyr)
setwd("/Users/ScottMac/Dropbox/alm12-sf-hackathon")
dir()
dois <- read.csv("alm_report_2012-09-12.csv")[,1]

out <- lapply(dois[1:3000], function(x) almplosallviews(x, info='detail')$history)
length(out[[2]])