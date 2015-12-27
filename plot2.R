## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
## (fips == 24510) from 1999 to 2008? Use the base plotting system to make a
## plot answering this question.

## data is in same directory as R code
if (!exists("NEI")) {
    NEI <- readRDS("summarySCC_PM25.rds")
}
if (!exists("SCC")) {
    SCC <- readRDS("Source_Classification_Code.rds")
}

## subset NEI data using Baltimore's fip
baltNEI <- NEI[NEI$fips == "24510",]

## create total emissions by year    
aggByYearBalt <- aggregate(Emissions ~ year, baltNEI, sum)

## create barplot showing total emissions by year and save .png of plot
barplot(
        (aggByYearBalt$Emissions),
        names.arg = aggByYearBalt$year,
        main = "Baltimore's Total PM 2.5 Annual Emissions", font.main = 3,
        xlab = "Years",
        ylab = "Total PM 2.5 emissions (tons)",
        ylim = c(0, 4000),
        col = "steelblue"
)
dev.copy(png, "plot2.png", width = 640, height = 480)
dev.off()
