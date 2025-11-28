# Script permite optener un scaterplot para realizar un modelo de regresión lineal
# Es necesario instalar el paquete openair para realizar el grafico


#1. Cargar librerias -----------------------------------------------------
library(openair)


# 2. Graficos de scaterplot    --------------------------------------------

png("C:/Semestre 2-2025/Visualizacion/Calibracion de sensores/Calibracion de sensores/02_Figuras/2.scatterplot.png",
    width = 16, 
    height = 10,
    units = "in",
    res = 900)

scatterPlot(
  mydata = Condes_Plantower_SINCA_long_2,
  x      = "value",
  y      = "value_SINCA",
  method = "hexbin",
  col    = "jet",
  linear = TRUE,
  ci     = TRUE,
  fit    = TRUE,
  type   = "sensor",
  main   = "Plantower vs SINCA por sensor",
  xlab   = "PM2.5 Sensor Plantower (µg/m³)",
  ylab   = "PM2.5 SINCA (µg/m³)",
  fontsize = 15
)

dev.off()

