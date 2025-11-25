# Se unieron los datos de las concentraciones del SINCA con los datos de los sensores
# de bajo costo instalados en Santiago de Chile, especificamente en la comuna Las Condes
# Se tomo de base el repositorio de la profesora Sara Acevedo para modificar datos
# temporales (https://github.com/Saryace/datascience-sinca/blob/main/codigo/02_procesamiento-horas.R)
# y para usar la funcion joing
# Para transformar fechas se uso la siguiente página web (https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/as.POSIX*)
# y (https://certidevs.com/tutorial-r-lubridate-fechas-y-tiempo-hora)
# Para convertir datos a numerico se uso el siguiente link (https://r-coder.com/funcion-as-numeric-r/)
#Se empleo chat gpt para ordenar, modificar, transformar,  optimizar codigos y unir codigos
# Nota: Para usar la libreria open air es necesario tener una columana que se llame date

# 1. Cargar librerias --------------------------------------------------------

library(dplyr)
library(lubridate)
library(stringr)

# 2. Modificar formato de la fecha del SINCA a formato (fecha-hora POSIXct)-------------------------------------------

#2.1. Crear un nuevo df con las fechas corregidas
Las_Condes_Sinca_date <- Las_Condes_Sinca

#2.2. Seleccionar la columna que voy a convertir a formato POSIXct y zona horaria Santiago
Las_Condes_Sinca_date$date_hour <- as.POSIXct(
  Las_Condes_Sinca_date$date,
  format = "%d/%m/%Y %H:%M",
  tz =  "Etc/GMT+4"
)
# 2.3 Convertir la concentracion de PM25 a numerico
Las_Condes_Sinca_date$PM25 <- as.numeric(Las_Condes_Sinca_date$PM25)
  
# 2.4 Seleccionar para el nuevo df solo las columnas necesarias (PM25 y date_hour)
Las_Condes_Sinca_date <- Las_Condes_Sinca_date[, c("date_hour", "PM25")]

# 3. Modificar formato de la fecha Sensores -------------------------------------------
Condes_Plantower <- Condes_Plantower %>% 
  mutate(
    Fecha = Fecha + 20000000,
    Hora  = Hora / 100,
    Hora  = str_pad(Hora, 2, side = "left", pad = "0"),
    date_hour = paste(Fecha, Hora, sep = " "),
    date_hour = as.POSIXct(date_hour, format = "%Y%m%d %H", tz = "Etc/GMT+4")
  )

# 4. Unir las concentraciones del SINCA al df Condes_Plantawer por fecha ---------------------

Condes_Plantower_1 <- Condes_Plantower %>%
  left_join(Las_Condes_Sinca_date %>% select(date_hour, PM25_SINCA = PM25),
            by = "date_hour")  

# 5. Crear un nuevo df con las concentraciones de PM25 de Plantawer y SINCA --------

Condes_Plantower_SINCA <- Condes_Plantower_1 %>%
  select(date_hour, PM25_P1:PM25_P5, PM25_SINCA)

# 6. Modificar el nombre date_hour y añade columna temporales ----------------

Condes_Plantower_SINCA <- Condes_Plantower_SINCA %>%
  rename(date = date_hour) %>% # Modificar el nombre date_hour por date
  mutate(                   # Añadir dos columnas temporales date y wday
    hour = hour(date),
    wday = wday(date, label = TRUE, week_start = 1) 
  )