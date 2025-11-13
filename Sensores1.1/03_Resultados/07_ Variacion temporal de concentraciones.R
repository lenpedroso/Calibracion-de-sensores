# la funcion utlizada fue copidada del siguiente link:
#(https://github.com/Saryace/datascience-sinca/blob/main/codigo/02_procesamiento-horas.R)
# y modificada para los df de trabajo
#Chat gpt fue utilizado para corregir errores y como complemento para hacer la función

# Funcion para calcular las concentraciones semanales
Condes_summary_pm25 <- function(datos, tiempo, pm_col = "value") {
  datos %>%
    group_by(across(all_of(tiempo)), sensor) %>%   
    summarise(
      n    = sum(!is.na(.data[[pm_col]])),
      mean = mean(.data[[pm_col]], na.rm = TRUE),
      sd   = sd(.data[[pm_col]],  na.rm = TRUE),
      se   = ifelse(n > 1, sd / sqrt(n), NA_real_),
      ymin = mean - 1.96 * se,
      ymax = mean + 1.96 * se,
      .groups = "drop"
    )
}
# Resumenes por dia de la hora y por dia de la semana
hour_wday <- Condes_summary_pm25(Condes_Plantower_SINCA_long3, c("wday", "hour"), "value_PM25")
hour <- Condes_summary_pm25(Condes_Plantower_SINCA_long3, "hour", "value_PM25")
wday <- Condes_summary_pm25(Condes_Plantower_SINCA_long3, "wday", "value_PM25")

# Grafico de 
ggplot(hour_wday, aes(x = hour, y = mean, color = sensor, fill = sensor, group = sensor)) +
  geom_ribbon(aes(ymin = ymin, ymax = ymax), alpha = 0.15, colour = NA) +
  geom_line(linewidth = 0.7) +
  facet_wrap(vars(wday), nrow = 1) +
  labs(
    x = "Hora del día",
    y = expression(PM[2.5]~(mu*g/m^3)),
    color = "Sensor",
    fill  = "Sensor",
    title = "Promedio horario de PM2.5 por día de la semana y sensor"
  ) +
  theme_bw() +
  theme(
    legend.position = "top",
    strip.background = element_rect(fill = "grey90", color = NA),
    strip.text = element_text(face = "bold"),
    axis.text.x = element_text(angle = 0, hjust = 0.5)
  )
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
