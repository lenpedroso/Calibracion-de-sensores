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

# 1.  Función para calcular los errores dados valores referenciaes y predichoichos
calculo_error <- function(referencia, predicho) {
referencia <- as.numeric(referencia)
predicho   <- as.numeric(predicho) # Para garantizar que el argumento sea numérico

# 2. Calculo de los errores
  RMSE_antes <- sqrt(mean((predicho - referencia)^2, na.rm = TRUE)) # Error cuadrático medio
  MB_antes   <- mean(predicho - referencia, na.rm = TRUE)           # Sesgo          
  MGE_antes  <- mean(abs(predicho - referencia), na.rm = TRUE)      # Error absoluto medio

#3. Obtener resultados en una tabla
  tibble(
    RMSE = RMSE_antes,
    MGE  = MGE_antes,
    MB   = MB_antes
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
errores_antes_calibracion
  
