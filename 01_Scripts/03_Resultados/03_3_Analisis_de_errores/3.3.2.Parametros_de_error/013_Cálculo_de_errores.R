# Este script presenta las funciones para calcular los errores para cada sensor
# Los valores de referencia se tratan de los valores de las estaciones oficiales de 
# Chile (SINCA) y los predichos son los valores referidos a los sensores instalados (P1-P5)
# A partir de los valores de referencia y los predichos se determinan los errores
# Para calcular eror se emplearon las siguientes pagina web (https://www.delftstack.com/es/howto/r/standard-error-in-r/)
# error absoluto se empeo (https://www.mycompiler.io/view/INVqRfz3y62)
# Para la creacion de funciones se empleo (https://fhernanb.github.io/Manual-de-R/creafun.html)
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo

# Cargar librerias --------------------------------------------------------
library(dplyr)
library(purrr)
library(broom)
library(tibble)
library(tidyr)

# Vector con el nombre de los sensores ------------------------------------
sensores <- c("PM25_P1", "PM25_P2", "PM25_P3", "PM25_P4", "PM25_P5")

# # Función para calcular los errores generales --------
calculo_error <- function(referencia, predicho) {
referencia <- as.numeric(referencia)
predicho   <- as.numeric(predicho) # Para garantizar que el argumento sea numérico
  
# Cálculo de los errores --------------------------------------------------
error   <- predicho - referencia
error_abs  <- abs(error) # Error absoluto
MB   <- mean(predicho - referencia, na.rm = TRUE)   # Media del sesgo          
MGE <- mean(abs(predicho - referencia), na.rm = TRUE)  # Media del error absoluto medio
SD_MB   <- sd(error, na.rm = TRUE) # Desviación estándar del sesgo
SD_MGE <- sd(error_abs, na.rm = TRUE) # Desviación estándar del error absoluto
  

# Obtener resultados en una tabla ---------------------------------------
tibble(
    MGE,
    MB,
    SD_MB,
    SD_MGE
  )
}



