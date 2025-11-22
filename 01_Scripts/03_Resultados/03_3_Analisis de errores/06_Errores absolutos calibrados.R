# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo



# Función que ajusta el modelo y calcula errores para cada sensor de bajo costo -------
errores_por_sensor <- function(sensor) {
  
# Seleccionar referencia (SINCA) y el sensor de bajo costo --------------
Valores_calibrados <- Condes_Plantower_SINCA[, c("PM25_SINCA", sensor)] #columnas seleccionadas
  
# Eliminar filas con Na  ------------------------------------------------------------
Valores_calibrados <- na.omit(Valores_calibrados)
  
#  Ajustar modelo: PM25_SINCA vs sensor (Plantower) ---------------------
form <- reformulate(sensor, response = "PM25_SINCA")# Para construir una formula de regresion automatica
modelo <- lm(form, data = Valores_calibrados)
  
# Extraer valores ajustados del modelo (se emplea broom)--------------------------
aug <- augment(modelo)

# Tabla de errores por observación
tibble(
  Sensor        = sensor,
  referencia    = aug$PM25_SINCA,  # valor real (SINCA)
  predicho      = aug$.fitted,     # valor ajustado por el modelo
  error         = predicho - referencia,
  error_abs     = abs(error),
  Clasificacion = "Calibrados"
)
}
# Aplicar la función a todos los sensores y unir resultados en una tabla --
errores_calibrados <- purrr::map_dfr(sensores, errores_por_sensor)

# Ver la tabla final ------------------------------------------------------
print(errores_calibrados)
