## dplyr used to aggregate data by year
library(dplyr)

## Read data - assumes source data unzipped and present in current directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Aggregate total emissions by year, then plot.
baltimore <- filter(NEI,fips=="06037")
by_year <- group_by(baltimore, year)
em <- summarise(by_year, total_em=sum(Emissions))
png(filename="./plot2.png", width=480, height=480)
with(em, plot(total_em ~ year,type="o", ylab="Total Emissions (Tons)",
              xlab="Year",main="Baltimore Total Emission By Year"))
dev.off()
