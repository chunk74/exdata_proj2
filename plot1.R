## Have total emissions from PM2.5 decreased in the United States from 1999 to
## 2008? Using the base plotting system, make a plot showing the total PM2.5 
## emission from all sources for each of the years 1999, 2002, 2005, and 2008.

## data is in same directory as R code
if (!exists("NEI")) {
    NEI <- readRDS("summarySCC_PM25.rds")
}
if (!exists("SCC")) {
    SCC <- readRDS("Source_Classification_Code.rds")
}

## create total emissions by year    
aggByYear <- aggregate(Emissions ~ year, NEI, sum)

## create barplot showing total emissions by year and save .png of plot
barplot(
        (aggByYear$Emissions)/10^6,
        names.arg = aggByYear$year,
        main = "Total PM 2.5  Annual Emissions", font.main = 3,
        xlab = "Years",
        ylab = "Total PM 2.5 emissions (millions of tons)",
        col = "steelblue"
)
dev.copy(png, "plot1.png", width = 640, height = 480)
dev.off()
