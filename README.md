# 📡 Calibracion de sensores de bajo costo

Este repositorio presenta los codigos necesarios para calibrar sensores de bajo costo (Plantawer). Estos se evaluaran tomando referencia el Sistema de Información Nacional de Calidad del Aire (SINCA) que es la estacion oficial refulatoria de calidad de aire en Chile.

# 📘 Descripción del proyecto

Los sensores de bajo costo surgen como una alternativa complementaria al permitir una mayor cobertura espacial y una mejor caracterización de la variabilidad local de contaminates atmosféricos. No obstante, su desempeño se ve influenciado por factores ambientales (temperatura y humedad), por lo que tienden a sobreestimar los valores de sus concentraciones. Como consecuencia es necesario aplicarle ecuaciones de calibración para contrarrestar estas limitaciones.

Este proyecto tiene como objetivo calibrar y evaluar el desempeño de sensores de bajo costo (Plantower) utilizados para la medición de la concentración de material patrticulado con diametro aerodinámico (\<2,5 μm ) PM$2.5$, comparándolos con datos de referencia provenientes del SINCA. Se analiza la diferencia antes y después de la calibración mediante múltiples parámetros de error y visualizaciones estadísticas.

## Objetivo

Evaluar la precisión de sensores Plantower mediante su comparación con estaciones de referencia SINCA, aplicando modelos de calibración y cuantificando la mejora del desempeño a través de métricas de error como MGE y MB.

## 🗂️ ️Estructura del repositorio

Para que pueda funcionar el repositorio correctamente es necesario descargar cada una de estas carpetas con sus respectivos scripts.

``` text
01_Datos/
├── Plantower_raw.csv

02_Scripts/
├── 01_Cargar_datos/
├── 02_Procesamiento_de_datos/
└── 03_Resultados/
    ├── 03_1_Tendencia_temporal/
    ├── 03_2_Regresion_lineal/
    └── 03_3_Analisis_de_errores/
        ├── 3.3.1_Errores_absolutos/
        └── 3.3.2_Parametros_de_error/

03_Figuras/
├── Variacion_temporal.png
├── Scatterplot.png
└── Analisis_de_errores.png

04_Informe/
└── Informe_final.pdf

README.md
```

## Flujo de trabajo

1.  Cargar los datos correspondiante al SINCA y los sensores de bajo costo(Plantower).
2.  Conversión de fecha y hora a formato POSIXct.
3.  Verificacion del comprtamiento temporal de las concentraciones de PM$2,5$ del Plantower vs SINCA.
4.  Calibracion de los sensores mediante un modelo de regresión lineal.
5.  Cálculo de errores absolutos antes y después de calibración para determinar la distribución de los errores.
6.  Cálculo de métrica de error (MB, MGE) antes y después de calibración.
7.  Visualización comparativa antes y después de la calibración.

### Descripción de cada archivo y organización de los scripts

#### 1. Carga y preparación de datos

-   `01_Cargar_datos_sensores_(Plantower).R`\
    Descarga los datos correspondientes a los sensores de bajo costo desde la nube.

-   `02_Cargar_datos_SINCA.R`\
    Descarga los archivos de referencia del SINCA.

-   `03_Unir_PM25_sensores_con_SINCA.R`\
    Modifica el formato de la fecha y une en un solo data frame las concentraciones de PM2.5 de los sensores y de SINCA.

-   `04_Modificar_estructura_de_los_datos.R`\
    Convierte los datos a formato long para facilitar la visualización y comparación entre sensores.

-   `05_Variacion_temporal_de_concentraciones.R`\
    Calcula las concentraciones diarias y semanales y genera resúmenes temporales.

------------------------------------------------------------------------

#### 2. Visualización de la variación temporal y relación con la referencia

-   `06_Grafico_variacion_temporal.R`\
    Genera gráficos para comparar el comportamiento temporal de los sensores Plantower vs SINCA.

-   `07_Scatterplot.R`\
    Genera gráficos de dispersión para el análisis de regresión lineal y la frecuencia de las concentraciones de contaminante.

------------------------------------------------------------------------

#### 3. Cálculo de errores absolutos

-   `08_Errores_absoluto_no_calibrados.R`\
    Calcula los errores absolutos para cada uno de los sensores antes de la calibración.

-   `09_Errores_absolutos_calibrados.R`\
    Calcula los errores absolutos para cada observación después de la calibración.

-   `010_Unir_errores_absolutos.R`\
    Une los errores absolutos de todos los sensores en una sola tabla.

------------------------------------------------------------------------

#### 4. Distribución de errores (gráficos de violín)

-   `011_Grafico_de_violin_no_cal.R`\
    Genera gráficos de violín para analizar la distribución de los errores antes de la calibración.

-   `012_Grafico_de_violin_calibrado.R`\
    Genera gráficos de violín para analizar la distribución de los errores después de la calibración.

------------------------------------------------------------------------

#### 5. Parámetros de error (MB, MGE, desviaciones estándar)

-   `013_Cálculo_de_errores.R`\
    Contiene las funciones para calcular las métricas de error para cada sensor (MB, MGE).

-   `014_Parametros_de_errores_no_calibrados.R`\
    Calcula los parámetros de error (MGE, MB, SD_MGE, SD_MB) para los sensores antes de la calibración.

-   `015_Parametros_de_errores_calibrado.R`\
    Calcula los parámetros de error (MGE, MB, SD_MGE, SD_MB) para los sensores calibrados mediante el modelo de regresión lineal.

-   `016_Unir_parametros_de_errores.R`\
    Une todos los parámetros de error (MGE, SD_MGE, MB, SD_MB) en una sola tabla.

------------------------------------------------------------------------

#### 6. Visualización final de las métricas de error

-   `017_Grafico_MGE.R`\
    Genera gráficos de barras para el análisis del Error Medio Global (MGE).

-   `018_Grafico_MB.R`\
    Genera gráficos de barras para el análisis del Sesgo Medio (MB).

Nota: Para usar la libreria open air es necesario tener una columana que se llame date.

## Audiencia

Este procedimiento está orientado a personas que tengan un conocimiento básico en analisis de contaminates atmósfericos para la compresión y analisi de los resultados

## 🌐 Recursos en línea utilizados

**Lectura y escritura de datos** - <https://www.rdocumentation.org/packages/readr/versions/2.1.6/topics/read_delim>\
- <https://readr.tidyverse.org/reference/read_delim.html>

**Fechas y tiempos** - <https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/as.POSIX>\*\
- <https://certidevs.com/tutorial-r-lubridate-fechas-y-tiempo-hora>

**Conversión y creación de tablas** - <https://r-coder.com/funcion-as-numeric-r/>\
- <https://tibble.tidyverse.org/reference/tibble.html>

**Programación funcional y listas** - <https://purrr.tidyverse.org/reference/map_dfr.html#arguments>\
- <https://stackovercoder.es/programming/1169456/the-difference-between-bracket-and-double-bracket-for-accessing-the-el>

**Modelos y predicción** - <https://www.datacamp.com/es/tutorial/linear-regression-R>\
- <https://www.digitalocean.com/community/tutorials/predict-function-in-r>

**Estructuras de control y funciones** - <https://r-coder.com/for-en-r/>\
- <https://fhernanb.github.io/Manual-de-R/creafun.html>\
- <https://dplyr.tidyverse.org/reference/relocate.html>

**Gráficos, colores y material docente de apoyo** - <https://r-charts.com/es/colores/>\
- <https://github.com/Saryace/environ-dataviz-uc/tree/main/scr/05-semana>\
- <https://github.com/Saryace/environ-dataviz-uc/blob/main/scr/04-semana/03-funciones.R>\
- <https://github.com/Saryace/environ-dataviz-uc/blob/main/scr/05-semana/03-funciones-ggplot.R>\
- <https://github.com/Saryace/datascience-sinca/blob/main/codigo/02_procesamiento-horas.R>
