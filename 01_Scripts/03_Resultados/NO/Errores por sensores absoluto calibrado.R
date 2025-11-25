# Calculo para hacer la distribucion de errores
errores_por_sensor_detalle <- function(sensor) {
  
  Valores_calibrados <- Condes_Plantower_SINCA %>%
    dplyr::select(PM25_SINCA, all_of(sensor)) %>%
    tidyr::drop_na()
  
  # Modelo: PM25_SINCA ~ sensor
  form   <- reformulate(sensor, response = "PM25_SINCA")
  modelo <- lm(form, data = Valores_calibrados)
  
  # Predicciones (calibradas) con broom
  aug <- augment(modelo, data = Valores_calibrados)
  
  aug %>%
    transmute(
      Sensor        = sensor,
      referencia    = PM25_SINCA,
      valor_bruto   = .data[[sensor]],  # valor original del sensor
      predicho_cal  = .fitted,          # valor calibrado (modelo)
      error_cal     = predicho_cal - referencia,
      error_cal2    = error_cal^2,
      error_cal_abs = abs(error_cal)
    )
}
errores_calibrados2 <- map_dfr(sensores, errores_por_sensor_detalle)
errores_detalle_calibrados <- errores_detalle_calibrados %>%
  mutate(Clasificacion = "Calibrados")

# Tabla completa
errores_full <- bind_rows(
  errores_no_calibrados %>%
    transmute(Sensor, referencia, predicho, error, error_abs,
              Tipo = "No calibrados"),
  
  errores_detalle_calibrados %>%
    transmute(Sensor, referencia,
              predicho = predicho_cal,
              error    = error_cal,
              error_abs = error_cal_abs,
              Tipo = "Calibrados")
) %>%
  mutate(
    Tipo = factor(Tipo, levels = c("No calibrados", "Calibrados"))
  ) %>%
  arrange(Sensor, referencia)


