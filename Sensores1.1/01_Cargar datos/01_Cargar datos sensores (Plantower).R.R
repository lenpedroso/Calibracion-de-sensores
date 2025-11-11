
# Es necesario instalar paquete para leer csv (install.packages("readr"). Chat gpt 
# fue empleado para ordenar codigos y corregir errores

# Cargar libreria ---------------------------------------------------------
library(readr)

# Seleccionar datos desde git hub -----------------------------------------

url <- "https://raw.githubusercontent.com/lenpedroso/Calibracion-de-sensores/master/Sensores1.1/00_Datos/CON_Plantower.csv"
Condes_Plantower<- read_csv(url)

# Especificar delimitador -------------------------------------------------

Condes_Plantower <- read_delim(url, delim = ";", locale = locale(decimal_mark = ","))

# # Modificacion del formato de la fecha de los datos de los senso --------

Condes_Plantower$Fecha<-Condes_Plantower$Fecha+ 20000000
Condes_Plantower$Hora<-Condes_Plantower$Hora/100
Condes_Plantower$Hora<-paste(Condes_Plantower$Hora,"00",sep=":",collapse = NULL)
Condes_Plantower$date<-paste(Condes_Plantower$Fecha, Condes_Plantower$Hora,sep = " ", collapse = NULL)
Condes_Plantower$date <- as.POSIXct(Condes_Plantower$date, format = "%Y%m%d %H:%M", tz = "Etc/GMT+4")