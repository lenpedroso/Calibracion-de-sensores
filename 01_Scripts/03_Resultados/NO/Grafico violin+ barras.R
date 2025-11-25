png("C:/Semestre 2-2025/Visualizacion/Calibracion de sensores/Calibracion de sensores/Sensores1.1/04_Figuras/barras_violin.png",
    width = 16, 
    height = 10,
    units = "in",
    res = 900)

# Gráfico VIOLÍN (No calibrados) — primero
library(ggplot2)
library(dplyr)

errores_no <- errores_full %>% filter(Tipo == "No calibrados")

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
#Gráfico VIOLÍN (Calibrados)
errores_cal <- errores_full %>% filter(Tipo == "Calibrados")

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

# Gráfico MBE (barras)
p_MB <- ggplot(Errores_antes_despues, 
               aes(x = Sensor, y = MB, fill = Clasificación)) +
  geom_bar(stat = "identity", color = "black",
           position = position_dodge(width = 0.9)) +
  geom_errorbar(aes(ymin = MB - SD_MB, ymax = MB + SD_MB),
                width = 0.2, linewidth = 0.8,
                position = position_dodge(width = 0.9)) +
  
  # ← Línea roja discontinua en 20
  geom_hline(yintercept = 20,
             linetype = "dashed",
             color = "red",      # o "firebrick4"
             linewidth = 1) +
  
  scale_fill_manual(values = c(
    "No calibrados" = "#1E90FF",
    "Calibrados"    = "firebrick1"
  )) +
  theme_bw(base_size = 16) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.title = element_blank()
  ) +
  labs(title = "MB antes / después de calibrar",
       x = "Sensor", y = "MB (µg/m³)")

# Gráfico MGE (barras)
p_MGE <- ggplot(Errores_antes_despues, 
                aes(x = Sensor, y = MGE, fill = Clasificación)) +
  geom_bar(stat = "identity", color = "black",
           position = position_dodge(width = 0.9)) +
  geom_errorbar(aes(ymin = MGE - SD_MGE, ymax = MGE + SD_MGE),
                width = 0.2, linewidth = 0.8,
                position = position_dodge(width = 0.9)) +
  
  # ← Línea roja discontinua en 20
  geom_hline(yintercept = 20,
             linetype = "dashed",
             color = "red",
             linewidth = 1) +
  
  scale_fill_manual(values = c(
    "No calibrados" = "#1E90FF",
    "Calibrados"    = "firebrick1"
  )) +
  theme_bw(base_size = 16) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.title = element_blank()
  ) +
  labs(title = "MGE antes / después de calibrar",
       x = "Sensor", y = "MGE (µg/m³)")

# Combinar TODO en un solo panel (violín primero)
library(patchwork)

(p_violin_no | p_violin_cal) /
  (p_MB | p_MGE) +
  plot_layout(guides = "collect") &
  theme(legend.position = "right")

dev.off()