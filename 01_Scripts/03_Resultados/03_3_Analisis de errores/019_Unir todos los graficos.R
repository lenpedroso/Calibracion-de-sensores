#Permite unir todos los grficos en luna sola imagen 
## El codigo  base para hacer el grafico fue extraido del repositorio  de la profesora
# Sara Acevedo (https://github.com/Saryace/environ-dataviz-uc/blob/main/scr/08-semana/02_mapa-ggplot.R)
# Chat gpt fue empleado para modificar, ordenar y corregir errores en el codigo

# Cargar librerias --------------------------------------------------------
library(patchwork)

# Unir los graficos -------------------------------------------------------

figura_final <-(violin_nocalibrado | violin_calibrado ) / # Especifica el orden en la cuadricula 
  (barras_MGE  | barras_MB) +
  plot_layout(guides = "collect") & # Una leyenda
  theme(legend.position = "right") # Que las leyendas esten a la derecha

figura_final