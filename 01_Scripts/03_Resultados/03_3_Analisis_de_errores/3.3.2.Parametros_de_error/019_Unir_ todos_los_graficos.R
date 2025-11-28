# Permite unir todos los grficos en luna sola imagen 
## El codigo  base para hacer el grafico fue extraido del repositorio  de la profesora
# Sara Acevedo (https://github.com/Saryace/environ-dataviz-uc/blob/main/scr/08-semana/02_mapa-ggplot.R)
# Se empleo el siguiente link (https://patchwork.data-imaginist.com/articles/patchwork.html)
# y (https://patchwork.data-imaginist.com/reference/plot_layout.html)
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo

# 1. Cargar librerias --------------------------------------------------------
library(patchwork)

# 2. Especificar una leyenda para los violines ----------------------------------------
figura_violines <- (violin_nocalibrado | violin_calibrado) + # Especifica el orden en la cuadricula 
  plot_layout(guides = "collect") +        # Una sola leyenda para las barras
  theme(legend.position = "right")      # Leyendas  a la derecha

# 3,Especificar una leyenda para los graficos de barras -------------------------------------------------------
figura_barras <- (barras_MGE | barras_MB) +
  plot_layout(guides = "collect") +        # Una sola leyenda para las barras
  theme(legend.position = "right")      # Leyendas  a la derecha

# 4. Unir figuras y especificar orden --------------------------------------------------------
png("C:/Semestre 2-2025/Visualizacion/Calibracion de sensores/Calibracion de sensores/02_Figuras/3.error.png",
    width = 16, 
    height = 10,
    units = "in",
    res = 900)

figura_final <- figura_violines / figura_barras
 print (figura_final)

dev.off()
