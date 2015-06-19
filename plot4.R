## dplyr used to aggregate data by year
library(dplyr)

## data.table used to make joining NEI and SCC on coal sources easy
library(data.table)

## Read data - assumes source data unzipped and present in current directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset SCC table for coal combustion
coal <- filter(SCC, grepl('Fuel Comb .* Coal',EI.Sector))

## Make data tables
coalTable <- as.data.table(coal)
neiTable <- as.data.table(NEI)

## Join the two tables to filter down to coal sources
coalEmissions <- inner_join(coalTable, neiTable, by = "SCC")

## Aggregate and plot data
by_year <- group_by(coalEmissions, year)
em <- summarise(by_year, total_em=sum(Emissions))

png(filename="./plot4.png", width=480, height=480)
with(em, plot(total_em ~ year,type="o", ylab="Total Emissions (Tons)",
              xlab="Year",main="United States - Coal Combustion Emissions"))
dev.off()
