## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
## vehicle sources in Los Angeles County, California (fips == 06037). Which city has seen 
## greater changes over time in motor vehicle emissions?

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
baltVehicleNEI$location <- "Baltimore City"

# Subset the vehicle related NEI data specific to Los Angeles's fip
losangVehicleNEI <- vehicleNEIxSCC[vehicleNEIxSCC$fips=="06037",]
losangVehicleNEI$location <- "Los Angeles County"

# merge LA and Balitmore data to single data frame
labaltVehicleNEI <- rbind(baltVehicleNEI, losangVehicleNEI)

## plot vehicle related emissions for Baltimore and LA and save .png file
library(ggplot2)
labaltVehiclePlot <- ggplot(labaltVehicleNEI, aes(factor(year), Emissions)) +
    geom_bar(stat = "identity", fill = "steelblue") +
    facet_grid(scales="free", space="free", .~location) +
    labs(x = "Years") +
    labs(y = expression("Total PM" [2.5]* " Emissions (tons)")) +
    labs(title = expression("Baltimore's Los Angeles' Annual Total PM" [2.5]* " Motor Vehicle Emissions")) +
    theme_gray()
print(labaltVehiclePlot)

dev.copy(png, "plot6.png", width = 640, height = 480)
dev.off()
