# Abrir dispositivo gráfico ------------------------------------------------
png("C:/Semestre 2-2025/Visualizacion/Calibracion de sensores/Calibracion de sensores/Sensores1.1/04_Figuras/barraslinea.png",
    width = 16, 
    height = 10,
    units = "in",
    res = 900)

# Cargar librerías ---------------------------------------------------------
library(ggplot2)
library(dplyr)
library(patchwork)

# Datos para violines ------------------------------------------------------
errores_no <- errores_full %>% filter(Tipo == "No calibrados")
errores_cal <- errores_full %>% filter(Tipo == "Calibrados")

# 1) VIOLÍN – No calibrados -----------------------------------------------
p_violin_no <- ggplot(errores_no,
                      aes(x = Sensor, y = error_abs, fill = Sensor)) +
  geom_violin(trim = FALSE, alpha = 0.35, linewidth = 1.1) +
  geom_boxplot(width = 0.10, alpha = 0.8, linewidth = 1.0,
               outlier.size = 1.5) +
  geom_hline(yintercept = 20, linetype = "dashed",
             color = "firebrick4", linewidth = 1) +
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
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.text.x = element_text(angle = 45, hjust = 1)
  ) +
  labs(title = "Error absoluto — No calibrados",
       x = "Sensor", y = "Error absoluto (µg/m³)",
       fill = "Sensor")

# 2) VIOLÍN – Calibrados ---------------------------------------------------
p_violin_cal <- ggplot(errores_cal,
                       aes(x = Sensor, y = error_abs, fill = Sensor)) +
  geom_violin(trim = FALSE, alpha = 0.35, linewidth = 1.1) +
  geom_boxplot(width = 0.10, alpha = 0.8, linewidth = 1.0,
               outlier.size = 1.5) +
  geom_hline(yintercept = 20, linetype = "dashed",
             color = "firebrick4", linewidth = 1) +
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
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.text.x = element_text(angle = 45, hjust = 1)
  ) +
  labs(title = "Error absoluto — Calibrados",
       x = "Sensor", y = "Error absoluto (µg/m³)",
       fill = "Sensor")


# 3) MB – Barras de error + puntos (SIN línea de unión) --------------------
p_line_MB <- ggplot(Errores_antes_despues,
                    aes(x = Sensor, 
                        y = MB, 
                        color = Clasificación, 
                        group = Clasificación)) +
  
  geom_errorbar(aes(ymin = MB - SD_MB,
                    ymax = MB + SD_MB),
                width = 0.25,
                linewidth = 1.2) +
  
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

# 4) MGE – Barras de error + puntos (SIN línea de unión) -------------------
p_line_MGE <- ggplot(Errores_antes_despues,
                     aes(x = Sensor, 
                         y = MGE, 
                         color = Clasificación, 
                         group = Clasificación)) +
  
  geom_errorbar(aes(ymin = MGE - SD_MGE,
                    ymax = MGE + SD_MGE),
                width = 0.25,
                linewidth = 1.2) +
  
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

# 5) Combinar TODOS los gráficos en una figura 2x2 ------------------------
(p_violin_no | p_violin_cal) /
  (p_line_MB   | p_line_MGE) +
  plot_layout(guides = "collect") &
  theme(legend.position = "right")

# Cerrar dispositivo gráfico ----------------------------------------------
dev.off()

