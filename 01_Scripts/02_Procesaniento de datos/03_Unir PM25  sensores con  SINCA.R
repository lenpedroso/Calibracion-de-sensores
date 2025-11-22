# Se unieron los datos de las concentraciones del SINCA con los datos de los sensores
# de bajo costo instalados en Santiago de Chile, especificamente en la comuna Las Condes
# Se tomo de base el repositorio de la profesora Sara Acevedo para modificar datos
# temporales (https://github.com/Saryace/datascience-sinca/blob/main/codigo/02_procesamiento-horas.R)
# Se empleo chat gpt para ordenar, modificar, transformar,  optimizar codigos y unir codigos
# Nota: Para usar la libreria open air es necesario tener una columana que se llame date
# Cargar librerias --------------------------------------------------------

library(dplyr)
library(lubridate)


# Modificar formato de la fecha del SINCA a formato (fecha-hora POSIXct)-------------------------------------------

Las_Condes_Sinca_date <- Las_Condes_Sinca %>%
  mutate(date_hour = dmy_hm(date, tz = "America/Santiago")) %>% # Convertir date en formato POSIXct y zona horaria Santiago
  transmute(date_hour, PM25 = as.numeric(PM25)) # Devuelve dos columanas date_hour y PM25(numerico) y descarta las demás

# Modificar formato de la fecha Sensores -------------------------------------------

Condes_Plantower <- Condes_Plantower %>%
  mutate(
    Fecha = Fecha + 20000000L,# Es necesario sumarle 2000 a la fecha 
    Hora_chr = sprintf("%02d:00", Hora %/% 100),# Divide entre 100 y fijas los minutos en 00
    date_hour = as.POSIXct(    # Especifica el tipo de formato de hora (as.POSIXct)
      paste(Fecha, Hora_chr),  # Para unir ambas partes (año + hora)
      format = "%Y%m%d %H:%M",  # Especifica el formato: año-mes-dia-hora-minuto
      tz = "Etc/GMT+4"  # Define la zona horaria de Chile
    )
  )
# # Unir las concentraciones del SINCA al df Condes_Plantawer por fecha ---------------------

Condes_Plantower_1 <- Condes_Plantower %>%
  left_join(Las_Condes_Sinca_date %>% select(date_hour, PM25_SINCA = PM25),
            by = "date_hour")  

# # Crear un nuevo df con las concentraciones de PM25 de Plantawer y SINCA --------

Condes_Plantower_SINCA <- Condes_Plantower_1 %>%
  select(date_hour, PM25_P1:PM25_P5, PM25_SINCA)

# Modificar el nombre date_hour y añade columna temporales ----------------

Condes_Plantower_SINCA <- Condes_Plantower_SINCA %>%
  rename(date = date_hour) %>% # Modificar el nombre date_hour por date
  mutate(                   # Añadir dos columnas temporales date y wday
    hour = hour(date),
    wday = wday(date, label = TRUE, abbr = TRUE, week_start = 1) 
  )