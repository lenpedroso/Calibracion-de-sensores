# Peromite unir todos los parametros de los errores (MGE, SDMGE,MB,SD-MB)
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo

# Unir los valores de los errrores antes y despues de la calibra --------

Errores_antes_despues <- bind_rows(
  tabla_errores_no_calibrado %>% mutate(Clasificación = "No calibrados"),
  tabla_errores_calibrado %>% mutate(Clasificación = "Calibrados")
)

# Especificar los niveles a utilizar --------------------------------------

Errores_antes_despues$Clasificación <- factor(
  Errores_antes_despues$Clasificación,
  levels = c("No calibrados", "Calibrados")
)