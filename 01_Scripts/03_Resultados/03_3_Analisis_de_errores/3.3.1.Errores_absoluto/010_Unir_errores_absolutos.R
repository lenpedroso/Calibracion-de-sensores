# Permite unir los erroes absoluto en una tabla 
# Se empleo para unir los dos df como base la informacion del siguiente link
# (https://dplyr.tidyverse.org/reference/bind_rows.html)
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo
# Empleo rbind porque me garantiza quue los datos se mantengas a lo largo 
# uniendo solo por filas para despues poder usar ggplot

# 1. Cargar librerias ------------------------------------------------------

library(dplyr)

# 2. Crear una tabla con los errores absolutos completos --------------------


errores_completo <- bind_rows(    # Une df por columnas aumentando el numero de filas
  errores_no_calibrados, errores_calibrados) 


