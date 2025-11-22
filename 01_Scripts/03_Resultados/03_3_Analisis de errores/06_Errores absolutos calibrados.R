# 4) calcula error y error absoluto por observación

errores_calibrados <- map_dfr(sensores, function(sensor) {
  
# Datos sin NA para ese sensor
  Valores_calibrados <- Condes_Plantower_SINCA %>%
    select(PM25_SINCA, all_of(sensor)) %>%
    tidyr::drop_na()
  
# Fórmula: PM25_SINCA ~ sensor
form <- reformulate(sensor, response = "PM25_SINCA")
modelo <- lm(form, data = Valores_calibrados)
  
# Valores ajustados
aug <- augment(modelo)
  
# Tabla de errores por observación
tibble(
    Sensor        = sensor,
    referencia    = aug$PM25_SINCA,
    predicho      = aug$.fitted,
    error         = predicho - referencia,
    error_abs     = abs(error),
    Clasificacion = "Calibrados"
  )
})
print(errores_calibrados)
