# Procedimiento para calcular los errores absoluto para cada uno de los valores 
# Se utlizaron los diferentes link para usar map y seleccionar elementos de una lista
#(https://purrr.tidyverse.org/reference/map_dfr.html#arguments) y 
#(https://stackovercoder.es/programming/1169456/the-difference-between-bracket-and-double-bracket-for-accessing-the-el)
# Para la elaboracion de la tablas se uso (https://tibble.tidyverse.org/reference/tibble.html)
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo

# 1. Cargar libreias -------------------------------------------------------
library(dplyr)
library(purrr)
library(tibble)

# 2. Vector con el nombre de los sensores --------------------------------
sensores <- c("PM25_P1", "PM25_P2", "PM25_P3", "PM25_P4", "PM25_P5")

# 3. Cálculo de los errores individuales de cada observación sin calibración --------

# 3.1 Para cada sensor de la lista ejecuta la función y lo guarda en una tabla (errores no calibrado)
errores_no_calibrados <- map(sensores, function(sensor) { # repite la funcion para cada elemento

# 3.2 Extraer los valores de referencia y predicho
referencia <- Condes_Plantower_SINCA$PM25_SINCA
predicho   <- Condes_Plantower_SINCA[[sensor]] # Extraer datos para cada sensor (lista)

# 3.3 Calculo del  error y error absoluto 
error     <- predicho - referencia
error_abs <- abs(error)

 # 4. Tabla  con los resultados ---------------------------------------------------
tibble(
  sensor,         
  referencia,     
  predicho,       
  error,          
  error_abs,     
  Clasificacion = "No calibrados"
)
})
# # 5. Obtener tabla ------------------------------------------------------
print(errores_no_calibrados)


  
