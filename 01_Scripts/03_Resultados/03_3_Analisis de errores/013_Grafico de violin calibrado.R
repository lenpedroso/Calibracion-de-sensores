# Script para realizar los graficos de violin para el analisis de la distribucion 
# de los errores por cada una de las observaciones después de la calibración
#Para realizar los graficos se tomo de base los script presentado en la siguiente 
#página web (https://r-charts.com/es/distribucion/grafico-violin-grupo-ggplot2/)
#Los colores fueron extraidos de la siguiente página web (https://r-charts.com/es/colores/)
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo

# Seleccionar datos -------------------------------------------------------
errores_cal <- errores_completo %>% filter(Clasificacion == "Calibrados")

# Grafico de violín para errores no calibrados ----------------------------

p_violin_calibrado <- ggplot(errores_cal,
                               aes(x = Sensor, y = error_abs, fill = Sensor)) +
  geom_violin(trim = FALSE, alpha = 0.35, linewidth = 1.1) + # No recorta extremo y especifica la transparencia
  geom_boxplot(width = 0.10, alpha = 0.8, linewidth = 1.0, #Añadir box plot dentro del violin
               outlier.size = 1.5) +   # Especifica el tamaño de los puntos outlier
  geom_hline(yintercept = 20, linetype = "dashed",  # Añade una linea horizontal en y=20
             color = "firebrick4", linewidth = 1) + # Selecciona el color de la linea
  scale_y_continuous(limits = c(0, NA)) +       # Establece que el valor minimo es 0 y sin max(Na)
  scale_fill_manual(values = c(                 # Seleccion de colores para cada grafico de violin
    "PM25_P1" = "firebrick1",
    "PM25_P2" = "firebrick2",
    "PM25_P3" = "firebrick3",
    "PM25_P4" = "firebrick4",
    "PM25_P5" = "#5A0F0F"
  )) +
  theme_bw(base_size = 16) +                 # Tema blanco y negro con tamño de texto 16
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5), #Título en negrita y centrado
    axis.text.x = element_text(angle = 45, hjust = 1) # Inclina el eje para evitar solapamientos
  ) +
  labs(title = "Error absoluto — No calibrados",
       x = "Sensor", y = "Error absoluto (µg/m³)",
       fill = "Sensor")
