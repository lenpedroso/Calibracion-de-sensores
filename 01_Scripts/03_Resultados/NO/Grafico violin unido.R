# Instalar paquete # install.packages("patchwork") # si no lo tienes
# la paleta de colores (https://r-charts.com/es/colores/)
library(patchwork)
library(dplyr)
library(ggplot2)


# No calibrados
p_no <- ggplot(errores_no,
               aes(x = Sensor,
                   y = error_abs,
                   fill = Sensor)) +
  geom_violin(trim = FALSE,
              alpha = 0.35,
              linewidth = 0.4) +   # ← MÁS FINO
  geom_boxplot(width = 0.10,
               alpha = 0.8,
               linewidth = 1.0,
               outlier.size = 1.5) +
  geom_hline(yintercept = 20,
             linetype = "dashed",
             color = "firebrick4",
             linewidth = 1) +
  scale_y_continuous(limits = c(0, NA)) +
  scale_fill_manual(values = c(
    "PM25_P1" = "firebrick1",
    "PM25_P2" = "firebrick2",
    "PM25_P3" = "firebrick3",
    "PM25_P4" = "firebrick4",
    "PM25_P5" = "#5A0F0F"
  )) +
  theme_bw(base_size = 16) +
  theme(
    plot.title  = element_text(hjust = 0.5, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1)
  ) +
  labs(
    title = "Datos de sensores no calibrados",
    x = "Sensor",
    y = "Error absoluto (µg/m³)",
    fill = "Sensor"
  )

# Calibrados
p_cal <- ggplot(errores_cal,
                aes(x = Sensor,
                    y = error_abs,
                    fill = Sensor)) +
  geom_violin(trim = FALSE,
              alpha = 0.35,
              linewidth = 0.4) +   # ← MISMO CAMBIO AQUÍ
  geom_boxplot(width = 0.10,
               alpha = 0.8,
               linewidth = 1.0,
               outlier.size = 1.5) +
  geom_hline(yintercept = 20,
             linetype = "dashed",
             color = "firebrick4",
             linewidth = 1) +
  scale_y_continuous(limits = c(0, NA)) +
  scale_fill_manual(values = c(
    "PM25_P1" = "firebrick1",
    "PM25_P2" = "firebrick2",
    "PM25_P3" = "firebrick3",
    "PM25_P4" = "firebrick4",
    "PM25_P5" = "#5A0F0F"
  )) +
  theme_bw(base_size = 16) +
  theme(
    plot.title  = element_text(hjust = 0.5, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1)
  ) +
  labs(
    title = "Datos de sensores calibrados",
    x = "Sensor",
    y = "Error absoluto (µg/m³)",
    fill = "Sensor"
  )

# Combinar con misma leyenda
p_no + p_cal +
  plot_layout(guides = "collect") &
  theme(legend.position = "right")
# MB (líneas)
p_line_MB <- ggplot(Errores_antes_despues,
                    aes(x = Sensor, 
                        y = MB, 
                        color = Clasificación, 
                        group = Clasificación)) +
  
  geom_errorbar(aes(ymin = MB - SD_MB,
                    ymax = MB + SD_MB),
                width = 0.25,
                linewidth = 1.2) +
  geom_line(linewidth = 1.8) +
  geom_point(size = 4) +
  
  scale_color_manual(values = c(
    "No calibrados" = "#EE0000",
    "Calibrados"    = "#1E90FF"
  )) +
  
  theme_bw(base_size = 16) +
  theme(
    plot.title  = element_text(hjust = 0.5, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.title = element_blank()
  ) +
  labs(
    title = "MB antes y después de la calibración",
    x = "Sensor",
    y = "MB (µg/m³)"
  )


# MGE (líneas)
p_line_MGE <- ggplot(Errores_antes_despues,
                     aes(x = Sensor, 
                         y = MGE, 
                         color = Clasificación, 
                         group = Clasificación)) +
  
  geom_errorbar(aes(ymin = MGE - SD_MGE,
                    ymax = MGE + SD_MGE),
                width = 0.25,
                linewidth = 1.2) +
  geom_line(linewidth = 1.8) +
  geom_point(size = 4) +
  
  scale_color_manual(values = c(
    "No calibrados" = "#EE0000",
    "Calibrados"    = "#1E90FF"
  )) +
  
  theme_bw(base_size = 16) +
  theme(
    plot.title  = element_text(hjust = 0.5, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.title = element_blank()
  ) +
  labs(
    title = "MGE antes y después de la calibración",
    x = "Sensor",
    y = "MGE (µg/m³)"
  )
# unir todos
library(patchwork)

(p_no | p_cal) /
  (p_line_MB | p_line_MGE) +
  plot_layout(guides = "collect") &
  theme(legend.position = "right")
