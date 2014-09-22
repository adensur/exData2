library(plyr)
# read in the data; the SCC data is not even required for this plot
# assumption - the data files are in the same directory as this file
NEI <- readRDS("./summarySCC_PM25.rds")
# open a device for outputting the plot
png("./plot1.png", height=480,width=480)
# get the summarised emissions data for all of the US, by year
neiAll <- ddply(NEI,.(year),summarise,sumOf=sum(Emissions))
# make a (simple) plot
plot(neiAll$year, neiAll$sumOf/1000, xlab="Year",
     ylab="PM2.5 Emissions (kilotons)",
     main="PM2.5 Emissions for USA, 1999-2008",
     xaxt="n",type="b",lwd=2,
     col="red", cex.main=0.9,xlim=c(1999,2009))
# make the X axis by "year"
axis(1,at=neiAll$year)
# write the summarised Emission values on the plot
text(neiAll$year,neiAll$sumOf/1000,as.integer(neiAll$sumOf/1000),
     pos=4,col="blue",cex=0.8)
# close the device
dev.off()


#Usefull stuff here:
#xaxt="n" - plot without x axis, which will be added later
#xlim=c() - set correct plotting limits. much better then my way, by plotting (type="n")
#axis() - add the x axis
