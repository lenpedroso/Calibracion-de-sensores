# El codigo para realizar el grafico se escogió de la pagina web (https://programmerclick.com/article/61581791854/) 

# Cargar librerias

library(ggplot2)
# Realizar el grafico para MB lineas

ggplot(Errores_antes_despues, 
       aes(x = Sensor, y = MGE, fill = Clasificación)) +
  
  geom_bar(stat = "identity",
           color = "black",
           position = position_dodge(width = 0.9)) +
  
  geom_errorbar(aes(ymin = MGE - SD_MGE,
                    ymax = MGE + SD_MGE),
                width = 0.2,
                position = position_dodge(width = 0.9),
                linewidth = 0.8) +
  
  labs(title = "Comparación del MGE antes y después de la calibración",
       x = "Sensor",
       y = "MGE (µg/m³)") +
  
  scale_fill_manual(values = c(
    "No calibrados" = "#1E90FF",
    "Calibrados"    = "firebrick1"
  )) +
  
  # 🔳 FONDO CUADRICULADO
  theme_bw(base_size = 16) +
  theme(
    plot.title    = element_text(face = "bold", hjust = 0.5),
    axis.text.x   = element_text(angle = 45, hjust = 1),
    legend.title  = element_blank(),
    legend.position = "right"
  )



# MB barras
ggplot(Errores_antes_despues, 
       aes(x = Sensor, y = MB, fill = Clasificación)) +
  
  geom_bar(stat = "identity",
           color = "black",
           position = position_dodge(width = 0.9)) +
  
  geom_errorbar(aes(ymin = MB - SD_MB,
                    ymax = MB + SD_MB),
                width = 0.2,
                position = position_dodge(width = 0.9),
                linewidth = 0.8) +
  
  labs(title = "Comparación del MB antes y después de la calibración",
       x = "Sensor",
       y = "MB (µg/m³)") +
  
  scale_fill_manual(values = c(
    "No calibrados" = "#1E90FF",
    "Calibrados"    = "firebrick1"
  )) +
  
  #  FONDO CUADRICULADO
  theme_bw(base_size = 16) +
  theme(
    plot.title    = element_text(face = "bold", hjust = 0.5),
    axis.text.x   = element_text(angle = 45, hjust = 1),
    legend.title  = element_blank(),
    legend.position = "right"
  )
