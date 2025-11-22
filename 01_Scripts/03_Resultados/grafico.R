# Paquetes
library(dplyr)
library(ggplot2)
library(paletteer)

# ==== 1. Datos y estadísticos por sensor ==========================
# Asumo que ya tienes cargado Condes_Plantower_SINCA_long_2
# con columnas: sensor, value_SINCA (SINCA), value (sensor)

df <- Condes_Plantower_SINCA_long_2 %>%
  filter(!is.na(value_SINCA), !is.na(value))

stats_sensores <- df %>%
  group_by(sensor) %>%
  do({
    m    <- lm(value ~ value_SINCA, data = .)
    pred <- predict(m, newdata = .)
    rmse  <- sqrt(mean((.$value - pred)^2))
    nrmse <- 100 * rmse / mean(.$value_SINCA)
    
    tibble(
      slope     = coef(m)[2],
      intercept = coef(m)[1],
      r2        = summary(m)$r.squared,
      rmse      = rmse,
      nrmse     = nrmse
    )
  }) %>%
  ungroup() %>%
  mutate(
    label = sprintf(
      "y = %.2f x %+ .2f\nR² = %.2f\nRMSE = %.2f\nNRMSE = %.1f%%",
      slope, intercept, r2, rmse, nrmse
    )
  )

# ==== 2. Objeto del gráfico ========================================

gg <- ggplot(df, aes(x = value_SINCA, y = value, colour = value_SINCA)) +
  
  # puntos
  geom_point(size = 1.6, alpha = 0.8) +
  
  # línea y = x discontinua
  geom_abline(slope = 1, intercept = 0,
              linetype = "dashed", linewidth = 0.9, colour = "red") +
  
  # línea de regresión
  geom_smooth(method = "lm", se = FALSE,
              colour = "black", linewidth = 1) +
  
  # facetas por sensor
  facet_wrap(~ sensor, nrow = 2) +
  
  # texto con ecuación, R2, RMSE y NRMSE
  geom_text(
    data = stats_sensores,
    aes(label = label),
    x = -Inf, y = Inf,
    hjust = -0.05, vjust = 1.1,
    size = 4.5,
    lineheight = 1.1,
    inherit.aes = FALSE
  ) +
  
  # paleta azul -> rojo
  scale_colour_gradientn(
    colours = paletteer::paletteer_c("pals::coolwarm", 100),
    name = expression(paste("PM"[2.5], " SINCA (", mu, "g/m"^3, ")")),
    guide = guide_colourbar(
      barwidth  = 0.6,
      barheight = 6
    )
  ) +
  
  coord_equal() +
  
  labs(
    title = "Calibración Plantower vs SINCA (PM\u2082\u00b7\u2085)",
    x = expression(paste("PM"[2.5], " SINCA (", mu, "g/m"^3, ")")),
    y = expression(paste("PM"[2.5], " Sensor Plantower (", mu, "g/m"^3, ")"))
  ) +
  
  theme_bw(base_size = 15) +
  theme(
    plot.title  = element_text(size = 22, face = "bold", hjust = 0.5),
    axis.text   = element_text(size = 12),
    axis.title  = element_text(size = 14),
    strip.text  = element_text(size = 16, face = "bold"),
    panel.grid  = element_blank(),
    panel.spacing = unit(0.5, "lines"),
    plot.margin = margin(5, 5, 5, 5),
    legend.position = "right",
    legend.title = element_text(size = 14),
    legend.text  = element_text(size = 12)
  )

# ==== 3. Guardar en PNG en tu carpeta ==============================

png("C:/Semestre 2-2025/Visualizacion/Calibracion de sensores/Calibracion de sensores/Sensores1.1/04_Figuras/scatter_PM25_azul_rojo.png",
    width = 30, height = 10, units = "in", res = 900)

print(gg)
dev.off()

