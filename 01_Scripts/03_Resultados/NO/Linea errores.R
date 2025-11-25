ggplot(Errores_antes_despues,
       aes(x = Sensor, 
           y = MB, 
           color = Clasificación, 
           group = Clasificación)) +
  
  # Barras de error
  geom_errorbar(aes(ymin = MB - SD_MB,
                    ymax = MB + SD_MB),
                width = 0.25,
                linewidth = 1.2) +
  
  # Puntos
  geom_point(size = 4) +
  
  # Colores solicitados
  scale_color_manual(values = c(
    "No calibrados" = "#EE0000",
    "Calibrados"    = "#1E90FF"
  )) +
  
  # Tema con fondo cuadriculado
  theme_bw(base_size = 16) +
  theme(
    plot.title  = element_text(hjust = 0.5, face = "bold"),  # título centrado
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.title = element_blank()
  ) +
  
  labs(
    title = "MB antes y después de la calibración",
    x = "Sensor",
    y = "MB (µg/m³)"
  )
# Para MGE
ggplot(Errores_antes_despues,
       aes(x = Sensor, 
           y = MGE, 
           color = Clasificación, 
           group = Clasificación)) +
  
  # Barras de error
  geom_errorbar(aes(ymin = MGE - SD_MGE,
                    ymax = MGE + SD_MGE),
                width = 0.25,
                linewidth = 1.2) +
  
  # Línea de tendencia
  geom_line(linewidth = 1.8) +
  
  # Puntos
  geom_point(size = 4) +
  
  # Colores solicitados
  scale_color_manual(values = c(
    "No calibrados" = "#EE0000",
    "Calibrados"    = "#1E90FF"
  )) +
  
  # Tema con fondo cuadriculado
  theme_bw(base_size = 16) +
  theme(
    plot.title  = element_text(hjust = 0.5, face = "bold"),  # título centrado
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.title = element_blank()
  ) +
  
  labs(
    title = "MGE antes y después de la calibración",
    x = "Sensor",
    y = "MGE (µg/m³)"
  )
