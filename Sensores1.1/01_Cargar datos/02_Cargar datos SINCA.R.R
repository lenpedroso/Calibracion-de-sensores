# Se utilizo chat gpt para ordenar codigos 
# Se baso en el repositorio elaborado por 	Francisco Catalan Meyer para descargar los datos del SINCA
# Usando su repositorio (https://github.com/franciscoxaxo/AtmChile/blob/main/R/ChileAirQuality.R)
#Primeraqmente se instalo el paquete "AtmChile"
# Paso 1. Instalar el paquetes
# install.packages("AtmChile") # permite recopilar información de parámetros de calidad del aire del SINCA
#install.packages("remotes") # se emplea para instalar paquetes que se encuentran en repositorios remotos (GitHub)
#install.packages("devtools") # Todas sus funciones aceptan una ruta (ej:URL) como argumento

 # Paso 2.  Cargar librerias
library(remotes) 
library(devtools)
library(AtmChile)

# Al ya estar cargada la libreria remotes se puede cargar paquetes desde GitHUB
#install_github("franciscoxaxo/AtmChile")
help(package = "AtmChile") # Saber que tiene el paquete y como escribir las funciones
# Paso 3 Descargar la base de datos de las concentraciones del SINCA
 Las_Condes_Sinca<- ChileAirQuality(   # Funcion para leer los archivos de SINCA.csv
  Comunas = "Las Condes",
  Parametros = c("PM25"),
  fechadeInicio = "4/06/2025",
  fechadeTermino = "23/08/2025",
  Site = FALSE, # Si se pone TRUE es para ingresar el codigo de la estacion 
  Curar = FALSE, # Ajusta outliers y datos extremos (utiliza solo valores logicos)
  st = TRUE) # Añade una columna con el estado de validacion de los datos


 