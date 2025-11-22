# Procedimiento para calcular los errores absoluto para cada uno de los valores 
# de concentración y determinar la distribucion de los errores para cada sensor. 
# Se debe instalar (install.packages("here")) para crear rutas que permitan 
# cargar codigos (librerias, funciones) de script anteriores.
# Se debe descargar todas las carpeteas correspondientes al proyecto 
#"Calibración de sensores" para que pueda funcionar este script
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo

# # Cargar libreias -------------------------------------------------------
library(here)

# Seleccionar la ruta para el cálculo de error --------------
source(here(
  "01_Scripts",
  "03_Resultados",
  "03_3_Analisis de errores",
  "01_Cálculo de errores.R"
))

# # Cálculo de los errores individuales de cada observacion sin calibración --------
errores_no_calibrados <- map_dfr(sensores, function(sensor) { # Iterar para cada sensor
    Condes_Plantower_SINCA %>%
      select(PM25_SINCA, all_of(sensor)) %>% 
      transmute(             # Agregar nueva columnas de error al df
        Sensor     = sensor,
        referencia = PM25_SINCA,
        predicho   = .data[[sensor]],
        error      = predicho - referencia,
        error_abs  = abs(error),
        Clasificacion       = "No calibrados"
      )
  })




  
