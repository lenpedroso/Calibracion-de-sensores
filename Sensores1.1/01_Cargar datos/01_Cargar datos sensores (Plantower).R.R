

# Seleccionar ambiente de trabajo -----------------------------------------

setwd("C:\\Semestre 2-2025\\Visualizacion\\Calibracion de sensores\\Calibracion de sensores\\Sensores1.1")


# # Cargar archivos modificar para que lo ejecute desde hgit hub ----------

Condes_Plantawer<- read.csv2("datos/CON_Plantawer.csv", header = TRUE)
# # Modificacion del formato de la fecha de los datos de los senso --------

Condes_Plantawer$Fecha<-Condes_Plantawer$Fecha+ 20000000
Condes_Plantawer$Hora<-Condes_Plantawer$Hora/100
Condes_Plantawer$Hora<-paste(Condes_Plantawer$Hora,"00",sep=":",collapse = NULL)
Condes_Plantawer$date<-paste(Condes_Plantawer$Fecha, Condes_Plantawer$Hora,sep = " ", collapse = NULL)
Condes_Plantawer$date <- as.POSIXct(Condes_Plantawer$date, format = "%Y%m%d %H:%M", tz = "Etc/GMT+4")