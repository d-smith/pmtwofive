## dplyr used to aggregate data by year
library(dplyr)

## ggplot2 used for ploy
library(ggplot2)

## Read data - assumes source data unzipped and present in current directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Aggregate total emissions by year, then plot.
baltimore <- filter(NEI,fips=="24510")
by_year <- group_by(baltimore, year,type)
em <- summarise(by_year, total_em=sum(Emissions))

png(filename="./plot3.png", width=480, height=480)
print(qplot(year, total_em,data=em,color=type,geom=c("point","line"), main="Baltimore Emissions per Year",ylab="total emissions (tons)"))
dev.off()