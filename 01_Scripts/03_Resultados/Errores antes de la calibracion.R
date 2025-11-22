# Los valores de referencia se tratan de los valores de las estaciones oficiales de la 
#ciudad (SINCA) y los predichos son los valores referidos a los sensores instalados (P1-P5)
# A partir de los valores de referencia y los predichos se determinan los valores de los errores
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo
# Cargar librerias --------------------------------------------------------

library(dplyr)
library(purrr)
library(broom)
library(tibble)

# Calculo de errores antes de la calibración ------------------------------

# 1.  Función para calcular los errores dados valores referenciaes y predichos
calculo_error <- function(referencia, predicho) {
referencia <- as.numeric(referencia)
predicho   <- as.numeric(predicho) # Para garantizar que el argumento sea numérico

# 2. Calculo de los errores
  error   <- predicho - referencia
  error2     <- error^2 
  error_abs  <- abs(error)
  RMSE <- sqrt(mean((predicho - referencia)^2, na.rm = TRUE)) # Error cuadrático medio
  MB   <- mean(predicho - referencia, na.rm = TRUE)   # Sesgo          
  MGE <- mean(abs(predicho - referencia), na.rm = TRUE)  # Error absoluto medio
  SD_RMSE <- sd(error2, na.rm = TRUE)
  SD_MB   <- sd(error, na.rm = TRUE)
  SD_MGE <- sd(error_abs, na.rm = TRUE) # Desviación estándar del error absoluto

#3. Obtener resultados en una tabla
  tibble(
     RMSE,
     MGE,
     MB,
     SD_RMSE,
     SD_MB,
     SD_MGE
  )
}

# Vector con el nombre de los sensores ------------------------------------
sensores <- paste0("PM25_P", 1:5)

# # Funcion para calcular los errores para cada sensor --------------------

errores_antes_calibracion <- map_dfr(sensores, function(sensor) { # map_dfr permite optener una tabla

# Para seleccionar sensor de referencia (SINCA) y el valor de sensor de bajo costo y eliminar NA
  Valores_no_calibrados <- Condes_Plantower_SINCA %>%
    select(PM25_SINCA, all_of(sensor)) %>%
    drop_na()
  
# Calcular error para cada sensor
  No_calibrado <- calculo_error(
    referencia = Valores_no_calibrados$PM25_SINCA,
    predicho   = Valores_no_calibrados[[sensor]]
  )
  
# Agregar nombre de sensor y ordenar columnas
No_calibrado %>%
  mutate(Sensor = sensor) %>% # Agregar un nueva columna (sensor)
  relocate(Sensor, .before = RMSE) # Mueve la palabra sensor al inicio (before error)
})
# Obtener la tabla ----------------------------------------------
tabla_errores_no_calibrado <- errores_antes_calibracion
# Determinacion de los errores
# Errores individuales antes de la calibración
errores_no_calibrados <- map_dfr(sensores, function(sensor) {
  Condes_Plantower_SINCA %>%
    select(PM25_SINCA, all_of(sensor)) %>%
    drop_na() %>%
    transmute(
      Sensor     = sensor,
      referencia = PM25_SINCA,
      predicho   = .data[[sensor]],
      error      = predicho - referencia,
      error_abs  = abs(error),
      Clasificacion       = "No calibrados"
    )
})
