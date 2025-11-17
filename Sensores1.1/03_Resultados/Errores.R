library(openair)
# Dataset
dataset <- Condes_Plantower_SINCA
# Crear una listapara guardar modelos
modelos <- list()
# Crear vector sensores 
sensores <- paste0("PM25_P", 1:5)

# Ajustar modelo lineal PM25_SINCA ~ PM25_Pi para cada sensor
for (s in sensores) {
  formula <- as.formula(paste("PM25_SINCA ~", s))
  modelos[[s]] <- lm(formula, data = dataset)

}
# Resumen de los modelos
summary(modelos[["PM25_P1"]])
# Crear una columna para cada sensor
for (s in sensores) {
  nombre_cal <- paste0(s, "_calibrado")              
  dataset[[nombre_cal]] <- predict(modelos[[s]])
}

# Errores antes de calibrar
errores_antes <- lapply(sensores, function(s) {
  modStats(dataset, obs = "PM25_SINCA", mod = s)
})
names(errores_antes) <- sensores

# Errores despues de calibrar
sensores_calibrado <- paste0(sensores, "_calibrado")

errores_despues <- lapply(sensores_calibrado, function(s) {
  modStats(dataset, obs = "PM25_SINCA", mod = s)
})
names(errores_despues) <- sensores

# Crear un df con mi lista 
library(dplyr)

# Crear df de errores antes
df_antes <- lapply(sensores, function(s) {
  out <- errores_antes[[s]]
  out$Sensor <- s
  out$Tipo   <- "Antes"
  out
})
df_antes <- bind_rows(df_antes)

# Crear df de errores después
df_despues <- lapply(sensores, function(s) {
  out <- errores_despues[[s]]
  out$Sensor <- s
  out$Tipo   <- "Despues"
  out
})
df_despues <- bind_rows(df_despues)

# Unir todo en un solo df

tabla_RMSE <- data.frame(
  Sensor       = sensores,
  RMSE_antes     = sapply(sensores, function(s) errores_antes[[s]]$RMSE),
  RMSE_despues   = sapply(sensores, function(s) errores_despues[[s]]$RMSE),
  
  MB_antes       = sapply(sensores, function(s) errores_antes[[s]]$MB),
  MB_despues     = sapply(sensores, function(s) errores_despues[[s]]$MB),
  
  MGE_antes      = sapply(sensores, function(s) errores_antes[[s]]$MGE),
  MGE_despues    = sapply(sensores, function(s) errores_despues[[s]]$MGE)
)

tabla_RMSE

# Porcentual
# Calcular la media 
media_ref <- mean(dataset$PM25_SINCA, na.rm = TRUE)
media_ref
# Tabla resumen
tabla_errores_pct <- data.frame(
  Sensor           = sensores,
  
  # RMSE
  RMSE_antes_pct   = 100 * sapply(sensores, function(s) errores_antes[[s]]$RMSE) / media_ref,
  RMSE_despues_pct = 100 * sapply(sensores, function(s) errores_despues[[s]]$RMSE) / media_ref,
  
  # MB
  MB_antes_pct     = 100 * sapply(sensores, function(s) errores_antes[[s]]$MB) / media_ref,
  MB_despues_pct   = 100 * sapply(sensores, function(s) errores_despues[[s]]$MB) / media_ref,
  
  # MGE
  MGE_antes_pct    = 100 * sapply(sensores, function(s) errores_antes[[s]]$MGE) / media_ref,
  MGE_despues_pct  = 100 * sapply(sensores, function(s) errores_despues[[s]]$MGE) / media_ref
)

tabla_errores_pct

