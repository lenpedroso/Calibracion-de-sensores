# Permite modificar la estructura de los datos a formato long.
# Se tomó de base el repositorio de la profesora Sara Acevedo para transformar
# los datos a diferentes formatos (https://github.com/Saryace/environ-dataviz-uc/tree/main/scr/05-semana)  
# Para el uso de la funcion ifself (automatiza para cada observación)
# (https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/ifelse)
# Chat GPT fue utilizado para ordenar, modificar y corregir errores de código. 
# Chat GPT fue utilizado para para identificar y consultar las funciones 
# requeridas en el desarrollo del trabajo.

# 1. Cargar librerías ------------------------------------------------------

library(tidyverse)
library(ggplot2)

# 2.Transformar a formato largo -------------------------------------------

Condes_Plantower_SINCA_long<-Condes_Plantower_SINCA%>% 
  pivot_longer(cols = c(
    PM25_P1, PM25_P2, PM25_P3, PM25_P4, PM25_P5),
    names_to  = c("variable", "sensor"),
    names_sep = "_",
    values_to = "value")

# 3. Modificar para realizar un análisis de regresión---------------------
Condes_Plantower_SINCA_long_2 <- Condes_Plantower_SINCA_long %>% pivot_longer(
  cols = c(PM25_SINCA),
  names_to  = c("variable_SINCA", "sensor_SINCA"),
  names_sep = "_",
  values_to = "value_SINCA"
)
# 4. Hacer una columna long para agregar los datos SINCA en la categoría sensores (grafico de variación temporal) --------
Condes_Plantower_SINCA_long3 <- Condes_Plantower_SINCA_long %>%
  pivot_longer(
    cols = c(value, PM25_SINCA),
    names_to  = "sensores",
    values_to = "value_PM25"
  ) %>%
  mutate(sensor = ifelse(sensores == "PM25_SINCA", "SINCA", sensor))




