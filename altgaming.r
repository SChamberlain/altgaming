# gaming/signal detection
# install_github('rplos', 'ropensci', 'almv3')
# install.packages(c("ggplot2","plyr"))
library(rplos); library(ggplot2); library(plyr); library(doMC); library(multicore); library(reshape2)
setwd("/Users/ScottMac/Dropbox/alm12-sf-hackathon")
# dir()
dois <- read.csv("alm_report_2012-09-12.csv")[,1]

dff <- data.frame(.id = "NA", dates = "NA", totals = "NA", doi = "NA")
write.table(dff, "~/data/dfftable.txt", row.names=F)
getit <- function(x){
	out <- almplosallviews(x, info='detail')$history
	out$doi <- rep(x, nrow(out))
	if(!is.null(out)){write.table(out, "dfftable.txt", append=T, col.names=F, row.names=F)} else {NULL}
}
safe_getit <- plyr::failwith(NULL,getit)
# registerDoMC(cores=4)
setwd("~/data")
out <- llply(dois[1:5000], safe_getit, .parallel=T)

# dois2 <- dois[150:200]
# outlist <- list()
# for(i in 1:length(dois2)) {
# # 	registerDoMC(cores=4)
# # 	out <- lapply(dois[vec[i]:vec[i]+10], getit)
# 	out <- getit(dois[vec[i]])
# 	outlist[[i]] <- out
# }
# outdf <- ldply(outlist, function(x) x[[1]])
# write.csv(outdf, "outdf.csv", row.names=F)

# # using alm old version
# dev_mode(F)
# install_github('rplos', 'ropensci')
# library(rplos)
# 
# # y <- dois[[1]]
# getmets <- function(y){
# 	df <- almplosallviews(y, 'counter', 1, 0, 'xml')
# 	
# 	convertdf <- function(x){
# # 		xx <- data.frame(x)
# 		if(nrow(xx)==1){xxx <- xx[1,]} else {xxx <- xx[,1]}
# # 		as.numeric(as.character(xxx))
# 		xxx
# 	}
# 	temp <- lapply(df$article$source[[1]]$events, convertdf)
# 	dfout <- ldply(temp, function(x) as.data.frame(x))
# 	dfout
# }
# 
# mydf <- lapply(as.character(dois[1:2]), getmets)