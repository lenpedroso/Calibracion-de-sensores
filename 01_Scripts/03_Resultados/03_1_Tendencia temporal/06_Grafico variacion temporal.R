# El script permite hacer un grafico de la tendencia temporal de los sensores
# El codigo para hacer el grafico fue extraido del repositorio  de la profesora
# Sara Acevedo para modificar datos
# temporales (https://github.com/Saryace/datascience-sinca/blob/main/codigo/03_plot
# La paleta de colores fue seleccionada del sigueinte link (https://r-charts.com/es/colores/)
# Chat gpt fue empleado para modificar, ordenar y solucionar errores de codigo
# Cargar librerias --------------------------------------------------------
library (ggplot2)
# Grafico de variacion de PM25 por horas y dias de la semana
png("C:/Semestre 2-2025/Visualizacion/Calibracion de sensores/Calibracion de sensores/Sensores1.1/04_Figuras/tendencia.png",
    width = 16, 
    height = 10,
    units = "in",
    res = 900)
ggplot(hour_wday, aes(x = hour, y = mean, color = sensor, fill = sensor, group = sensor)) +
  geom_ribbon(aes(ymin = ymin, ymax = ymax), alpha = 0.15, colour = NA) +
  geom_line(linewidth = 1.4) +
  facet_wrap(vars(wday), nrow = 1) +
  labs(
    x = "Hora del día",
    y = expression(PM[2.5]~(mu*g/m^3)),
    color = "Sensor",
    fill  = "Sensor",
    title = "Promedio horario de PM2.5 por día de la semana y sensor"
  ) +
  scale_color_manual(
    values = c(
      "P1" = "gold",
      "P2" = "blue",
      "P3" = "#4EEE94",
      "P4" = "#87CEEB",
      "P5" = "coral",
      "SINCA" = "#EE7AE9"
    )
  ) +
  scale_fill_manual(
    values = c(
      "P1" = "gold",
      "P2" =  "blue",
      "P3" = "#4EEE94",
      "P4" = "#87CEEB",
      "P5" = "coral",
      "SINCA" = "#EE7AE9"
    )
  ) +
  theme_bw() +
  theme(
    legend.position = "right",
    plot.title = element_text(hjust = 0.5, face = "bold"),  
    strip.background = element_rect(fill = "grey90", color = NA),
    strip.text = element_text(face = "bold"),
    axis.text.x = element_text(angle = 0, hjust = 0.5)
  )


dev.off()

# Box Plot
ggplot(Condes_Plantower_SINCA_long3, 
       aes(x = sensor, y = value_PM25, fill = sensor)) +
  geom_boxplot(outlier.shape = 16, outlier.alpha = 0.3) +
  labs(
    x = "Sensor",
    y = expression(PM[2.5]~(mu*g/m^3)),
    fill = "Sensor",
    title = "Distribución general de PM2.5 por sensor"
  ) +
  theme_bw() +
  theme(
    legend.position = "none",      # Oculta leyenda si ya está en el eje x
    plot.title = element_text(face = "bold", hjust = 0.5)
  )
# Unir ambos graficos
boxplot_PM25 + time_plot + plot_layout(heights = c(1, 2))

# Violin
ggplot(Condes_Plantower_SINCA_long3, 
       aes(x = sensor, y = value_PM25, fill = sensor)) +
  
  geom_violin(trim = FALSE, alpha = 0.8) +      # violines
  
  geom_boxplot(width = 0.15,                    # boxplot estrecho dentro del violín (opcional)
               outlier.shape = NA, 
               alpha = 0.5) +
  
  labs(
    x = "Sensor",
    y = expression(PM[2.5]~(mu*g/m^3)),
    fill = "Sensor",
    title = "Distribución general de PM2.5 por sensor"
  ) +
  theme_bw() +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )
