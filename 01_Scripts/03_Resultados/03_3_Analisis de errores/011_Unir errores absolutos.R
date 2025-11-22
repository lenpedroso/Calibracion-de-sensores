# Permite unir los erroes absoluto en una tabla 
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo

# Cargar librerias ------------------------------------------------------

library(dplyr)

# Crear una tabla con los errores absolutos completos --------------------

errores_completo <- bind_rows( # Une diferentes df por columnas
  errores_no_calibrados,
  errores_calibrados
)

