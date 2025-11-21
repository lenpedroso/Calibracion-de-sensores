# Para calcular los errores para cada uno de los valores de concentracion para 
#determinar la distribucion de los errores para cada sensor
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo
# Se debe instalar
# Cargar setup para cargar librerias, funciones para el cálculo de error --------------
source("01_Cálculo de errores.R")

# Definir funciones -------------------------------------------------------

errores_no_calibrados <- map_dfr(sensores, function(sensor) {
  
# Calculo de los errores individuales de cada observacion sin calibracion 
errores_no_calibrados <- map_dfr(sensores, function(sensor) {
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
  
