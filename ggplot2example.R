library(plyr)
library(ggplot2)
# read in the data;  only the NEI data is required
# assumption - the data files are in the same directory as this file
NEI <- readRDS("./summarySCC_PM25.rds")
# subset the NEI data by city (Baltimore)
neiBalt <- NEI[NEI$fips == "24510",]
# create summarised data, summing by type and year
neiSumm <- ddply(neiBalt,.(type, year),summarise, sumOf=sum(Emissions))
# open a device for outputting the plot
png("./plot3.png", height=480,width=800)
fillCols <- c("blue1","skyblue2","lightblue","lightsteelblue")
# a set of bar plots, "faceted" by type
pm <- ggplot(data=neiSumm, aes(x=year, y=sumOf)) + 
        facet_grid(. ~ type) +
        geom_bar(stat="identity",fill=fillCols,color="black") +
        ylab("PM2.5 Emissions (tons)") + xlab('Year') +
        scale_x_continuous(breaks = seq(1999,2008,by=3)) +
        ggtitle("PM2.5 Emissions by Type in Baltimore")
print(pm)
# close the device
dev.off()