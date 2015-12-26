aggByYearPlot <- ggplot(data=aggByYear, aes(x=factor(year), y=Emissions))
aggByYearPlot + geom_bar(stat="identity", fill="steelblue")
aggByYearPlot + geom_text(aes(label=round(Emissions, digits = 2)),
                          vjust = 2, color="white", size=3)
aggByYearPlot + theme_minimal()
