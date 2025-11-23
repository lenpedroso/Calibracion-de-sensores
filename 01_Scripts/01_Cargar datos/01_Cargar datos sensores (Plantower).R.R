# Este script permite descargar los datos de concentracion de los Plantower (sensores de bajo costos) 
# Es necesario instalar paquete para leer csv (install.packages("readr").  
# Los datos se cargan desde mi cuenta de git hub personal
# Se emplearon las siguientas páginas web como base para delimitar las columnas
#(https://www.rdocumentation.org/packages/readr/versions/2.1.6/topics/read_delim) y 
# (https://readr.tidyverse.org/reference/read_delim.html)
# Chat gptfue empleado para ordenar codigos y corregir errores

# Cargar libreria ---------------------------------------------------------
library(readr)

# Seleccionar datos desde git hub -----------------------------------------

url <- "https://raw.githubusercontent.com/lenpedroso/Calibracion-de-sensores/master/00_Datos/CON_Plantower.csv"
Condes_Plantower<- read_csv(url)

# Especificar delimitador -------------------------------------------------

Condes_Plantower <- read_delim(url, delim = ";", locale = locale(decimal_mark = ","))

