# La función utlizada para calcular las concentraciones semanales y 
# para determinar los resumenes diario y semanales fue copidada del siguiente link:
#(https://github.com/Saryace/datascience-sinca/blob/main/codigo/02_procesamiento-horas.R)
# Esta función  fue modificada para los df de trabajo.
# Para mejor funcionamiento de la función(rlang) 
#Chat gpt fue utilizado para corregir errores y como complemento para transformar la función

# 1. Cargar librerias --------------------------------------------------------

library(dplyr)   
library(tidyr)    
library(rlang)   

# 2. Funcion para calcular las concentraciones semanales ----------------

Condes_summary_pm25 <- function(datos, tiempo, pm_col = "value") {
  datos %>%
    group_by(across(all_of(tiempo)), sensor) %>% # La funcion fue realizada para cada sensor
    summarise(
      n    = sum(!is.na(.data[[pm_col]])),# Para determinar los datos válidos
      mean = mean(.data[[pm_col]], na.rm = TRUE),
      sd   = sd(.data[[pm_col]], na.rm = TRUE),
      se   = ifelse(n > 1, sd / sqrt(n), NA_real_),
      ymin = mean - 1.96 * se,
      ymax = mean + 1.96 * se,
      .groups = "drop"
    )
}

# 3. Resumenes por dia de la hora y por dia de la semana ---------------------
hour_wday <- Condes_summary_pm25(Condes_Plantower_SINCA_long3, c("wday", "hour"),"value_PM25")
hour <- Condes_summary_pm25(Condes_Plantower_SINCA_long3, "hour", "value_PM25")
wday <- Condes_summary_pm25(Condes_Plantower_SINCA_long3, "wday", "value_PM25")


