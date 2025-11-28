# Calculo de los errores absoluto para cada observación después de la calibración
# Para realizar las funciones se empleo el siguiente link (https://github.com/Saryace/environ-dataviz-uc/blob/main/scr/04-semana/03-funciones.R) 
# y (https://github.com/Saryace/environ-dataviz-uc/blob/main/scr/05-semana/03-funciones-ggplot.R)extraido del repositorio de la profesora 
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo.

# 1. Cargar libreria  ------------------------------------------------------
library(purrr)
library(tibble)
library(purrr)
library(tidyr)
# 2. Función que ajusta el modelo y calcula errores para cada sensor de bajo costo -------
errores_por_sensor <- function(sensor) {
  
# 3. Seleccionar referencia (SINCA) y el sensor de bajo costo --------------
Valores_calibrados <- Condes_Plantower_SINCA[, c("PM25_SINCA", sensor)] #columnas seleccionadas

# 4. Eliminar Na  --------------------------------------------------------
Valores_calibrados <- Valores_calibrados %>% 
  drop_na()

#  5. Ajustar modelo: PM25_SINCA vs sensor (Plantower)  ---------------------
# 5.1 Construir formula de regresion lineal automatizada y simplificada por sensor
form <- as.formula(paste("PM25_SINCA ~", sensor))
# 5.2 Ajuste del modelo de regrsion lineal automatizado para cada sensor 
modelo <- lm(form, data = Valores_calibrados)
  
# 6. Extraer valores ajustados del modelo --------------------------
referencia <- Valores_calibrados$PM25_SINCA # Valores de referencia
predicho   <- predict(modelo)   # valores ajustados del modelo (ya calibrados)

# 7. Calcular errores --------------------------------------------------
error     <- predicho - referencia
error_abs <- abs(error)

# 8. Tabla de errores por observación -----------------------------------

tibble(
  sensor,
  referencia,    
  predicho,      
  error,
  error_abs,
  Clasificacion = "Calibrados"
)
}
# 9. Aplicar la función a todos los sensores y une resultados en una tabla --
errores_calibrados <- map(sensores, errores_por_sensor) #Aplicar una funcion a  cada sensor

# 10.Obtener tabla con todos los parametros de errores calibrados ----------
print(errores_calibrados)
