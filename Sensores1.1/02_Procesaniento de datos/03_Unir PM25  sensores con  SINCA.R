

# Cargar librerias --------------------------------------------------------

library(dplyr)
library(lubridate)


# Modificar formato de la fecha del SINCA a formato (fecha-hora POSIXct)-------------------------------------------

Las_Condes_Sinca_date <- Las_Condes_Sinca %>%
  mutate(date_hour = dmy_hm(date, tz = "America/Santiago")) %>% # Convertir date en formato POSIXct y zona horaria Santiago
  transmute(date_hour, PM25 = as.numeric(PM25)) # Devuelve dos columanas date_hour y PM25(numerico) y descarta las demás

# Modificar formato de la fecha Sensores -------------------------------------------
Condes_Plantower$Fecha<-Condes_Plantower$Fecha+ 20000000
Condes_Plantower$Hora<-Condes_Plantower$Hora/100
Condes_Plantower$Hora<-paste(Condes_Plantower$Hora,"00",sep=":",collapse = NULL)
Condes_Plantower$date_hour<-paste(Condes_Plantower$Fecha, Condes_Plantower$Hora,sep = " ", collapse = NULL)
Condes_Plantower$date_hour <- as.POSIXct(Condes_Plantower$date_hour, format = "%Y%m%d %H:%M", tz = "Etc/GMT+4")
# # Unir las concentraciones del SINCA al df Condes_Plantawer por fecha ---------------------

Condes_Plantower_1 <- Condes_Plantower %>%
  left_join(Las_Condes_Sinca_date %>% select(date_hour, PM25_SINCA = PM25),
            by = "date_hour")  

# # Crear un nuevo df con las concentraciones de PM25 de Plantawer --------

Condes_Plantower_SINCA <- Condes_Plantower_1 %>%
  select(date_hour, PM25_P1:PM25_P5, PM25_SINCA)

# Modificar el nombre de la columna date_hour por date --------------------
# Nota: Para usar la libreria open air es necesario tener una columana que se llame date

Condes_Plantower_SINCA <- Condes_Plantower_SINCA %>%
  rename(date = date_hour)
