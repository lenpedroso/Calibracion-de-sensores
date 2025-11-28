# Permite unir todos los parametros de los errores (MGE, SDMGE,MB,SD-MB) en una sola tabla
# Se basó en (https://r-coder.com/factor-en-r/) para construir el codigo
# Se empleó bind_rows para mantener en formato largo la lista y unir filas (https://r-coder.com/rbind-cbind-en-r/)
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo

# 1. Unir los valores de los errrores antes y despues de la calibra --------
Errores_antes_despues <- bind_rows(
  tabla_errores_no_calibrado %>% mutate(Clasificación = "No calibrados"),
  tabla_errores_calibrado %>% mutate(Clasificación = "Calibrados")
)

# 2. Especificar los niveles a utilizar --------------------------------------
Errores_antes_despues$Clasificación <- factor(
  Errores_antes_despues$Clasificación,
  levels = c("No calibrados", "Calibrados")
)

