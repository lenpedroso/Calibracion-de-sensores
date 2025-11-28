# Permite calcular los parametros de errores(MGE,MB, SD_MGE, SD_MM) para los sensores calibrados(modelo de regresion lineal) 
# Se debe descargar todas las carpeteas correspondient al proyecto"Calibración de sensores" 
# Para el modelo de regresion lineal(https://www.datacamp.com/es/tutorial/linear-regression-R)
# El uso de form para crear bucles me base de este link (https://r-coder.com/for-en-r/)
# El empleo de predict (https://www.digitalocean.com/community/tutorials/predict-function-in-r)
#(https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/formula)
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo


# 1. Cargar libreias -------------------------------------------------------
library(tidyverse)

# 2. Seleccionar la ruta y carga las librerias y funciones del script cálculo de error --------------
leer_datos <- list.files(
  path = "01_Scripts/03_Resultados/03_3_Analisis_de_errores/3.3.2. Parametros_de_error", # indica las carpetas
  pattern = "013_Cálculo_de_errores\\.R",               # Filtrar el archivo .R
  full.names = TRUE
)
walk(leer_datos, source)     # Ejecuta el archivo de la ruta

# 3. Función que ajusta el modelo y calcula errores para cada sensor de bajo costo -------
errores_por_sensor <- function(sensor) {

# 4. Seleccionar referencia (SINCA) y cada sensor de bajo costo --------------
Valores_calibrados <- Condes_Plantower_SINCA[, c("PM25_SINCA", sensor)] #Columnas seleccionadas

# 5. Eliminar filas con Na  ------------------------------------------------------------
Valores_calibrados <- drop_na(Valores_calibrados)
  
# 6. Ajustar modelo: PM25_SINCA vs sensor (Plantower) ---------------------

#6.1 Construir formula de regresion lineal automatizada y simplificada por sensor
form <- as.formula(paste("PM25_SINCA ~", sensor))

# 6.2 Ajuste del modelo de regrsion lineal automatizado para cada sensor
modelo <- lm(form, data = Valores_calibrados)

#7.  Extraer valores ajustados del modelo --------------------------

predicho   <- predict(modelo) # Valores calibrados (predichos por el modelo)
referencia <- Valores_calibrados$PM25_SINCA # Valores de referencia

# 8. Función general para calcular las métricas de error -------------------
calculo_error(referencia = referencia, predicho = predicho)
}
# 9. Aplicar a todos los sensores y unir en una sola tabla -----------------
tabla_errores_calibrado <- map_dfr(sensores, errores_por_sensor)

# 10. Obtener tabla con todos los parametros de errores calibrados ----------

tabla_errores_calibrado <- tabla_errores_calibrado %>%
  mutate(Sensor = sensores) %>%   # Agrega los nombres P1-P5
  relocate(Sensor)  # Recoloca la palabra sensor al inicio
