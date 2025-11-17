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
predicho <- aug$.fitted        # Sensor calibrado (predichoicho)

#  Calcular errores
rmse <- sqrt(mean((referencia - predicho)^2, na.rm = TRUE))
mge  <- mean(abs(predicho - referencia), na.rm = TRUE)
mb   <- mean(predicho - referencia, na.rm = TRUE)
  
# Obterner los resuktados en una misma fila
  tibble(
    Sensor = sensor,
    RMSE   = rmse,
    MGE    = mge,
    MB     = mb
  )
}

# Aplicar a todos los sensores y unir en una sola tabla
tabla_errores_calibrado <- map_dfr(sensores, errores_por_sensor)




