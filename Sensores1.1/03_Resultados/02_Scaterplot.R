
# ## Cargar librerias -----------------------------------------------------
library(openair)

# Graficos de scaterplot
scatterPlot(
  mydata = Condes_Plantawer_SINCA_long_2,
  x      = "value_SINCA",
  y      = "value",
  method = "hexbin",
  linear = TRUE,
  ci     = TRUE,
  fit    = TRUE,
  type   = "sensor",
  main   = "Plantower vs SINCA por sensor",
  xlab   = "PM2.5 SINCA (µg/m³)",
  ylab   = "PM2.5 Sensor Plantower (µg/m³)"
)