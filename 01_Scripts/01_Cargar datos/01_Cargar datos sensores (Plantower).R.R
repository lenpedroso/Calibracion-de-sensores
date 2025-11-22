
# Es necesario instalar paquete para leer csv (install.packages("readr").  
# Los datos se cargan desde mi cuenta de git hub personal
# Chat gptfue empleado para ordenar codigos y corregir errores

# Cargar libreria ---------------------------------------------------------
library(readr)

# Seleccionar datos desde git hub -----------------------------------------

url <- "https://github.com/lenpedroso/Calibracion-de-sensores/tree/master/00_Datos/CON_Plantower.csv"
Condes_Plantower<- read_csv(url)

# Especificar delimitador -------------------------------------------------

Condes_Plantower <- read_delim(url, delim = ";", locale = locale(decimal_mark = ","))

