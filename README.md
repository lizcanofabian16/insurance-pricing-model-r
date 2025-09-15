# Insurance Pricing Model - R Version

Un modelo de pricing actuarial implementado en R usando regresión lineal.

## Estructura del Proyecto
├── data/ Datos sintéticos
├── scripts/ Código R (generación, modelo, visualización)
├── outputs/ Gráficas y modelo guardado
├── requirements.R Dependencias
└── README.md

text

## Cómo Ejecutar
1. Clonar repositorio
2. Ejecutar en R: `source("requirements.R")`
3. Ejecutar scripts en orden: `01_generate_data.R` -> `02_pricing_model.R` -> `03_visualization.R`

## Resultados
El modelo genera las siguientes gráficas actuariales:
- Importancia de variables (coeficientes del modelo)
- Distribución de primas en el portafolio
- Relación entre edad y prima
- Comparación de primas por género

## Autor
Fabian Lizcano - Matemático y Analista Actuarial