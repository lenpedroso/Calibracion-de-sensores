# Unir los valores de los errrores antes de la calibración y despues de calibrar
Errores_antes_despues <- bind_rows(
  tabla_errores_no_calibrado %>% mutate(Clasificación = "No calibrados"),
  tabla_errores_calibrado %>% mutate(Clasificación = "Calibrados")
)

# Poner por niveles
Errores_antes_despues$Clasificación <- factor(
  Errores_antes_despues$Clasificación,
  levels = c("No calibrados", "Calibrados")
)