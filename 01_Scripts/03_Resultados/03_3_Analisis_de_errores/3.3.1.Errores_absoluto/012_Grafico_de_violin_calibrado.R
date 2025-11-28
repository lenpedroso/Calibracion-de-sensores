# Script para realizar los graficos de violin para el analisis de la distribucion después de realizar la calibración
# de los errores por cada una de las observaciones después de la calibración
#Para realizar los graficos se tomo de base los script presentado en la siguiente 
#página web (https://r-charts.com/es/distribucion/grafico-violin-grupo-ggplot2/)
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo

# 1. Seleccionar datos -------------------------------------------------------
errores_cal <- errores_completo %>% filter(Clasificacion == "Calibrados")

# 2. Gráfico de violín para errores no calibrados ----------------------------

violin_calibrado <- ggplot(errores_cal, aes(x = sensor, y = error_abs, fill = sensor)) +
  geom_violin(
    trim = FALSE,
    alpha = 0.35,
    linewidth = 1.1 # No recorta extremo y especifica la transparencia
  ) + 
  geom_boxplot(            # Añadir box plot dentro del violin
    width = 0.10,
    alpha = 0.8,
    linewidth = 1.0,
    outlier.size = 1.5
  ) +   
  geom_hline(                 # Especifica el tamaño de los puntos outlier
    yintercept = 20,
    linetype = "dashed",      # Añade una línea horizontal en y = 20
    color = "firebrick4",     # Selecciona el color de la línea
    linewidth = 1
  ) + 
  scale_y_continuous(limits = c(0, NA)) +  
  scale_fill_manual(   # Selección de colores para cada gráfico de violín
    values = c(
      "PM25_P1" = "firebrick1",
      "PM25_P2" = "firebrick2",
      "PM25_P3" = "firebrick3",
      "PM25_P4" = "firebrick4",
      "PM25_P5" = "#5A0F0F"
    )
  ) +
  theme_bw(base_size = 16) +  # Tema blanco y negro con tamaño de texto 16
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5) # Título en negrita y centrado
  ) +
  labs(
    title = "Error absoluto — Calibrados",
    x = "sensor",
    y = "Error absoluto (µg/m³)",
    fill = "sensor"
  )

        
# 3. Ver el gráfico ----------------------------------------------------------

print(violin_calibrado)
