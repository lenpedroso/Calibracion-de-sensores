# Es necesario installar el paquete openair que muestra como se distribuye los contaminates
# segun los sensores de bajo costo y su comparacion con las estaciones de monitoreo
#install.packages("openair")

# ### Cargar librerias ----------------------------------------------------
library(openair)

# ##Grafico de time variation para verificar tendencias diaras de  --------

timeVariation(mydata = Condes_Plantower_SINCA, 
              pollutant = c("PM25_P1", "PM25_P2", "PM25_P3", "PM25_P4", "PM25_P5", "PM25_SINCA"), 
              main = "Time variation Plantawer vs Sinca en Las Condes",
              ylab = expression(PM[2.5]~" (" * mu * "g/" * m^3 * ")") 
)
# ##Grafico de time variation para verificar tendencias diaras y horarias  --------
timeVariation_hour <- timeVariation(
  mydata = Condes_Plantower_SINCA,
  pollutant = c("PM25_P1", "PM25_P2", "PM25_P3", "PM25_P4", "PM25_P5", "PM25_SINCA"),
  type = "hour",
  main = "Variación horaria PM2.5: Plantower vs SINCA",
  ylab = expression(PM[2.5]~" (" * mu * "g/" * m^3 * ")")
)