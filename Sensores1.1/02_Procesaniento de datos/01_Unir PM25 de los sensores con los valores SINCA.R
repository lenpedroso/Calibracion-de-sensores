

# Cargar librerias --------------------------------------------------------

library(dplyr)
# # Unir las concentraciones del SINCA al df Condes_Plantawer ---------------------

Condes_Plantawer$PM25_SINCA<-Las_Condes_Sinca$PM25 # Agregar la columna PM25 (SINCA) 
                                                   #a el df que tinen los datos sensores plantawer 

# # Crear un nuevo df con las concentraciones de PM25 de Plantawer --------

Condes_Plantawer_SINCA <- Condes_Plantawer %>%
  select(date, PM25_P1:PM25_P5, PM25_SINCA)


# Bajar formato csv -------------------------------------------------------

dir.create("data", showWarnings = FALSE)
write.csv(Condes_Plantawer_SINCA, "data/Condes_Plantawer_SINCA.csv", row.names = FALSE)

