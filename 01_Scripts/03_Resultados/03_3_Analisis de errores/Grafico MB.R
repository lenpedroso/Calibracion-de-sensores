
# Script para realizar los graficos de barra para el analisis del Sesgo medio (MB)
# antes y despues de la calibración 
#Para realizar los graficos se tomo de base los script presentado en la siguiente 
#página web (https://programmerclick.com/article/61581791854/)
#Los colores fueron extraidos de la siguiente página web (https://r-charts.com/es/colores/)
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo

# Gráfico MBE (barras)
p_MB <- ggplot(Errores_antes_despues, 
               aes(x = Sensor, y = MB, fill = Clasificación)) +
  geom_bar(stat = "identity", color = "black", # añade un borde negro a cada grafica
           position = position_dodge(width = 0.9)) +
  geom_errorbar(aes(ymin = MB - SD_MB, ymax = MB + SD_MB),# añade los valores de desviación del error
                width = 0.2, linewidth = 0.8,
                position = position_dodge(width = 0.9)) +
  geom_hline(yintercept = 20,  # Linea en 20 discontinua 
             linetype = "dashed",
             color = "red",      
             linewidth = 1) +
  scale_fill_manual(values = c(
    "No calibrados" = "#1E90FF",
    "Calibrados"    = "firebrick1"
  )) +
  theme_bw(base_size = 16) +    # Tema blanco y negro con tamño de texto 16
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),# Título en negrita y centrado.
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.title = element_blank()
  ) +
  labs(title = "MB antes / después de calibrar",
       x = "Sensor", y = "MB (µg/m³)")

