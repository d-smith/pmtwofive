## Load required libraries

library(dplyr)
library(ggplot2)
library(data.table)

## Read data - assumes source data unzipped and present in current directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Using Onroad in the Data.Category var as the definition of auto emissions
auto <- filter(SCC, grepl('Onroad',Data.Category))

## Filter the NEI table to Baltimore observations before joining tables
baltimore <- filter(NEI,fips=="24510")

autoTable <- as.data.table(auto)
baltimoreTable <- as.data.table(baltimore)

## Join the two tables to pick up just the auto emission observations
autoEmissions <- inner_join(autoTable, baltimoreTable, by = "SCC")

## Sum the emissions per year
by_year <- group_by(autoEmissions, year)
em <- summarise(by_year, total_em=sum(Emissions))

## Plot the result
png(filename="./plot5.png", width=480, height=480)
print(qplot(year, total_em, data=em,geom=c("point","line"),
            ylab="total emissions (tons)",
            main="Baltimore Motor Vehicle Emissions"))
dev.off()