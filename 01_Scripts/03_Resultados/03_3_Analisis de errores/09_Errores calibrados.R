# Calculo de los errores despues de aplicar un modelo de regresion lineal 

# Cargar libreria ---------------------------------------------------------
library(dplyr)
library(purrr)
library(broom)
library(tibble)
library(tidyr)

# # Vector con los nombres de los sensores sensores  --------
sensores <- paste0("PM25_P", 1:5)

# Función que ajusta el modelo y calcula errores para UN sensor
errores_por_sensor <- function(sensor) {

# Para seleccionar sensor de referencia (SINCA) y el valor de sensor de bajo costo
  Valores_calibrados <- Condes_Plantower_SINCA %>%
    dplyr::select(PM25_SINCA, all_of(sensor)) %>%
    tidyr::drop_na()
  
#  Ajustar modelo: PM25_SINCA ~ sensor
form <- reformulate(sensor, response = "PM25_SINCA")# Para construir una formula de regresion automatica
modelo <- lm(form, data = Valores_calibrados)

# Definir los valores de referencia y predichoichos usando broom
aug <- augment(modelo)
referencia <- aug$PM25_SINCA     # Referencia
predicho <- aug$.fitted        # Sensor calibrado (predicho)

#  Calcular errores
error   <- predicho - referencia
error2     <- error^2 
error_abs  <- abs(error)
RMSE <- sqrt(mean((predicho - referencia)^2, na.rm = TRUE)) # Error cuadrático medio
MB   <- mean(predicho - referencia, na.rm = TRUE)   # Sesgo          
MGE <- mean(abs(predicho - referencia), na.rm = TRUE)  # Error absoluto medio
SD_RMSE <- sd(error2, na.rm = TRUE)
SD_MB   <- sd(error, na.rm = TRUE)
SD_MGE <- sd(error_abs, na.rm = TRUE) # Desviación estándar del error absoluto
  
# Obterner los resuktados en una misma fila
tibble(
  RMSE,
  MGE,
  MB,
  SD_RMSE,
  SD_MB,
  SD_MGE
)
}

 
# Aplicar a todos los sensores y unir en una sola tabla
tabla_errores_calibrado <- map_dfr(sensores, errores_por_sensor)
# Construir
tabla_errores_calibrado <- tabla_errores_calibrado %>%
  mutate(Sensor = sensores) %>%   # aquí agregas los nombres P1...P5
  select(Sensor, everything())    # poner Sensor como primera columna

