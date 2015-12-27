## Of the four types of sources indicated by the type 
## (point, nonpoint, onroad, nonroad) variable,
## which of these four sources have seen decreases in emissions from 1999–2008
## for Baltimore City? Which have seen increases in emissions from 1999–2008?
## Use the ggplot2 plotting system to make a plot answer this question.

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

## create faceted plot by emissions type and save .png of plot
library(ggplot2)
baltPlot <- ggplot(baltNEI, aes(factor(year), Emissions, fill = type)) +
            geom_bar(stat = "identity") + 
            theme_grey(base_size = 14) + 
            facet_grid(.~type, scales = "free", space = "free") + 
            labs(x = "Years", y = expression("Total PM" [2.5]* " Emissions (tons)"))  + 
            labs(title = expression("PM" [2.5]* " Emissions for Baltimore by Source Type"))

print(baltPlot)

dev.copy(png, "plot3.png", width = 640, height = 480)
dev.off()
