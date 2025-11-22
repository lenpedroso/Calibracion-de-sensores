#install.packages("ggpmisc") Para agregar a los graficos notaciones estadisticas
# ## Cargar librerias -----------------------------------------------------
library(openair)
# Graficos de scaterplot
  
png("C:/Semestre 2-2025/Visualizacion/Calibracion de sensores/Calibracion de sensores/Sensores1.1/04_Figuras/scatterplot.png",
    width = 16, 
    height = 10,
    units = "in",
    res = 900)

scatterPlot(
  mydata = Condes_Plantower_SINCA_long_2,
  x      = "value_SINCA",
  y      = "value",
  method = "hexbin",
  col    = "jet",
  linear = TRUE,
  ci     = TRUE,
  fit    = TRUE,
  type   = "sensor",
  main   = "Plantower vs SINCA por sensor",
  xlab   = "PM2.5 SINCA (µg/m³)",
  ylab   = "PM2.5 Sensor Plantower (µg/m³)",
  fontsize = 14
)

dev.off()

