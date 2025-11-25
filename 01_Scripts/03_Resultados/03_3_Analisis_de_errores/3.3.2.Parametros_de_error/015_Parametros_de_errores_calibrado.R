# Calculo de los parametros de error (MGE,MB) despues de aplicar un modelo de regresion lineal
#Se debe instalar (install.packages("here")) para crear rutas que permitan 
# cargar codigos (librerias, funciones) de script anteriores
# Se debe descargar todas las carpeteas correspondient al proyecto"Calibración de sensores" para que pueda funcionar este script
# Para realizar las funciones se empleo el siguiente link (https://github.com/Saryace/environ-dataviz-uc/blob/main/scr/04-semana/03-funciones.R) 
# y (https://github.com/Saryace/environ-dataviz-uc/blob/main/scr/05-semana/03-funciones-ggplot.R)extraido del repositorio de la profesora 
#Se utlizaron los diferentes link para usar map y seleccionar elementos de una lista
#(https://purrr.tidyverse.org/reference/map_dfr.html#arguments) y 
#(https://stackovercoder.es/programming/1169456/the-difference-between-bracket-and-double-bracket-for-accessing-the-el)
# Para crear tabla se baso en el codigo (https://tibble.tidyverse.org/reference/tibble.html)
# Para el modelo de regresion lineal(https://www.datacamp.com/es/tutorial/linear-regression-R)
# El uso de form para crear bucles me base de este link (https://r-coder.com/for-en-r/)
# El empleo de reformulate (para simplificar la formula) me base del siguiente link (https://www.r-bloggers.com/2023/06/simplifying-model-formulas-with-the-r-function-reformulate/)
# El empleo de predict (https://www.digitalocean.com/community/tutorials/predict-function-in-r)
# fitted  (https://stackoverflow.com/questions/12201439/is-there-a-difference-between-the-r-functions-fitted-and-predict)
#(https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/formula)
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo


# 1. Cargar libreias -------------------------------------------------------

library(tidyverse)

# Seleccionar la ruta y carga las librerias y funciones del script cálculo de error --------------
leer_datos <- list.files(
  path = "01_Scripts/03_Resultados/03_3_Analisis_de_errores/3.3.2. Parametros_de_error", # indica las carpetas
  pattern = "013_Cálculo_de_errores\\.R",               # Filtrar el archivo .R
  full.names = TRUE
)
walk(leer_datos, source)     # Ejecuta el archivo de la ruta
# 3. Función que ajusta el modelo y calcula errores para cada sensor de bajo costo -------
errores_por_sensor <- function(sensor) {

# 4. Seleccionar referencia (SINCA) y cada sensor de bajo costo --------------
Valores_calibrados <- Condes_Plantower_SINCA[, c("PM25_SINCA", sensor)] #columnas seleccionadas

# 5. Eliminar filas con Na  ------------------------------------------------------------
Valores_calibrados <- drop_na(Valores_calibrados)
  
# 6. Ajustar modelo: PM25_SINCA vs sensor (Plantower) ---------------------
#6.1 Construir formula de regresion lineal automatizada y simplificada por sensor
#form <- reformulate(sensor, response = "PM25_SINCA")# Para construir una formula de regresion automatica
form <- as.formula(paste("PM25_SINCA ~", sensor))
# 6.2 Ajuste del modelo de regrsion lineal automatizado para cada sensor
modelo <- lm(form, data = Valores_calibrados)

#7.  Extraer valores ajustados del modelo (se emplea broom)--------------------------

predicho   <- predict(modelo) # Valores calibrados (predichos por el modelo)
referencia <- Valores_calibrados$PM25_SINCA # Valores observados

# 8. Función general para calcular las métricas de error -------------------
calculo_error(referencia = referencia, predicho = predicho)
}
# Aplicar a todos los sensores y unir en una sola tabla -----------------
tabla_errores_calibrado <- map_dfr(sensores, errores_por_sensor)

# Obtener tabla con todos los parametros de errores calibrados ----------

tabla_errores_calibrado <- tabla_errores_calibrado %>%
  mutate(Sensor = sensores) %>%   # Agrega los nombres P1-P5
  relocate(Sensor)  # Recoloca la palabra sensor al inicio
