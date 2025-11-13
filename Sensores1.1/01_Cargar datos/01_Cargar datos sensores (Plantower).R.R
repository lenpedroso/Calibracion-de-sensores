
# Es necesario instalar paquete para leer csv (install.packages("readr"). Chat gpt 
# fue empleado para ordenar codigos y corregir errores

# Cargar libreria ---------------------------------------------------------
library(readr)

# Seleccionar datos desde git hub -----------------------------------------

url <- "https://raw.githubusercontent.com/lenpedroso/Calibracion-de-sensores/master/Sensores1.1/00_Datos/CON_Plantower.csv"
Condes_Plantower<- read_csv(url)

# Especificar delimitador -------------------------------------------------

Condes_Plantower <- read_delim(url, delim = ";", locale = locale(decimal_mark = ","))

