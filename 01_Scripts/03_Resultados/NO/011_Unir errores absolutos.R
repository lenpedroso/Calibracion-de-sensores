# Permite unir los erroes absoluto en una tabla 
# Se empleo para unir los dos df como base la informacion del siguiente link
# (https://dplyr.tidyverse.org/reference/bind_rows.html)
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo

# Cargar librerias ------------------------------------------------------

library(dplyr)

# Crear una tabla con los errores absolutos completos --------------------

errores_completo <- bind_rows( # Une diferentes df por columnas
  errores_no_calibrados,
  errores_calibrados
)

