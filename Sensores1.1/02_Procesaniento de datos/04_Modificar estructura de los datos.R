# Chat GPT fue utilizado para ordenar el codigo
# Copie algunos codigos de la clase correspondiente a la semna 5

# Cargar librerias
library(tidyverse)
library(ggplot2)
# Transformar a formato largo
Condes_Plantawer_SINCA_long<-Condes_Plantawer_SINCA%>% 
  pivot_longer(cols = c(
    PM25_P1, PM25_P2, PM25_P3, PM25_P4, PM25_P5),
    names_to  = c("variable", "sensor"),
    names_sep = "_",
    values_to = "value")

# Modificar 
Condes_Plantawer_SINCA_long_2<-Condes_Plantawer_SINCA_long %>% pivot_longer(
  cols = c(PM25_SINCA),
  names_to  = c("variable_SINCA", "sensor_SINCA"),
  names_sep = "_",
  values_to = "value_SINCA"
)