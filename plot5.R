## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

## data is in same directory as R code
if (!exists("NEI")) {
    NEI <- readRDS("summarySCC_PM25.rds")
}
if (!exists("SCC")) {
    SCC <- readRDS("Source_Classification_Code.rds")
}

## in the SCC.Level.Two column, vehicle appears to catch nearly all motor vehicle sources
## therefore, find all "vehicle" related codes in SCC.Level.Two
vehicleRelated <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicleSCC <- SCC[vehicleRelated,]$SCC
## subset vehicle related NEI data
vehicleNEIxSCC <- NEI[NEI$SCC %in% vehicleSCC,]

# Subset the vehicle related NEI data specific to Baltimore's fip
baltVehicleNEI <- vehicleNEIxSCC[vehicleNEIxSCC$fips=="24510",]

## plot vehicle related emissions for Baltimore and save .png file
library(ggplot2)
baltVehiclePlot <- ggplot(baltVehicleNEI, aes(factor(year), Emissions)) +
    geom_bar(stat = "identity", fill = "steelblue") +
    labs(x = "Years") +
    labs(y = expression("Total PM" [2.5]* " Emissions (tons)")) +
    labs(title = expression("Baltimore's Annual Total PM" [2.5]* " Motor Vehicle Emissions")) +
    theme_gray()
print(baltVehiclePlot)

dev.copy(png, "plot5.png", width = 640, height = 480)
dev.off()
