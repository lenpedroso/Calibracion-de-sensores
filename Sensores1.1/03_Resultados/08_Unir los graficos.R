colores_sensores <- c(
  "PM25_P1" = "#1f77b4",
  "PM25_P2" = "#ff7f0e",
  "PM25_P3" = "#2ca02c",
  "PM25_P4" = "#d62728",
  "PM25_P5" = "#9467bd",
  "PM25_SINCA" = "#8c564b"
)
boxplot_PM25 <- Condes_Plantower_SINCA_long3 %>%
  drop_na(value_PM25) %>%
  ggplot(aes(x = sensores, y = value_PM25, fill = sensores)) +
  geom_boxplot() +
  scale_fill_manual(values = colores_sensores) +
  labs(
    x = "Sensor",
    y = expression(PM[2.5]~" (" * mu * "g/m"^3*")")
  ) +
  theme_bw() +
  theme(
    legend.position = "none",
    axis.text.x = element_text(angle = 45, hjust = 1)
  )
time_plot <- hour_wday %>%
  ggplot(aes(x = hour, y = mean,
             color = sensor, fill = sensor, group = sensor)) +
  geom_ribbon(aes(ymin = ymin, ymax = ymax),
              alpha = 0.15, colour = NA) +
  geom_line(linewidth = 0.7) +
  facet_wrap(vars(wday), nrow = 1) +
  scale_color_manual(values = colores_sensores) +
  scale_fill_manual(values = colores_sensores) +
  labs(
    x = "Hora del día",
    y = expression(PM[2.5]~" (" * mu * "g/m"^3*")"),
    color = "Sensor",
    fill  = "Sensor"
  ) +
  theme_bw() +
  theme(legend.position = "top")
library(patchwork)

boxplot_PM25 + time_plot + plot_layout(heights = c(1, 2))
