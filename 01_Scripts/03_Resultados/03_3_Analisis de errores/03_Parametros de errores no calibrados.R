# Chat GPT
# se emplea la funcion setup para cargar el script con las funciones para el 
# calculo de errores
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo
# Se debe instalar (install.packages("here")) para crear rutas más seguras

# Cargar libreias
library(here)

# Seleccionar la ruta y carga las librerias y funciones para el cálculo de error --------------
source(here(
  "01_Scripts",
  "03_Resultados",
  "03_3_Analisis de errores",
  "01_Cálculo de errores.R"
))

# Funcion para calcular los errores para cada sensor (tabla) --------------------
errores_antes_calibracion <- map_dfr(sensores, function(sensor) { 

# Para seleccionar referencia (SINCA) y los valored de sensores de bajo costo --------
Valores_no_calibrados <- Condes_Plantower_SINCA %>%
  select(PM25_SINCA, all_of(sensor)) %>%
  drop_na()                            

#  Calcular error para cada sensor ---------------------------------------

No_calibrado <- calculo_error(     # Selecciona la función definida para calcular error
  referencia = Valores_no_calibrados$PM25_SINCA, # Especifica los valores de referencia (SINCA)
  predicho   = Valores_no_calibrados[[sensor]]  # Seleccionar los valores predicho de Cada sensor
)

# Agregar nombre de sensor y ordenar columnas ---------------------------
No_calibrado %>%
  mutate(Sensor = sensor) %>% # Agregar un nueva columna (sensor)
  relocate(Sensor, .before = MGE) # Mueve la palabra sensor al inicio (before error)
})
# Obtener la tabla ----------------------------------------------
tabla_errores_no_calibrado <- errores_antes_calibracion