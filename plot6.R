## Load required libraries

library(dplyr)
library(ggplot2)
library(data.table)

## Read data - assumes source data unzipped and present in current directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


auto <- filter(SCC, grepl('Onroad',Data.Category))
baltAndLA <- filter(NEI,fips=="06037" | fips == "24510")
autoTable <- as.data.table(auto)
citiesTable <- as.data.table(baltAndLA)
autoEmissions <- inner_join(autoTable, citiesTable, by = "SCC")
by_year <- group_by(autoEmissions, year,fips)
em <- summarise(by_year, total_em=sum(Emissions))

png(filename="./plot6.png", width=480, height=480)
print(qplot(year, total_em, data=em,geom=c("point","line"), color=fips, 
      main="Baltimore (fips=24510) and LA County (fips=06037)\n Motor Vehicle Emissions",ylab="total emissions (tons)"))
dev.off()