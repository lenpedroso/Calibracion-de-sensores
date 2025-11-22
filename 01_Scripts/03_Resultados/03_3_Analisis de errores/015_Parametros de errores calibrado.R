# Calculo de los parametros de error (MGE,MB) despues de aplicar un modelo de regresion lineal
#Se debe instalar (install.packages("here")) para crear rutas que permitan 
# cargar codigos (librerias, funciones) de script anteriores
# Se debe descargar todas las carpeteas correspondient al proyecto 
#"Calibración de sensores" para que pueda funcionar este script
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo

# Cargar libreias
library(here)

# Seleccionar la ruta original para el cálculo de error --------------
source(here(
  "01_Scripts",
  "03_Resultados",
  "03_3_Analisis de errores",
  "01_Cálculo de errores.R"
))
# Función que ajusta el modelo y calcula errores para cada sensor de bajo costo -------
errores_por_sensor <- function(sensor) {

# Seleccionar referencia (SINCA) y el sensor de bajo costo --------------
Valores_calibrados <- Condes_Plantower_SINCA[, c("PM25_SINCA", sensor)] #columnas seleccionadas

# Eliminar filas con Na  ------------------------------------------------------------
Valores_calibrados <- na.omit(Valores_calibrados)
  
# Ajustar modelo: PM25_SINCA vs sensor (Plantower) ---------------------
form <- reformulate(sensor, response = "PM25_SINCA")# Para construir una formula de regresion automatica
modelo <- lm(form, data = Valores_calibrados)

# Extraer valores ajustados del modelo (se emplea broom)--------------------------
aug <- augment(modelo)
referencia <- aug$PM25_SINCA     # Valores observados
predicho   <- aug$.fitted        # Valores calibrados (predichos por el modelo)


# # Función general para calcular las métricas de error -------------------
calculo_error(referencia = referencia, predicho = predicho)
}
# Aplicar a todos los sensores y unir en una sola tabla -----------------
tabla_errores_calibrado <- map_dfr(sensores, errores_por_sensor)

# Obtener tabla con todos los parametros de errores calibrados ----------

tabla_errores_calibrado <- tabla_errores_calibrado %>%
  mutate(Sensor = sensores) %>%   # Agrega los nombres P1-P5
  select(Sensor, everything())    # poner Sensor como primera columna