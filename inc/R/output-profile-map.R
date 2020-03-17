#!/usr/bin/R
require(raster)
args <- commandArgs(TRUE)

r1 <- raster(sprintf("%s/%s.tif",args[1],args[2]))
h <- 350
w <- round(h* ncol(r1)/nrow(r1))

png(file=sprintf("%s/%s",args[3],args[4]),width=w,height=h)
par(mar=c(0,0,0,0))
image(r1,col=c("white","red","yellow","snow4","aliceblue"))
legend("bottomleft",sprintf("map ver. %s",args[2]),cex=.75,bty="n")
dev.off()

##plot(r1,col=c("white","red","yellow","snow4","aliceblue"),legend=F,axes=F)
