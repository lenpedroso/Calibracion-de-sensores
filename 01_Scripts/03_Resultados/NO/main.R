
# Librerias ---------------------------------------------------------------
library(tidyverse)

# Carga de datos ----------------------------------------------------------
leer_datos<- list.files(path = "01_Scripts/01_Cargar datos", recursive = TRUE, full.names = TRUE)
walk(leer_datos, source)
