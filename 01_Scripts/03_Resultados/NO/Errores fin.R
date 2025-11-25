# Cargar librerías -------------------------------------------
library(dplyr)
library(purrr)
library(tibble)
library(tidyr)

# Vector con los nombres de los sensores ---------------------
sensores <- paste0("PM25_P", 1:5)

# Función genérica para calcular errores ---------------------
calculo_error <- function(referencia, predicho) {
  referencia <- as.numeric(referencia)
  predicho   <- as.numeric(predicho)
  
# Errores punto a punto
  error     <- predicho - referencia
  error_abs <- abs(error)
  
  tibble(
    RMSE   = sqrt(mean(error^2, na.rm = TRUE)),   # Error cuadrático medio
    MGE    = mean(error_abs, na.rm = TRUE),       # Error absoluto medio
    MB     = mean(error, na.rm = TRUE),           # Sesgo
    SD_MGE = sd(error_abs, na.rm = TRUE)          # Desviación estándar del error absoluto
  )
}

# Sin calibrar ------------------------------------------------------------

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
    relocate(Sensor, .before = RMSE_antes) # Mueve la palabra sensor al inicio (before error)
})
# 2) ERRORES DESPUÉS DE CALIBRAR
#     (modelo de regresión lineal)
# -----------------------------
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
