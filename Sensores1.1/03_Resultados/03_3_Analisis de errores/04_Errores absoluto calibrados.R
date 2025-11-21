# Calculo de los errores despues de aplicar un modelo de regresion lineal
# Chat gpt
# Cargar setup para cargar librerias, funciones para el cálculo de error --------------
source("Cálculo de errores.R")

 # Función que ajusta el modelo y calcula errores para cada sensor de bajo costo -------
errores_por_sensor <- function(sensor) {

# Seleccionar referencia (SINCA) y el sensor de bajo costo --------------
  Valores_calibrados <- Condes_Plantower_SINCA %>%
    dplyr::select(PM25_SINCA, all_of(sensor)) %>%
    tidyr::drop_na()

# #  Ajustar modelo: PM25_SINCA vs sensor (Plantower) ---------------------
form <- reformulate(sensor, response = "PM25_SINCA")# Para construir una formula de regresion automatica
modelo <- lm(form, data = Valores_calibrados)

# # Extraer valores ajustados con broom::augment --------------------------
aug <- augment(modelo)
referencia <- aug$PM25_SINCA     # Valores observados
predicho   <- aug$.fitted        # Valores calibrados (predichos por el modelo)

# Función general para calcular las métricas de error
calculo_error(referencia = referencia, predicho = predicho)
}

# Aplicar a todos los sensores y unir en una sola tabla
tabla_errores_calibrado <- map_dfr(sensores, errores_por_sensor)
# Construir
tabla_errores_calibrado <- tabla_errores_calibrado %>%
  mutate(Sensor = sensores) %>%   # Agrega los nombres P1-P5
  select(Sensor, everything())    # poner Sensor como primera columna