# Chat GPT fue utilizado para ordenar el codigo
# Copie algunos codigos de la clase correspondiente a la semna 5

# Cargar librerias
library(tidyverse)
library(ggplot2)
# Transformar a formato largo
Condes_Plantower_SINCA_long<-Condes_Plantower_SINCA%>% 
  pivot_longer(cols = c(
    PM25_P1, PM25_P2, PM25_P3, PM25_P4, PM25_P5),
    names_to  = c("variable", "sensor"),
    names_sep = "_",
    values_to = "value")
# Hacer una columna long para inclior SINCa en la categoria sensor
Condes_Plantower_SINCA_long3 <- Condes_Plantower_SINCA_long %>%
  select(wday, hour, sensor, value, PM25_SINCA) %>%
  pivot_longer(
    cols = c(value, PM25_SINCA),
    names_to = "sensores",
    values_to = "value_PM25"
  ) %>%
  mutate(sensor = ifelse(sensores == "PM25_SINCA", "SINCA", sensor))


# Modificar para realizar un analisis de regresion
Condes_Plantower_SINCA_long_2<-Condes_Plantower_SINCA_long %>% pivot_longer(
  cols = c(PM25_SINCA),
  names_to  = c("variable_SINCA", "sensor_SINCA"),
  names_sep = "_",
  values_to = "value_SINCA"
)