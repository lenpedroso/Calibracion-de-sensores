
# Los valores de referencia se tratan de los valores de las estaciones oficiales de la 
# Chile (SINCA) y los predichos son los valores referidos a los sensores instalados (P1-P5)
# A partir de los valores de referencia y los predichos se determinan los valores de los errores
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo

# Cargar librerias --------------------------------------------------------

library(dplyr)
library(purrr)
library(broom)
library(tibble)
library(tidyr)

# Vector con el nombre de los sensores ------------------------------------
sensores <- paste0("PM25_P", 1:5)

# # Función para calcular los errores generales --------
calculo_error <- function(referencia, predicho) {
referencia <- as.numeric(referencia)
predicho   <- as.numeric(predicho) # Para garantizar que el argumento sea numérico

# Calculo de los errores --------------------------------------------------
error   <- predicho - referencia
error_abs  <- abs(error) # Error absoluto
MB   <- mean(predicho - referencia, na.rm = TRUE)   # Sesgo          
SD_MB   <- sd(error, na.rm = TRUE) # Desviación estándar del sesgo
MGE <- mean(abs(predicho - referencia), na.rm = TRUE)  # Media del error absoluto medio 
SD_MGE <- sd(error_abs, na.rm = TRUE) # Desviación estándar del error absoluto

#3. Obtener resultados en una tabla
  tibble(
     MGE,
     MB,
     SD_MB,
     SD_MGE
  )
}

