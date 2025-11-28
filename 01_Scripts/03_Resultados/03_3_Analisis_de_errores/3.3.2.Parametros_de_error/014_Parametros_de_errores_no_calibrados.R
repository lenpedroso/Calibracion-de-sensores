# Este script permite calcular los parametros de errores(MGE,MB, SD_MGE, SD_MM) para los sensores antes de calibración 
# y crear una tabla con los resultados para cada uno de los sensores.
# Se debe descargar todas las carpeteas correspondientes a al proyecto "Calibración de sensores" 
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo

# 1. Cargar libreias -------------------------------------------------------
library(tidyverse)

# 1.1. Seleccionar la ruta y carga las librerias y funciones del script cálculo de error --------------
leer_datos <- list.files(
  path = "01_Scripts/03_Resultados/03_3_Analisis_de_errores/3.3.2. Parametros_de_error", # Indica las carpetas
  pattern = "013_Cálculo_de_errores\\.R",               # Filtrar el archivo .R
  full.names = TRUE
)
walk(leer_datos, source)     # Ejecuta el archivo de la ruta especificada

# 2. Funcion para calcular los errores para cada sensor (tabla) --------------------
errores_antes_calibracion <- map_dfr(sensores, function(sensor) { 

# 3. Para seleccionar referencia (SINCA) y los valored de sensores de bajo costo --------
Valores_no_calibrados <- Condes_Plantower_SINCA %>%
  select(PM25_SINCA, PM25_P1:PM25_P5) %>%
  drop_na()                            

# 4.Calcular error para cada sensor ---------------------------------------
No_calibrado <- calculo_error(     # Selecciona la función definida para calcular error
  referencia = Valores_no_calibrados$PM25_SINCA, # Especifica los valores de referencia (SINCA)
  predicho   = Valores_no_calibrados[[sensor]]  # Seleccionar los valores predicho de Cada sensor
)
# 5. Agregar nombre de sensor y ordenar columnas ---------------------------
No_calibrado %>%
  mutate(Sensor = sensor) %>% # Agregar un nueva columna (sensor)
  relocate(Sensor)  # Mueve la palabra sensor al inicio
})
# 6. Obtener la tabla ----------------------------------------------
tabla_errores_no_calibrado <- errores_antes_calibracion