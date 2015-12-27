## Across the United States, how have emissions from coal combustion-related sources
## changed from 1999–2008?

## data is in same directory as R code
if (!exists("NEI")) {
    NEI <- readRDS("summarySCC_PM25.rds")
}
if (!exists("SCC")) {
    SCC <- readRDS("Source_Classification_Code.rds")
}

## in the EI.sector column, coal is listed only as combustible
## therefore, find all coal related codes via EI.sector
coalRelated <- grepl("coal", SCC$EI.Sector, ignore.case=TRUE)
coalCombSCC <- SCC[coalRelated,]$SCC
## subset coal combustion-related NEI data
coalCombNEIxSCC <- NEI[NEI$SCC %in% coalCombSCC,]

## plot coal combustion-related emissions and save .png file
library(ggplot2)
coalCombPlot <- ggplot(coalCombNEIxSCC, aes(factor(year), Emissions/10^5)) +
    geom_bar(stat = "identity", fill = "steelblue") +
    labs(x = "Years") +
    labs(y = expression("Total PM" [2.5]* " Emissions (millions of tons)")) +
    labs(title = expression("Total PM" [2.5]* " Coal Combustion Emissions by Year")) +
    theme_gray()
print(coalCombPlot)

dev.copy(png, "plot4.png", width = 640, height = 480)
dev.off()
