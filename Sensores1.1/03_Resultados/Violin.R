# Grafico violin
library(ggplot2)
library(dplyr)



# Filtrar solo los errores calibrados
library(dplyr)
library(ggplot2)

# Filtrar solo los errores después de calibrar
library(dplyr)
library(ggplot2)

# Filtrar solo los errores después de calibrar
errores_cal <- errores_full %>%
  filter(Tipo == "Calibrados")

ggplot(errores_cal,
       aes(x = Sensor,
           y = error_abs,
           fill = Sensor)) +
  
  # Violines (forma de la distribución)
  geom_violin(trim = FALSE,
              alpha = 0.35,
              linewidth = 1.1) +
  
  # Boxplot (mediana y cuartiles)
  geom_boxplot(width = 0.10,
               alpha = 0.8,
               linewidth = 1.0,
               outlier.size = 1.5) +
  
  # Línea roja discontinua en 20
  geom_hline(yintercept = 20,
             linetype = "dashed",
             color = "firebrick4",
             linewidth = 1) +
  
  # Paleta firebrick aplicada a tus 5 sensores
  scale_fill_manual(values = c(
    "PM25_P1" = "firebrick1",   
    "PM25_P2" = "firebrick2",   #
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
    title = "Distribución del error absoluto\nSensores calibrados",
    x = "Sensor",
    y = "Error absoluto (µg/m³)"
  )



# Sin calibrar ------------------------------------------------------------
library(dplyr)
library(ggplot2)
# Filtrar solo los errores antes de calibrar
# Filtrar solo los errores antes de calibrar
# Filtrar solo los errores antes de calibrar
library(dplyr)
library(ggplot2)

# Filtrar solo los errores antes de calibrar
errores_no <- errores_full %>%
  filter(Tipo == "No calibrados")

ggplot(errores_no,
       aes(x = Sensor,
           y = error_abs,
           fill = Sensor)) +
  
  # Violines (distribución del error absoluto)
  geom_violin(trim = FALSE,
              alpha = 0.35,
              linewidth = 1.1) +
  
  # Boxplot dentro del violín
  geom_boxplot(width = 0.10,
               alpha = 0.8,
               linewidth = 1.0,
               outlier.size = 1.5) +
  
  # Línea roja discontinua en 20
  geom_hline(yintercept = 20,
             linetype = "dashed",
             color = "firebrick4",
             linewidth = 1) +
  
  # Misma paleta manual firebrick para PM25_P1–P5
  scale_fill_manual(values = c(
    "PM25_P1" = "firebrick1",   # #FF3030
    "PM25_P2" = "firebrick2",   # #EE2C2C
    "PM25_P3" = "firebrick3",   # #CD2626
    "PM25_P4" = "firebrick4",   # #8B1A1A
    "PM25_P5" = "#5A0F0F"       # tono extra para completar gradiente
  )) +
  
  # Eje Y partiendo en 0 (opcional)
  scale_y_continuous(limits = c(0, NA)) +
  
  # Fondo cuadriculado
  theme_bw(base_size = 16) +
  theme(
    plot.title  = element_text(hjust = 0.5, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1)
  ) +
  
  labs(
    title = "Distribución del error absoluto\nSensores no calibrados",
    x = "Sensor",
    y = "Error absoluto (µg/m³)"
  )
